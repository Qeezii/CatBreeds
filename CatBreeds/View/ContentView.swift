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

                    buttonsStack
                        .opacity(classifierViewModel.opacityForDownloadingEnd)
                }

                Spacer()

                buttonsStack
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

    var buttonsStack: some View {
        Group {
            if classifierViewModel.selectedImage != nil {
                HStack {
                    buttons
                }
                .foregroundColor(.black)
            } else {
                VStack {
                    buttons
                }
                .font(.largeTitle)
                .foregroundColor(.black)
            }
        }
    }

    var buttons: some View {
        Group {
            Button {
#if targetEnvironment(simulator)
                print("You are using a simulator. The camera is not available.")
#else
                self.sourceType = .camera
                DispatchQueue.main.async {
                    self.isImagePickerDisplay.toggle()
                }
#endif
            } label: {
                Image(systemName: "camera")
                if classifierViewModel.selectedImage == nil {
                    Text("Camera")
                }
            }.padding()

            Button {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "photo.on.rectangle.angled")
                if classifierViewModel.selectedImage == nil {
                    Text("Library")
                }
            }.padding()

            NavigationLink("See all cat breeds") {
                AllCatBreedsView(classifierViewModel: classifierViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.locale, .init(identifier: "en"))
    }
}
