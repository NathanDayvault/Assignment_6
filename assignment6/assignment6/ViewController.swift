//
//  ViewController.swift
//  assignment6
//
//  Created by Christian Gil on 10/15/18.
//  Copyright © 2018 MobileComputing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adventurers"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    var names : [String] = []
    
    @IBAction func addMember(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController( title: "New Name",
                                       message: "Add a new name",
                                       preferredStyle: .alert )
        
        let saveAction = UIAlertAction( title: "Save",
                                        style: .default)
        {
            [unowned self] action in
                                            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else
                {
                return
                }
                                            
            self.names.append(nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction ( title: "Back",
                                           style: .cancel)
    
    alert.addTextField()
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = names[indexPath.row]
            return cell
    }
}


