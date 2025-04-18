//
//  ContentView.swift
//  Lab1_Fatima_arab
//
//  Created by Fatemeh (Fatima) Arab on 2025-02-08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var randomNumber = Int.random(in: 1...100) // we generate randm number
    @State private var answerMessage  = " " // this is where we keep feedback for message
    
    // add variables to track correct and wrong answers and attempts
    @State private var correctAnswers = 0 // THis is to track correct answers
    @State private var wrongAnswers = 0 // track wrong answers
    @State private var attemptCounter = 0 // track attempts
    
    // create a message to show the number of attempts after 10 times
    @State private var showMessage =  " "
    
    @State private var timeLeft = 5 // timer starts at 5 seconds
    @State private var timerRunning = true // this controls the timer state
    
    var body: some View {
        VStack {
            
            Spacer()
            
            // Display random number
            
            Text("\(randomNumber)") // this is to display random number
                .font(.custom("Cochin",size:100))
                .italic()
                .foregroundColor(.teal)
                .padding()
            
            // to show timer
            Text("Time Left: \(timeLeft) seconds")
                .font(.headline)
                .foregroundColor(.red)
                .padding()
            
            Spacer()
            
            // buttons fro prime and not prime
            
            VStack(spacing:20){
                Button (action:{
                    checkAnswer(isPrimeSelected: true)
                }){
                    Text("Prime")
                        .font(.custom("Cochin", size: 40))
                        .italic()
                        .foregroundColor(.teal)
                    
                }
                
                Button(action:{
                    checkAnswer(isPrimeSelected: false)
                }){
                    Text("not Prime")
                        .font(.custom("Cochin", size : 40))
                        .italic()
                        .foregroundColor(.teal)
                }
            }
            
            Spacer()
            
            Text (answerMessage) // here we show feedback message
                .font(.headline)
                .foregroundColor(.green)
                .padding()
            
            // show the result message after 10 attempts
            if !showMessage.isEmpty{
                Text(showMessage)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                
            }
        }
        
        .onAppear{
            startTimer()
        }
        
    }
    
    func startTimer(){
        timeLeft = 5 // we reset the timer to 5 seconds
        
        //Create timer
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true){
            timer in
            if self.timeLeft > 0 {
                self.timeLeft -= 1 // decrease time
            }else{
                timer.invalidate() // stop the timer
                self.handleTimeout()
            }
        }
        
    }
    
    // handle timeout
    func handleTimeout(){
        wrongAnswers += 1 // to keep record of wrong answer if the user does not choose the answer in 5 seconds
        attemptCounter += 1 // increment the attempts
        answerMessage = "\u{274C} Time's up!"  //record times is up
        
        if attemptCounter == 10{
            // shows results after 10 times
            showMessage = " Results: \nCorrect Answers: \(correctAnswers)\nWrong Answers"
            
            // clear the results after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                showMessage = ""
            }
            attemptCounter = 0 // reset attempts
            correctAnswers = 0
            wrongAnswers = 0
        }
        randomNumber = Int.random(in: 1...100)// create a new set of randow number
        startTimer()
        
    }
    
    
    
    func checkAnswer(isPrimeSelected : Bool){
        if isPrime(randomNumber) == isPrimeSelected{
            answerMessage = "\u{2705} correct!"
            correctAnswers += 1 // increment the correct answer
        }else{
            answerMessage = "\u{274C} wrong!"
            wrongAnswers += 1 // increment wrong answer
        }
        attemptCounter += 1 // increament the number of attempt
        
        if attemptCounter == 10{
            showMessage = " Results: \nCorrect Answers: \(correctAnswers) \nWrong Answers: \(wrongAnswers)" // this shows the message when the count reaches 10
            
            // clear the results after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                showMessage = ""
            }
            
            attemptCounter = 0 // reset attempts after reaching 10
            correctAnswers = 0
            wrongAnswers = 0
        }
        randomNumber = Int.random(in: 1...100) // create a new number
        startTimer()
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


