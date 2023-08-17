//
//  PasscodeField.swift
//  BlaBlaCar
//
//  Created by Pragath on 17/08/23.
//

import SwiftUI


public struct PasscodeField: View {

var maxDigits: Int = 6
var label = "Enter One Time Password"

@State var pin: String = ""
@State var showPin = true
//@State var isDisabled = false


//var handler: (String, (Bool) -> Void) -> Void

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
        ForEach(0..<maxDigits) { index in
            Image(systemName: self.getImageName(at: index))
                .font(.system(size: 60))
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity)
        .padding(.trailing, -24)
    }
}
//
//private var backgroundField: some View {
////    let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
////        self.pin = newValue
////        self.submitPin()
////    })
//
//    return
  
  // Introspect library can used to make the textField become first resonder on appearing
  // if you decide to add the pod 'Introspect' and import it, comment #50 to #53 and uncomment #55 to #61
  
//       .accentColor(.clear)
//       .foregroundColor(.clear)
//       .keyboardType(.numberPad)
       //.disabled(isDisabled)
  

//}


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
        return "circle"
    }
    
    if self.showPin {
        return self.pin.digits[index].numberString + ".circle"
    }
    
    return "circle.fill"
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
