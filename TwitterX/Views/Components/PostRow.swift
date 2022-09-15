//
//  PostRow.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct PostRow: View {
    @EnvironmentObject var vm: PostViewModel
    let post: Post
    var author: Authentication {
        vm.getPostAuthor(postExternalID: post.externalid)!
    }
    var body: some View {
        HStack {
            VStack {
                ProfileImageView(
                    text: String(Array(author.externalname!)[0]),
                    bgColor: vm.getPostAuthorColor(auth: author)!
                )
                .padding(.trailing, 15)
                .padding(.top, 15)
                Spacer()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(author.externalname!)
                        .bold()
                        .font(.subheadline)
                    Group {
                        Text("@") + Text(author.internalname!)
                        Text("·")
                        Text(vm.getTimeElapsed(postTimeStamp: post.externalid))
                    }
                    .foregroundColor(.secondary)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondary)

                }
                
                Text(post.description)
                
                if post.hasimage == 1 {
                    vm.decodeImage(post: post)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 280, height: 200)
                        .clipped()
                        .cornerRadius(14)
                }
                
                HStack(spacing: 20) {
                    HStack {
                        Image(systemName: "ellipsis.bubble")
                        Text("593")
                        //Text("\(post.countcomments)")
                    }
                    HStack {
                        Image(systemName: "arrow.2.squarepath")
                        Text("11.8k")
                        //Text("\(post.countretweets)")
                    }
                    HStack {
                        Image(systemName: "heart")
                        Text("93.2k")
                        //Text("\(post.countlikes)")
                    }
                    Image(systemName: "square.and.arrow.up")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding([.top, .bottom], 15)
            }
            .frame(width: 280)
            .padding(.trailing, 5)
        }
        //.border(.red) // for testing & validation purpose only
    }
}

struct ProfileImageView: View {
    var text: String
    var bgColor: Color
    var body: some View {
        Text(text)
            .bold()
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 55, height: 55)
            .background(bgColor)
            .cornerRadius(21)
    }
}
