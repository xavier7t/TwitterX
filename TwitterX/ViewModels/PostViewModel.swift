//
//  PostViewModel.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import Foundation
import SwiftUI
import PhotosUI

class  PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    private let dbHelperPost = DBHelperPost.shared
    private let dbHelperAuth = DBHelperAuthentication.shared
    
    
    func reloadPosts() {
//        self.objectWillChange.send()
        posts.removeAll()
        posts = dbHelperPost.readAll().reversed()
    }
    
    func getPostAuthor(postExternalID: String) -> Authentication? {
        let authExternalID: String = dbHelperPost.readOne(filterValue: "externalid", filterKey: postExternalID)[0].authenticationextid
        let authFetchResult = dbHelperAuth.readOne(Authentication.self, "externalid", authExternalID)
        switch authFetchResult {
        case .success(let auths): return auths[0]
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getPostAuthorColor(auth: Authentication) -> Color? {
        switch auth.color {
        case 0: return .logoBlue
        default: return .teal
        }
    }
    
    func getTimeElapsed(postTimeStamp: String) -> String {
        var result = ""
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "EST")
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        
        let current = Int(formatter.string(from: Date()))!
        let post = Int(postTimeStamp)!
        let variance = current - post
        
        switch variance {
        case 0...30000: result = "Just now"
        case 30001...60000: result = "\(Int(variance/1000))s"
        case 60001...3600000: result = "\(Int(variance/1000/60))m"
        case 3600001...86400000: result = "\(Int(variance/1000/60/60))h"
            //    case 86400001...172799999: result = "Yesterday"
        default:
            let postDate: Date = formatter.date(from: postTimeStamp)!
            
            let formatter2 = DateFormatter()
            formatter2.timeZone = TimeZone(abbreviation: "EST")
            formatter2.dateFormat = "yyyyMMdd"
            let postDayStr = formatter2.string(from: postDate)
            let currentDayStr = formatter2.string(from: Date())
            
            if Int(currentDayStr)! - Int(postDayStr)! == 1 {
                result = "Yesterday"
            } else {
                let formatter3 = DateFormatter()
                formatter3.timeZone = TimeZone(abbreviation: "EST")
                formatter3.dateFormat = "MMM dd, yyyy"
                result = formatter3.string(from: postDate)
            }
        }
        
        return result
    }
    
    func decodeImage(post: Post) -> Image {
        decodeImageFromString(string: post.encodedimage)
    }
    
    func prepareData() {
        dbHelperPost.create(authenticationextid: "20220913220248230", description: "This is the first post ever!", encodedimage: "No", hasimage: 0)
        dbHelperPost.create(authenticationextid: "20220913220248230", description: "MacBook Air M2 2022 is now available!", encodedimage: """
        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
        """, hasimage: 1)
        
    }
    
    // new post view
//    private let dbHelperAuth = DBHelperAuthentication.shared
//    private let dbHelperPost = DBHelperPost.shared
    @Published var errorMessage: String = ""
    @Published var hasimage: Int = 0
    var encodedimage: String = ""
    var data: Data?
    var posted: Bool = false
    
    func currentAuthProfileView() -> ProfileImageView {
        let currentUserExternalID = UserDefaults.standard.string(forKey: "currentUserExternalID")!
        let result = dbHelperAuth.readOne(Authentication.self, "externalid", currentUserExternalID)
        var text = ""
        var color: Color
        switch result {
        case .success(let auths):
            text = (String(Array(auths[0].externalname!)[0]))
            switch (auths[0].color) {
            case 0: color = .logoBlue
            default: color = .teal
            }
        case .failure(let error):
            print(error.localizedDescription)
            text = ""
            color = .teal
        }
        return ProfileImageView(text: text, bgColor: color)
    }
    
    func presentSelectedImage() -> Image {
        let uiImage = UIImage(data: self.data!)
        return Image(uiImage: uiImage!)
    }
    
    func processSelectedImage(selectedImages: [PhotosPickerItem]) {
        guard let item = selectedImages.first else {
            return
        }
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.data = data
                    self.hasimage = 1
                    self.encodedimage = data.base64EncodedString(options: .lineLength64Characters)
                } else {
                    self.data = nil
                    self.hasimage = 0
                    self.encodedimage = ""
                }
            case .failure(let error):
                self.data = nil
                self.hasimage = 0
                self.encodedimage = ""
                self.errorMessage = error.localizedDescription
                print(self.errorMessage)
            }
        }
    }
    
    func processPostRequest(description: String) {
        guard isBlankOrEmptyString(description) != true else {
            errorMessage = "Description can't be blank."
            return
        }
        let currentUserExternalID = UserDefaults.standard.string(forKey: "currentUserExternalID")!
        dbHelperPost.create(
            authenticationextid: currentUserExternalID,
            description: description,
            encodedimage: self.encodedimage,
            hasimage: self.hasimage)
        self.posted = true
        self.data = nil
        self.hasimage = 0
        self.encodedimage = ""
        
        reloadPosts()
    }
    
    private func isBlankOrEmptyString(_ str: String) -> Bool {
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
}
