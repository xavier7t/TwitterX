//
//  PostView.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct PostView: View {
    @StateObject var vm = PostViewModel()
    var body: some View {
        NavigationView {
            if vm.posts.count != 0 {
                ScrollView {
                    ForEach(vm.posts, id: \.externalid) { post in
                        Divider()
                        PostRow(post: post)
                            .listRowInsets(EdgeInsets())
                    }
                    .listStyle(GroupedListStyle())
                    .navigationTitle("TwitterX")
                }
                .refreshable {
                    vm.loadPosts()
                }
            } else {
                Text("No post found yet. Feel free to create the first one!")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
        .onAppear {
            vm.loadPosts()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
