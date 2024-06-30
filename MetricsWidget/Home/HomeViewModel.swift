//
//  HomeViewModel.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 9.6.24..
//

import Foundation
import WidgetKit


struct Point: Identifiable {
    let id = UUID()
    let x: Int
    let y: Int
}

class HomeViewModel: ObservableObject {
    let appGroupIdentifier = Constants.appGroupId
    @Published var streamingValues: [String: [Point]] = [:]
    
    enum Constants {
        static let appGroupId = "group.com.ethmetrics"
        static let cacheKey = "sharedData"
        static let gasUsed = "Gas used"
        static let gasLimit = "Gas limit"
        static let gasPrice = "Gas price"
        static let value = "Value"
        static let gas = "Gas"
        static let maxPriority = "Max priority fee per gas"
        static let baseFee = "Base fee per gas"
    }
    
    init() {
        streamingValues[Constants.gasUsed] = []
        streamingValues[Constants.gasPrice] = []
        streamingValues[Constants.value] = []
        streamingValues[Constants.gas] = []
        streamingValues[Constants.gasLimit] = []
        streamingValues[Constants.maxPriority] = []
        streamingValues[Constants.baseFee] = []
        
        fetchMockData()
    }
    
    func fetchMockData() {
        DispatchQueue.global(qos: .userInteractive).async {
            while true {
                Thread.sleep(forTimeInterval: 2)
                
                for key in self.streamingValues.keys {
                    let randomY = Int.random(in: 0..<10)
                    
                    DispatchQueue.main.async {
                        let x = self.streamingValues[key]!.last?.x ?? 0
                        self.streamingValues[key]!.append(Point(x: x + 1, y: randomY))
                    }
                }
            }
        }
    }
    
    func updateWidgetData(newData: String) {
        // Save data to UserDefaults in the shared app group
        if let userDefaults = UserDefaults(suiteName: appGroupIdentifier) {
            userDefaults.setValue(newData, forKey: Constants.cacheKey)
        }
        
        // Trigger widget update
        WidgetCenter.shared.reloadAllTimelines()
    }
}
