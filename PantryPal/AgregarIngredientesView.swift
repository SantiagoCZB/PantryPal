import SwiftUI

struct AgregarIngredientesView: View {
    @State private var nuevoIngrediente: String = ""
    @State private var ingredientes: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                // Campo para agregar ingredientes
                HStack {
                    TextField("Agrega un ingrediente", text: $nuevoIngrediente)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                    
                    // Botón para agregar ingrediente
                    Button(action: agregarIngrediente) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.vertical, 10)
                
                // Lista de ingredientes agregados
                List {
                    ForEach(ingredientes, id: \.self) { ingrediente in
                        HStack {
                            // Botón para borrar ingrediente
                            Button(action: {
                                eliminarIngrediente(ingrediente)
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                            .padding(.trailing, 10)
                            
                            // Texto del ingrediente
                            Text(ingrediente)
                            
                            Spacer()
                            
                            // Botón para agregar (puede usarse para otras funciones)
                            Button(action: {
                                // Acción para agregar o alguna otra acción
                            }) {
                                Image(systemName: "arrow.right.circle")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .onDelete(perform: eliminarIngredientes)
                }
                
                // Botón para finalizar o agregar todos los ingredientes
                Button(action: {
                    // Acción al finalizar la adición de ingredientes
                }) {
                    Text("Agregar Ingredientes")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                }
                .padding(.bottom, 10)
            }
            .navigationBarTitle("Agregar Ingrediente", displayMode: .inline)
            .navigationBarItems(leading: Button("Regresar") {
                // Acción de regresar
            })
        }
    }
    
    // Función para agregar un ingrediente
    private func agregarIngrediente() {
        guard !nuevoIngrediente.isEmpty else { return }
        ingredientes.append(nuevoIngrediente)
        nuevoIngrediente = ""
    }
    
    // Función para eliminar un ingrediente específico
    private func eliminarIngrediente(_ ingrediente: String) {
        if let index = ingredientes.firstIndex(of: ingrediente) {
            ingredientes.remove(at: index)
        }
    }
    
    // Función para eliminar varios ingredientes
    private func eliminarIngredientes(at offsets: IndexSet) {
        ingredientes.remove(atOffsets: offsets)
    }
}

struct IngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        AgregarIngredientesView()
    }
}

#Preview {
    AgregarIngredientesView()
}
