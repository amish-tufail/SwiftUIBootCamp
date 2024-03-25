//
//  HashableBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 25/03/2024.
//

import SwiftUI
// Instead of using id, we can use hashing to unqiue identify our object

struct HashableBootCamp: View {
    let items = ["ONE", "TWO", "THREE"]
    let data = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE")
    ]
    let dataTwo = [
        MyCustomModelTwo(title: "ONE"),
        MyCustomModelTwo(title: "TWO"),
        MyCustomModelTwo(title: "THREE")
    ]
    var body: some View {
        VStack {
            ForEach(items, id:\.self) { item in
                Text(item.hashValue.description)
            }
            Text("-------------------------")
            Text("-------------------------")
            ForEach(data) { item in
                Text(item.title.hashValue.description)
            }
            Text("-------------------------")
            Text("-------------------------")
            ForEach(dataTwo, id: \.self) { item in
                Text(item.hashValue.description)
            }
        }
    }
}

#Preview {
    HashableBootCamp()
}

struct MyCustomModel: Identifiable {
    let id = UUID()
    let title: String
}

struct MyCustomModelTwo: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
