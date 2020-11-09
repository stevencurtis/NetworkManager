//
//  File.swift
//  
//
//  Created by Steven Curtis on 09/11/2020.
//

import Foundation

extension Dictionary {
    func paramsString() -> String {
        var paramsString = [String]()
        for (key, value) in self {
            guard let stringValue = value as? String,
                  let stringKey = key as? String else {
                return ""
            }
            paramsString += [stringKey + "=" + "\(stringValue)"]
            
        }
        return (paramsString.isEmpty ? "" : paramsString.joined(separator: "&"))
    }
}
