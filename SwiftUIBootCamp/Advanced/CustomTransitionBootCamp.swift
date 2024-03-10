//
//  CustomTransitionBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 10/03/2024.
//

import SwiftUI

struct MyCustomTransitionModifier: ViewModifier {
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation))
            .offset(x: rotation != 0.0 ? 500 : 0.0, y: rotation != 0.0 ? 500 : 0.0)
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        return AnyTransition.modifier(active: MyCustomTransitionModifier(rotation: 180.0), identity: MyCustomTransitionModifier(rotation: 0.0))
    }
    
    static func rotating(degree: Double) -> AnyTransition {
        return AnyTransition.modifier(active: MyCustomTransitionModifier(rotation: degree), identity: MyCustomTransitionModifier(rotation: 0.0))
    }
    
    static var onChange: AnyTransition {
        return AnyTransition.asymmetric(insertion: .rotating, removal: .slide)
    }
}

struct CustomTransitionBootCamp: View {
    @State private var isPressed = false
    var body: some View {
        VStack {
            Spacer()
            if isPressed {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(.orange)
                    .frame(width: 300.0, height: 400.0)
//                    .transition(.move(edge: .bottom)) // Default Transition
//                    .transition(.rotating)
//                    .transition(.rotating(degree: 1080))
                    .transition(.onChange)
            }
            Spacer()
            Button {
                withAnimation(.easeInOut(duration: 3.2)) {
                    isPressed.toggle()
                }
            } label: {
                Text("Custom Transition")
            }
            .customStyle()
        }
    }
}

#Preview {
    CustomTransitionBootCamp()
}
