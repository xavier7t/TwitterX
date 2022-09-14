//
//  NewPostButton.swift
//  TwitterX
//
//  Created by M_2217304 on 9/10/22.
//

import SwiftUI

struct NewPostButton: View {
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
