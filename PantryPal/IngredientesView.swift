//
//  IngredientesView.swift
//  PantryPal
//
//  Created by Alumno on 10/09/24.
//

import SwiftUI

struct IngredientesView: View {
    @State private var ingredientes: [(nombre: String, cantidad: String)] = []
    @State private var showAgregarIngredientes = false

    var body: some View {
        VStack {
            
            HStack{
                Text("PantryPal")
                    .foregroundStyle(.blue)
                Spacer()
            }
            .padding(.leading, 15.0)
            
            HStack{
                Text("Ingredientes")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.leading, 15.0)
            
            List(ingredientes, id: \.nombre) { ingrediente in
                HStack {
                    Text("\(ingrediente.nombre) - \(ingrediente.cantidad)")
                    Spacer()
                }
            }
            .navigationTitle("Ingredientes")
            
            Button(action: {
                showAgregarIngredientes = true
            }) {
                Text("Agregar Ingredientes")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
            }
            .sheet(isPresented: $showAgregarIngredientes) {
                AgregarIngredientesView(ingredientes: $ingredientes)
            }
            .padding(.bottom, 10)
        }
    }
}

struct IngredientesView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientesView()
    }
}
