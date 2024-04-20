//
//  TimerBootCamp.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 20/04/2024.
//

import SwiftUI

struct TimerBootCamp: View {
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    func updateRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let mint = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(mint):\(second)"
    }
    
    @State var countTwo = 0
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.red, Color.pink, Color.purple]), center: .center, startRadius: 5.0, endRadius: 500.0)
                .ignoresSafeArea()
//            Text(currentDate.description)
//            Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
            Text(timeRemaining)
                .font(.system(size: 100.0, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { value in
//            currentDate = value
//            if count <= 1 {
//                finishedText = "WOW!"
//            } else {
//                count -= 1
//            }
            
            updateRemaining()
        })
    }
}

#Preview {
    TimerBootCamp()
}
