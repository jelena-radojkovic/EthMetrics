//
//  HomeViewModel.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 9.6.24..
//

import Foundation
import WidgetKit

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
        static let maxFee = "Max Fee Per Gas"
        static let size = "Size"
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
                Thread.sleep(forTimeInterval: 5)
                
                for key in self.streamingValues.keys {
                    let randomY = Double.random(in: 0..<10)
                    
                    DispatchQueue.main.async {
                        let x = self.streamingValues[key]!.last?.x ?? 0
                        self.streamingValues[key]!.append(Point(x: x + 1, y: randomY))
                    }
                }
            }
        }
    }
    
    func updateWidgetData(with key: String) {
        guard let streamingValues = streamingValues[key] else {
            return
        }
        
        saveCustomDataArray(streamingValues)
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}
