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
                timerStartShape().frame(width: 100, height: 100)
                    .padding()
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
                if (questions != 0 && minutes != 0 ) {
                    Button(action:{
                        questionsFieldIsFocused = false
                        durationFieldIsFocused = false
                        
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
                           
                    ) {
                        RoundedButton(title: "Calculate", color: .blue)
                    }
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
struct timerStartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.64583*width, y: 0.22917*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.375*height), control1: CGPoint(x: 0.64583*width, y: 0.29167*height), control2: CGPoint(x: 0.58125*width, y: 0.375*height))
        path.addCurve(to: CGPoint(x: 0.35417*width, y: 0.22917*height), control1: CGPoint(x: 0.41875*width, y: 0.375*height), control2: CGPoint(x: 0.35417*width, y: 0.29167*height))
        path.addLine(to: CGPoint(x: 0.64583*width, y: 0.22917*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.64583*width, y: 0.77083*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.625*height), control1: CGPoint(x: 0.64583*width, y: 0.6875*height), control2: CGPoint(x: 0.58125*width, y: 0.625*height))
        path.addCurve(to: CGPoint(x: 0.35417*width, y: 0.77083*height), control1: CGPoint(x: 0.41875*width, y: 0.625*height), control2: CGPoint(x: 0.35417*width, y: 0.6875*height))
        path.addLine(to: CGPoint(x: 0.64583*width, y: 0.77083*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.79167*width, y: 0.22917*height))
        path.addLine(to: CGPoint(x: 0.79167*width, y: 0.20833*height))
        path.addCurve(to: CGPoint(x: 0.83333*width, y: 0.16667*height), control1: CGPoint(x: 0.79167*width, y: 0.18542*height), control2: CGPoint(x: 0.81042*width, y: 0.16667*height))
        path.addCurve(to: CGPoint(x: 0.875*width, y: 0.125*height), control1: CGPoint(x: 0.85625*width, y: 0.16667*height), control2: CGPoint(x: 0.875*width, y: 0.14792*height))
        path.addLine(to: CGPoint(x: 0.875*width, y: 0.04167*height))
        path.addCurve(to: CGPoint(x: 0.83333*width, y: 0), control1: CGPoint(x: 0.875*width, y: 0.01875*height), control2: CGPoint(x: 0.85625*width, y: 0))
        path.addLine(to: CGPoint(x: 0.16667*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.125*width, y: 0.04167*height), control1: CGPoint(x: 0.14375*width, y: 0), control2: CGPoint(x: 0.125*width, y: 0.01875*height))
        path.addLine(to: CGPoint(x: 0.125*width, y: 0.125*height))
        path.addCurve(to: CGPoint(x: 0.16667*width, y: 0.16667*height), control1: CGPoint(x: 0.125*width, y: 0.14792*height), control2: CGPoint(x: 0.14375*width, y: 0.16667*height))
        path.addCurve(to: CGPoint(x: 0.20833*width, y: 0.20833*height), control1: CGPoint(x: 0.18958*width, y: 0.16667*height), control2: CGPoint(x: 0.20833*width, y: 0.18542*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.22917*height))
        path.addCurve(to: CGPoint(x: 0.39167*width, y: 0.5*height), control1: CGPoint(x: 0.20833*width, y: 0.35208*height), control2: CGPoint(x: 0.28542*width, y: 0.45625*height))
        path.addCurve(to: CGPoint(x: 0.20833*width, y: 0.77083*height), control1: CGPoint(x: 0.28333*width, y: 0.54375*height), control2: CGPoint(x: 0.20833*width, y: 0.64792*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: 0.79167*height))
        path.addCurve(to: CGPoint(x: 0.16667*width, y: 0.83333*height), control1: CGPoint(x: 0.20833*width, y: 0.81458*height), control2: CGPoint(x: 0.18958*width, y: 0.83333*height))
        path.addCurve(to: CGPoint(x: 0.125*width, y: 0.875*height), control1: CGPoint(x: 0.14375*width, y: 0.83333*height), control2: CGPoint(x: 0.125*width, y: 0.85208*height))
        path.addLine(to: CGPoint(x: 0.125*width, y: 0.95833*height))
        path.addCurve(to: CGPoint(x: 0.16667*width, y: height), control1: CGPoint(x: 0.125*width, y: 0.98125*height), control2: CGPoint(x: 0.14375*width, y: height))
        path.addLine(to: CGPoint(x: 0.83333*width, y: height))
        path.addCurve(to: CGPoint(x: 0.875*width, y: 0.95833*height), control1: CGPoint(x: 0.85625*width, y: height), control2: CGPoint(x: 0.875*width, y: 0.98125*height))
        path.addLine(to: CGPoint(x: 0.875*width, y: 0.875*height))
        path.addCurve(to: CGPoint(x: 0.83333*width, y: 0.83333*height), control1: CGPoint(x: 0.875*width, y: 0.85208*height), control2: CGPoint(x: 0.85625*width, y: 0.83333*height))
        path.addCurve(to: CGPoint(x: 0.79167*width, y: 0.79167*height), control1: CGPoint(x: 0.81042*width, y: 0.83333*height), control2: CGPoint(x: 0.79167*width, y: 0.81458*height))
        path.addLine(to: CGPoint(x: 0.79167*width, y: 0.77083*height))
        path.addCurve(to: CGPoint(x: 0.60833*width, y: 0.5*height), control1: CGPoint(x: 0.79167*width, y: 0.64792*height), control2: CGPoint(x: 0.71458*width, y: 0.54375*height))
        path.addCurve(to: CGPoint(x: 0.79167*width, y: 0.22917*height), control1: CGPoint(x: 0.71458*width, y: 0.45625*height), control2: CGPoint(x: 0.79167*width, y: 0.35208*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.16667*width, y: 0.04167*height))
        path.addLine(to: CGPoint(x: 0.83333*width, y: 0.04167*height))
        path.addLine(to: CGPoint(x: 0.83333*width, y: 0.125*height))
        path.addLine(to: CGPoint(x: 0.16667*width, y: 0.125*height))
        path.addLine(to: CGPoint(x: 0.16667*width, y: 0.04167*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.83333*width, y: 0.95833*height))
        path.addLine(to: CGPoint(x: 0.16667*width, y: 0.95833*height))
        path.addLine(to: CGPoint(x: 0.16667*width, y: 0.875*height))
        path.addLine(to: CGPoint(x: 0.83333*width, y: 0.875*height))
        path.addLine(to: CGPoint(x: 0.83333*width, y: 0.95833*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.75*width, y: 0.77083*height))
        path.addLine(to: CGPoint(x: 0.75*width, y: 0.79167*height))
        path.addCurve(to: CGPoint(x: 0.7625*width, y: 0.83333*height), control1: CGPoint(x: 0.75*width, y: 0.80625*height), control2: CGPoint(x: 0.75417*width, y: 0.82083*height))
        path.addLine(to: CGPoint(x: 0.2375*width, y: 0.83333*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: 0.79167*height), control1: CGPoint(x: 0.24375*width, y: 0.82083*height), control2: CGPoint(x: 0.25*width, y: 0.80625*height))
        path.addLine(to: CGPoint(x: 0.25*width, y: 0.77083*height))
        path.addCurve(to: CGPoint(x: 0.47917*width, y: 0.52292*height), control1: CGPoint(x: 0.25*width, y: 0.63958*height), control2: CGPoint(x: 0.35208*width, y: 0.53333*height))
        path.addLine(to: CGPoint(x: 0.47917*width, y: 0.5625*height))
        path.addLine(to: CGPoint(x: 0.52083*width, y: 0.5625*height))
        path.addLine(to: CGPoint(x: 0.52083*width, y: 0.52292*height))
        path.addCurve(to: CGPoint(x: 0.75*width, y: 0.77083*height), control1: CGPoint(x: 0.64792*width, y: 0.53333*height), control2: CGPoint(x: 0.75*width, y: 0.63958*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.52083*width, y: 0.47708*height))
        path.addLine(to: CGPoint(x: 0.52083*width, y: 0.4375*height))
        path.addLine(to: CGPoint(x: 0.47917*width, y: 0.4375*height))
        path.addLine(to: CGPoint(x: 0.47917*width, y: 0.47708*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: 0.22917*height), control1: CGPoint(x: 0.35208*width, y: 0.46667*height), control2: CGPoint(x: 0.25*width, y: 0.35833*height))
        path.addLine(to: CGPoint(x: 0.25*width, y: 0.20833*height))
        path.addCurve(to: CGPoint(x: 0.2375*width, y: 0.16667*height), control1: CGPoint(x: 0.25*width, y: 0.19375*height), control2: CGPoint(x: 0.24583*width, y: 0.17917*height))
        path.addLine(to: CGPoint(x: 0.76042*width, y: 0.16667*height))
        path.addCurve(to: CGPoint(x: 0.75*width, y: 0.20833*height), control1: CGPoint(x: 0.75417*width, y: 0.17917*height), control2: CGPoint(x: 0.75*width, y: 0.19375*height))
        path.addLine(to: CGPoint(x: 0.75*width, y: 0.22917*height))
        path.addCurve(to: CGPoint(x: 0.52083*width, y: 0.47708*height), control1: CGPoint(x: 0.75*width, y: 0.36042*height), control2: CGPoint(x: 0.64792*width, y: 0.46667*height))
        path.closeSubpath()
        return path
    }
}
struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
