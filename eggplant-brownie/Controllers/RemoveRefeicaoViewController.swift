//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 17/12/22.
//

import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    
    func exibe (_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void){
        
        //Cria um alerta para o usuario sobre a refeicao selecionada
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        //Criando um botao no alerta para cancelar
        let botaoCancelar = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(botaoCancelar)
        
        //Criando um botao no alerta para remover
        let botaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        
        //Adionando o botao
        alerta.addAction(botaoRemover)
        
        //Exibindo no ViewController
        controller.present(alerta, animated: true, completion: nil)
    }
}
