//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Arilson Silva on 04/12/22.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
    var refeicoes: Array<Refeicao> = []
    
    override func viewDidLoad() {
        //Criando diretorio onde o sera salvo o arquivo de refeicoes
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return }
        
        //Criando uma nova pasta para salvar as refeicoes
        let caminho = diretorio.appendingPathComponent("refeicoes")
        
        do{
            //Pegar os dados que estao salvos
            let dados = try Data(contentsOf: caminho)
            //Converter a lista de refeicoes
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else {return}
            //Apresentando as refeicoes salvas assim que a aplicao for carregada
            refeicoes = refeicoesSalvas
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let refeicao = refeicoes[indexPath.row]
        
        celula.textLabel?.text = refeicao.nome
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        celula.addGestureRecognizer(longPress)
        return celula
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            
            //Recuperando qual foi a refeicao selecionado pelo usuario
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: {
                alerta in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
        
        //Criando diretorio onde o sera salvo o arquivo de refeicoes
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return }
        
        //Criando uma nova pasta para salvar as refeicoes
        let caminho = diretorio.appendingPathComponent("refeicoes")
        
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
    
    //Pega o destino no qual o segue esta sendo preparado para instaciar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
