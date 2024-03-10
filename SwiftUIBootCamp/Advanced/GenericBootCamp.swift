//
//  GenericBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 10/03/2024.
//

import SwiftUI

struct GenericModel<T> { // Generic Model
    let value: T
}

struct GenericView<T: View>: View { // Generic View
    let content: T
    var body: some View {
        VStack {
            Text("Generic View")
            content
        }
    }
}

struct GenericBootCamp: View {
    var body: some View {
        VStack {
            GenericView(content: VStack(content: {
                ZStack(content: {
                    RoundedRectangle(cornerRadius: 12.0)
                        .frame(height: 200.0)
                    Text("Custom View")
                        .font(.title)
                        .fontWeight(.heavy)
                        .kerning(3.0)
                        .foregroundStyle(.white)
                })
                .padding()
            }))
            
            GenericView(content: VStack(content: {
                ZStack(content: {
                    RoundedRectangle(cornerRadius: 12.0)
                        .fill(.orange)
                        .frame(height: 200.0)
                    Text("Custom View")
                        .font(.title)
                        .fontWeight(.heavy)
                        .kerning(3.0)
                        .foregroundStyle(.white)
                })
                .padding()
            }))
        }
    }
}

#Preview {
    GenericBootCamp()
}
