//
//  CatBreedsResponse.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 08.05.2022.
//

import Foundation

struct CatBreedsResponse: Codable, Identifiable {
    var weight: Weight
    var id: String
    var name: String
    var description: String
    var temperament: String
    var origin: String
    var life_span: String
    var wikipedia_url: String?
    var image: ImageCatBreed?
    
    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case description
        case temperament
        case origin
        case life_span
        case wikipedia_url
        case image
    }
    
    init() {
        id = "abys"
        name = "Abyssinian"
        description = "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals."
        weight = Weight.init(imperial: "7 - 10",
                             metric: "3 - 5")
        temperament = "Active, Energetic, Independent, Intelligent, Gentle"
        origin = "Egypt"
        life_span = "14 - 15"
        wikipedia_url = "https://en.wikipedia.org/wiki/Abyssinian_(cat)"
        image = ImageCatBreed.init(id: "0XYvRd7oD",
                                   width: 1204,
                                   height: 1445,
                                   url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")
    }
}

struct Weight: Codable {
    var imperial: String
    var metric: String
}

struct ImageCatBreed: Codable {
    var id: String?
    var width: Int?
    var height: Int?
    var url: String?
}
