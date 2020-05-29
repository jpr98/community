//
//  ProfileViewController.swift
//  Community
//
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // UI Variables
    @IBOutlet weak var logoutBT: UIButton!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLB: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emergercyTF: UITextField!
    @IBOutlet weak var communTF: UITextField!
    
    @IBOutlet weak var saveBT: UIButton!
    
    
    @IBOutlet weak var errorLB: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //getProfileInfo
        
        //User.shared.load.(completion: , completionUser: )
        errorLB.text = ""
        
        
        
    }
    
    
    @IBAction func logOutTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user_loggedin")
        let ob = WelcomeViewController.make()
        UIApplication.shared.windows.first?.rootViewController = ob
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        //ChangeProfileInfo
        
        
        
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
