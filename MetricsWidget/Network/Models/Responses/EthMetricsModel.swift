//
//  EthMetricsModel.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 15.6.24..
//

import Foundation

struct EthMetricsModel: Codable {
    let gasUsed: String
    let gasLimit: String
    let gasPrice: String
    let value: String
    let gas: String
    let maxPriorityFeePerGas: String
    let maxFeePerGas: String
    let size: String
    let baseFeePerGas: String
}
