//
//  OrderCard.swift
//  Frucht
//
//  Created by Feni Brian on 20/07/2022.
//

import SwiftUI

struct OrderCard: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title.bold())
                .textCase(.uppercase)
                .layoutPriority(1)
            Text(subtitle)
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 36)
        .frame(width: 300, height: 300)
        .background(in: Circle())
    }
}

struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        OrderCard(title: "Thank you for your order!", subtitle: "We will notify you when your order is ready.")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
