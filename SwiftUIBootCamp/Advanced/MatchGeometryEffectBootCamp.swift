//
//  MatchGeometryEffectBootCamo.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 10/03/2024.
//

import SwiftUI

struct MatchGeometryEffectBootCamp: View {
    @State private var isPressed: Bool = false
    @Namespace private var namespace
    let values = ["Home", "About", "Contact"]
    @State private var selectedValue = "Home"
    @Namespace private var valueNamespace
    
    var body: some View {
        VStack {
            if !isPressed {
                RoundedRectangle(cornerRadius: 12.0)
                    .matchedGeometryEffect(id: "ID", in: namespace)
                    .frame(width: 100.0, height: 100.0)
            }
            Spacer()
            HStack {
                ForEach(values, id:\.self) { value in
                    ZStack(alignment: .bottom) {
                        if value == selectedValue {
                            RoundedRectangle(cornerRadius: 2.0)
                                .fill(.red)
                                .matchedGeometryEffect(id: "ID", in: valueNamespace)
                                .frame(width: 30.0, height: 2.0)
                                .offset(y: 10)
                        }
                        Text(value)
                            .foregroundStyle(selectedValue == value ? .red : .black)
                    }
                    
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            selectedValue = value
                        }
                    }
                }
            }
            Spacer()
            if isPressed {
                RoundedRectangle(cornerRadius: 12.0)
                    .matchedGeometryEffect(id: "ID", in: namespace)
                    .frame(width: 300.0, height: 300.0)
            }
            
        }
//        .onTapGesture {
//            withAnimation(.easeIn) {
//                isPressed.toggle()
//            }
//        }
    }
}

#Preview {
    MatchGeometryEffectBootCamp()
}
