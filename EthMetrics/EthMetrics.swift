//
//  EthMetrics.swift
//  EthMetrics
//
//  Created by Macbook Pro  on 8.6.24..
//

import WidgetKit
import SwiftUI
import Charts


struct Point: Identifiable {
    var id: Int
    let x: Int
    let y: Int
}


struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct EthMetricsEntryView : View {
    var entry: Provider.Entry

    let mockData: [Point] = [
        Point(id: 0, x: 1, y: 0),
        Point(id: 1, x: 2, y: 2),
        Point(id: 2, x: 3, y: 4),
        Point(id: 3, x: 4, y: 5),
        Point(id: 4, x: 5, y: 8),
        Point(id: 5, x: 6, y: 12)
    ]
    
    var body: some View {
        VStack {
            Text("Gas Used")
                .padding(.top, -10)
            //            Text(entry.date, style: .time)
            Spacer()
            
            Chart(mockData) {
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
//        StaticConfiguration(
//            kind: kind,
//            provider: MyProvider()) { entry in
//            EthMetricsEntryView(entry: entry)
//               .frame(maxWidth: .infinity, maxHeight: .infinity)    // << here !!
//               .background(Color.green)
//        }.supportedFamilies([.systemSmall])
        
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
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
