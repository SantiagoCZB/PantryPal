//
//  MainView.swift
//  PantryPal
//
//  Created by MacBook Air on 10/09/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {

            Spacer(minLength: 20)
            
            // La vista seleccionada se renderiza aquí.
            switch selectedTab {
            case 0:
                IngredientesView()
            //case 1:
              //  TiendaView()
            //case 2:
               // PerfilView()
            default:
                IngredientesView()
            }
            Spacer(minLength: 40)
            
            HStack {
                Spacer()
                Button(action: {
                    selectedTab = 0
                }) {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 32, height: 28)
                            .foregroundColor(selectedTab == 0 ? Color(red: 0/255, green: 156/255, blue: 166/255) : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(selectedTab == 1 ? Color(red: 0/255, green: 156/255, blue: 166/255) : .gray)
                    }
                }
                Spacer()
                
                    
            }
            .padding(.bottom, 25)
            .padding(.top, 20) // Ajusta el padding inferior para más espacio.
            .background(Color.white.shadow(radius: 10))
            .navigationBarBackButtonHidden(true)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainView()
}

