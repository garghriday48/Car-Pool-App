//
//  DateCalenderView.swift
//  BlaBlaCar
//
//  Created by Pragath on 15/05/23.
//

import SwiftUI

struct DateCalenderView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var carPoolVM: CarPoolRidesViewModel
    
    @State var originalDate = Date()
    
    @Binding var date: Date
    @Binding var toShowCalenderPicker: Bool
    
    var interval = DateInterval(start: Date(), duration: 365.0 * 24.0 * 3600.0)
    var typeOfPicker: DatePickerComponents
    
    var body: some View {
        VStack{
            VStack{
                Capsule()
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color(.systemGray3))
                HStack{
                    HStack{
                        Button {
                            dismiss()
                            date = originalDate
                            
                        } label: {
                            Text(Constants.ButtonsTitle.close)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(Color.redColor))
                                .padding(.horizontal)
                        }
                        Spacer()
                        Text(Constants.Headings.selectDate)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .bold()
                            
                        Spacer()
                        Button {
                            
                            toShowCalenderPicker.toggle()
                        } label: {
                            Text(Constants.ButtonsTitle.done)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(Color.redColor))
                                .padding(.horizontal)
                        }
                    }
                }
                Divider()
                
            }
            .padding(.vertical)

            DatePicker(selection: $date, in: Date()...interval.end ,displayedComponents: typeOfPicker, label: {})
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
        .onAppear{
            if carPoolVM.rideMethod == .offeringRide {
                originalDate = carPoolVM.publishingDate
            } else if carPoolVM.rideMethod == .bookingRide {
                originalDate = carPoolVM.departureDate
            }
        }
    }
}

struct DateCalenderView_Previews: PreviewProvider {
    static var previews: some View {
        DateCalenderView(date: .constant(Date()), toShowCalenderPicker: .constant(false), typeOfPicker: .date)
            .environmentObject(CarPoolRidesViewModel())
    }
}
