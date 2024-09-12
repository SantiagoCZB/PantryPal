import Foundation
import SwiftUI
import Vision

class PredictionStatus: ObservableObject {
    @Published var modelUrl = URL(fileURLWithPath: "")
    // TODO - replace with the name of your classifier
    @Published var modelObject = IngredientesML()
    @Published var topLabel = ""
    @Published var topConfidence: Double = 0.0  // Cambia de String a Double
    
    // Live prediction results
    @Published var livePrediction: LivePredictionResults = [:]
    
    func setLivePrediction(with results: LivePredictionResults, label: String, confidence: String) {
        livePrediction = results
        topLabel = label
        topConfidence = Double(confidence) ?? 0.0  // Convertimos la confianza a Double
    }


}
