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
            
            HStack{
                Button("Prime"){
                    checkAnswer(isPrimeSelected:true)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Not Prime"){
                    checkAnswer(isPrimeSelected: false)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            }
            .padding()
            Text (answerMessage) // here we show feedback message
                .font(.headline)
                .foregroundColor(.green)
                .padding()
        }
    }
    
    func checkAnswer(isPrimeSelected : Bool){
        if isPrime(randomNumber) == isPrimeSelected{
            answerMessage = "\u{2705} correct!"
        }else{
            answerMessage = "\u{274C} wrong!"
        }
        randomNumber = Int.random(in: 1...100) // create a new number
    }
    func isPrime (_ num:Int)-> Bool{
        if num < 2{ return false}
        for i in 2..<num{
            if num % i == 0 {
                return false
            }
        }
        return true
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}


