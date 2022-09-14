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
            ScrollView {
                ForEach(vmPost.posts, id: \.externalid) { post in
                    Divider()
                    PostRow(post: post)
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("TwitterX")
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
