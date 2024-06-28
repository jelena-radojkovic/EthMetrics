//
//  HomeView.swift
//  MetricsWidget
//
//  Created by Macbook Pro  on 9.6.24..
//

import SwiftUI
import Charts

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    let mockData: [Point] = [
        Point(id: 0, x: 1, y: 0),
        Point(id: 1, x: 2, y: 2),
        Point(id: 2, x: 3, y: 4),
        Point(id: 3, x: 4, y: 5),
        Point(id: 4, x: 5, y: 8),
        Point(id: 5, x: 6, y: 12)
    ]
    var body: some View {
        ZStack {
            ScrollView {
                Text("Choose metrics you want to display in widget")
                    .foregroundColor(Color(hex: 0x0C1844, opacity: 1))
                    .padding(.all, 30)
                    .multilineTextAlignment(.center).fontWeight(.bold)
                
                HStack {
                    Text("Gas used")
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Chart(mockData) {
                        LineMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y)
                        )
                    }.padding([.top, .bottom], 20)
                        .padding(.trailing, 20)
                        .frame(width: 150)
                }
                .frame(height: 130)
                .background(Color(hex: 0xF9F9E0, opacity: 1))
                .cornerRadius(16)
            
                
                HStack {
                    Text("Gas limit")
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Chart(mockData) {
                        LineMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y)
                        )
                    }.padding([.top, .bottom], 20)
                        .padding(.trailing, 20)
                        .frame(width: 150)
                }
                .frame(height: 130)
                .background(Color(hex: 0xF9F9E0, opacity: 1))
                .cornerRadius(16)
                
                HStack {
                    Text("Gas price")
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Chart(mockData) {
                        LineMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y)
                        )
                    }.padding([.top, .bottom], 20)
                        .padding(.trailing, 20)
                        .frame(width: 150)
                }
                .frame(height: 130)
                .background(Color(hex: 0xF9F9E0, opacity: 1))
                .cornerRadius(16)
                
                HStack {
                    Text("Value")
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Chart(mockData) {
                        LineMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y)
                        )
                    }.padding([.top, .bottom], 20)
                        .padding(.trailing, 20)
                        .frame(width: 150)
                }
                .frame(height: 130)
                .background(Color(hex: 0xF9F9E0, opacity: 1))
                .cornerRadius(16)
                
                HStack {
                    Text("Gas")
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Chart(mockData) {
                        LineMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y)
                        )
                    }.padding([.top, .bottom], 20)
                        .padding(.trailing, 20)
                        .frame(width: 150)
                }
                .frame(height: 130)
                .background(Color(hex: 0xF9F9E0, opacity: 1))
                .cornerRadius(16)
                
                HStack {
                    Text("Max priority fee per gas")
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Chart(mockData) {
                        LineMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y)
                        )
                    }.padding([.top, .bottom], 20)
                        .padding(.trailing, 20)
                        .frame(width: 150)
                }
                .frame(height: 130)
                .background(Color(hex: 0xF9F9E0, opacity: 1))
                .cornerRadius(16)
                
                HStack {
                    Text("Base fee per gas")
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Chart(mockData) {
                        LineMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y)
                        )
                    }.padding([.top, .bottom], 20)
                        .padding(.trailing, 20)
                        .frame(width: 150)
                }
                .frame(height: 130)
                .background(Color(hex: 0xF9F9E0, opacity: 1))
                .cornerRadius(16)
                
            }.padding(.horizontal, 30)
        }
        .background(Color(hex: 0x028391, opacity: 1))
    }
}

#Preview {
    HomeView()
}
