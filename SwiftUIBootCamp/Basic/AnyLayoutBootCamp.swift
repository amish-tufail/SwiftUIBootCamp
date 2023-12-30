//
//  AnyLayoutBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 29/12/2023.
//

import SwiftUI

struct AnyLayoutBootCamp: View {
    @Environment(\.horizontalSizeClass) var horizontal
    @Environment(\.verticalSizeClass) var vertical
    
    var body: some View {
        VStack {
            Text("Horizontal: \(horizontal.debugDescription)")
            Text("Vertical: \(vertical.debugDescription)")
            
            if vertical == .regular {
                VStack {
                    Text("1")
                    Text("2")
                    Text("3")
                }
            } else {
                HStack {
                    Text("1")
                    Text("2")
                    Text("3")
                }
            }
            // Now what we have done is that when veritcal is regular which means in potrait then we will have a VStack, but when it is compact meaning in landscape then it will convert it into HStack
            // This strategy is good but we can make our code much simpler and shorter using ANYLAYOUT
            
            Text("ANYLAYOUT")
                .bold()
            let layout: AnyLayout = vertical == .regular ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
            layout {
                Text("1")
                Text("2")
                Text("3")
            }
            // So, here we define the value in layout so it auto changes and determines, and we dont need if else and having to write code again.
        }
    }
}

#Preview {
    AnyLayoutBootCamp()
}
