//
//  getDate.swift
//  Crypto Bank
//
//  Created by Yujia on 2022/4/25.
//

import Foundation

func getDate() -> String{
    
    let date = Date()
    let df = DateFormatter()
    df.dateFormat = "MM/dd"
    let dateString = df.string(from: date)
    return dateString
}
