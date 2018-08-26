//
//  HomeViewController.swift
//  ItauInsights
//
//  Created by Piera Marchesini on 26/08/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var olaBeatriz: UILabel!
    @IBOutlet weak var resultado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let txt = NSAttributedString(string: "Olá, ", attributes: [NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor(red: 122/255, green: 122/255, blue: 120/255, alpha: 1)])
        
        let txt2 = NSAttributedString(string: "Beatriz!", attributes: [NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 24)!, NSAttributedStringKey.foregroundColor: UIColor(red: 122/255, green: 122/255, blue: 120/255, alpha: 1)])
        
        let text = NSMutableAttributedString()
        text.append(txt)
        text.append(txt2)
        olaBeatriz.attributedText = text
        
        let a = NSAttributedString(string: "Sua empresa ficou com nota ", attributes: [NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor(red: 122/255, green: 122/255, blue: 120/255, alpha: 1)])
        let b = NSAttributedString(string: "63", attributes: [NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)])
        let text2 = NSMutableAttributedString()
        text2.append(a)
        text2.append(b)
        resultado.attributedText = text2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
