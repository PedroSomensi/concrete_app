//
//  DateConvert.swift
//  desafio-ios
//
//  Created by Pedro on 04/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation


func convertDate(str: String) -> String {
    
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let date = dateFormatter.date(from: str) else { return "" }
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    dateFormatter.locale = tempLocale
    let dateString = dateFormatter.string(from: date)
    return dateString
    
}
