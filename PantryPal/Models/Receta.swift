//
//  File.swift
//  PantryPal
//
//  Created by MacBook Air on 11/09/24.
//

import Foundation

// Modelo para la respuesta de Spoonacular
struct Receta: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
}
