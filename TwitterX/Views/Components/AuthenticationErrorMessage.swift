//
//  AuthenticationErrorMessage.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct AuthenticationErrorMessage: View {
    var errorMsg: String
    var body: some View {
        Text(errorMsg)
            .lineLimit(3, reservesSpace: true)
            .font(.subheadline)
            .foregroundColor(.errorRed)
            .bold()
            .frame(width: 320)
    }
}

struct AuthenticationErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationErrorMessage(errorMsg: "Error Message Placeholder")
    }
}
