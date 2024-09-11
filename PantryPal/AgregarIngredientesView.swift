import SwiftUI

struct AgregarIngredientesView: View {
    @Binding var ingredientes: [String] // Updated to only keep ingredient names
    @State private var nuevoIngrediente: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            // Campo para agregar ingredientes
            HStack {
                TextField("Ingrediente", text: $nuevoIngrediente)
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
            
            // Lista de ingredientes agregados (para visualización)
            List {
                ForEach(ingredientes, id: \.self) { ingrediente in
                    HStack {
                        Text(ingrediente)
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle("Agregar Ingrediente", displayMode: .inline)
    }
    
    // Función para agregar un ingrediente
    private func agregarIngrediente() {
        guard !nuevoIngrediente.isEmpty else {
            print("Error: Ingrediente vacío")
            return
        }
        ingredientes.append(nuevoIngrediente)
        print("Ingrediente agregado: \(nuevoIngrediente)")
        
        // Limpia el campo para agregar más ingredientes
        nuevoIngrediente = ""
    }
}

struct AgregarIngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        AgregarIngredientesView(ingredientes: .constant([]))
    }
}
