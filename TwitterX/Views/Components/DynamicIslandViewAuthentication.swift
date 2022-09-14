//
//  DynamicIslandViewAuthen.swift
//  TwitterX
//
//  Created by Xavier on 9/14/22.
//

import SwiftUI

struct DynamicIslandViewAuthentication: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: AuthenticationViewModel
    @Binding var expanded: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                
                if expanded {
                    vm.currentAuthProfileView()
                        .scaleEffect(0.7)
                        .frame(
                            width: expanded ? 27 : 10,
                            height: expanded ? 19 : 10)
                        .foregroundColor(.white)
                        .padding(expanded ? 20 : 5)
                }
                
                Spacer()
                
                if expanded {
                    VStack {
                        Text("Welcome back,")
                        Text(vm.currentUser!.externalname!)
                    }
                    .foregroundColor(.white)
                    .bold()
                    .font(.caption)
                    .frame(width: 95)
                }
                
                Spacer()
                if expanded {
                    Image(systemName: "checkmark")
                        .resizable()
                        .bold()
                        .foregroundColor(colorScheme == .dark ? .strokeBlue : .logoBlue)
                        .frame(
                            width: expanded ? 20 : 10,
                            height: expanded ? 20 : 10)
                        .padding(expanded ? 20 : 5)
                }
            }
            Spacer()
        }
        .frame(width: expanded ? 350 : 127, height: expanded ? 100 : 39)
        .contentShape(Rectangle())
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.strokeBlue, lineWidth: (colorScheme == .dark) && expanded ? 3 : 0)
        )
    }
}

struct DynamicIslandView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicIslandViewAuthentication(expanded: .constant(true))
            .environmentObject(AuthenticationViewModel())
    }
}
