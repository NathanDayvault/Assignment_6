//
//  AdventurerDetailViewController.swift
//  assignment6
//
//  Created by Christian Gil on 10/18/18.
//  Copyright © 2018 MobileComputing. All rights reserved.
//

import UIKit

class AdventurerDetailViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Adventurer Recruit"
        nameTextField.delegate = self
        classTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(AdventurerDetailViewController.keyboardDidChange(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AdventurerDetailViewController.keyboardDidChange(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AdventurerDetailViewController.keyboardDidChange(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    
    // UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    // Methods
    func hideKeyboard()
    {
        nameTextField.resignFirstResponder()
        classTextField.resignFirstResponder()
    }
    
    @objc func keyboardDidChange(notification: Notification)
    {
        view.frame.origin.y = -300
        
        // Actual keyboard height
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        // Show or hide
        if (notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification)
        {
//            view.frame.origin.y = -keyboardRect.height
            view.frame.origin.y = 0
        }
        else{
            view.frame.origin.y = 0
        }
        
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
