//
//  ContentView.swift
//  Project4
//
//  Created by Frank Solleveld on 25/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    var body: some View {
        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            .labelsHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
