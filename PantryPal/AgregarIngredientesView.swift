import SwiftUI

struct AgregarIngredientesView: View {
    @State private var nuevoIngrediente: String = ""
    @State private var nuevaCantidad: String = ""
    @State private var ingredientes: [(nombre: String, cantidad: String)] = []

    var body: some View {
        NavigationView {
            VStack {
                // Campo para agregar ingredientes y su cantidad
                HStack {
                    TextField("Ingrediente", text: $nuevoIngrediente)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                    
                    TextField("Cantidad", text: $nuevaCantidad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80) // Tamaño pequeño para cantidad
                        .keyboardType(.numberPad)
                    
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
                    ForEach(ingredientes, id: \.nombre) { ingrediente in
                        HStack {
                            // Botón para borrar ingrediente
                            Button(action: {
                                eliminarIngrediente(ingrediente)
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                            .padding(.trailing, 10)
                            
                            // Texto del ingrediente y su cantidad
                            Text("\(ingrediente.nombre) - \(ingrediente.cantidad)")
                            
                            Spacer()
                            
                        }
                    }
                    .onDelete(perform: eliminarIngredientes)
                }
                
                // Botón para finalizar o agregar todos los ingredientes
                Button(action: {
                    // Acción al finalizar la adición de ingredientes
                    print("Agregar ingredientes: \(ingredientes)")
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
        }
    }
    
    // Función para agregar un ingrediente
    private func agregarIngrediente() {
        guard !nuevoIngrediente.isEmpty, !nuevaCantidad.isEmpty else {
            print("Error: Ingrediente o cantidad vacío")
            return
        }
        ingredientes.append((nombre: nuevoIngrediente, cantidad: nuevaCantidad))
        print("Ingrediente agregado: \(nuevoIngrediente) - Cantidad: \(nuevaCantidad)")
        print(ingredientes)
        nuevoIngrediente = ""
        nuevaCantidad = ""
    }
    
    // Función para eliminar un ingrediente específico
    private func eliminarIngrediente(_ ingrediente: (nombre: String, cantidad: String)) {
        if let index = ingredientes.firstIndex(where: { $0.nombre == ingrediente.nombre }) {
            ingredientes.remove(at: index)
            print("Ingrediente eliminado: \(ingrediente.nombre)")
        }
    }
    
    // Función para eliminar varios ingredientes
    private func eliminarIngredientes(at offsets: IndexSet) {
        ingredientes.remove(atOffsets: offsets)
        print("Ingredientes eliminados en índices: \(offsets)")
    }
}

struct IngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        AgregarIngredientesView()
    }
}
