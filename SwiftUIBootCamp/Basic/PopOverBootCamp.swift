//
//  PopOverBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 29/12/2023.
//

import SwiftUI

struct PopOverBootCamp: View {
    @State var showPopover: Bool = false
    var body: some View {
        VStack {
            Button {
                withAnimation(.easeInOut) {
                    showPopover.toggle()
                }
            } label: {
                Text("Show PopOver")
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18.0)
                    .fill(.orange.opacity(0.60))
            )
            .popover(isPresented: $showPopover, content: {
                Button {
                    showPopover.toggle()
                } label: {
                    Text("POP")
                }
                .bold()
                .padding()
                .padding(.horizontal)
                .presentationCompactAdaptation(.popover)
            })
        }
    }
}

#Preview {
    PopOverBootCamp()
}
