import SwiftUI

struct CameraScanView: View {
    @EnvironmentObject var predictionStatus: PredictionStatus
    @StateObject var classifierViewModel = ClassifierViewModel()
    @State private var showMessage = false  // Estado para controlar la visibilidad del mensaje
    
    // Closure para pasar el ingrediente de vuelta a la vista principal
    var onIngredientAdded: (String) -> Void

    var body: some View {
        let predictionLabel = predictionStatus.topLabel
        let confidence = predictionStatus.topConfidence
        
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack(alignment: .center) {
                    // Mensaje en la parte superior que aparece temporalmente
                    if showMessage {
                        Text("Se agregó el ingrediente a la lista")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.top, 20)
                            .transition(.move(edge: .top))  // Animación para mostrar el mensaje
                            .zIndex(1)  // Asegurarse de que esté por encima de otros elementos
                    }
                    
                    // Cámara más pequeña y arriba
                    VStack {
                        LiveCameraRepresentable() {
                            // Actualizamos la predicción
                            predictionStatus.setLivePrediction(with: $0, label: $1, confidence: String($2))
                            print("Prediction label: \($1), confidence: \($2)")  // Asegúrate de que esto funciona correctamente
                        }
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4)  // Cámara más pequeña y más arriba
                    }
                    
                    Spacer() // Espaciado entre la cámara y la predicción

                    // Mostrar la predicción y confianza abajo
                    ShowSignView(labelData: Classification(label: predictionLabel, confidence: confidence))
                        .padding()
                    
                    // Botón para agregar el ingrediente actual
                    Button(action: {
                        // Añade solo la predicción, sin la confianza
                        onIngredientAdded(predictionLabel)
                        withAnimation {
                            showMessage = true  // Mostrar el mensaje cuando se presione el botón
                        }
                        
                        // Ocultar el mensaje después de 2 segundos
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showMessage = false
                            }
                        }
                    }) {
                        Text("Agregar ingrediente")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                    }
                    
                    Spacer()
                }
            }
        } // Geo
    }
}

struct CameraScanView_Previews: PreviewProvider {
    static var previews: some View {
        CameraScanView(onIngredientAdded: { _ in })
            .environmentObject(PredictionStatus())
    }
}
