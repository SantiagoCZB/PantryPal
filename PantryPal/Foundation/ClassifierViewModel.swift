//
//  ClassifierViewModel.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 11/10/23.
//

import Foundation

final class ClassifierViewModel: ObservableObject {
    @Published var classifierData: [Classification] = []
    @Published var dataWhenAboutTapped:Int = 0
    
    func loadJSON() {
        print("load JSON")
        if let url = Bundle.main.url(forResource: "mydata", withExtension: "json") { // Cambia .geojson a .json
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                classifierData = try decoder.decode([Classification].self, from: jsonData)
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        } else {
            print("No se pudo encontrar el archivo mydata.json")
        }
    }
    
    func getPredictionData(label: String, confidence: Double) -> Classification {
        return classifierData.filter { $0.label == label }.first ?? Classification(label: label, confidence: confidence)
    }

}
