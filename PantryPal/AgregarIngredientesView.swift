import SwiftUI

struct AgregarIngredientesView: View {
    @Binding var ingredientes: [(nombre: String, cantidad: String)]
    @State private var nuevoIngrediente: String = ""
    @State private var nuevaCantidad: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
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
            
            // Lista de ingredientes agregados (para visualización)
            List {
                ForEach(ingredientes, id: \.nombre) { ingrediente in
                    HStack {
                        Text("\(ingrediente.nombre) - \(ingrediente.cantidad)")
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle("Agregar Ingrediente", displayMode: .inline)
    }
    
    // Función para agregar un ingrediente
    private func agregarIngrediente() {
        guard !nuevoIngrediente.isEmpty, !nuevaCantidad.isEmpty else {
            print("Error: Ingrediente o cantidad vacío")
            return
        }
        ingredientes.append((nombre: nuevoIngrediente, cantidad: nuevaCantidad))
        print("Ingrediente agregado: \(nuevoIngrediente) - Cantidad: \(nuevaCantidad)")
        
        // Limpia los campos para agregar más ingredientes
        nuevoIngrediente = ""
        nuevaCantidad = ""
    }
}

struct AgregarIngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        AgregarIngredientesView(ingredientes: .constant([]))
    }
}
