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
        DispatchQueue.global().async { // background thread
//            DispatchQueue.global(qos: .background).async { // More options
            let newData = self.downloadData()
            print(Thread.isMainThread)
            print(Thread.current)
            DispatchQueue.main.async { // main thread
                self.dataArray = newData
                print(Thread.isMainThread)
                print(Thread.current)
            }
            /*
             false
             <NSThread: 0x60000174e240>{number = 7, name = (null)}
             -----------------------------------------------------
             true
             <_NSMainThread: 0x600001700040>{number = 1, name = main}
            */
        }
    }
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}
