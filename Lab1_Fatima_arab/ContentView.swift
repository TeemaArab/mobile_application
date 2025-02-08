//
//  ContentView.swift
//  Lab1_Fatima_arab
//
//  Created by Fatemeh (Fatima) Arab on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var randomNumber = Int.random(in: 1...100) // we generate randm number
    @State private var answerMessage = " " // this is where we keep feedback for message
    var body: some View {
        VStack {
            Text("Is this number prime?")
                .font(.title)
                .padding()
            
            Text("\(randomNumber)") // this is to display random number
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
