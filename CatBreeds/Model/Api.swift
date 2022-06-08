//
//  Api.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 08.05.2022.
//

import Foundation

final class Api {
    static let shared = Api()
    let catBreeds: URL? = URL(string: "https://api.thecatapi.com/v1/breeds")
}

// cat api: 753f52d8-c5ca-4a02-891d-b5d774703fd2
