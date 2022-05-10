//
//  CatBreedDetail.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//

import SwiftUI

struct CatBreedDetail: View {
    
    @State var showSafari: Bool = false
    var catBreed: CatBreedsResponse
    
    var body: some View {

        VStack {
            
            GeometryReader { geo in
                AsyncImage(url: URL(string: catBreed.image?.url ?? "https://http.cat/400")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            
            Text(catBreed.name)
                .font(.title)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Country: \(catBreed.origin)").padding(.bottom, 5)
                    Text("Weight: \(catBreed.weight.metric) kg").padding(.bottom, 5)
                    Text("Life span: \(catBreed.life_span) years").padding(.bottom, 5)
                    Text("Temperament: \(catBreed.temperament)").padding(.bottom)
                    Text(catBreed.description)
                    Text("More information is available at the link")
                        .foregroundColor(.blue)
                        .padding()
                        .onTapGesture { showSafari.toggle() }
                }
            }
        }
        .navigationTitle("Detail info")
        .padding()
        .background(.regularMaterial)
        .fullScreenCover(isPresented: $showSafari) {
            SFSafariViewWrapper(url: URL(string: catBreed.wikipedia_url ?? "https://www.google.com/")!)
        }
    }
}

struct CatBreedDetail_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetail(catBreed: CatBreedsResponse())
    }
}
