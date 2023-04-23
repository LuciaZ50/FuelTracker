//
//  Service.swift
//  FuelTracker
//
//  Created by LuciaDecode on 16.01.2023..
//

import Foundation
import RealmSwift

class Service {
    
    let realm = try! Realm()
    var fuels: [FuelInfo] = []
    
    init() {
        self.fuels = readFromRealm()
    }
    
    func writeToRealm(fuel: FuelInfo) {
        do {
            try realm.write {
                realm.add(fuel)
                print("SAVEED")
            }
        } catch {
            print("Couldn't  write into realm")
        }
        self.fuels = readFromRealm()
    }
    
    func readFromRealm() -> [FuelInfo] {
        let fetchedFuels = realm.objects(FuelInfo.self)
        self.fuels = Array(fetchedFuels)
        return Array(fetchedFuels)
    }
    
    func deleteFromRealm(at index: Int) {
        
        let item = realm.objects(FuelInfo.self)[index]
        try! realm.write {
            realm.delete(item)
        }
        
        print("deleting...")
        self.fuels = readFromRealm()
        print(self.fuels)
    
    }
}
