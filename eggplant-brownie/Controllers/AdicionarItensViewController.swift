//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 10/12/22.
//

import UIKit

protocol AdicionaItensDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var caloriaTextField: UITextField?
    
    //MARK: - Atributos
    var delegate: AdicionaItensDelegate?
    
    init(delegate: AdicionaItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: - IBAction
    @IBAction func adicionarItem(_ sender: Any) {
        
        guard let nome = nomeTextField?.text, let caloriaItem = caloriaTextField?.text, let calorias = Double(caloriaItem) else { return }
        
        let item = Item(nome: nome, calorias: calorias)
        
        delegate?.add(item)
        
        navigationController?.popViewController(animated: true)
    }
    
}
