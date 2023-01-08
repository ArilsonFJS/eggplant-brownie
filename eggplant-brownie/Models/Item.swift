//
//  Item.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 01/12/22.
//

import UIKit

class Item: NSObject {
    
    var nome: String
    var calorias: Double
    
    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
