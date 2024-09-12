//
//  PantryPalApp.swift
//  PantryPal
//
//  Created by MacBook Air on 10/09/24.
//

import SwiftUI

@main
struct PantryPalApp: App {
    @StateObject private var predictionStatus = PredictionStatus()
    var body: some Scene {
        
        
        WindowGroup {
            IngredientesView()
                .environmentObject(predictionStatus)
        }
    }
}
