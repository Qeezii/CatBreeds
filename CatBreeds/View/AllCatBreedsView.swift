//
//  AllCatBreedsView.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//

import SwiftUI

struct AllCatBreedsView: View {
    
    @ObservedObject var classifierViewModel: ClassifierViewModel
    
    var body: some View {
        List(classifierViewModel.catBreedsArray) { catBreed in
            NavigationLink(destination: CatBreedDetail(catBreed: catBreed)) {
                ListDetailView(catBreed: catBreed)
            }
        }
        .navigationTitle("All cat breeds")
    }
}

struct ListDetailView: View {
    var catBreed: CatBreedsResponse
    var body: some View {
        VStack {
            HStack {
                Text(catBreed.name).font(.title)
                Spacer()
            }
            HStack {
                Text(catBreed.origin)
                Spacer()
            }
            Spacer()
        }
    }
}

//struct AllCatBreedsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCatBreedsView(classifierViewModel: ClassifierViewModel())
//    }
//}
