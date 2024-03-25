//
//  WeakSelfBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish Tufail on 25/03/2024.
//

import SwiftUI

struct WeakSelfBootCamp: View {
    @AppStorage("count") var count: Int = 0
    init() {
        count = 0
    }
    var body: some View {
        NavigationStack {
            NavigationLink("Navigate") {
                SecondScreen()
            }
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count)")
                .padding()
                .font(.largeTitle)
                .background(.orange.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                .padding()
        }
    }
}

#Preview {
    WeakSelfBootCamp()
}

class WeakVM: ObservableObject {
    @Published var data: String? = nil
    init() {
        print("INIT")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    deinit {
        print("DE-INIT")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            // Now here suppose this data was coming from internet, it might take some time to return, user can leave this screen, now here self.data creates a strong reference meaning that the class absoulte needs this and cant be de-init until this data returns, so even if user leaves the screen the data is still be returning which is something we dont want, we want a weak referenc
//            self.data = "NEW DATA!"
//        }
        // So Soln is:
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in // This creates weak reference and calls de-init if user leaves screen earlier
            self?.data = "NEW DATA!"
        }
    }
}

struct SecondScreen: View {
    @StateObject var vm = WeakVM()
    var body: some View {
        VStack {
            Text("Second Screen")
            if let data = vm.data {
                Text(data)
            }
        }
    }
}
