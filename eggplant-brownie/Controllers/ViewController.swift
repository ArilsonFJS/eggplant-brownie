//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 08/10/22.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}
                                       //Protocolo de Dados   |Protocolo de acoes de usuario
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var itensTableView: UITableView?
    
    
    
    //MARK: - Atributos
    var delegate: AdicionaRefeicaoDelegate?
    
    var itens: [Item] = []
    
    var itensSelecionados: [Item] = []
    
    //MARK: - IBOutlets
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        let botaoAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAddItem
        recuperaItens()
    }
    
    func recuperaItens(){
        itens = ItemDao().recupera()
    }
    
    @objc func adicionarItens(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        ItemDao().save(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else{
            Alerta(controller: self).exibe(mensagem: "Erro ao atualizar a tabela")
        }
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let item = itens[indexPath.row]
        celula.textLabel?.text = item.nome
        
        return celula
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            
            let linhaTabela = indexPath.row
            itensSelecionados.append(itens[linhaTabela])
            
        } else {
            celula.accessoryType = .none
            let item = itens[indexPath.row]
            if let position = itensSelecionados.index(of: item) {
                itensSelecionados.remove(at: position)
            }
        }
        
    }
    
    func recuperaRefeicaoDoFormulario () -> Refeicao? {
        
            // Retirando as variaveis opcionais com guard let
            guard let nomeRefeicao = nomeTextField?.text, let felicidadeRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeRefeicao) else {
                Alerta(controller: self).exibe(mensagem: "Erro ao ler campos")
                return nil
            }
            
            let refeicao = Refeicao(nome: nomeRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
            print("\n" + "Comi \(refeicao.nome) e fiquei com felicidade: \(refeicao.felicidade)")
        
            return refeicao
    }
    
    //MARK: - IBActions
    @IBAction func adicionar(_ sender: Any) {
    
        guard let refeicao =  recuperaRefeicaoDoFormulario() else{ return }
        delegate?.add(refeicao)
    
        //Metodo usado para retornar a tela anterior 
        navigationController?.popViewController(animated: true)
   }
}

