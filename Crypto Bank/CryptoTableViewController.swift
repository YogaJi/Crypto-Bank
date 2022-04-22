//
//  CryptoTableViewController.swift
//  Crypto Bank
//
//  Created by Yujia on 2022/3/31.
//

import UIKit

class CryptoTableViewController: UITableViewController {
    
    //set of crypto name array list
    var cryptoLists : Array = ["BTC","DOGE","ETH","LUNA","SHIB","AVAX","DOT","GMT","APE","LINK"]

    //receive ExchangeRateAPIHelper response
    var newArray2 = Array<Any>()
    var volumeArray = [Decimal]()
    var priceArray = [Decimal]()
    
    
    //receive IconAPIHelper response
    var newArray = Array<Any>()
    //crypto asset_id list
    var iconIDArray = [String]()
    //crypto icon array list
    var iconImageArray = [String]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //fetch table view data: icon, currency name, current price, current volume
        ExchangeRateAPIHelper.fetch{ newArray in
            self.newArray = newArray

            for i in 0...5000 {
                let someDict:[String: Any] = newArray[i] as! [String : Any]

                for cryptoList in self.cryptoLists {
                    //match the crypto list in case the api and data from API crushes
                    if someDict["asset_id"] as! String == cryptoList {
                        
                        //receive currency name
                        self.iconIDArray.append(someDict["asset_id"] as! String)
                        //receive icon url string
                        let rawIcon: String = someDict["id_icon"] as! String
                        
                        var iconUrl = rawIcon.replacingOccurrences(of: "-", with: "")
                        iconUrl = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_64/" + iconUrl + ".png"
                        self.iconImageArray.append(iconUrl)
                        //transfer NSDecimalNumber from API to decimal and add to the list
                        self.priceArray.append(NSDecimalNumber(decimal: (someDict["price_usd"] as? NSNumber)?.decimalValue ?? 0.0) as Decimal)
                        self.volumeArray.append(NSDecimalNumber(decimal: (someDict["volume_1day_usd"] as! NSNumber).decimalValue) as Decimal)

                    }
                    //print(self.priceArray)
                }

            }
            self.tableView.reloadData()
        }// end of  Exchange Rate APIHelper
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return iconIDArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crypto", for: indexPath) as! CryptoTableViewCell

        // Configure name
    
        let nameCells = iconIDArray[indexPath.row]
        cell.CryptoName.text = nameCells
        // Configure image
        do{
            cell.IconImage.image = UIImage(data: try NSData(contentsOf: NSURL(string: iconImageArray[indexPath.row])! as URL) as Data)
        }catch let error{
            print(error)
        }

        //Configure price
        let priceCells = priceArray[indexPath.row]
        let volumeCells = volumeArray[indexPath.row]
        
        //tranfer the decimal to string with format .x or format no point
        let priceString : String = DecimalToString(num1: priceCells,formats: "%.1f")
        let volumeString : String = DecimalToString(num1: volumeCells,formats: "%.0f")

        if (priceCells == 0 || volumeCells == 0) {
            //in case some crypto currency has no data today
            cell.StatsPrice.text! = "Null"
            cell.TotalVol.text! = "Null"

        }else{
            //set volume to million format
            cell.StatsPrice.text! = priceString
            cell.TotalVol.text! = volumeString.dropLast(6) + "M"
            //print("cell", cell.StatsPrice.text!)
        }
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
        if let dst = segue.destination as? DetailViewController  {
            let index = tableView.indexPathForSelectedRow!.row
                    let selectedCrypto = iconIDArray[index].self
                    let selectedIcon = iconImageArray[index].self
                    let selectedPri = priceArray[index].self

                    dst.cryptoName = selectedCrypto
                    dst.iconUri = selectedIcon
                    dst.priceDec = selectedPri
                    
//                    dst.cryptoName = "selectedCrypto"
//                         dst.iconUri = "selectedIcon"
//                    dst.priceDec = 0.09
        }
        if segue.destination is NewsCollectionViewController {
            //navigate to news collection view
        }
        
     

    }
    

}
