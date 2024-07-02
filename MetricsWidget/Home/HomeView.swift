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
        static let titleText = "Choose metrics you want to display in widget"
        static let cardPadding: CGFloat = 20
        static let scrollPadding: CGFloat = 30
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                Text(Constants.titleText)
                    .foregroundColor(Color(hex: Constants.titleColor, opacity: 1))
                    .padding(.all, Constants.scrollPadding)
                    .multilineTextAlignment(.center).fontWeight(.bold)
                
                ForEach(Array(viewModel.streamingValues.keys), id: \.self) { key in
                    
                    HStack {
                        Button {
                            viewModel.updateWidgetData(with: key)
                        } label: {
                            Text(key)
                                .padding(.leading, Constants.cardPadding)
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            if let chartData = viewModel.streamingValues[key] {
                                Chart(chartData) {
                                    LineMark(
                                        x: .value("x", $0.x),
                                        y: .value("y", $0.y)
                                    )
                                }.padding([.top, .bottom], Constants.cardPadding)
                                    .padding(.trailing, Constants.cardPadding)
                                    .frame(width: 150)
                            }
                        }
                    }
                    .frame(height: 130)
                    .background(Color(hex: Constants.cardColor, opacity: 1))
                    .cornerRadius(16)
                    
                }
            }.padding(.horizontal, Constants.scrollPadding)
        }
        .background(Color(hex: Constants.backgroundColor, opacity: 1))
    }
}

#Preview {
    HomeView()
}
