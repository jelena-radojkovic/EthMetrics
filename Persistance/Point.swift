//
//  Point.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 30.6.24..
//

import Foundation

struct Point: Identifiable, Codable {
    var id = UUID()
    let x: Double
    let y: Double
}
