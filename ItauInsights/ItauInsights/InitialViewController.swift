//
//  InitialViewController.swift
//  ItauInsights
//
//  Created by Piera Marchesini on 26/08/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var faceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceButton.layer.cornerRadius = self.faceButton.frame.size.width/2
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
