//
//  ContentView.swift
//  BetterRest
//
//  Created by Benjamin on 30/11/2022.
//

import SwiftUI

struct ContentViewExamples: View {
    @State private var sleepAmount = 8.0
    
    @State private var wakeUp = Date.now


    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                .padding()
            
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()
            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .date)

            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))


        }
    }

    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        let range = Date.now...tomorrow
    }

}
    
struct ContentViewExamples_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewExamples()
    }
}
