//
//  AccessbilityTextBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 30/12/2023.
//

import SwiftUI

struct AccessbilityTextBootcamp: View {
    @Environment(\.dynamicTypeSize) var sizes // This gives us which type size user has selected
    
    var body: some View {
        VStack {
            List {
                ForEach(0..<10, id:\.self) { _ in
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.largeTitle)
                        Text("This is a subtitle, it could have been a description as well.")
                            .lineLimit(2)
                            .minimumScaleFactor(sizes.minimumScaleFactor) // we use this based on dynamic size
                        
                    }
                }
            }
        }
    }
}

// Here we exetend it, its enum ig, and we add our computed type where we return minimumscale values which will change base on your app or screen
extension DynamicTypeSize {
    var minimumScaleFactor: CGFloat {
        switch self {
        case .xSmall:
            return 1.0
        case .small:
            return 1.0
        case .medium:
            return 1.0
        case .large:
            return 0.85
        case .xLarge:
            return 0.8
        case .xxLarge:
            return 0.7
        case .xxxLarge:
            return 0.7
        case .accessibility1:
            return 0.7
        case .accessibility2:
            return 0.7
        case .accessibility3:
            return 0.6
        case .accessibility4:
            return 0.5
        case .accessibility5:
            return 0.45
        default:
            return 0.45
        }
    }
}

#Preview {
    AccessbilityTextBootcamp()
}
