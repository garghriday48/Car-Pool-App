//
//  ItineraryDetailsView.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/06/23.
//

import SwiftUI

struct ItineraryDetailsView: View {
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    @EnvironmentObject var carPoolVM: CarPoolRidesViewModel
    
    var interval = DateInterval(start: Date(), duration: 365.0 * 24.0 * 3600.0)
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow) {
                   // presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .bold()
                Text(Constants.Headings.itineraryDetails)
                    .foregroundColor(.black)
                    .font(.title2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            .padding(.bottom, 40)
            
            VStack(spacing: 15) {
                HStack {
                    Text("Date")
                    Spacer()
                    DatePicker(selection: $myRidesVM.editedDate, in: Date()...interval.end ,displayedComponents: .date, label: {})
                        .labelsHidden()
                }
                .padding(.vertical)
                HStack {
                    Text("Time")
                    Spacer()
                    
                    DatePicker(selection: $myRidesVM.editedTime, displayedComponents: .hourAndMinute, label: {})
                        .labelsHidden()
                }
                .padding(.vertical)
                
                DividerCapsule(height: 2, color: Color(.lightGray))
                    .padding(.bottom, 30)
                
                ZStack(alignment: .leading){
                    VStack(spacing: 50){
                        Button {
                            myRidesVM.isSource.toggle()
                            myRidesVM.editedLocation = myRidesVM.editedSource
                        } label: {
                            HStack {
                                Text(myRidesVM.editedSource)
                                Spacer()
                                Image(systemName: Constants.Images.rightArrow)
                            }
                            
                        }
                        Button {
                            myRidesVM.isDestination.toggle()
                            myRidesVM.editedLocation = myRidesVM.editedDestination
                        } label: {
                            HStack {
                                Text(myRidesVM.editedDestination)
                                Spacer()
                                Image(systemName: Constants.Images.rightArrow)
                            }
                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.leading, 30)
                    PointToPointView(color: Color(Color.redColor), height: 70)
                        .padding(.top, 10)
                }
            }
            .font(.title3).bold()
            .lineLimit(2)
            .padding()
            
            Spacer()
            
            Button {
                myRidesVM.toDismissRouteView.toggle()
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.proceed, border: false)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(Color.redColor))
                        )
                    .padding()
                    
            }
            .navigationDestination(isPresented:              $myRidesVM.toDismissRouteView, destination: {
                EditRouteView()
            })
            
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
     
        .sheet(isPresented: $myRidesVM.isSource, content: {
            EditLocationSearch()
        })
        .sheet(isPresented: $myRidesVM.isDestination, content: {
            EditLocationSearch()
        })
        .onAppear{
            myRidesVM.editedDate = DateTimeFormat.shared.stringToDate(date: myRidesVM.publishResponseWithId.data.date)
            myRidesVM.editedTime = DateTimeFormat.shared.stringToTime(time: myRidesVM.time)
            
            myRidesVM.editedSource = myRidesVM.publishResponseWithId.data.source
            myRidesVM.editedDestination = myRidesVM.publishResponseWithId.data.destination
            
            myRidesVM.editSourceCoordinate.latitude = myRidesVM.publishResponseWithId.data.sourceLatitude
            myRidesVM.editSourceCoordinate.longitude = myRidesVM.publishResponseWithId.data.sourceLongitude
            myRidesVM.editDestCoordinate.latitude = myRidesVM.publishResponseWithId.data.destinationLatitude
            myRidesVM.editDestCoordinate.longitude = myRidesVM.publishResponseWithId.data.destinationLongitude
            if !myRidesVM.toDismissItineraryDetails {
                self.dismiss()
             //   self.presentationMode.wrappedValue.dismiss()
            }
            
                //.// self.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

struct ItineraryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryDetailsView()
            .environmentObject(CarPoolRidesViewModel())
            .environmentObject(MyRidesViewModel())
    }
}
