//
//  WelcomeView.swift
//  TwitterX
//
//  Created by Xavier on 9/7/22.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showSignUpView: Bool = false
    @State private var showSignInView: Bool = false
    var body: some View {
        ZStack {
            Color.logoBlue
                .ignoresSafeArea()
            VStack(spacing: 50) {
                Spacer()
                Image("logo-white")
                    .resizable()
                    .frame(width: 70, height: 70)
                Spacer()
                VStack(spacing: 15) {
                    Text("Welcome to TwitterX")
                        .bold()
                        .padding(.bottom, 10)
                    Text("Get real time updates about what matters to you.")
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.white)
                .frame(width: 300)
                .lineLimit(2)
                
                VStack(spacing: 25) {
                    Button(action: {
                        print("Tapped - Sign up")
                        showSignUpView.toggle()
                    }, label: {
                        WideButtonLabel(text: "Sign up", fgColor: .logoBlue, bgColor: .white, width: 210)
                    })
                    
                    Button(action: {
                        print("Tapped - Sign in")
                        showSignInView.toggle()
                    }, label: {
                        WideButtonLabel(text: "Sign in", fgColor: .white, bgColor: .logoBlue, width: 210)
                    })
                }
            }
            .onAppear {
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                print(paths[0])
            }
        }
        .fullScreenCover(isPresented: $showSignInView, content: SignInView.init)
        .fullScreenCover(isPresented: $showSignUpView, content: SignUpView.init)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
