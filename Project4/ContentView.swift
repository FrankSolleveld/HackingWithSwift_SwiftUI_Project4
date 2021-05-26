//
//  ContentView.swift
//  Project4
//
//  Created by Frank Solleveld on 25/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep 💤")
                    .font(.headline)
                Stepper(value: $sleepAmount, in: 1...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
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
            .navigationBarTitle(Text("BetterRest 😴"))
            .navigationBarItems(trailing:
                                    Button(action: calculateBedtime) {
                                        Text("Calculate")
                                    }
            )
        }
    }
    
    func calculateBedtime() {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
