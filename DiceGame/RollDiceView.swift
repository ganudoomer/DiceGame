//
//  RollDiceView.swift
//  DiceGame
//
//  Created by Sree on 24/01/22.
//

import SwiftUI

struct RollDiceView: View {
    private var options = [4,6,8,10,12,20,100]
    @State private var selectedDiceCount = 4
    @State private var selectedDiceSide = 1
    @EnvironmentObject var dieController: Dies
    
    @State var timeRemaining = 3
    @State var timer = Timer.publish(every: 1/2, on: .main, in: .common).autoconnect()
    @State var isRolling = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Picker your dice side")) {
                    Picker("Dice Side", selection: $selectedDiceCount) {
                        ForEach(options, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                Section("Dice Roll") {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            if(selectedDiceSide > 6) {
                                Text("\(selectedDiceSide)")
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(isRolling ? Color.red : Color.black, lineWidth: 10)
                                )
                            } else {
                                Image(systemName: "die.face.\(selectedDiceSide)")
                                    .resizable()
                                    .foregroundColor(isRolling ? Color.red : Color.black)
                                    .frame(width: 100, height: 100)
                            }
                           
                            
                            Spacer()
                        }.onReceive(timer) { _ in
                            print("Happening")
                            if timeRemaining ==  1 {
                                timer.upstream.connect().cancel()
                                let random =  Int.random(in: 1..<selectedDiceCount)
                                selectedDiceSide = random
                                isRolling = false
                                print("DIE\(random)")
                                dieController.add(die: random)
                                return
                            }
                            if timeRemaining > 0 {
                               let random =  Int.random(in: 1..<selectedDiceCount)
                                selectedDiceSide = random
                                timeRemaining -= 1
                                print("DIE 2\(random)")
                            }
                        }
                        
                        Spacer()
                    }.padding(.top,100)
                        .padding(.bottom,100)
                }.onAppear {
                    timer.upstream.connect().cancel()
                }
               
                
                          
                
            }.navigationTitle("Roll Dice")
                .navigationBarItems(trailing: Button("Roll"){
                    start()
                })
                
        }
    }
    
    func start() {
        timeRemaining = 3
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        isRolling = true
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView().environmentObject(Dies())
    }
}
