//
//  alerta.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 14/12/22.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller =  controller
    }
    
    func exibe(titulo: String = "Atenção", mensagem: String){
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        controller.present(alerta, animated: true)
    }
}
