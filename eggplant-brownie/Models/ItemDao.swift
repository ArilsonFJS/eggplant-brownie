//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 09/01/23.
//

import Foundation

class ItemDao {
    
    func save(_ itens: [Item]) {
        
        do{
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let caminho = recuperarDiretorio() else { return }
            try dados.write(to: caminho)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    //Criando diretorio para salvar os arquivos de itens
    func recuperarDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathExtension("itens")
        
        return caminho
    }
    
    func recupera () -> [Item] {
        //recuperando os arquivos
        do{
            guard let diretorio = recuperarDiretorio() else {return []}
            let dados = try Data(contentsOf: diretorio)
            let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! Array<Item>
            
            return itensSalvos
        }catch{
            print(error.localizedDescription)
            return []
        }
    }
}
