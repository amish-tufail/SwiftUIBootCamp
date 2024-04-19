//
//  EscapingBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 19/04/2024.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    @Published var value: Int = 0
    func getData() {
//        text = self.downloadData()
//        self.downloadData3 { data in
//            self.text = data
//        }
        
        // Has strong reference which is bad
//        self.downloadData5 { data in
//            self.text = data
//        }
        
        // Now has weak reference
//        self.downloadData5 { [weak self] data in
//            self?.text = data
//        }
        
//        self.downloadData6 { [weak self] result in
//            self?.text = result.data
//            self?.value = result.data2
//        }
        
        self.downloadData7 { [weak self] result in
            self?.text = result.data
            self?.value = result.data2
        }
    }
    
    func downloadData() -> String {
        "New data!"
    }
    
    // Cannot do this as, it expects data to be returned immediately
//    func downloadData2() -> String {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            return "New data!"
//        }
//    }
    
    
    func downloadData3(completionHandler: (_ data: String) -> ())  {
        completionHandler("New Data!")
    }
    
    // Still can't do it, as it requires immediate results
//    func downloadData4(completionHandler: (_ data: String) -> ())  {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            completionHandler("New Data!")
//        }
//    }
    
    // @escaping makes the code async, meaning it wont execute and return immediately
    func downloadData5(completionHandler: @escaping (_ data: String) -> ())  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data!")
        }
    }
    // Above is best, but we can make it even better
    
    func downloadData6(completionHandler: @escaping (DownloadResult) -> ())  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Hello Data!", data2: 12345)
            completionHandler(result)
        }
    }
    
    // We can make even more better
    
    func downloadData7(completionHandler: @escaping DownloadCompletion)  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Hello Data!", data2: 12345)
            completionHandler(result)
        }
    }
    
    
}


struct DownloadResult {
    let data: String
    let data2: Int
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootCamp: View {
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        VStack {
            Text(vm.text)
            Text("\(vm.value)")
                .bold()
        }
        .onAppear {
            vm.getData()
        }
    }
}

#Preview {
    EscapingBootCamp()
}
