//
//  CustomViewModifiersBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 10/03/2024.
//

import SwiftUI

struct MyCustomModifier: ViewModifier {
    func body(content: Content) -> some View { // ==  .modifier(MyCustomModifier())
        content
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .clipShape(.rect(cornerRadius: 12.0))
    }
}

extension View {
    func customModifierButton() -> some View { // ==   .customModifierButton()
//        self
//            .modifier(MyCustomModifier())
        
        // OR
        
        modifier(MyCustomModifier())
    }
}

struct CustomViewModifiersBootCamp: View {
    var body: some View {
        VStack {
            Text("Custom View Modifiers")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .clipShape(.rect(cornerRadius: 12.0))
                .padding()
            Text("Custom View Modifiers")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .clipShape(.rect(cornerRadius: 12.0))
                .padding()
            
            // Repeation is taking place above so, to fix this we create our own custom modifier like .font(), .fontWeight() etc
            
            Text("Custom View Modifiers")
                .modifier(MyCustomModifier())
                .padding()
            
            // As you see above, we used our custom modifier, but still it doesnt look like .font() etc, it works but we can make it even better
            
            // For this we extend View and create a function and call that Custom Modifier in it
            
            Text("Custom View Modifiers")
                .customModifierButton()
                .padding()
            
            // Now much more better
        }
    }
}

#Preview {
    CustomViewModifiersBootCamp()
}
