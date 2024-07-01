//
//  UserDefaultsCaching.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 30.6.24..
//

import Foundation

func saveCustomDataArray(_ dataArray: [Point]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(dataArray),
       let userDefaults = UserDefaults(suiteName: "group.com.ethmetrics") {
        userDefaults.set(encoded, forKey: "sharedData")
    }
}

func loadCustomDataArray() -> [Point]? {
    if let userDefaults = UserDefaults(suiteName: "group.com.ethmetrics"),
       let savedData = userDefaults.data(forKey: "sharedData") {
        let decoder = JSONDecoder()
        if let loadedDataArray = try? decoder.decode([Point].self, from: savedData) {
            return loadedDataArray
        }
    }
    return nil
}