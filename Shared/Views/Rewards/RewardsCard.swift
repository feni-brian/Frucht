//
//  RewardsCard.swift
//  Frucht
//
//  Created by Feni Brian on 20/07/2022.
//

import SwiftUI

struct RewardsCard: View {
    var totalStamps: Int
    var animatedStamps: Int = 0
    var hasAccount: Bool
    var compact: Bool = false
    var spacing: Double { compact ? 10 : 20 }
    var columns: [GridItem] { [GridItem](repeating: GridItem(.flexible(minimum: 20), spacing: 10), count: 5) }
    
    var body: some View {
        VStack {
            firstBlock
            if !compact { secondBlock }
        }
        .padding(20)
    }
}

struct RewardsCard_Previews: PreviewProvider {
    static var previews: some View {
        RewardsCard(totalStamps: 8, animatedStamps: 4, hasAccount: true)
            .previewLayout(.sizeThatFits)
    }
}

//MARK: - Extension.

extension RewardsCard {
    
    struct StampSlot: View {
        var status: Status
        var compact: Bool = false
        @State private var stamped = false
        
        var body: some View {
            ZStack {
                Circle().fill(Color("bubbles-background").opacity(0.5))
                
                switch status {
                case .stamped, .stampedAnimaed:
                    Image(systemName: "seal.fill")
                        .font(.system(size: compact ? 24 : 30))
                        .scaleEffect(stamped ? 1 : 2)
                        .foregroundStyle(Color("rewards-foreground"))
                default:
                    EmptyView()
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear(perform: switchAction)
        }
        
        enum Status {
            case unstamped
            case stampedAnimaed(delayIndex: Int)
            case stamped
        }
        
        fileprivate func switchAction() {
            switch status {
            case .stamped:
                stamped = true
            case .stampedAnimaed(let delayIndex):
                let delay = Double(delayIndex + 1) * 0.15
                #if !os(macOS)
                withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.8).delay(delay)) { stamped = true }
                #else
                stamped = true
                #endif
            default:
                stamped = false
            }
        }
    }
    
    var firstBlock: some View {
        VStack(spacing: 0) {
            Text("Rewards Card", comment: "Header for rewards card.")
                .font(compact ? Font.subheadline.bold() : Font.title2.bold())
                .padding(.top, spacing)
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(1...10, id: \.self) { index in
                    let status: StampSlot.Status = {
                        guard index <= totalStamps else { return .unstamped }
                        let firstAnimatedIndex = totalStamps - animatedStamps
                        if index >= firstAnimatedIndex {
                            return .stampedAnimaed(delayIndex: index - firstAnimatedIndex)
                        } else {
                            return .stamped
                        }
                    }()
                    StampSlot(status: status, compact: compact)
                }
            }
            .frame(maxWidth: compact ? 250 : 300)
            .opacity(hasAccount ? 1 : 0.5)
            .padding(spacing)
        }
        .background()
        .clipShape(RoundedRectangle(cornerRadius: spacing, style: .continuous))
        .accessibility(label: Text("\(totalStamps) of 10 points earned.", comment: "Accessibility label for number of points earned."))
    }
    
    var secondBlock: some View {
        Group {
            if hasAccount {
                Text("You are \(10 - totalStamps) points away from a free smoothie!", comment: "Label showing the number of points needed to get a free smoothie in rewards card view.")
            } else {
                #if EXTENDED_ALL
                Text("Sign up to get rewards!", comment: "Label shown in rewards card view when no account has been created yet.")
                #endif
            }
        }
        .font(.system(.headline, design: .rounded).bold())
        .multilineTextAlignment(.center)
        .foregroundStyle(Color("rewards-foreground"))
        .padding(.horizontal, 20)
    }
}
