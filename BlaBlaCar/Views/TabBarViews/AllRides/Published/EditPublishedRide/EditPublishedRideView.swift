//
//  EditPublishedRideView.swift
//  BlaBlaCar
//
//  Created by Pragath on 16/06/23.
//

import SwiftUI

struct EditPublishedRideView: View {
    @Environment (\.presentationMode) var presentationMode
    
    @EnvironmentObject var myRidesVM: MyRidesViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                BackButton(image: Constants.Images.backArrow) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .bold()
                Text(Constants.Headings.editYourPublication)
                    .foregroundColor(.black)
                    .font(.title2)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 80 ,alignment: .leading)
            .background(Color(Color.redColor))
            .padding(.bottom, 40)
            
            VStack {
                ForEach(EditPublicationTypes.allCases, id: \.self) { options in
                    NavigationLink {
                        switch options {
                        case .itineraryDetails: ItineraryDetailsView()
                        case .price: PriceEditView()
                        case .seats: SeatsEditView(value: $myRidesVM.updatedSeats)
                        }
                    } label: {
                        HStack {
                            Text(options.rawValue)
                            Spacer()
                            Image(systemName: Constants.Images.rightArrow)
                        }
                        .foregroundColor(.primary)
                        .font(.title3).bold()
                        .padding(.vertical,5)
                    }
                }
                
                DividerCapsule(height: 2, color: Color(.systemGray3))
                    .padding(.top)
                Button {
                    
                } label: {
                    Text(Constants.Headings.cancelYOurRide).bold().padding(.top)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            
            myRidesVM.publishWithIdApiCall(method: .publishById, httpMethod: .GET)
            myRidesVM.updatedSeats = myRidesVM.publishResponseWithId.data.passengersCount
            myRidesVM.idToUpdate = myRidesVM.publishResponseWithId.data.id
        }
        .alert("Your ride has been successfully updated", isPresented: $myRidesVM.updateIsSuccess, actions: {
            Button(Constants.ButtonsTitle.okay, role: .cancel) {
            }
        })
    }
}

struct EditPublishedRideView_Previews: PreviewProvider {
    static var previews: some View {
        EditPublishedRideView()
            .environmentObject(MyRidesViewModel())
    }
}
