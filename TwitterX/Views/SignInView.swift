//
//  SignInView.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct SignInView: View {
    @State private var usernameoremail: String = ""
    @State private var password: String = ""
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
                    Text("Sign in to your account")
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
                AuthenticationFieldView(placeholder: "Email or Username", isSecureField: false, textValue: $usernameoremail)
                AuthenticationFieldView(placeholder: "Confirm you password", isSecureField: true, textValue: $password)
                AuthenticationErrorMessage(errorMsg: vm.errorMessage)
                Button(action: {
                    vm.processSignInRequest(usernameoremail: usernameoremail, password: password)
                    if vm.currentUser != nil {
                        showLandingPage.toggle()
                    }
                }, label: {
                    WideButtonLabel(
                        text: "Sign in",
                        fgColor: .logoBlue,
                        bgColor: .white,
                        width: 210)
                })
                
                HStack {
                    Text("Don’t have an account?")
                        .foregroundColor(.white)
                    Button(action: {
                        switchAuthenticationMode.toggle()
                    }, label: {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .bold()
                    })
                }
            }
            .offset(y: -105)
        }
        .fullScreenCover(isPresented: $showLandingPage, content: PostView.init)
        .fullScreenCover(isPresented: $switchAuthenticationMode, content: SignUpView.init)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
