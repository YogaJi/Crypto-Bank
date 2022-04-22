//
//  DetailViewController.swift
//  Crypto Bank
//
//  Created by Yujia on 2022/4/21.
//

import UIKit

class DetailViewController: UIViewController {
    var cryptoName: String!
    var iconUri: String!
    var priceDec: Decimal!
    var newArray = Array<Any>()
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var highSt: UILabel!

    @IBOutlet weak var lowSt: UILabel!
    @IBOutlet weak var volSt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = cryptoName
        
        price.text = "$" + DecimalToString(num1: priceDec,formats: "%.2f")

        // Do any additional setup after loading the view.
                do{
                    Icon.image = UIImage(data: try NSData(contentsOf: NSURL(string: iconUri)! as URL) as Data)
                }catch let error{
                    print(error)
                }
        DetailCryptoAPIHelper.fetch( query: cryptoName){ newArray in
            self.newArray = newArray
            let someDict:[String: Any] = newArray[0] as! [String : Any]
            
            let price_open = NSDecimalNumber(decimal: (someDict["price_open"] as! NSNumber).decimalValue)
       
            let price_high = NSDecimalNumber(decimal: (someDict["price_high"] as! NSNumber).decimalValue)
            let price_low = NSDecimalNumber(decimal: (someDict["price_low"] as! NSNumber).decimalValue)
            let volume_traded = NSDecimalNumber(decimal: (someDict["volume_traded"] as! NSNumber).decimalValue)
            

            let higher: String = calculateToString(num1: price_high, num2: price_open)
            
            let lower: String = calculateToString(num1: price_open, num2: price_low)
            
            self.highSt.text = higher
            self.lowSt.text = lower
            self.volSt.text = NSDecimalToString(num1: volume_traded)
            print("higher",higher)
            print("lower", lower)
            }
    }
    

}
