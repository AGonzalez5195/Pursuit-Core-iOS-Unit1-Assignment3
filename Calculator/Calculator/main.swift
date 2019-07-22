//
//  main.swift
//  Calculator_Project
//
//  Created by Anthony Gonzalez on 7/21/19.
//  Copyright © 2019 Anthony Gonzalez. All rights reserved.
//

import Foundation

var randomOperatorGlobal = String()

func welcome() {
    print("""
 _____________________________________________
|🐸 Welcome to Anthony's Magic Calculator! 🐸|
 ---------------------------------------------
""")
    startup()
}





func calculator(num1: Double, op: String, num2: Double) -> Double {
    switch op {
        
    case "+":
        return num1 + num2
    case "-":
        return num1 - num2
    case "*":
        return num1 * num2
    case "/":
        return num1 / num2
    default: return Double()
    }
}





func againAgain () {
    print("Calculate again, Y or N?")
    let answer = readLine()?.uppercased().replacingOccurrences(of: " ", with: "")
    if answer == "Y" {
        startup()
    } else if answer == "N" {
        print("Cya nerd. 🤓")
    } else {
        print("Must input Y or N")
        againAgain()
    }
}





func regularCalculate () {
    print("Enter your operation(separated by spaces):", terminator: " ")
    let input = readLine()?.components(separatedBy: " ")
    let allowedOperators = ["+", "-", "*", "/", "?"]
    let realOperators = allowedOperators.dropLast()
    let randomOperator = realOperators.randomElement()
    var operand1 = Double()
    var operand2 = Double()
    if input!.count > 3 {
        print("Limit to two numbers and one operator")
        regularCalculate()
    }
    if let myDouble = Double(input![0]) {
        operand1 = myDouble
    } else {
        print("Error: invalid input")
        regularCalculate()
    }
    
    if let myDouble2 = Double(input![2]) {
        operand2 = myDouble2
    } else {
        print("Error: invalid input")
        regularCalculate()
    }
    
    let operatorSign = input![1]
    
    guard allowedOperators.contains(operatorSign) else {
        print("Error: \(operatorSign) is an invalid operator")
        return regularCalculate()
    }
    
    if operatorSign == "?" {
        print(calculator(num1: operand1, op: randomOperator!, num2: operand2))
        randomOperatorGlobal = randomOperator!
        guessTheOperator(input: randomOperatorGlobal)
    }
    print(calculator(num1: operand1, op: operatorSign, num2: operand2))
    againAgain()
}





func guessTheOperator (input: String) {
    print(randomOperatorGlobal)
    let allowedOperators = ["+", "-", "*", "/"]
    print("Guess the operator used? +, -, *, or /")
    let answer = readLine()?.replacingOccurrences(of: " ", with: "")
    if !allowedOperators.contains(answer!) {
        print("Invalid input")
        guessTheOperator(input: randomOperatorGlobal)
    } else {
        if answer == randomOperatorGlobal {
            print("Good shit!")
            againAgain()
        } else {
            print("Incorrect. The operation was '\(randomOperatorGlobal)'")
            againAgain()
        }
    }
}





func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    var answerArray = [Int]()
    for numbers in inputArray {
        if filter(numbers){
            answerArray.append(numbers)
        }
    }
    print(answerArray)
    return answerArray
}





func myMap(inputArray: [Int], operation: String, transformation: (Int))  -> [Int] {
    var answerArray = [Int]()
    for numbers in inputArray {
        switch operation {
        case "*":
            answerArray.append(numbers * transformation)
        case "/":
            answerArray.append(numbers / transformation)
        default: print("Hi")
        }
    }
    return(answerArray)
}





func myReduce(inputArray: [Int], operation: String, startingValue: (Int))  -> Int {
var answer = startingValue
for numbers in inputArray {
    switch operation {
    case "+":
       answer += numbers
    case "*":
        answer *= numbers
    default: print("Hi")
    }
}
return answer
}





func highOrderCalculate () {
    print("What method would you like to perform? Filter, map, or reduce?")
    let answer = readLine()?.lowercased().split(separator: " ")
    guard let answerUnwrapped = answer else {
        print("Enter something, fool.")
        return highOrderCalculate()
    }
    let method = answerUnwrapped[0]
    let numberString = answerUnwrapped[1].components(separatedBy: ",")
    var numberArray: [Int] = []
    for stuff in numberString {
        if let shit = Int(stuff) {
            numberArray.append(shit)
        }
    }
    let operatorThing = answerUnwrapped [3]
    var realGivenNumber = Int()
    if let givenNumber = Int(answerUnwrapped[4]) {
        realGivenNumber = givenNumber
    }
    
    switch method {
    case "filter":
        switch operatorThing {
        case ">": _ = myFilter(inputArray: numberArray) { (num: Int) -> Bool in
            return num > realGivenNumber
            }
        case "<": _ = myFilter(inputArray: numberArray) { (num: Int) -> Bool in
            return num < realGivenNumber
            }
        default:
            print("hi")
        }
    case "map":
        print(myMap(inputArray: numberArray, operation: String(operatorThing), transformation: realGivenNumber))
        
    case "reduce":
        print(myReduce(inputArray: numberArray, operation: String(operatorThing), startingValue: realGivenNumber))
    default:
        print("hi")
    }
    againAgain()
}



func startup () {
    print("Enter type of calculation, 1 (regular) or 2 (high order)?")
    let answer = readLine()
    if answer == "1" {
        regularCalculate()
    }
    if answer == "2" {
        highOrderCalculate()
    }
}


welcome()


