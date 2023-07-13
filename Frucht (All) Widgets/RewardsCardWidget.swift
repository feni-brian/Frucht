//
//  RewardsCardWidget.swift
//  Frucht
//
//  Created by Feni Brian on 23/07/2022.
//

import WidgetKit
import SwiftUI

struct RewardsCardWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "RewardsCard", provider: Provider()) { entry in
            RewardsCardEntryView(entry: entry)
        }
        .configurationDisplayName(Text("Rewards Card", comment: "The name shown for the widget when the user adds or edits it."))
        .description(Text("See your progress towards your next free smoothie!", comment: "Description shown for the widget when the user adds or edits it."))
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

// MARK: - RewardsCardWidget Extensions.

extension RewardsCardWidget {
    struct Entry: TimelineEntry {
        var date: Date
        var points: Int
    }
}

extension RewardsCardWidget {
    struct Provider: TimelineProvider {
        typealias Entry = RewardsCardWidget.Entry
        
        func placeholder(in context: Context) -> Entry {
            Entry(date: Date(), points: 4)
        }
        
        func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
            completion(Entry(date: Date(), points: 4))
        }
        
        func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
            let entry = Entry(date: Date(), points: 4)
            let timeline = Timeline(entries: [entry], policy: .never)
            completion(timeline)
        }
    }
}

// MARK: - RewardsCardEntryView

struct RewardsCardEntryView: View {
    @Environment(\.widgetFamily) private var family
    var entry: RewardsCardWidget.Entry
    var compact: Bool { family != .systemLarge }
    
    var body: some View {
        ZStack {
            BubbleBackground()
            RewardsCard(totalStamps: entry.points, hasAccount: true, compact: compact)
        }
    }
}

struct RewardsCardEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RewardsCardEntryView(entry: .init(date: Date(), points: 4))
                .previewDisplayName("Small")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .redacted(reason: .placeholder)
            RewardsCardEntryView(entry: .init(date: Date(), points: 4))
                .previewDisplayName("Medium")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            RewardsCardEntryView(entry: .init(date: Date(), points: 4))
                .previewDisplayName("Large")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
