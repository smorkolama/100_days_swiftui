//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Benjamin on 19/09/2022.
//

import SwiftUI

struct ContentViewExamples: View {
    
    @State private var showingAlert = false

    var body: some View {
//        VStack {
//            HStack {
//                Text("1")
//                Text("1")
//                Text("1")
//            }
//            HStack {
//                Text("1")
//                Text("1")
//                Text("1")
//            }
//            HStack {
//                Text("1")
//                Text("1")
//                Text("1")
//            }
//        }
        
//        ZStack {
//            Color.red
//                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
//            Text("Your content")
//        }
//        Color.red
//            .ignoresSafeArea()
        
//        .padding()
        
//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
//
//            Text("Your content")
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(.thinMaterial)
//        }
//        .ignoresSafeArea()
        
//        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
        
//        LinearGradient(gradient: Gradient(stops: [
//                Gradient.Stop(color: .white, location: 0.45),
//                Gradient.Stop(color: .black, location: 0.55),
//            ]), startPoint: .top, endPoint: .bottom)

//        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
        
//        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)


//            .ignoresSafeArea()
        
//        Button("Delete selection", role: .destructive, action: executeDelete)

        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
//                .tint(.mint)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
            }
            
            Image(systemName: "pencil").padding()
            
            Button {
                print("Edit button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            

            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("OK") { }
                Button("Delete", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please read this.")
            }
        }
        
        

    }
    
    func executeDelete() {
        print("Now deleting…")
    }
}

struct ContentViewExamples_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
