//
//  LandingPageView.swift
//  TwitterX
//
//  Created by Xavier on 9/14/22.
//

import SwiftUI

struct LandingPageView: View {
    @State private var showNewPost: Bool = false
    @State private var selection: Tab = .PostView
    @EnvironmentObject var vmAuth: AuthenticationViewModel
    @EnvironmentObject var vmPost: PostViewModel
    enum Tab {
        case PostView
        case Search
        case Message
    }
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selection) {
                PostView()
                    .tabItem {
                        Label("PostListView", systemImage: "house")
                            .labelStyle(.iconOnly)
                    }
                    .tag(Tab.PostView)
                PostView()
                    .tabItem {
                        Label("SearchView", systemImage: "magnifyingglass")
                            .labelStyle(.iconOnly)
                    }
                    .tag(Tab.Search)
                
                PostView()
                    .tabItem {
                        Label("NotificationListView", systemImage: "bell")
                            .labelStyle(.iconOnly)
                    }
                    .tag(Tab.Search)
                
                PostView()
                    .tabItem {
                        Label("MessageListView", systemImage: "envelope")
                            .labelStyle(.iconOnly)
                    }
                    .tag(Tab.Message)
            }
            .accentColor(.logoBlue)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NewPostButton(showView: $showNewPost)
                        .padding(.bottom, 70)
                        .padding(.trailing, 35)
                        .sheet(isPresented: $showNewPost) {
                            NewPostView()
                                .presentationDetents([.bar])
                        }
                }
            }
            VStack {
                DynamicIslandViewAuthentication(expanded: vmAuth.showAuthenticationDI)
                    .offset(y: -49)

                Spacer()
            }
            VStack {
                DynamicIslandViewPost(expanded: vmPost.showPostDI)
                    .offset(y: -49)

                Spacer()
            }
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(PostViewModel())
    }
}
