//
//  AccessbilityColorBootcamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 30/12/2023.
//

import SwiftUI

struct AccessbilityColorBootcamp: View {
    @Environment(\.accessibilityInvertColors) var invert
    @Environment(\.accessibilityReduceTransparency) var transparency
    // We can use these envionrments variables and many other as well to customize colors if a user has enabled any of these
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AccessbilityColorBootcamp()
}
