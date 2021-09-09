//
//  ContentView.swift
//  Dicee-SwiftUI
//
//  Created by Debora Del Vecchio on 09/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var leftDiceNumber = 1
    @State var rightDiceNumber = 1

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(diceNumber: leftDiceNumber)
                    DiceView(diceNumber: rightDiceNumber)
                }
                Spacer()
                Button(action: {
                    self.leftDiceNumber = Int.random(in: 1...6)
                    self.rightDiceNumber = Int.random(in: 1...6)
                }, label: {
                    Text("Roll")
                        .font(.system(size: 50.0))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }).background(Color.red)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DiceView: View {
    let diceNumber: Int
    var body: some View {
        Image("dice\(diceNumber)")
            .aspectRatio(1, contentMode: .fit)
            .padding(.all)
    }
}
