//
//  RecetaDetalleView.swift
//  PantryPal
//
//  Created by MacBook Air on 11/09/24.
//

import SwiftUI

struct RecetaDetalleView: View {
    let receta: Receta
    @State private var instrucciones: [Instruccion] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(receta.title)
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
            
            AsyncImage(url: URL(string: receta.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(height: 250)
            }
            
            if instrucciones.isEmpty {
                Text("Cargando instrucciones...")
                    .padding()
            } else {
                List(instrucciones) { instruccion in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(instruccion.name)
                            .font(.headline)
                        
                        ForEach(instruccion.steps) { paso in
                            HStack(alignment: .top) {
                                Text("\(paso.number).")
                                    .bold()
                                Text(paso.step)
                            }
                            .padding(.bottom, 5)
                        }
                    }
                }
            }
        }
        .onAppear {
            fetchInstrucciones(id: receta.id)
        }
    }
    
    func fetchInstrucciones(id: Int) {
        let apiKey = "ee0e5dfda0b94ae2a6bf5dbb4a9195af"
        let urlString = "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("URL no válida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al hacer fetch: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Datos no válidos")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Instruccion].self, from: data)
                DispatchQueue.main.async {
                    instrucciones = decodedData
                }
            } catch {
                print("Error al decodificar los datos: \(error.localizedDescription)")
            }
        }.resume()
    }
}


#Preview {
    RecetaDetalleView(
        receta: Receta(id: 123, title: "Spaghetti Carbonara", image: "https://via.placeholder.com/150")
    )
}
