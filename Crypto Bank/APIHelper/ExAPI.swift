//
//  ExAPI.swift
//  Crypto Bank
//
//  Created by Yujia on 2022/4/21.
//

import Foundation
struct ExAPI{
    
    private static let baseURL: String = "https://api.blockchain.com/v3/exchange/tickers"
  
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    static func fetch(callback: @escaping (Array<Any>) -> Void){
        guard
            let url = URL(string: baseURL)
        else{return}
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                do{
     
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    guard
                        let jsonDictionary = jsonObject as? Array<Any>

                    else {preconditionFailure("could not parse JSOn data")}

                    OperationQueue.main.addOperation {
                        callback(jsonDictionary)
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
