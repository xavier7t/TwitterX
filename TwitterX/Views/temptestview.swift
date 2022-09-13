//
//  temptestview.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct temptestview: View {
    @State private var posts: [Post] = []
    var body: some View {
        VStack {
            if posts.count == 0 {
                Text("No post")
            } else {
                ForEach(posts, id: \.externalid) { post in
                    HStack {
                        post.decodedimage
                            .resizable()
                            .frame(width: 50, height: 50)
                        Spacer()
                        Text(post.externalid)
                    }
                    .frame(height: 90)
                }
            }
        }
        .onAppear {
            DBHelperPost.shared.updateRecord(externalid: "20220913175158769", countcomments: 150)
            posts = DBHelperPost.shared.readAll()
        }
    }
}

struct temptestview_Previews: PreviewProvider {
    static var previews: some View {
        temptestview()
    }
}