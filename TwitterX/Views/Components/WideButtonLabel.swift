//
//  WideButtonLabel.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI


struct WideButtonLabel: View {
    var text: String
    var fgColor: Color
    var bgColor: Color
    var width: CGFloat
    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(fgColor)
            .frame(width: width, height: 40)
            .background(bgColor)
            .cornerRadius(10)
    }
}

struct WideButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        WideButtonLabel(
            text: "Tap me",
            fgColor: .white,
            bgColor: .logoBlue,
            width: 210)
    }
}
