//
//  ThreadsBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 25/03/2024.
//

import SwiftUI

struct ThreadsBootCamp: View {
    @StateObject private var vm = BackThreadVM()
    var body: some View {
        ScrollView {
            VStack {
                Text("LOAD DATA")
                    .bold()
                    .font(.title)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id:\.self) { item in
                    Text(item)
                }
            }
        }
    }
}

#Preview {
    ThreadsBootCamp()
}


class BackThreadVM: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        let newData = downloadData()
        dataArray = newData
    }
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}
