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
        streamingValues[Constants.gasLimit] = []
        streamingValues[Constants.gasPrice] = []
        streamingValues[Constants.value] = []
        streamingValues[Constants.gas] = []
        streamingValues[Constants.maxPriority] = []
        streamingValues[Constants.maxFee] = []
        streamingValues[Constants.size] = []
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
                        let x = self.streamingValues[key]!.last?.x ?? -1
                        self.streamingValues[key]!.append(Point(x: x + 1, y: randomY))
                    }
                }
            }
        }
    }
    
    func fetchData() {
        DispatchQueue.global(qos: .userInteractive).async {
            var startingX = 0.0
            
            while true {
                Thread.sleep(forTimeInterval: 5)
                
                NetworkManager.shared.fetchMetrics { [weak self] result in
                    guard let self else { return }
                    
                    switch result {
                    case .failure(let error):
                        fatalError("Error fetching data \(error.localizedDescription)")
                    case .success(let model):
                        DispatchQueue.main.async {
                            self.updateStreamingValues(with: model, x: startingX)
                        }
                    }
                    
                    startingX += 1
                }
            }
        }
    }

    private func updateStreamingValues(with model: EthMetricsModel, x: Double) {
        streamingValues[Constants.gasUsed]?.append(Point(x: x, y: Double(model.gasUsed)!))
        streamingValues[Constants.gasLimit]?.append(Point(x: x, y: Double(model.gasLimit)!))
        streamingValues[Constants.gasPrice]?.append(Point(x: x, y: Double(model.gasPrice)!))
        streamingValues[Constants.value]?.append(Point(x: x, y: Double(model.value)!))
        streamingValues[Constants.gas]?.append(Point(x: x, y: Double(model.gas)!))
        streamingValues[Constants.maxPriority]?.append(Point(x: x, y: Double(model.maxPriorityFeePerGas)!))
        streamingValues[Constants.maxFee]?.append(Point(x: x, y: Double(model.maxFeePerGas)!))
        streamingValues[Constants.size]?.append(Point(x: x, y: Double(model.size)!))
        streamingValues[Constants.baseFee]?.append(Point(x: x, y: Double(model.baseFeePerGas)!))
    }
    
    func updateWidgetData(with key: String) {
        guard let streamingValues = streamingValues[key] else {
            return
        }
        
        saveCustomDataArray(streamingValues)
        saveCustomString(key)
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}
