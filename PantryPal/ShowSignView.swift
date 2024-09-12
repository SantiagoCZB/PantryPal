import SwiftUI

struct ShowSignView: View {
    private(set) var labelData: Classification

    var body: some View {
        VStack {
            Text(labelData.label.capitalized)  // Muestra el label
                .font(.title)
                .foregroundColor(.black)
                .padding(.bottom, 5)

        }
        .frame(width: 300, height: 100)  // Ajustamos el tamaño
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ShowSignView_Previews: PreviewProvider {
    static var previews: some View {
        ShowSignView(labelData: Classification(label: "Test Label", confidence: 0.85))
    }
}
