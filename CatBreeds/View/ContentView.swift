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
    @State var isImagePickerDisplay: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Spacer()
                
                ZStack {
                    ScrollView {
                        VStack {
                            Image(uiImage: classifierViewModel.selectedImage ?? UIImage())
                                .resizable()
                                .scaledToFit()
                            
                            BarChartsVView(classifierViewModel: classifierViewModel)
                                .opacity(classifierViewModel.resultClassify != nil ? 100 : 0)
                        }
                    }
                    
                    ProgressView()
                        .opacity(classifierViewModel.opacityForDownloadingInProgress)
                    
                    buttonsVStack
                        .opacity(classifierViewModel.opacityForDownloadingEnd)
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
#if targetEnvironment(simulator)
                print("You are using a simulator. The camera is not available.")
#else
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
#endif
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
            
            NavigationLink("See all cat breeds") {
                AllCatBreedsView(classifierViewModel: classifierViewModel)
            }
        }
        .font(.largeTitle)
        .foregroundColor(.black)
    }
    
    var buttonsHStack: some View {
        HStack {
            Button {
#if targetEnvironment(simulator)
                print("You are using a simulator. The camera is not available.")
#else
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
#endif
            } label: {
                Image(systemName: "camera")
            }
            .padding()
            .font(.largeTitle)
            
            Button {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "photo.on.rectangle.angled")
            }
            .padding()
            .font(.largeTitle)
            
            NavigationLink("See all cat breeds") {
                AllCatBreedsView(classifierViewModel: classifierViewModel)
            }
        }
        .foregroundColor(.black)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
