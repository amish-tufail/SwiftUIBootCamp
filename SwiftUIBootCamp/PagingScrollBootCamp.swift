//
//  PagingScrollBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 22/04/2024.
//

import SwiftUI

struct PagingScrollBootCamp: View {
    @State private var scrollPosition: Int? = nil
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<10) { index in
                    Rectangle()
                        .frame(width: 300.0, height: 300.0)
                        .overlay {
                            Text("\(index)")
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .containerRelativeFrame(.vertical, alignment: .center)
                        .id(index)
                        .scrollTransition(.interactive) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.0)
                                .blur(radius: phase.isIdentity ? 0.0 : 20.0)
                        }
                }
            }
        }
        .scrollTargetLayout()
//        .scrollTargetBehavior(.viewAligned) // aligns to a edge
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize) // scroll enables based on size, if size less no scroll, as data is more scroll enables
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .animation(.smooth, value: scrollPosition)
        .safeAreaInset(edge: .bottom) {
            Button {
                scrollPosition = (0..<10).randomElement()
            } label: {
                Text("Scroll To")
            }
        }
    }
}

#Preview {
    PagingScrollBootCamp()
}
