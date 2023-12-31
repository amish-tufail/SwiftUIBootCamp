//
//  AccessbilityVoiceOverBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 31/12/2023.
//

import SwiftUI

struct AccessbilityVoiceOverBootcamp: View {
    @State var isOn: Bool = false
    var body: some View {
        List {
            Section {
                VStack {
                    Toggle("Volume", isOn: $isOn) // This has accessibility by default as its a native component
                    // But what about it when we have our own custom component
                    HStack {
                        Text("Volume")
                        Spacer()
                        Text(isOn ? "On" : "Off") // Good but to make it accessible hide it with a modifier and add .accessibilityValue()
                            .accessibilityHidden(true)
                    }
                    // Now without using any modifier it will just say volume or ig volume on/off
                    // Now we add modifiers to make it accessible
                    .accessibilityElement(children: .combine) // This combines both text and are called as one -> "Volume On"
                    .accessibilityAddTraits(.isButton) // This tell its a button
                    .accessibilityValue(isOn ? "is on" : "is off")
                    .accessibilityHint("Double tap to toggle it.") // Here it tells what to do to change it.
                    .accessibilityAction { // Its a good practice to add the action as well
                        isOn.toggle()
                    }
                    Text("Section2") // Now to make this header like if we swipe up and down we move from one section to another, so, this is our custom section so it doesnt have native thing so to add it
                        .accessibilityAddTraits(.isHeader)
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill") // Now this native but what it says is not what we want as diff app require diff names, so...
                            .accessibilityLabel("Favourites") // This adds label
                    }
                    
                }
                // Further more there are more options to explore according to your app.
            } header: {
                Text("Accessibility")
            }
        }
    }
}

#Preview {
    AccessbilityVoiceOverBootcamp()
}
