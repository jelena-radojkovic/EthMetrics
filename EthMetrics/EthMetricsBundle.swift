//
//  EthMetricsBundle.swift
//  EthMetrics
//
//  Created by Macbook Pro  on 8.6.24..
//

import WidgetKit
import SwiftUI

@main
struct EthMetricsBundle: WidgetBundle {
    var body: some Widget {
        EthMetrics()
        EthMetricsLiveActivity()
    }
}
