//
//  BioView.swift
//  BlaBlaCar
//
//  Created by Pragath on 01/06/23.
//

import SwiftUI

struct BioView: View {
    
    @ObservedObject var vm: SignInSignUpViewModel
    @ObservedObject var profileVM: ProfileViewModel
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    BackButton(image: Constants.Images.cross) {
                        profileVM.isGoingBack.toggle()
                    }
                    .font(.title)
                    .bold()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                DividerCapsule(height: 4, color: Color(.systemGray3))
                
            }
            VStack(alignment: .leading){
                Text(Constants.Headings.miniBio)
                    .font(.title.bold())
                    .padding(.bottom)

                Text(Constants.Description.bioDescription)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            TextField(Constants.TextfieldPlaceholder.addBio, text: $vm.updateBio, axis: .vertical)
                .lineLimit(4, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
                .padding([.horizontal])
            
            if vm.updateBio.count > 50 {
                HStack{
                    Image(systemName: Constants.Images.infoImage)
                    Text(Constants.ValidationsMsg.bioLimit)
                        .font(.system(size: 15))
                }
                
                .padding(.leading)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            }
            
            Button {
                vm.apiCall(method: .bioUpdate, httpMethod: .PUT, data: vm.getData(method: .bioUpdate))
            } label: {
                ButtonView(buttonName: Constants.ButtonsTitle.done, border: false)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(vm.updateBio.count > 50 || 0 >= vm.updateBio.count ? Color(Color.redColor).opacity(0.2) : Color(Color.redColor))
                        )
                    .padding(.top, vm.updateBio.count > 50 ? 0 : 40)
                    .padding()
            }
            .disabled(vm.updateBio.count > 50 || 0 >= vm.updateBio.count)
        }
        .navigationBarBackButtonHidden()
        .scrollDismissesKeyboard(.immediately)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear{
            vm.updateBio = vm.userData?.status.data?.bio ?? ""
        }
        .onChange(of: vm.updateProfileDone, perform: { _ in
            if vm.updateProfileDone {
                self.dismiss()
            }
        })
        .confirmationDialog(Constants.Headings.backAlertHeading, isPresented: $profileVM.isGoingBack, actions: {
            Button(Constants.ButtonsTitle.yes, role: .destructive) {
                self.dismiss()
            }
        }, message: {
            Text(Constants.Headings.backAlertHeading)
        })
        .onDisappear{
            vm.updateProfileDone = false
        }
    }
}

struct BioView_Previews: PreviewProvider {
    static var previews: some View {
        BioView(vm: SignInSignUpViewModel(), profileVM: ProfileViewModel())
    }
}
