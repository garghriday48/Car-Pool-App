//
//  timer.swift
//  BlaBlaCar
//
//  Created by Pragath on 18/08/23.
//

import SwiftUI

struct TimerView: View {
    @State var timeRemaining = 10
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            Text("\(timeRemaining)")
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
            Button("Pause") {
                timer.upstream.connect().cancel()
            }
            Button("Resume") {
                //timeRemaining = 10
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                
            }
            Button("Restart") {
                timeRemaining = 10
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            .disabled(timeRemaining != 0)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
