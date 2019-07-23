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




func startup () {
    print("Enter type of calculation, 1 (regular) or 2 (high order)?")
    let answer = readLine()?.replacingOccurrences(of: "[ ]+", with: "", options: .regularExpression)
    if answer == "1" {
        print("")
        regularCalculate()
    }
    if answer == "2" {
        print("")
        highOrderCalculate()
    } else {
        print("[I SAID 1 OR 2, BRUH]")
        print("")
        startup()
    }
}




func againAgain () {
    print("[Calculate again, Y or N?]")
    let answer = readLine()?.uppercased().replacingOccurrences(of: "[ ]+", with: "", options: .regularExpression)
    if answer == "Y" {
        startup()
    } else if answer == "N" {
        print("[Cya nerd. 🤓]")
    } else {
        againAgain()
    }
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




func regularCalculate () {
    print("Enter your operation(separated by spaces):", terminator: " ")
    print("")
    let input = readLine()?.components(separatedBy: " ")
    guard let inputUnwrapped = input else {
        print("Enter something, fool.")
        return regularCalculate()
    }
    let allowedOperators = ["+", "-", "*", "/", "?"]
    let randomOperator = allowedOperators.dropLast().randomElement()
    var operand1 = Double()
    var operand2 = Double()
    if inputUnwrapped.count > 3 || inputUnwrapped.count < 3 {
        print("[error: input must contain two operands and one operator]")
        print("")
        regularCalculate()
    }
    if let myDouble = Double(inputUnwrapped[0]) {
        operand1 = myDouble
    } else {
        print("[error: invalid input]")
        print("")
        regularCalculate()
    }
    
    if let myDouble2 = Double(inputUnwrapped[2]) {
        operand2 = myDouble2
    } else {
        print("[error: invalid input]")
        print("")
        regularCalculate()
    }
    
    let operatorSign = inputUnwrapped[1]
    
    guard allowedOperators.contains(operatorSign) else {
        print("[error: '\(operatorSign)' is an invalid operator]")
        print("")
        return regularCalculate()
    }
    
    if operatorSign == "?" {
        print(calculator(num1: operand1, op: randomOperator!, num2: operand2))
        randomOperatorGlobal = randomOperator!
        guessTheOperator(input: randomOperatorGlobal)
    }
    print(calculator(num1: operand1, op: operatorSign, num2: operand2))
    print("")
    againAgain()
}




func guessTheOperator (input: String) {
    //  print(randomOperatorGlobal) //Used to show what the operator actually is.
    let allowedOperators = ["+", "-", "*", "/"]
    print("[Guess the operator used: +, -, *, or /]")
    let answer = readLine()?.replacingOccurrences(of: "[ ]+", with: "", options: .regularExpression)
    if !allowedOperators.contains(answer!) {
        print("[Answer must be one of the four operators]")
        guessTheOperator(input: randomOperatorGlobal)
    } else {
        if answer == randomOperatorGlobal {
            print("[Correct. You're too big-brained.]")
            print("")
            againAgain()
        } else {
            print("[Incorrect. The operation was '\(randomOperatorGlobal)']")
            print("")
            againAgain()
        }
    }
}




func highOrderCalculate () {
    print("""
Enter the method in the following format:

'Method (map, reduce, filter) Numbers(Int, separated by commas) by Operator Number'

Acceptable operators:
Map (* , /)
Reduce (+ , *)
Filter (< , >)

ex: filter 1,2,3,4,5 by < 4


""")
    let answer = readLine()?.lowercased().split(separator: " ")
    guard let answerUnwrapped = answer else {
        print("Enter something, fool.")
        return highOrderCalculate()
    }
    if answerUnwrapped.count > 5 || answerUnwrapped.count < 5{
        print("[error: input must contain exactly 5 elements]")
        print("")
        highOrderCalculate()
    }
    
    let method = answerUnwrapped[0]
    let numberString = answerUnwrapped[1].components(separatedBy: ",")
    var numberArray: [Int] = []
    for stuff in numberString {
        if let realNums = Int(stuff) {
            numberArray.append(realNums)
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
            print("[error: operator can only be '<' or '>']")
            print("")
        }
    case "map":
        print(myMap(inputArray: numberArray, operation: String(operatorThing), transformation: realGivenNumber))
        
    case "reduce":
        print(myReduce(inputArray: numberArray, operation: String(operatorThing), startingValue: realGivenNumber))
    default:
        print("[error: \(method) is not an acceptable method]")
        print("")
        highOrderCalculate()
    }
    againAgain()
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
        default: print("[error: operator must be '*' or '/']")
        print("")
        highOrderCalculate()
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
        default: print("[error: operator must be '+' or '*']")
        print("")
        highOrderCalculate()
        }
    }
    return answer
}





welcome()


