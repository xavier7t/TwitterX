//
//  Post.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import Foundation
import SwiftUI

struct Post {
    var internalid: Int
    var externalid: String
    var authenticationextid: String
    var description: String
    var encodedimage: String
    var decodedimage: Image {
        decodeImageFromString(string: encodedimage)
    }
    var hasimage: Int
    var countcomments: Int
    var countlikes: Int
    var countretweets: Int
}

func encodeImageToString(image: UIImage) -> String {
    return (image.pngData()?.base64EncodedString())!
}

func decodeImageFromString(string: String) -> Image {
    guard let imageData = Data(base64Encoded: string, options: .ignoreUnknownCharacters) else {
        return Image("postImagePlaceholder")
    }
    
    return Image(uiImage: UIImage(data: imageData)!)
}
