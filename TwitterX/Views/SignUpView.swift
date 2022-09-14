//
//  SignUpView.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordCnf: String = ""
    @State private var showLandingPage: Bool = false
    @State private var switchAuthenticationMode: Bool = false
    @StateObject var vm = AuthenticationViewModel()
    
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
                AuthenticationFieldView(placeholder: "Name", isSecureField: false, textValue: $name)
                AuthenticationFieldView(placeholder: "Username", isSecureField: false, textValue: $username)
                AuthenticationFieldView(placeholder: "Email", isSecureField: false, textValue: $email)
                AuthenticationFieldView(placeholder: "Password", isSecureField: true, textValue: $password)
                AuthenticationFieldView(placeholder: "Confirm you password", isSecureField: true, textValue: $passwordCnf)
                AuthenticationErrorMessage(errorMsg: vm.errorMessage)
                Button(action: {
                    vm.processSignUpRequest(name: name, username: username, email: email, password: password, passwordCnf: passwordCnf)
                    if vm.currentUser != nil {
                        showLandingPage.toggle()
                    }
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
                        switchAuthenticationMode.toggle()
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .bold()
                    })
                }
            }
            .offset(y: -105)
        }
        .fullScreenCover(isPresented: $showLandingPage, content: PostView.init)
        .fullScreenCover(isPresented: $switchAuthenticationMode, content: SignInView.init)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


