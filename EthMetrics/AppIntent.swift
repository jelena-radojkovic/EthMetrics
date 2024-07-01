//
//  AppIntent.swift
//  EthMetrics
//
//  Created by Macbook Pro  on 8.6.24..
//

import WidgetKit
import AppIntents

//@available(macOS 14.0, *)
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
