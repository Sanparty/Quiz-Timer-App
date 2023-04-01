//
//  TimerView.swift
//  Quiz Timer v1
//
//  Created by Dan San Pedro on 2023-03-20.
//

import SwiftUI

struct TimerView: View {
    
    var time: String
    @State var questions: Int
    var minutes: Int
    @State var isRunning: Bool
    
    @State var timeRemaining: Int
    @State var timeQuestion: String

    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds % 3600) / 60
        let seconds = (timeInSeconds % 3600) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    var body: some View {
        
        let timeperquestion: String = "time per question at start"
        let timeremainingperquestion: String = "remaining time per question"
        
        VStack {
            timerStartShape().frame(width: 100, height: 100)
                .padding()
            if ( questions > 0 && timeRemaining > 0 ) {
                Text("Good Luck!")
                    .font(.largeTitle)
            } else if ( questions == 0 && timeRemaining > 0 ) {
                Text("Congratulations on finishing!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            Text("Duration of test: \(minutes) minutes")
                .padding()
                .font(.title)
            if (timeRemaining > 0 && questions > 0 ) {
                Text("Time remaining: \(convertSecondsToTime(timeInSeconds: timeRemaining))")
                    .onReceive(timer) { _ in
                        timeRemaining -= 1
                        timeQuestion = convertSecondsToTime(timeInSeconds: timeRemaining/questions)
                    }
                    .font(.title2)
            } else if ( timeRemaining <= 0 ){
                Text("Time is up!")
                    .font(.largeTitle)
            }
            if (!isRunning) {
                Button(action:{
                    timeRemaining = minutes * 60
                    isRunning = true
                    timer.connect()
                }) {
                    RoundedButton(title: "Start Timer", color: .blue)
                }
                .padding()
            }
            if (!isRunning) {
                Text("\(timeperquestion):")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(5)
                Text("\(time)")
                    .font(.title2)
                    .multilineTextAlignment(.center)
            } else if ( isRunning && questions > 0 ){
                Text("\(timeremainingperquestion):")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(5)
                Text("\(timeQuestion)")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(5)
            }
            Text("\(questions) questions left")
                .font(.title2)
                .padding()
            if (questions > 0  && timeRemaining > 0 && isRunning) {
                Button(action:{
                    questions -= 1
                    
                }) {
                    RoundedButton(title: "Finished Question", color: .blue)
                }
                .padding()
            }
            
        }
        .onDisappear {
            timer.connect().cancel()
        }
    }
    
}
func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(time: "1 minute", questions: 1, minutes: 1, isRunning: false, timeRemaining: 10, timeQuestion: "2:59" )
    }
}
