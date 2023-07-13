//
//  FeaturedSmoothieWidget.swift
//  Frucht
//
//  Created by Feni Brian on 23/07/2022.
//

import WidgetKit
import SwiftUI

struct FeaturedSmoothieWidget: Widget {
    var supportedFamilies: [WidgetFamily] {
        #if os(iOS)
        return [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge]
        #else
        return [.systemSmall, .systemMedium, .systemLarge]
        #endif
    }
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Featured Smoothie", provider: Provider()) { entry in
            FeaturedSmoothieEntryView(entry: entry)
        }
        .configurationDisplayName(Text("Featured Smoothie", comment: "The name shown for the widget when the user adds or edits it."))
        .description(Text("Displays the latest featured smoothie!", comment: "Description shown for the widget when the user adds or edits it."))
        .supportedFamilies(supportedFamilies)
    }
}

// MARK: FeaturedSmoothieWidget Extensions.

extension FeaturedSmoothieWidget {
    struct Entry: TimelineEntry {
        var date: Date
        var smoothie: Smoothie
    }
}

extension FeaturedSmoothieWidget {
    struct Provider: TimelineProvider {
        typealias Entry = FeaturedSmoothieWidget.Entry
        
        func placeholder(in context: Context) -> Entry {
            Entry(date: Date(), smoothie: .berryBlue)
        }
        
        func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
            let entry = Entry(date: Date(), smoothie: .berryBlue)
            completion(entry)
        }
        
        func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
            var entries: [Entry] = []
            let currentDate = Date()
            let smoothies = [Smoothie.berryBlue, .kiwiCutie, .hulkingLemonade, .lemonBerry, .mangoJambo, .tropicalBlue]
            
            for index in 0..<smoothies.count {
                let entryDate = Calendar.current.date(byAdding: .hour, value: index, to: currentDate)!
                let entry = Entry(date: entryDate, smoothie: smoothies[index])
                entries.append(entry)
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

// MARK: - FeaturedSmoothieEntryView

struct FeaturedSmoothieEntryView: View {
    @Environment(\.widgetFamily) private var family
    var entry: FeaturedSmoothieWidget.Provider.Entry
    
    var body: some View {
        ZStack {
            if family == .systemMedium {
                firstContentBlock
            } else {
                secondContentBlock
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(content: { BubbleBackground() })
    }
}

struct FeaturedSmoothieEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeaturedSmoothieEntryView(entry: FeaturedSmoothieWidget.Entry(date: Date(), smoothie: .berryBlue))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            FeaturedSmoothieEntryView(entry: FeaturedSmoothieWidget.Entry(date: Date(), smoothie: .kiwiCutie))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            FeaturedSmoothieEntryView(entry: FeaturedSmoothieWidget.Entry(date: Date(), smoothie: .tropicalBlue))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

// MARK: FeaturedSmoothieEntryView Extension
extension FeaturedSmoothieEntryView {
    var title: some View {
        Text(entry.smoothie.title)
            .font(family == .systemSmall ? Font.body.bold() : Font.title3.bold())
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
    
    var description: some View {
        Text(entry.smoothie.description)
            .font(.subheadline)
    }
    
    var calories: some View {
        Text(entry.smoothie.energy.formatted(.measurement(width: .wide, usage: .food)))
            .foregroundStyle(.secondary)
            .font(.subheadline)
    }
    
    var image: some View {
        Rectangle()
            .overlay {
                entry.smoothie.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .aspectRatio(1, contentMode: .fit)
            .clipShape(ContainerRelativeShape())
    }
    
    var firstContentBlock: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading) {
                title
                description
                calories
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityElement(children: .combine)
            
            image
        }
        .padding()
    }
    
    var secondContentBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                title
                if family == .systemLarge {
                    description
                    calories
                }
            }
            .accessibilityElement(children: .combine)
            
            image
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        }
        .padding()
    }
}
