//
//  RefeicaoDao.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 09/01/23.
//

import Foundation

class RefeicaoDao {
    
    func recuperarCaminho () -> URL? {
        //Criando diretorio onde o sera salvo o arquivo de refeicoes
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        //Criando uma nova pasta para salvar as refeicoes
        let caminho = diretorio.appendingPathComponent("refeicoes")
        return caminho
    }
    
    func save (_ refeicoes: [Refeicao]){
        guard let caminho = recuperarCaminho() else {return}
        
        //Tratamendo de erro
        do{
            //Salvando a lista de refeicoes
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            
            //Criar os arquivos
            try dados.write(to: caminho)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func recupera () -> [Refeicao] {
        guard let caminho = recuperarCaminho() else {return []}
        
        do{
            //Pegar os dados que estao salvos
            let dados = try Data(contentsOf: caminho)
            //Converter a lista de refeicoes
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else {return []}
            
            return refeicoesSalvas
        }catch{
            print(error.localizedDescription)
            return []
        }
    }
}
