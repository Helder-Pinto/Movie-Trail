//
//  LoginViewController.swift
//  MovieTrail
//
//  Created by Apple on 30/03/2019.
//  Copyright © 2019 Helder Pinto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToMain", sender: self)
//        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
//        mainTabController.selectedViewController = mainTabController.viewControllers?[0]
//        present(mainTabController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
