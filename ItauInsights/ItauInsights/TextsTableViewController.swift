//
//  TextsTableViewController.swift
//  ItauInsights
//
//  Created by Piera Marchesini on 26/08/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit

class TextsTableViewController: UITableViewController {

    var messages = [String]()
    var incomingMessages: [String] = [
        "Olá! Que bom ter você aqui para bater um papo sobre seu negócio. \nEu sou o Rubens e estou aqui para te ajudar a impulsionar o seu negócio. \n\nComo posso te chamar?",
        "Vamos fazer algumas perguntas sobre seu negócio e depois sobre seus custo, para podermos fazer um diagnóstico da saúde e do momento da sua empresa vc trabalha com produto ou serviço?",
        "Qual ramo você se inclui? \nPor exemplo: Alimentação,\nVestuário e acessórios, \nFrete e transporte,\nConstrução civil e manutenção, \nComunicação, \nProfissional de tecnologia",
        "Você trabalha na sua casa? \nSe você trabalha na sua casa, é importante saber quanto das suas contas são de responsabilidade da empresa, e quanto são suas.",
        "Onde é o seu negócio?",
        "Legal! Agora já entendemos um pouco do seu perfil empreendedor. Vamos ver como estão suas contas para fazer um diagnóstico mais preciso. \nQuanto você fatura com suas vendas em um mês?",
        "Você tem pago seus impostos (DAS) em dia?",
        "Quanto você gasta com a compra de seus insumos e matéria prima.",
        "Qual é o custo com mão de obra? (sua e de possíveis funcionários)",
        "Muito bom, já conseguimos entender um pouco melhor seu fluxo de caixa."
    ]
    var countIncoming = 0
    fileprivate let MessageCellIdentifier = "MessageTableViewCell"
    
    func addMessage(_ message: String) {
        messages.append(message)
        self.tableView.reloadData()
        showMessage()
    }
    
    func showMessage() {
        messages.append(incomingMessages[countIncoming])
        self.tableView.reloadData()
        countIncoming += 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: MessageCellIdentifier, bundle: nil), forCellReuseIdentifier: MessageCellIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 10.0
        self.tableView.tableFooterView = UIView()
        showMessage()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let count = messages?.count {
//            return count
//        }
//        return 0
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCellIdentifier) as? MessageTableViewCell else {
            return UITableViewCell()
        }
        
        let message = messages[indexPath.row]
        let currentUserIsSender = indexPath.row % 2 == 0
        cell.configure(withMessage: message, currentUserIsSender: currentUserIsSender)
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
