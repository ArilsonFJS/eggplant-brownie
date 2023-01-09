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
    
    var itens: [Item] = [Item(nome: "Molho de tomate", calorias: 30.0),
                         Item(nome: "Queijo", calorias: 30.0),
                         Item(nome: "Manjericao", calorias: 30.0)]
    
    var itensSelecionados: [Item] = []
    
    //MARK: - IBOutlets
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        let botaoAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAddItem
        
        //recuperando os arquivos
        do{
            guard let diretorio = recuperarDiretorio() else {return}
            let dados = try Data(contentsOf: diretorio)
            let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! Array<Item>
            
            itens = itensSalvos
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    @objc func adicionarItens(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        
        if let tableView = itensTableView {
            tableView.reloadData()
        } else{
            Alerta(controller: self).exibe(mensagem: "Erro ao atualizar a tabela")
        }
        
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

