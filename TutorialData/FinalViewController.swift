//
//  FinalViewController.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/20/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickFinal(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
