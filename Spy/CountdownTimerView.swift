//
//  GameView.swift
//  Spy
//
//  Created by moein shishebor on 2024-07-19.
//

import SwiftUI

struct CountdownTimerView: View {
    @State private var startDate: Date = Date()
    let totalTime: TimeInterval
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0, paused: false)) { context in
            let timeElapsed = Date().timeIntervalSince(startDate)
            let timeRemaining = max(totalTime - timeElapsed, 0)
            
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .opacity(0.3)
                Circle()
                    .trim(from: 0.0, to: CGFloat(timeRemaining / totalTime))
                    .stroke(timeRemaining > (totalTime / 4) ? Color.green : Color.red, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: timeRemaining)
                Text(timeString(from: timeRemaining))
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(40)
        }
        .onAppear {
            startDate = Date()
        }
    }
    
    private func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//struct CountdownTimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountdownTimerView(totalTime: 60)
//    }
//}
