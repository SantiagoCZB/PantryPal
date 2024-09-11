import SwiftUI

struct RecetaDetalleView: View {
    let receta: Receta
    @State private var instrucciones: [Instruccion] = []
    @State private var ingredientes: [Ingrediente] = []
    
    var body: some View {
        ScrollView {
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
                
                // Mostrar ingredientes como texto
                if ingredientes.isEmpty && instrucciones.isEmpty {
                    Text("Cargando datos...")
                        .padding()
                } else {
                    if !ingredientes.isEmpty {
                        Text("Ingredientes:\n" + ingredientes.map { ingrediente in
                            let amount = formatAmount(ingrediente.amount.metric.value)
                            let unit = ingrediente.amount.metric.unit
                            return "- \(ingrediente.name) \(amount) \(unit)"
                        }.joined(separator: "\n"))
                            .padding()
                            .font(.body)
                    }
                    
                    if !instrucciones.isEmpty {
                        Text("\nInstrucciones:\n" + instrucciones.flatMap { instruccion in
                            [instruccion.name] + instruccion.steps.map { step in
                                "\(step.number). \(step.step)"
                            }
                        }.joined(separator: "\n"))
                            .padding()
                            .font(.body)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            fetchInstrucciones(id: receta.id)
            fetchIngredientes(id: receta.id)
        }
    }
    
    func fetchInstrucciones(id: Int) {
        //let apiKey = "ee0e5dfda0b94ae2a6bf5dbb4a9195af"
        let apiKey = "8e74f15038a444c7848a62e689a74c66"
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

    func fetchIngredientes(id: Int) {
        //let apiKey = "ee0e5dfda0b94ae2a6bf5dbb4a9195af"
        let apiKey = "8e74f15038a444c7848a62e689a74c66"
        let urlString = "https://api.spoonacular.com/recipes/\(id)/ingredientWidget.json?apiKey=\(apiKey)"
        
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
                let decodedData = try JSONDecoder().decode([String: [Ingrediente]].self, from: data)
                if let ingredientes = decodedData["ingredients"] {
                    DispatchQueue.main.async {
                        self.ingredientes = ingredientes
                    }
                }
            } catch {
                print("Error al decodificar los datos: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // Función para formatear la cantidad
    func formatAmount(_ value: Double) -> String {
        let integerPart = Int(value)
        let fractionalPart = value - Double(integerPart)
        
        if fractionalPart == 0 {
            return "\(integerPart)"
        }
        
        let denominator = 100
        let numerator = Int(round(fractionalPart * Double(denominator)))
        
        if numerator == denominator {
            return "\(integerPart + 1)"
        } else if numerator == 0 {
            return "\(integerPart)"
        } else {
            return "\(integerPart) \(numerator)/\(denominator)"
        }
    }
}

#Preview {
    RecetaDetalleView(
        receta: Receta(id: 123, title: "Spaghetti Carbonara", image: "https://via.placeholder.com/150")
    )
}
