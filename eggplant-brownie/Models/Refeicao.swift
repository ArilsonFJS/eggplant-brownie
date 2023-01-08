//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 01/12/22.
//

import UIKit

class Refeicao: NSObject {

    let nome: String
    let felicidade: Int
    var itens: Array<Item> = []
    
    init(nome: String, felicidade: Int, itens: [Item] = []) {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    func totalCalorias()-> Double{
        var total = 0.0
        
        for item in itens {
            total += item.calorias
        }
        return total
    }
    
    func detalhes() -> String{
        var mensagem = "Felicidade: \(felicidade)"
        
        for item in itens {
            mensagem += ", \(item.nome) - Calorias: \(item.calorias)"
        }
        
        return mensagem
    }
}
