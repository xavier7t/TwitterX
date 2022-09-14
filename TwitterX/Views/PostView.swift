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
            ScrollView {
                ForEach(vm.posts, id: \.externalid) { post in
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
