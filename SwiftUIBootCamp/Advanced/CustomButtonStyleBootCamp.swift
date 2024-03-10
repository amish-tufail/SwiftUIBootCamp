//
//  CustomButtonStyleBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 10/03/2024.
//

import SwiftUI

struct MyCustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.cyan)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 12.0))
            .padding()
            .opacity(isPressed ? 0.8 : 1.0)
            .scaleEffect(isPressed ? 1.5 : 1.0)
            .animation(.linear(duration: 2.0), value: isPressed)
            
    }
}

extension View {
    func customStyle() -> some View {
        self
            .buttonStyle(MyCustomButtonStyle())
    }
}

struct CustomButtonStyleBootCamp: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Custom Button Style")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.cyan)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 12.0))
                    .padding()
            }
            .buttonStyle(.plain) // Default
            
            Button {
                
            } label: {
                Text("Custom Button Style")
            }
            .buttonStyle(MyCustomButtonStyle()) // Custom Style, it is good but we can make it even better
            
            Button {
                
            } label: {
                Text("Custom Button Style")
            }
            .customStyle()
        }
    }
}

#Preview {
    CustomButtonStyleBootCamp()
}
