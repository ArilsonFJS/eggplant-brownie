import UIKit

//let comprar = ["Camisa","Short","Calça","Blusa","Meia","Sapato"]
/*let comprar: [String] = []

func listaShopping (comprar: Array<String>) {
    if comprar.isEmpty{
        print("Lista de compras vazia")
    }else{
        for i in comprar {
            print(i)
        }
    }
}

listaShopping(comprar: comprar)*/

//let pesos: [Double] = []
/*let pesos = [78.10,90.5,80.3]

func somarPesos(pesos: [Double]) -> Double{
    var total: Double = 0
    
    if pesos.isEmpty{
        print("A lista de pesos está vazia")
    }else{
        for i in pesos {
            total += i
        }
    }
    return total
}
let total = somarPesos(pesos:pesos)
print(total)*/


//---------------------------------------Boas praticas para extrais valores opcinais

/*--------------------------------if let
 
var nome: String?

nome = "Arilson"

if let nome = nome {
    print(nome)
}else{
    print("Essa varíavel é nula")
}

---------------------------------guard let
 
com esse método é temos a vantagem de se utilizar a variável "n" fora do escopo, diferente do if let
//que só poderá ser usada dentro do escopo

func exibeNome(){
    guard let n = nome else{
        return
    }
    print(n)
}

exibeNome()
*/

/*class Refeicao {
    
    var nome: String
    var felicidade: String
    
    init(nome: String, felicidade: String) {
        self.nome = nome
        self.felicidade = felicidade
    }
}

let refeicao = Refeicao(nome: "Frango", felicidade: "10")
print("Refeicao \(refeicao.nome) de Felicidade \(refeicao.felicidade)")
*/

var listaJogos: Set<String> = ["God of War", "Call of Duty", "Fifa"]

if listaJogos.isEmpty {
    print("A lista está vazia")
}else{
    for lista in listaJogos{
        print(lista)
    }
}
