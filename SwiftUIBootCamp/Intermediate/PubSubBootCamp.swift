//
//  PubSubBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 20/04/2024.
//

import SwiftUI
import Combine

class PubSubViewModel: ObservableObject {
    @Published var count: Int = 0 // This is a publisher
    var timer: AnyCancellable? // Good when we have publisher
    var cancellables = Set<AnyCancellable>() // When we have bunch of publishers
    init() {
        setUpTimer()
        addTextFieldSub()
        addButtonSub()
    }
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    
    @Published var showButton: Bool = false
    
    func setUpTimer() {
//        timer = Timer
//            .publish(every: 1.0, on: .main, in: .common)
//            .autoconnect()
//            .sink { [weak self] (_) in
//                guard let self = self else { return }
//                self.count += 1
//                if count >= 10 {
//                    self.timer?.cancel()
//                }
//            } // We cant use onRecieve in viewModel, we know sink is for recieveValue and similar to onRecieve
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] (_) in
                guard let self = self else { return }
                self.count += 1
                if count >= 10 {
                    for item in cancellables { // In here we have 3, and cancel them, as Set so we need loop
                        print(cancellables.count)
                        item.cancel()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSub() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // Delays the map call by 0.5, like for 0.5 if there are no changes to publisher then it runs the next statement
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                } else {
                    return false
                }
            }
//            .assign(to: \.textIsValid, on: self) // Same as sink, but here we cant make it weak self and should not be used a lot
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSub() {
        $textIsValid
            .combineLatest($count) // Combines aur adds another publisher to subscribe to
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct PubSubBootCamp: View {
    @StateObject var vm = PubSubViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.title)
                .bold()
            Text(vm.textIsValid.description)
            TextField("Type...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55.0)
                .background(.gray.opacity(0.25))
                .cornerRadius(10.0)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                !vm.textIsValid ? 1.0 : 0.0
                            )
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                }
                .padding()
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
            }
            .buttonStyle(BorderedButtonStyle())
            .buttonBorderShape(.capsule)
            .opacity(vm.showButton ? 1.0 : 0.0)
        }
    }
}

#Preview {
    PubSubBootCamp()
}
