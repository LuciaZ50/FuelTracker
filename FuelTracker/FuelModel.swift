//
//  FuelModel.swift
//  FuelTracker
//
//  Created by LuciaDecode on 16.01.2023..
//

import Foundation
import RealmSwift

class FuelInfo: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var date: Date = Date()
    @Persisted var fuelAmount: String = ""
    @Persisted var distance: String = ""
    
    override init(){
        super.init()
    }

    init(date: Date, fuelAmount: String, mileage: String ){
        self.date = date
        self.fuelAmount = fuelAmount
        self.distance = mileage
    }
}
