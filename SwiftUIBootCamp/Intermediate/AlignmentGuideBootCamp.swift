//
//  AlignmentGuideBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 01/01/2024.
//

import SwiftUI

struct AlignmentGuideBootCamp: View {
    @State var show = false
    var body: some View {
        VStack(spacing: 50.0) {
            VStack(alignment: .leading) {
                Text("Hello")
                    .background(.red)
                    .offset(x: -50.0) // We can see it goes outside the orange background which is not good on every case so to fix this we usen alignment guides
                Text("Hello Worl! Hello Planet!")
                    .background(.green)
            }
            .background(.orange)
             
            VStack(alignment: .leading) {
                Text("Hello")
                    .background(.red)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        return dimension.width
//                        return 50.0
                    }) // Now here it fixes this
                Text("Hello Worl! Hello Planet!")
                    .background(.green)
            }
            .background(.orange)
            VStack(alignment: .center) {
                HStack {
                    if show {
                        Image(systemName: "heart.fill")
                    }
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "heart.fill")
                    Text("Hello")
                }
            } // Here you can see that when there is no image then alignment is not consisitent
            
            VStack {
                HStack {
                    if show {
                        Image(systemName: "heart.fill")
                    }
                    Text("Hello")
                    Spacer()
                }
                .alignmentGuide(.leading, computeValue: { dimension in
                    return show ? 100.0 : 0.0
                })
                .background(.red)
                HStack {
                    Image(systemName: "heart.fill")
                    Text("Hello")
                    Spacer()
                }
                .background(.red)
                .alignmentGuide(.leading, computeValue: { dimension in
                    return show ? 100.0 : 0.0
                }) // by using this we can fix the issue of alignment, here it doesnt appear but it does, when i apply so it push HStack to left like in 2 no view, so hello will align here
            }
            .padding(50.0)
            .background(.yellow)
        }
    }
}

#Preview {
    AlignmentGuideBootCamp()
}
