//
//  AuthenticationViewModel.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var currentUser: Authentication?
    
    private let dbHelper = DBHelperAuthentication.shared
    
    func processSignInRequest(usernameoremail: String, password: String) {
        // validate if both fields are filled & not empty
        let fields: [String] = [usernameoremail, password]
        for field in fields {
            guard isBlankOrEmptyString(field) != true else {
                errorMessage = "Please fill in both fields."
                return
            }
        }
        
        // validate if username or username is registered
        var userFound: Authentication? = nil
        switch dbHelper.readOne(Authentication.self, "internalname", usernameoremail) {
        case .success(let auths):
            if auths.count == 0 {
                switch dbHelper.readOne(Authentication.self, "email", usernameoremail) {
                case .success(let auths):
                    guard auths.count != 0 else {
                        errorMessage = "User not found. Please sign up first."
                        return
                    }
                    userFound = auths[0]
                case .failure(let error): print(error.localizedDescription)
                }
            } else {
                userFound = auths[0]
            }
        case .failure(let error): print(error.localizedDescription)
        }
        
        
        // validate if password is correct
        guard password == userFound?.password! else {
            errorMessage = "Incorrect password."
            return
        }
        
        errorMessage = ""
        currentUser = userFound
        print(currentUser?.externalid!)
        print(currentUser?.email!)
    }
    
    func processSignUpRequest(name: String, username: String, email: String, password: String, passwordCnf: String) {
        
        // validate if all fields are filled & not empty
        let fields: [String] = [name, username, email, password, passwordCnf]
        for field in fields {
            guard isBlankOrEmptyString(field) != true else {
                errorMessage = "Please fill in all fields."
                return
            }
        }
        
        // validate length of name
        guard name.count >= 2 else {
            errorMessage = "Name must contain 2 characters or more."
            return
        }
        
        // validate if username is used
        var countOfUsername: Int = 0
        switch dbHelper.readOne(Authentication.self, "internalname", username) {
        case .success(let auths): countOfUsername = auths.count
        case .failure(let error): print(error.localizedDescription)
        }
        guard countOfUsername == 0 else {
            errorMessage = "Username is registered. Please sign in."
            return
        }
        
        // validate email regex
        guard isValidEmail(email) else {
            errorMessage = "Invalid email address."
            return
        }
        
        // validate if email is used
        var countOfEmail: Int = 0
        switch dbHelper.readOne(Authentication.self, "email", email) {
        case .success(let auths): countOfEmail = auths.count
        case .failure(let error): print(error.localizedDescription)
        }
        guard countOfEmail == 0 else {
            errorMessage = "Email is registered. Please sign in."
            return
        }
        
        // validate if passwords match
        guard password == passwordCnf else {
            errorMessage = "Passwords don’t match."
            return
        }
        
        // validate passwords length
        guard password.count >= 8 && password.count <= 16 else {
            errorMessage = "Password must contain 8-16 characters."
            return
        }
        
        // validate password regex
        guard isValidPassword(password) else {
            errorMessage = "Password must contain at least one of uppercase, lowercase, number and special character (!@#$%^&*()\\-_=+{}|?>.<,:;~`’)."
            return
        }
        
        errorMessage = ""
        
        dbHelper.createAuthentication(username: username, fullname: name, email: email, password: password)
        switch dbHelper.readOne(Authentication.self, "email", email) {
        case .failure(let error): print(error.localizedDescription)
        case .success(let auths): currentUser = auths[0]
        }
    }
    
    
    func isBlankOrEmptyString(_ str: String) -> Bool {
        var isStringBlank: Bool = false
        var isStringEmpty: Bool = false
        
        if str == "" {
            isStringBlank = true
        }
        var counter: Int = 0
        for char in str {
            if char == " " {
                counter += 1
            }
        }
        if counter == str.count {
            isStringEmpty = true
        }
        
        return isStringBlank || isStringEmpty
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,16}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
