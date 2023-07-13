//
//  SmoothieHeader.swift
//  Frucht
//
//  Created by Feni Brian on 19/07/2022.
//

import SwiftUI

struct SmoothieHeader: View {
    var smoothie: Smoothie
    var wideClipShape = RoundedRectangle(cornerRadius: 20, style: .continuous)
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    var horizontallyConstrained: Bool {
        #if os(iOS)
        return horizontalSizeClass == .compact
        #else
        return false
        #endif
    }
    
    var body: some View {
        Group {
            if horizontallyConstrained {
                fullBleedContent
            } else {
                wideContent
            }
        }
        .accessibilityElement(children: .combine)
    }
}

struct SmoothieHeader_Previews: PreviewProvider {
    static var previews: some View {
        SmoothieHeader(smoothie: .berryBlue)
            .previewLayout(.sizeThatFits)
    }
}

extension SmoothieHeader {
    var fullBleedContent: some View {
        VStack(spacing: 0) {
            smoothie.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading) {
                Text(smoothie.description)
                Text(smoothie.energy.formatted(.measurement(width: .wide, usage: .food)))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background()
        }
    }
    
    var wideContent: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                #if os(macOS)
                Text(smoothie.title)
                    .font(.largeTitle.bold())
                #endif
                Text(smoothie.description)
                    .font(.title2)
                Spacer()
                Text(smoothie.energy.formatted(.measurement(width: .wide, usage: .asProvided)))
                    .foregroundStyle(.secondary)
                    .font(.headline)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background()
            
            smoothie.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 220, height: 250)
                .clipped()
                .accessibilityHidden(true)
        }
        .frame(height: 250)
        .clipShape(wideClipShape)
        .overlay{ wideClipShape.stroke(.quaternary, lineWidth: 0.5) }
        .padding()
    }
}
