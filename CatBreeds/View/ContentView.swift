//
//  ContentView.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 04.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var classifierViewModel: ClassifierViewModel = .init()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var isImagePickerDisplay = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    VStack {
                        Image(uiImage: classifierViewModel.selectedImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                        Text(classifierViewModel.resultClassify ?? "")
                            .font(.title2)
                        .padding()
                    }
                    
                    buttonsVStack
                        .opacity(classifierViewModel.selectedImage != nil ? 0 : 100)
                }
                
                Spacer()
                buttonsHStack
                    .opacity(classifierViewModel.selectedImage != nil ? 100 : 0)
            }
            .onChange(of: classifierViewModel.selectedImage, perform: { _ in
                classifierViewModel.classifierImage()
            })
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$classifierViewModel.selectedImage, sourceType: self.sourceType)
            }
            .navigationTitle("Cats Breed")
        }
        .navigationViewStyle(.stack)
    }
    
    var buttonsVStack: some View {
        VStack {
            Button {
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "camera")
                Text("Camera")
            }.padding()

            Button {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "photo.on.rectangle.angled")
                Text("Library")
            }.padding()
        }
        .font(.largeTitle)
    }
    
    var buttonsHStack: some View {
        HStack {
            Button {
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "camera")
            }.padding()

            Button {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "photo.on.rectangle.angled")
            }.padding()
        }
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
