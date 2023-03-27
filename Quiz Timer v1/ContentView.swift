//
//  ContentView.swift
//  Quiz Timer v1
//
//  Created by Dan San Pedro on 2023-02-10.
//

import SwiftUI

struct EntryView: View {
    
    @State var minutes: Int = 0
    @State var questions: Int = 0
    @State var timeperquestion = "0"
    @State var timeQuestion = ""
    @State private var goesToTimer: Bool = false
    @FocusState private var durationFieldIsFocused: Bool
    @FocusState private var questionsFieldIsFocused: Bool
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("This timer will help you pace yourself during an exam, test, or quiz. Just fill in how much time is alloted for the exam and then how many questions you have to complete. Follow the countdown timer and also get an updated time for each question remaining that you have to complete.")
                    .font(.body)
                    .padding()
                if (timeperquestion != "0") {
                    Text("\(timeperquestion) per question")
                        .font(.largeTitle)
                        .padding()
                        .multilineTextAlignment(.center)
                    NavigationLink(destination: TimerView(time: timeperquestion, questions: questions, minutes: minutes, isRunning: false, timeRemaining: minutes * 60, timeQuestion: timeperquestion))
                    {
                        Text("Ready to Start?")
                            .font(.title)
                            .padding(10)
                            .background(Color(.blue))
                            .foregroundColor(Color(.white))
                            .cornerRadius(6)
                    }
                } else {
                    HStack {
                        Text("Please enter the duration and # of questions in your test")
                            .padding()
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                }
                
                HStack {
                    VStack {
                        //                        Text("Duration in Minutes")
                        TextField("Minutes", value: $minutes, formatter: Formatter.danNumberFormat)
                            .keyboardType(.numberPad)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                            .focused($durationFieldIsFocused)
                    }
                    VStack {
                        //                        Text("# of Questions")
                        TextField("Questions", value: $questions, formatter:
                                    Formatter.danNumberFormat)
                        .keyboardType(.numberPad)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .focused($questionsFieldIsFocused)
                    }
                }
                .padding()
                
                Button(action:{
                    questionsFieldIsFocused = false
                    durationFieldIsFocused = false
                    if (questions != 0 || minutes != 0 ) {
                        let totalSeconds = minutes * 60
                        let result = totalSeconds/questions
                        let timeInSeconds = result
                        
                        let minutes = timeInSeconds / 60
                        let seconds = timeInSeconds % 60
                        if (seconds != 0 && minutes <= 0 ) {
                            timeperquestion = "\(seconds) seconds"
                        } else if (seconds == 0 && minutes > 0){
                            timeperquestion = "\(minutes) minutes"
                        } else if ( result <= 0 ) {
                            timeperquestion = "less than a second"
                        } else {
                            timeperquestion = "\(minutes) minutes \(seconds) seconds"
                        }
                    }
                    
                }) {
                    RoundedButton(title: "Calculate", color: .blue)
                }
                
                //                Button(action:{
                //                    questions = 0
                //                    minutes = 0
                //                    timeperquestion = "0"
                //                }) {
                //                    RoundedButton(title: "Reset", color: .green)
                //                }
                Spacer()
            }
            .navigationTitle("Dan's Quiz Timer")
            .padding()
            .onAppear() {
                minutes = 0
                questions = 0
                timeperquestion = "0"
            }
        }
    }
}

struct RoundedButton: View {
    
    var title: String
    var color: Color
    
    var body: some View {
        Text(title)
            .padding(10)
            .frame(maxWidth:.infinity)
            .background(color)
            .foregroundColor(.white)
            .font(.body)
            .cornerRadius(10)
    }
}

extension Formatter {
    static let danNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minusSign   = "👺 "  // Just for fun!
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}
struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
