//
//  PostView.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var vmPost: PostViewModel
    @EnvironmentObject var vmAuth: AuthenticationViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                if vmPost.posts.count != 0 {
                    ForEach(vmPost.posts, id: \.externalid) { post in
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
                vmPost.reloadPosts()
            }
            .toolbar(content: {
                ToolbarItem(content: {
                    
                    Menu(content: {
                        Button(action: {
                            print("profile tapped")
                        }, label: {
                            HStack {
                                Text("Profile")
                                Spacer()
                                Image(systemName: "person.circle")
                                    .foregroundColor(.primary)
                                    .frame(width: 20, height: 20)
                            }
                        })
                        Button(action: {
                            print("log out tapped")
                        }, label: {
                            HStack {
                                Text("Logout")
                                Spacer()
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                    .foregroundColor(.primary)
                                    .frame(width: 20, height: 20)
                            }
                        })
                    }, label: {
                        vmPost.currentAuthProfileView()
                            .scaleEffect(0.5)
                            .padding(.bottom, 5)
                            .padding(.trailing, 15)
                    })
                })
            })
        }
        .onAppear {
            vmPost.reloadPosts()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
            .environmentObject(PostViewModel())
    }
}
