//
//  JSONs.swift
//  desafio-ios
//
//  Created by Pedro on 02/11/17.
//  Copyright © 2017 pedrosomensi. All rights reserved.
//

import Foundation

func convertToArray(text: String) -> [Any]? {
    //print("Trying to convert string \(text) to [Any]")
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

func convertToJSONString(from object: Any) -> String? {
    //print("Trying to convert array \(object) to String")
    if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
        let objectString = String(data: objectData, encoding: .utf8)
        return objectString
    }
    return nil
}

func convertToDictionary(text: String) -> [String: Any]? {
    //print("Trying to convert string \(text) to [String:Any]")
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
