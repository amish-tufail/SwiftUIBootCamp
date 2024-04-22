//
//  PagingScrollBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 22/04/2024.
//

import SwiftUI

struct PagingScrollBootCamp: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30.0) {
                ForEach(0..<10) { index in
                    Rectangle()
                        .frame(width: 300.0, height: 300.0)
                        .overlay {
                            Text("\(index)")
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical, alignment: .center)
                }
            }
        }
        .scrollTargetLayout()
//        .scrollTargetBehavior(.viewAligned) // aligns to a edge
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize) // scroll enables based on size, if size less no scroll, as data is more scroll enables
    }
}

#Preview {
    PagingScrollBootCamp()
}
