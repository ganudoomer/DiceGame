//
//  HistoryView.swift
//  DiceGame
//
//  Created by Sree on 24/01/22.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var dieController: Dies
    var body: some View {
        NavigationView{
            List {
                ForEach(dieController.dies,id: \.self) { die in
                    Text("\(die)")
                }
            }.navigationTitle("History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(Dies())
    }
}
