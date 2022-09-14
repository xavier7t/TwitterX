//
//  PostView.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct PostView: View {
    @StateObject var vmPost = PostViewModel()
    @StateObject var vmAuth = AuthenticationViewModel()
    var body: some View {
        NavigationView {
            if vmPost.posts.count != 0 {
                ScrollView {
                    ForEach(vmPost.posts, id: \.externalid) { post in
                        Divider()
                        PostRow(post: post)
                            .listRowInsets(EdgeInsets())
                    }
                    .listStyle(GroupedListStyle())
                    .navigationTitle("TwitterX")
                }
            } else {
                Text("No post found yet. Feel free to create the first one!")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
