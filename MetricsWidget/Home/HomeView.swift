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
    
    enum Constants {
        static let titleColor = 0x0C1844
        static let cardColor = 0xF9F9E0
        static let backgroundColor = 0x028391
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("Choose metrics you want to display in widget")
                    .foregroundColor(Color(hex: Constants.titleColor, opacity: 1))
                    .padding(.all, 30)
                    .multilineTextAlignment(.center).fontWeight(.bold)
                
                ForEach(Array(viewModel.streamingValues.keys), id: \.self) { key in
                    
                    HStack {
                        Text(key)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        if let chartData = viewModel.streamingValues[key] {
                            Chart(chartData) {
                                LineMark(
                                    x: .value("x", $0.x),
                                    y: .value("y", $0.y)
                                )
                            }.padding([.top, .bottom], 20)
                                .padding(.trailing, 20)
                                .frame(width: 150)
                        }
                    }
                    .frame(height: 130)
                    .background(Color(hex: Constants.cardColor, opacity: 1))
                    .cornerRadius(16)
                    
                }
            }.padding(.horizontal, 30)
        }
        .background(Color(hex: Constants.backgroundColor, opacity: 1))
    }
}

#Preview {
    HomeView()
}
