import SwiftUI

struct AgregarIngredientesView: View {
    @Binding var ingredientes: [String]
    @State private var nuevoIngrediente = ""
    @State private var keyboardOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            // Cambiar ScrollView a List para soportar swipe-to-delete
            List {
                ForEach(ingredientes, id: \.self) { ingrediente in
                    Text(ingrediente)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.vertical, 5)
                }
                .onDelete(perform: eliminarIngrediente) // Soporte para eliminar al deslizar
            }
            
            Spacer()
            
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
            .offset(y: -keyboardOffset)
            .animation(.easeInOut, value: keyboardOffset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        self.keyboardOffset = frame.height
                    }
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    self.keyboardOffset = 0
                }
            }
        }
        .padding(.bottom, keyboardOffset)
        .animation(.easeInOut(duration: 0.3), value: keyboardOffset)
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
