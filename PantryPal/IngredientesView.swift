import SwiftUI

struct IngredientesView: View {
    @State private var ingredientes: [String] = []
    @State private var showAgregarIngredientes = false
    @State private var recetas: [Receta] = [] // Array para guardar las recetas
    @State private var showRecetasView = false // Variable para manejar la navegación
    @EnvironmentObject var predictionStatus: PredictionStatus // EnvironmentObject para PredictionStatus

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("PantryPal")
                        .foregroundStyle(.blue)
                    Spacer()
                }
                .padding(.leading, 15.0)
                
                HStack {
                    Text("Ingredientes")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding(.leading, 15.0)
                
                List(ingredientes, id: \.self) { ingrediente in
                    HStack {
                        Text("\(ingrediente)")
                        Spacer()
                    }
                }
                
                Button(action: {
                    showAgregarIngredientes = true
                }) {
                    Text("Agregar Ingredientes")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                }
                .sheet(isPresented: $showAgregarIngredientes) {
                    AgregarIngredientesView(ingredientes: $ingredientes)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                    fetchRecetas() // Llamar a la función para hacer el fetch
                }) {
                    Text("Buscar Recetas")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                }
                
                // Agregar NavigationLink para navegar a la vista de recetas
                NavigationLink(destination: RecetasView(recetas: recetas), isActive: $showRecetasView) {
                    EmptyView()
                }
                
                // Botón para ir a CameraScanView
                NavigationLink(destination: CameraScanView(onIngredientAdded: { newIngredient in
                    self.ingredientes.append(newIngredient)  // Agrega la predicción a la lista de ingredientes
                })) {
                    Text("Escanear con cámara")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                }
            }
            .padding()
        }
    }
    
    // Función para hacer fetch a la API de Spoonacular
    private func fetchRecetas() {
        let ingredientesQuery = ingredientes.joined(separator: ",")
        let apiKey = "8e74f15038a444c7848a62e689a74c66"
        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredientesQuery)&apiKey=\(apiKey)&number=5&ranking=2&ignorePantry=true"
        
        guard let url = URL(string: urlString) else {
            print("URL no válida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error en la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos")
                return
            }
            
            do {
                let recetasResponse = try JSONDecoder().decode([Receta].self, from: data)
                DispatchQueue.main.async {
                    self.recetas = recetasResponse
                    self.showRecetasView = true
                }
            } catch {
                print("Error al decodificar la respuesta: \(error)")
            }
        }.resume()
    }
}

struct IngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientesView()
            .environmentObject(PredictionStatus()) // Añade PredictionStatus al entorno
    }
}
