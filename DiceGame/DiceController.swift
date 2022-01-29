//
//  DiceController.swift
//  DiceGame
//
//  Created by Sree on 25/01/22.
//

import Foundation


@MainActor class Dies: ObservableObject {
    @Published  var dies = [Int]()
    
    let savePath = FileManager.doucmentsDir.appendingPathComponent("dieV2")
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Int].self, from: data)
            self.dies = decoded
        } catch {
            print("Some Random Error \(error.localizedDescription)")
            self.dies = []
        }
    }
    
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(dies)
            try data.write(to: savePath,options: [.atomic,.completeFileProtection])
        } catch {
            print("Error occurred While Saving")
        }
    }
    
    
    func add(die: Int) {
        dies.append(die)
        save()
    }

    func load(){
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Int].self, from: data)
            self.dies = decoded
        } catch {
            print("Some Random Error \(error.localizedDescription)")
            self.dies = []
        }
    }
}
