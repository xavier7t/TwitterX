//
//  AuthenticationField.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct AuthenticationFieldView: View {
    var placeholder: String
    var isSecureField: Bool
    @Binding var textValue: String
    var body: some View {
        Group {
            if isSecureField {
                SecureField(placeholder, text: $textValue)
                    .textContentType(.oneTimeCode)
            } else {
                TextField(placeholder, text: $textValue)
            }
        }
        .padding(.leading, 20)
        .frame(width: 300, height: 40)
        .background(.white)
        .cornerRadius(5)
        .listRowInsets(.init(top: 0, leading: 5, bottom: 0, trailing: 0))
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        
    }
}

struct AuthenticationField_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationFieldView(placeholder: "PreviewUsername", isSecureField: false, textValue: .constant(""))
        AuthenticationFieldView(placeholder: "PreviewPassword", isSecureField: true, textValue: .constant("PreviewPassword"))
    }
}
