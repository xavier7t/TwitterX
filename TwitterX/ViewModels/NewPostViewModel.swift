//
//  NewPostViewModel.swift
//  TwitterX
//
//  Created by Xavier on 9/14/22.
//

//import Foundation
//import SwiftUI
//import PhotosUI

//class NewPostViewModel: ObservableObject {
//    private let dbHelperAuth = DBHelperAuthentication.shared
//    private let dbHelperPost = DBHelperPost.shared
//    @Published var errorMessage: String = ""
//    @Published var hasimage: Int = 0
//    var encodedimage: String = ""
//    var data: Data?
//    var posted: Bool = false
//    func currentAuthProfileView() -> ProfileImageView {
//        let currentUserExternalID = UserDefaults.standard.string(forKey: "currentUserExternalID")!
//        let result = dbHelperAuth.readOne(Authentication.self, "externalid", currentUserExternalID)
//        var text = ""
//        var color: Color
//        switch result {
//        case .success(let auths):
//            text = (String(Array(auths[0].externalname!)[0]))
//            switch (auths[0].color) {
//            case 0: color = .logoBlue
//            default: color = .teal
//            }
//        case .failure(let error):
//            print(error.localizedDescription)
//            text = ""
//            color = .teal
//        }
//        return ProfileImageView(text: text, bgColor: color)
//    }
//    
//    func presentSelectedImage() -> Image {
//        let uiImage = UIImage(data: self.data!)
//        return Image(uiImage: uiImage!)
//    }
//    
//    func processSelectedImage(selectedImages: [PhotosPickerItem]) {
//        guard let item = selectedImages.first else {
//            return
//        }
//        item.loadTransferable(type: Data.self) { result in
//            switch result {
//            case .success(let data):
//                if let data = data {
//                    self.data = data
//                    self.hasimage = 1
//                    self.encodedimage = data.base64EncodedString(options: .lineLength64Characters)
//                } else {
//                    self.data = nil
//                    self.hasimage = 0
//                    self.encodedimage = ""
//                }
//            case .failure(let error):
//                self.data = nil
//                self.hasimage = 0
//                self.encodedimage = ""
//                self.errorMessage = error.localizedDescription
//                print(self.errorMessage)
//            }
//        }
//    }
//    
//    func processPostRequest(description: String) {
//        guard isBlankOrEmptyString(description) != true else {
//            errorMessage = "Description can't be blank."
//            return
//        }
//        let currentUserExternalID = UserDefaults.standard.string(forKey: "currentUserExternalID")!
//        dbHelperPost.create(
//            authenticationextid: currentUserExternalID,
//            description: description,
//            encodedimage: self.encodedimage,
//            hasimage: self.hasimage)
//        self.posted = true
//        self.data = nil
//        self.hasimage = 0
//        self.encodedimage = ""
//    }
//    
//    private func isBlankOrEmptyString(_ str: String) -> Bool {
//        var isStringBlank: Bool = false
//        var isStringEmpty: Bool = false
//        
//        if str == "" {
//            isStringBlank = true
//        }
//        var counter: Int = 0
//        for char in str {
//            if char == " " {
//                counter += 1
//            }
//        }
//        if counter == str.count {
//            isStringEmpty = true
//        }
//        
//        return isStringBlank || isStringEmpty
//    }
//}
