//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 01/12/22.
//

import UIKit

class Refeicao: NSObject, NSCoding {

    let nome: String
    let felicidade: Int
    var itens: Array<Item> = []
    
    init(nome: String, felicidade: Int, itens: [Item] = []) {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    //MARK: - NSConding
    
    //Metodo que transforma os atributos da classe em bytes
    func encode(with coder: NSCoder) {
        //forKey serve como uma chave para resgatar a informação.
        coder.encode(nome, forKey: "nome")
        coder.encode(felicidade, forKey: "felicidade")
        coder.encode(itens,forKey:"itens")
    }
    
    //Metodo que decodifica os atributos que foram transformado em bytes
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        felicidade = coder.decodeInteger(forKey: "felicidade")
        itens = coder.decodeObject(forKey: "itens") as! Array<Item>
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
