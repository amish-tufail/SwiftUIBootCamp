//
//  ViewThatFitView.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 29/12/2023.
//

import SwiftUI

struct ViewThatFitView: View {
    var body: some View {
        ZStack {
            // Now here the issue is that the line limit is 1 and text goes ..., so to fix this one way is to minimiz the size, but some time we dont want to do this
//            VStack {
//                Text("This is a my message to you and all of you okeh")
//                    .lineLimit(1)
//                    .minimumScaleFactor(0.8)
//            }
            // Here comes ViewThatFit, it auto fits the most suitable text
            // Now here it will use that text that fits into the view without ... this
            ViewThatFits {
                Text("This is a my message to you and all of you okeh")
                Text("This is a my message to you and all")
                Text("This is a my message to you")
            }
        }
        .frame(width: 350.0, height: 350.0)
        .background(.red)
        .padding()
    }
}

#Preview {
    ViewThatFitView()
}
