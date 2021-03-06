//
//  ContentView.swift
//  Project4
//
//  Created by Frank Solleveld on 25/05/2021.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                Form {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep 💤")
                            .font(.headline)
                        Stepper(value: $sleepAmount, in: 1...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake ☕️")
                            .font(.headline)
                        Stepper(value: $coffeeAmount, in: 0...20, step: 1) {
                            if coffeeAmount == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(coffeeAmount) cups")
                            }
                        }
                    }
                }
                }
                VStack(alignment: .center, spacing: 10, content: {
                    Button(action: calculateBedtime) {
                        Text("Calculate")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: 360)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 150)

                })
                Spacer()
            }
            .navigationBarTitle(Text("BetterRest 😴"))
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("\(alertTitle)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let model: SleepCalculator = try SleepCalculator(configuration: MLModelConfiguration())
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
