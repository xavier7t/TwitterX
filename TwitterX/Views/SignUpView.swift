//
//  SignUpView.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack {
            Color.logoBlue
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack {
                    Image("logo-white")
                        .resizable()
                        .frame(width: 70, height: 70)
                    Text("Create an account")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.top, 20)
                }
                .offset(y: -210)
                
                Spacer()
            }
            
            VStack(spacing: 14) {
                Spacer()
                AuthenticationFieldView(placeholder: "Name", isSecureField: false, textValue: .constant(""))
                AuthenticationFieldView(placeholder: "Username", isSecureField: false, textValue: .constant(""))
                AuthenticationFieldView(placeholder: "Email", isSecureField: false, textValue: .constant(""))
                AuthenticationFieldView(placeholder: "Password", isSecureField: false, textValue: .constant(""))
                AuthenticationFieldView(placeholder: "Confirm you password", isSecureField: false, textValue: .constant(""))
                AuthenticationErrorMessage(errorMsg: "Error Message Placeholder")
                Button(action: {
                    print("Tapped - Submit")
                }, label: {
                    WideButtonLabel(
                        text: "Submit",
                        fgColor: .logoBlue,
                        bgColor: .white,
                        width: 210)
                })
                
                HStack {
                    Text("Have an account already?")
                        .foregroundColor(.white)
                    Button(action: {
                        print("Tapped - Sign in")
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .bold()
                    })
                }
            }
            .offset(y: -105)
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


