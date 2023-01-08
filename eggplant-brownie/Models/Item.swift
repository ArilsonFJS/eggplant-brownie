//
//  Item.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 01/12/22.
//

import UIKit

class Item: NSObject, NSCoding {
    
    var nome: String
    var calorias: Double
    
    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
    
    //MARK: - NSConding
    
    //Metodo que transforma os atributos da classe em bytes
    func encode(with coder: NSCoder) {
        //forKey serve como uma chave para resgatar a informação.
        coder.encode(nome, forKey: "nome")
        coder.encode(calorias, forKey: "calorias")
    }
    
    //Metodo que decodifica os atributos que foram transformado em bytes
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        calorias = coder.decodeDouble(forKey: "calorias")
    }
}
