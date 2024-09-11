//
//  Ingredientes.swift
//  PantryPal
//
//  Created by Alumno on 11/09/24.
//

import Foundation

// Modelo para los ingredientes
struct Ingrediente: Identifiable, Decodable {
    let id = UUID()  // Usamos un UUID para Identifiable, aunque no está en el JSON
    let name: String
    let amount: Cantidad
    let image: String

    enum CodingKeys: String, CodingKey {
        case name
        case amount
        case image
    }
}

struct Cantidad: Decodable {
    let metric: Unidad
    let us: Unidad
}

struct Unidad: Decodable {
    let value: Double
    let unit: String
}

