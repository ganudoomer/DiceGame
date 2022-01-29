//
//  ContentView.swift
//  DiceGame
//
//  Created by Sree on 24/01/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dieController = Dies()
    var body: some View {
        TabView {
            
            RollDiceView()
                       .tabItem {
                               Label("Roll Dice", systemImage: "die.face.4")
                       }.environmentObject(dieController)
            HistoryView()
                       .tabItem {
                           Label("History", systemImage: "text.book.closed")
                       }.environmentObject(dieController)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
