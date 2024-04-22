//
//  VisualEffectModifierBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 22/04/2024.
//

import SwiftUI

// Visual Effect is like geometry reader, but is in modifier form

struct VisualEffectModifierBootCamp: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                ForEach(0..<100) { index in
                    Rectangle()
                        .fill(.black)
                        .frame(width: 300.0, height: 200.0)
                        .frame(maxWidth: .infinity)
                        .background(.orange)
                        .visualEffect { content, geometry in
                            content
                                .offset(x: geometry.frame(in: .global).minY * 0.05)
                        }
                }
            }
        }
//        VStack {
//            Text("Hello World!")
//                .foregroundStyle(.black)
//                .frame(width: 300.0, height: 200.0)
//                .background(Color.red)
//                .visualEffect { content, geometry in
//                    content // Special type of content and has limited modifiers to apply
////                        .grayscale(geometry.size.width > 300 ? 1.0 : 0.0)
//                        .grayscale(geometry.frame(in: .global).minY < 300 ? 1.0 : 0.0)
//                }
//            Spacer()
//        }
    }
}

#Preview {
    VisualEffectModifierBootCamp()
}
