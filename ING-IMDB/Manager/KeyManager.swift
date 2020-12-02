//
//  KeyManager.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 2.12.2020.
//

import Foundation

class KeyManager {
    
    class func getTmdbApiKey() -> String? {
        guard let path = Bundle.main.path(forResource: "Key", ofType: "plist") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            guard let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? Dictionary<String, String> else {
                return nil
            }
            return plist["tmdbApiKey"]
        } catch {
            return nil
        }
    }
    
}
