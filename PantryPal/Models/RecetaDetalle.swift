//
//  RecetaDetalle.swift
//  PantryPal
//
//  Created by MacBook Air on 11/09/24.
//

import Foundation

struct Instruccion: Identifiable, Codable {
    let id: UUID = UUID()  // Generar un ID único localmente.
    let name: String
    let steps: [Paso]
}

struct Paso: Identifiable, Codable {
    let id: UUID = UUID()  // Generar un ID único localmente.
    let number: Int
    let step: String
}

