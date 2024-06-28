//
//  EthMetricsLiveActivity.swift
//  EthMetrics
//
//  Created by Macbook Pro  on 8.6.24..
//

import ActivityKit
import WidgetKit
import SwiftUI

struct EthMetricsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct EthMetricsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EthMetricsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension EthMetricsAttributes {
    fileprivate static var preview: EthMetricsAttributes {
        EthMetricsAttributes(name: "World")
    }
}

extension EthMetricsAttributes.ContentState {
    fileprivate static var smiley: EthMetricsAttributes.ContentState {
        EthMetricsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: EthMetricsAttributes.ContentState {
         EthMetricsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: EthMetricsAttributes.preview) {
   EthMetricsLiveActivity()
} contentStates: {
    EthMetricsAttributes.ContentState.smiley
    EthMetricsAttributes.ContentState.starEyes
}
