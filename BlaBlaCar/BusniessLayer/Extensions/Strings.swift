//
//  Strings.swift
//  BlaBlaCar
//
//  Created by Pragath on 11/05/23.
//

import Foundation



extension String{
    
    
    //    length 6 to 16.
    //    One number in Password.
    //    One uppercase and lowercase in Password.
    func isValidPassword() -> Bool {
        let passwordRegEx = Constants.Regex.passRegex
        let passwordTest = NSPredicate(format: Constants.Regex.selfMatch, passwordRegEx)
        let result = passwordTest.evaluate(with: self.trimmingCharacters(in: .whitespaces))
        return result
        

    }

     //Validate email address logic
    func isValidEmail() -> Bool {
        //Declaring the rule of characters to be used. Applying rule to current state. Verifying the result.
        let regex = Constants.Regex.emailRegex
        let test = NSPredicate(format: Constants.Regex.selfMatch, regex)
        let result = test.evaluate(with: self.trimmingCharacters(in: .whitespaces))
        
        return result
    }
    func containsNoNumbers() -> Bool {
        let numRegex = Constants.Regex.numRegex
        return NSPredicate(format: Constants.Regex.selfMatch, numRegex).evaluate(with: self)
    }
    
    func containsNoAlphabet() -> Bool{
        let alphaRegex = Constants.Regex.alphabetRegex
        return NSPredicate(format: Constants.Regex.selfMatch, alphaRegex).evaluate(with: self)
    }
    
    func containsCharacters() -> Bool{
        let characterRegex = Constants.Regex.containsChRegex
        return NSPredicate(format: Constants.Regex.selfMatch, characterRegex).evaluate(with: self)
    }
    
    func isLowercase() -> Bool{
        let lowercaseRegex = Constants.Regex.isLowerRegex
        return NSPredicate(format: Constants.Regex.selfMatch, lowercaseRegex).evaluate(with: self)
    }
    
    func isUppercase() -> Bool{
        let UppercaseRegex = Constants.Regex.isUpperRegex
        return NSPredicate(format: Constants.Regex.selfMatch, UppercaseRegex).evaluate(with: self)
    }
}
