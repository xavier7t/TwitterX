//
//  DynamicIslandViewPost.swift
//  TwitterX
//
//  Created by Xavier on 9/14/22.
//

import SwiftUI

struct DynamicIslandViewPost: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vmAuth: AuthenticationViewModel
    @EnvironmentObject var vmPost: PostViewModel
    @Binding var expanded: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                if expanded {
                    vmAuth.currentAuthProfileView()
                        .scaleEffect(0.7)
                        .frame(
                            width: expanded ? 27 : 10,
                            height: expanded ? 19 : 10)
                        .foregroundColor(.white)
                        .padding(expanded ? 20 : 5)
                }
                
                Spacer()
                
                if expanded {
                    Text("Tweet posted!")
                        .foregroundColor(.white)
                        .bold()
                    .font(.caption2)
                }
                
                Spacer()
                if expanded {
//                    if vmPost.posted && vmPost.hasimage == 0 {
                        Image(systemName: "checkmark")
                            .resizable()
                            .bold()
                            .foregroundColor(.green)
                            .frame(
                                width: expanded ? 20 : 10,
                                height: expanded ? 20 : 10)
                            .padding(expanded ? 20 : 5)
//                    } else {
//                        vmPost.presentSelectedImage()
//                            .resizable()
//                            .frame(
//                                width: expanded ? 35 : 10,
//                                height: expanded ? 35 : 10)
//                            .cornerRadius(5)
//                            .padding(.trailing, 15)
//                    }
                }
            }
            Spacer()
        }
        .frame(width: expanded ? 225 : 127, height: expanded ? 100 : 39)
        .contentShape(Rectangle())
        .background(colorScheme == .dark ? Color.white : Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
    }
}

struct DynamicIslandPost_Previews: PreviewProvider {
    static var previews: some View {
        DynamicIslandViewPost(expanded: Binding.constant(true))
            .environmentObject(AuthenticationViewModel())
            .environmentObject(PostViewModel())
    }
}
