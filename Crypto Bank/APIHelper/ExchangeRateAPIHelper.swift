//
//  ExchangeRateAPIHelper.swift
//  Crypto Bank
//
//  Created by Yujia on 2022/3/31.
//

import Foundation
struct ExchangeRateAPIHelper{
    
    private static let baseURL: String = "https://rest.coinapi.io/v1/assets"
    private static var apiKey: String = "?apikey=0DEB865A-360B-49B6-841C-811224CFCB2F&history?period_id=1DAY"
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    static func fetch(callback: @escaping (Array<Any>) -> Void){
        guard
            let url = URL(string: baseURL + apiKey)
        else{return}
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                do{
     
                    let jsonObject2 = try JSONSerialization.jsonObject(with: data, options: [])
                    guard
                        let jsonDictionary2 = jsonObject2 as? Array<Any>

                    else {preconditionFailure("could not parse JSOn data")}
                    //print(jsonDictionary[1])
                    
//                    var newArray = Array<Any>()
//                    newArray.append(jsonDictionary[1])
//                    //for i in 0...10 {
//                        let someDict:[String: Any] = jsonDictionary[1] as! [String : Any]
//                        print(someDict["volume_1day_usd"]!)
//                        print(someDict["price_usd"]!)
                    //}
                    
                    //var newArray = [String]()
                   
//                    for i in 0..<jsonDictionary.count {
//                       let item = jsonDictionary[i]
//                        newArray.append(item as! String)
//                    }
//                    print(newArray[1])
                    OperationQueue.main.addOperation {
                        callback(jsonDictionary2)
                    }
                } catch let e {
                    print("error \(e)")
                }
            } else if let error = error {
                print("there was an error: \(error)")
            } else {
                print("something went wrong")
            }
        }
        task.resume()
    }
}
