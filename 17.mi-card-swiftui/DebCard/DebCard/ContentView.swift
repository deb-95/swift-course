//
//  ContentView.swift
//  DebCard
//
//  Created by Debora Del Vecchio on 09/09/21.
//

import SwiftUI
struct Colors {
    static let primaryColor = Color(red: 0.04, green: 0.52, blue: 0.89)
    static let accentColor = Color(red: 0.51, green: 0.93, blue: 0.93)
}
struct ContentView: View {
    var body: some View {
        ZStack {
            Colors.primaryColor.edgesIgnoringSafeArea(.all)
            VStack {
                Image("red-panda")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Colors.accentColor.opacity(0.5), lineWidth: 3.0))
                Text("Debora Del Vecchio")
                    .font(Font.custom("Urbanist-Regular", size: 26.0))
                    .bold()
                    .foregroundColor(.white.opacity(0.8))
                Text("Mobile Developer")
                    .font(Font.custom("Urbanist-Italic", size: 17.0))
                    .foregroundColor(.white)
                Divider().background(Colors.accentColor).frame(maxWidth: 250)
                InfoTile(iconName: "phone.fill", content: "012-3456789")
                InfoTile(iconName: "envelope.fill", content: "deb@example.com")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
