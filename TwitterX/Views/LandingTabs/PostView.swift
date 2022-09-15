//
//  PostView.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var vm: PostViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                if vm.posts.count != 0 {
                    ForEach(vm.posts, id: \.externalid) { post in
                        Divider()
                        PostRow(post: post)
                            .listRowInsets(EdgeInsets())
                    }
                    .listStyle(GroupedListStyle())
                    .navigationTitle("TwitterX")
                } else {
                    Text("No post found yet. Feel free to create the first one!")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
            }
            .scrollIndicators(.never)
            .refreshable {
                vm.reloadPosts()
            }
            .toolbar(content: {
                ToolbarItem(content: {
                    vm.currentAuthProfileView()
                        .scaleEffect(0.5)
                        .padding(.bottom, 5)
                        .padding(.trailing, 15)
                })
            })
        }
        .onAppear {
            vm.reloadPosts()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
            .environmentObject(PostViewModel())
    }
}
