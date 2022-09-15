//
//  NewPostButton.swift
//  TwitterX
//
//  Created by Xavier on 9/10/22.
//

import SwiftUI

struct NewPostButton: View {
    @EnvironmentObject var vm: PostViewModel
    @Binding var showView: Bool
    var body: some View {
        Button(action: {
            showView.toggle()
        }, label: {
            Image(systemName: "pencil")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(Color.logoBlue)
                .mask(Circle())
                .shadow(radius: 10, x: 5, y: 5)
        })
    }
}
