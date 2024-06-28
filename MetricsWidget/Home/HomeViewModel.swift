//
//  HomeViewModel.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 9.6.24..
//

import Foundation
import WidgetKit


struct Point: Identifiable {
    var id: Int
    let x: Int
    let y: Int
}

class HomeViewModel: ObservableObject {
    let appGroupIdentifier = "group.com.ethmetrics"
    
    // niz od sedam polja, svako polje ima niz poslednjih 10 vrednosti
    // tih 10 vrednosti treba da budu queue
    @Published var streamingValues: [String: [Int]] = [:]
    
    func updateWidgetData(newData: String) {
        // Save data to UserDefaults in the shared app group
        if let userDefaults = UserDefaults(suiteName: appGroupIdentifier) {
            userDefaults.setValue(newData, forKey: "sharedData")
        }
        
        // Trigger widget update
        WidgetCenter.shared.reloadAllTimelines()
    }
}
