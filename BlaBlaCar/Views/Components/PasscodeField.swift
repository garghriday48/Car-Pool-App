//
//  PasscodeField.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/08/23.
//

import SwiftUI


public struct PasscodeField: View {

var maxDigits: Int = 4
var label = "Enter One Time Password"

@State var pin: String = ""
@State var showPin = true

public var body: some View {
    VStack{
        Text(label).font(.title)
        ZStack {
            pinDots
            TextField("", text: $pin, onCommit: submitPin)
                .accentColor(.clear)
                .foregroundColor(.clear)
                .keyboardType(.numberPad)
        }
        ///showPinStack
    }
    
}

private var pinDots: some View {
    HStack {
        Spacer()
        ForEach(0..<4) { index in
            ZStack{
                Image(systemName: self.getImageName(at: index))
                    .font(.system(size: 50))
                Spacer()
                Image(systemName: "square")
                    .font(.system(size: 50))
                    .foregroundColor(self.getImageName(at: index) != "square" ? Color(Color.redColor) : .black)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

private func submitPin() {
    
    // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
    // max digits, we remove the additional characters and make a recursive call.
    if pin.count > maxDigits {
        pin = String(pin.prefix(maxDigits))
        submitPin()
    }
}

private func getImageName(at index: Int) -> String {
    if index >= self.pin.count {
        return "square"
    }
    
    return self.pin.digits[index].numberString + ".square"
}
}

extension String {

var digits: [Int] {
    var result = [Int]()
    
    for char in self {
        if let number = Int(String(char)) {
            result.append(number)
        }
    }
    
    return result
}

}

extension Int {

var numberString: String {
    
    guard self < 10 else { return "0" }
    
    return String(self)
}
}

struct PasscodeField_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeField()
    }
}
