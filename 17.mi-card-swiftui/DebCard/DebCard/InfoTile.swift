//
//  InfoTile.swift
//  DebCard
//
//  Created by Debora Del Vecchio on 09/09/21.
//

import SwiftUI

struct InfoTile: View {
    let iconName: String
    let content: String
    var body: some View {
        RoundedRectangle(cornerRadius: 30.0)
            .fill(Color.white)
            .frame(maxHeight: 40)
            .overlay(
                HStack {
                    Image(systemName: iconName)
                        .foregroundColor(Colors.primaryColor)
                    Text(content).foregroundColor(Color("InfoColor"))
                }
            )
            .padding(.all)
    }
}

struct InfoTile_Previews: PreviewProvider {
    static var previews: some View {
        InfoTile(iconName: "phone.fill", content: "Hello").previewLayout(.sizeThatFits)
    }
}
