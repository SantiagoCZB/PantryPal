import SwiftUI

struct IngredientesView: View {
    @State private var ingredientes: [String] = []
    @State private var showAgregarIngredientes = false
    @State private var recetas: [Receta] = [] // Array para guardar las recetas

    var body: some View {
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
            .navigationTitle("Ingredientes")
            
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
            
            // Sección para mostrar las recetas obtenidas
            if !recetas.isEmpty {
                Text("Recetas Encontradas")
                    .font(.headline)
                    .padding(.top)
                
                List(recetas) { receta in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(receta.title)
                                .font(.headline)
                            Text("ID: \(receta.id)")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: receta.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            } else {
                Text("No se encontraron recetas aún.")
                    .padding(.top)
            }
        }
        .padding()
    }
    
    // Función para hacer fetch a la API de Spoonacular
    private func fetchRecetas() {
        let ingredientesQuery = ingredientes.joined(separator: ",")
        let apiKey = "ee0e5dfda0b94ae2a6bf5dbb4a9195af"
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
    }
}
