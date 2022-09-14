//
//  NewPostView.swift
//  TwitterX
//
//  Created by Xavier on 9/14/22.
//

import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedImages: [PhotosPickerItem] = []
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    print("Dismissed.")
                }, label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .foregroundColor(.accentColor)
                        .padding(.leading, 30)
                })
                Spacer()
                Button(action: {
                    print("tweeted.")
                    // create post
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    WideButtonLabel(
                        text: "Tweet",
                        fgColor: (colorScheme == .dark) ? .accentColor : .white,
                        bgColor: (colorScheme == .dark) ? .white : .accentColor,
                        width: 100
                    )
                        .padding(.trailing, 30)
                })
            }
            .padding(.top, 50)
            
            HStack {
                VStack {
                    //ProfileImageView(name: currentUser)
                    //.scaleEffect(0.8)
                    Spacer()
                }
                VStack {
                    TextField("What’s happending?", text: .constant(""),  axis: .vertical)
                        .lineLimit(5...10)
                        .frame(width: 210)

                    Spacer()
                }
            }
            .padding(.trailing, 30)
            .padding(.top, 20)
            Spacer()
            Text("Error message placeholder")
                .foregroundColor(.errorRed)
            Divider()
            HStack {
                PhotosPicker(
                    selection: $selectedImages,
                    maxSelectionCount: 1,
                    matching: .images,
                    label: {
                        Image(systemName: "photo")
                            .resizable()
                            .bold()
                            .foregroundColor(.accentColor)
                            .scaledToFit()
                            .frame(width: 27, height: 16)
                    })
                Image(systemName: "video")
                    .resizable()
                    .bold()
                    .foregroundColor(.accentColor)
                    .scaledToFit()
                    .frame(width: 27, height: 16)
                
                Image(systemName: "location")
                    .resizable()
                    .bold()
                    .foregroundColor(.accentColor)
                    .scaledToFit()
                    .frame(width: 27, height: 16)
                Spacer()
            }
            .padding(.leading, 49)
            .padding(.top, 5)
            .padding(.bottom, 30)
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
