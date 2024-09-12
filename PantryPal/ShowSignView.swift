//
//  ShowSignView.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 15/10/23.
//

import SwiftUI

struct ShowSignView: View {
    private(set) var labelData: Classification
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(width: 50, height: 50)
                
            Text(labelData.label.capitalized)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("Secundarycolor"))
                .font(Font
                    .custom("Chapeau-Medium", size: 20))
                
        }
    }
}

struct ShowSignView_Previews: PreviewProvider {
    static var previews: some View {
        ShowSignView(labelData: Classification())
    }
}
