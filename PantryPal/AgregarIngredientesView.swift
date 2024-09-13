import SwiftUI

struct AgregarIngredientesView: View {
    @Binding var ingredientes: [String]
    @State private var nuevoIngrediente = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var isKeyboardVisible: Bool = false
    
    var body: some View {
        VStack {
            // Lista de ingredientes con soporte para eliminar
            List {
                ForEach(ingredientes, id: \.self) { ingrediente in
                    Text(ingrediente)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.vertical, 5)
                }
                .onDelete(perform: eliminarIngrediente)
            }
            .listStyle(PlainListStyle())
            .padding(.bottom, isKeyboardVisible ? keyboardHeight : 0)  // Ajustar solo cuando el teclado esté visible
            .animation(.easeInOut(duration: 0.3), value: keyboardHeight)

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
            .background(Color.white)
        }
        .onAppear {
            // Observadores para ajustar el desplazamiento cuando aparece el teclado
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardFrame.height
                    self.isKeyboardVisible = true
                }
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.keyboardHeight = 0
                self.isKeyboardVisible = false
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
