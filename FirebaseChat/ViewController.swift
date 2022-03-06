//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Mac on 06/01/22.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButtonCchat(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

