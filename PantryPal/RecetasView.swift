import SwiftUI

struct RecetasView: View {
    let recetas: [Receta]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recetas Encontradas")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
            
            if recetas.isEmpty {
                Text("No se encontraron recetas.")
                    .font(.title2)
                    .padding()
            } else {
                List(recetas) { receta in
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(receta.title)
                                .font(.title2)
                                .bold()
                            
                        }
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: receta.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .padding(.vertical, 10)
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecetasView(recetas: [
        Receta(id: 123, title: "Spaghetti Carbonara", image: "https://via.placeholder.com/150")
    ])
}
