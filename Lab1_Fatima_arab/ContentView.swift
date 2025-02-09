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
    
    // add variables to track correct and wrong answers and attempts
    @State private var correctAnswers = 0 // THis is to track correct answers
    @State private var wrongAnswers = 0 // track wrong answers
    @State private var attemptCounter = 0 // track attempts
    
    // create a message to show the number of attempts after 10 times
    @State private var showMessage =  " "
    
    @State private var timeLeft = 5 // timer starts at 5 seconds
    @State private var timerRunnig = true // this controls the timer state
    
    var body: some View {
        VStack {
            Text("Is this number prime?")
                .font(.title)
                .padding()
            
            Text("\(randomNumber)") // this is to display random number
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // to show timer
            Text("Time Left: \(timeLeft) seconds")
                .font(.headline)
                .foregroundColor(.accentColor)
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
            
            // show the result message after 10 attempts
            if !showMessage.isEmpty{
                Text(showMessage)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                
            }
        }
        onAppear{
            startCountdown()
        }
        
    }
    func startTimer(){
        timeLeft = 5 // we reset the timer to 5 seconds
        
        //Create timer
        Timer.schedulesTimer(withTimeInterval: 1.0, repeats: true){
            timer in
            if timeLeft> 0 {
                timeLeft -= 1 // decrease time
            }else{
                timer.invalidate() // stop the timer
                handleTimeout()
            }
        }
    
    }
    
    // handle timeout
    func handleTimeout(){
        wrongAnswers += 1 // to keep record of wrong answer
        answerMessage = "u{274c} Time's up!"  //record times is up
        attemptCounter += 1 // increment the attempts
        
        if attemptCounter == 10{
            // shows results after 10 times
            showMessage = " Results: \nCorrect Answers: \(correctAnswers)\nWrong Answers"
            
            // clear the results after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                showMessage = ""
            }
            attemptCounter = 0 // reset attempts
        }
        randomNumber = Int.random(in: 1...100)// create a new set of randow number
        startCountdown()
        
    
        
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
        }
        randomNumber = Int.random(in: 1...100) // create a new number
        startCountdown()
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


