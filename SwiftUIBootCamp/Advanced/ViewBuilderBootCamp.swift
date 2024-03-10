//
//  ViewBuilderBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 10/03/2024.
//

import SwiftUI

struct GenericViewBuilder<T: View>: View {
    let content: T
    
    init(@ViewBuilder content: () -> T) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Text("Header Section")
            content
        }
    }
}

struct ViewBuilderBootCamp: View {
    var body: some View {
        VStack {
            // This is working perfectly, but doesnt look good, so, we add custom init and then add @ViewBuilder
            //            GenericViewBuilder(content: VStack {
            //                Text("Text 1")
            //                Text("Text 2")
            //                Text("Text 3")
            //                Image(systemName: "heart.fill")
            //            })
            
            GenericViewBuilder { // This looks better
                VStack {
                    Text("Text 1")
                    Text("Text 2")
                    Text("Text 3")
                }
            }
            Text("_________________")
            GenericViewBuilderTwo(type: .one)
            GenericViewBuilderTwo(type: .two)
            GenericViewBuilderTwo(type: .three)
        }
    }
}

#Preview {
    ViewBuilderBootCamp()
}

struct GenericViewBuilderTwo: View {
    enum TYPE {
        case one
        case two
        case three
    }
    let type: TYPE
    
    var body: some View {
        VStack {
            conditions
        }
    }
//    private var conditions: some View { // Gives error as condition can return diff type of views, so fix is @ViewBuilder
//        if type == .one {
//            one
//        } else if type == .two {
//            two
//        } else if type == .three {
//            three
//        }
//    }
    
    @ViewBuilder private var conditions: some View { // Adding fixes that above issue
        switch type { // Same with if/else
        case .one:
            one
        case .two:
            two
        case .three:
            three
        }
    }
    private var one: some View {
        Text("ONE")
    }
    
    private var two: some View {
        Text("TWO")
    }
    
    private var three: some View {
        Text("THREE")
    }
}
