//
//  FlipView.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import SwiftUI

struct FlipView<Front: View, Back: View>: View {
    var visibleSide: FlipViewSide
    @ViewBuilder var front: Front
    @ViewBuilder var back: Back
    
    var body: some View {
        ZStack {
            front
                .modifier(FlipModifier(side: .front, visibleSide: visibleSide))
            back
                .modifier(FlipModifier(side: .back, visibleSide: visibleSide))
        }
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(visibleSide: .front) {
            Text(verbatim: "Front Side")
        } back: {
            Text(verbatim: "Back Side")
        }
    }
}
