import SwiftUI

struct AgregarIngredientesView: View {
    @Binding var ingredientes: [String] // Lista de ingredientes
    @State private var nuevoIngrediente = "" // Para almacenar el nuevo ingrediente temporalmente
    @State private var keyboardOffset: CGFloat = 0 // Para ajustar la vista cuando aparece el teclado
    
    var body: some View {
        VStack {
            // Lista de ingredientes, que se va llenando desde abajo
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack {
                        ForEach(ingredientes, id: \.self) { ingrediente in
                            Text(ingrediente)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 10)
                }
                .onAppear {
                    scrollToBottom(scrollView)
                }
                .onChange(of: ingredientes) {
                    scrollToBottom(scrollView)
                }
            }
            
            Spacer() // Asegura que el TextField y el botón estén abajo
            
            // TextField y botón para agregar ingredientes
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
            .offset(y: -keyboardOffset) // Ajuste con el teclado
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
        // Asegurarse de que el campo no esté vacío
        if !nuevoIngrediente.isEmpty {
            ingredientes.append(nuevoIngrediente) // Agregar el nuevo ingrediente a la lista
            nuevoIngrediente = "" // Limpiar el campo después de agregar
        }
    }
    
    private func scrollToBottom(_ scrollView: ScrollViewProxy) {
        DispatchQueue.main.async {
            if let lastItem = ingredientes.last {
                scrollView.scrollTo(lastItem, anchor: .bottom)
            }
        }
    }
}

#Preview {
    AgregarIngredientesView(ingredientes: .constant(["Pollo", "Tomate", "Pan", "Lechuga"]))
}
