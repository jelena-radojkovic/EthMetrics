//
//  EthMetrics.swift
//  EthMetrics
//
//  Created by Macbook Pro  on 8.6.24..
//

import WidgetKit
import SwiftUI
import Charts

struct Provider: AppIntentTimelineProvider {
    enum Constants {
        static let appGroupId = "group.com.ethmetrics"
        static let cacheKey = "sharedData"
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), points: [])
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, points: [])
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let sharedData: [Point] = loadCustomDataArray() ?? []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset * 2, to: currentDate)!
//            sharedData.append(Point(x: (sharedData.last?.x ?? 0) + 1, y: Int.random(in: 0..<10)))
            let entry = SimpleEntry(date: entryDate, configuration: configuration, points: sharedData)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    
    let points: [Point]
}

struct EthMetricsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Gas Used")
                .padding(.top, -10)
            Spacer()
            
            Chart(entry.points) {
                LineMark(
                    x: .value("x", $0.x),
                    y: .value("y", $0.y)
                )
            }.padding([.top, .bottom], 20)
                .padding(.horizontal, 10)
                .frame(width: 150)
        }
    }
}

struct EthMetrics: Widget {
    let kind: String = "EthMetrics"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            EthMetricsEntryView(entry: entry)
                .containerBackground(Color(hex: 0xF9F9E0, opacity: 1), for: .widget)
        }.supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    EthMetrics()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, points: [])
}
