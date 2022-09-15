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
    @State private var description: String = ""
    @EnvironmentObject var vm: PostViewModel
    
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
                    vm.processPostRequest(description: description)
                    if vm.posted {
                        presentationMode.wrappedValue.dismiss()
                        vm.triggerDI()
                    }
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
                    vm.currentAuthProfileView()
                        .scaleEffect(0.8)
                    Spacer()
                }
                VStack {
                    TextField("What’s happening?", text: $description,  axis: .vertical)
                        .lineLimit(5...10)
                        .frame(width: 210)
                    if vm.hasimage == 1 {
                        vm.presentSelectedImage()
                            .resizable()
                            .frame(width: 140, height: 140)
                            .cornerRadius(25)
                    }
                    Spacer()
                }
            }
            .padding(.trailing, 30)
            .padding(.top, 20)
            Spacer()
            Text(vm.errorMessage)
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
                .onChange(of: selectedImages) { newValue in
                    vm.processSelectedImage(selectedImages: selectedImages)
                }
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
            .environmentObject(PostViewModel())
    }
}
