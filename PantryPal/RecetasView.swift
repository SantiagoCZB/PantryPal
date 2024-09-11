import SwiftUI

struct RecetasView: View {
    let recetas: [Receta] // Recibe las recetas como un parámetro

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recetas Encontradas")
                .font(.largeTitle) // Hacer el título más grande
                .bold()
                .padding(.horizontal) // Añadir padding solo en los laterales para no ocupar demasiado espacio en la parte superior
            
            if recetas.isEmpty {
                Text("No se encontraron recetas.")
                    .font(.title2) // Aumentar un poco el tamaño del texto
                    .padding()
            } else {
                List(recetas) { receta in
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(receta.title)
                                .font(.title2) // Aumentar el tamaño del título
                                .bold()
                            
                        }
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: receta.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill) // Usar .fill para ocupar más espacio
                                .frame(width: 100, height: 100) // Aumentar el tamaño de la imagen
                                .clipShape(RoundedRectangle(cornerRadius: 10)) // Añadir bordes redondeados
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .padding(.vertical, 10) // Aumentar el padding entre los elementos
                }
                .listStyle(PlainListStyle()) // Cambiar el estilo de la lista para que se vea más limpia
            }
        }
        .padding(.horizontal) // Reducir el padding general para que el contenido se expanda más
    }
}

#Preview {
    RecetasView(recetas: [
        Receta(id: 123, title: "Spaghetti Carbonara", image: "https://via.placeholder.com/150")
    ])
}
