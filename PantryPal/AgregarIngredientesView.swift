import SwiftUI

struct AgregarIngredientesView: View {
    @Binding var ingredientes: [String]
    @State private var nuevoIngrediente = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                // Lista de ingredientes con posibilidad de eliminar
                ForEach(ingredientes, id: \.self) { ingrediente in
                    Text(ingrediente)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.vertical, 5)
                }
                .onDelete(perform: eliminarIngrediente)
                
                Spacer()
                
                // Campo de texto y botón para agregar el ingrediente
                HStack {
                    TextField("Ingrediente", text: $nuevoIngrediente)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 15)
                        .frame(height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                    Button(action: agregarIngrediente) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 30))
                    }
                    .padding(.trailing, 15)
                }
                .padding()
                .background(Color.white)  // Fondo para que no se mezcle con la lista
            }
            .padding(.bottom, keyboardHeight)  // Ajuste para el teclado
            .animation(.easeInOut(duration: 0.3), value: keyboardHeight)
        }
        .onAppear {
            // Observadores para ajustar el desplazamiento cuando aparece el teclado
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardFrame.height - 40  // Ajusta según la altura visible que necesitas
                }
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.keyboardHeight = 0
            }
        }
        .onDisappear {
            // Eliminar los observadores cuando la vista desaparezca
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    private func agregarIngrediente() {
        if !nuevoIngrediente.isEmpty {
            ingredientes.append(nuevoIngrediente)
            nuevoIngrediente = ""
        }
    }
    
    private func eliminarIngrediente(at offsets: IndexSet) {
        ingredientes.remove(atOffsets: offsets)
    }
}

#Preview {
    AgregarIngredientesView(ingredientes: .constant(["Pollo", "Tomate", "Pan", "Lechuga"]))
}
