//
//  DatePickerView.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import SwiftUI

struct PickerView: View {
    
    @Binding var isDatePicker: Bool
    @Binding var toShowPicker: Bool
    @Binding var myDate: Date
    
    @Binding var selectedIndex: Int
    
    @Environment (\.presentationMode) var presentationMode
    var date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
    
    var genderArray = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack{
                Spacer()
            Button {
                withAnimation{
                    toShowPicker.toggle()
                }
            } label: {
                Text(Constants.ButtonsTitle.done)
                    
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    .padding(.horizontal)
                    
            }
            
            if isDatePicker {
                DatePicker(selection: $myDate, in:...date!, displayedComponents: .date, label: {})
                    .labelsHidden()
                
                    .datePickerStyle(WheelDatePickerStyle())
                    .frame(maxWidth: .infinity, maxHeight: 200 ,alignment: .center)
                    .background(.gray.opacity(0.4))
                
            } else {
                Picker(selection: $selectedIndex, label: EmptyView()) {
                    ForEach(0 ..< genderArray.count) {
                        Text(self.genderArray[$0])
                    }
                }.pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity, maxHeight: 200 ,alignment: .center)
                .background(.gray.opacity(0.4))
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(isDatePicker: .constant(true), toShowPicker: .constant(true), myDate: .constant(Date()), selectedIndex: .constant(1))
    }
}
