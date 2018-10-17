//
//  ViewController.swift
//  assignment6
//
//  Created by Christian Gil on 10/15/18.
//  Copyright © 2018 MobileComputing. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adventurers"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Adventurer")
        
        //3
        do
        {
            members = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

    
    var members: [NSManagedObject] = []
    
    @IBAction func addMember(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController( title: "New Name",
                                       message: "Add a new name",
                                       preferredStyle: .alert )
        
        let saveAction = UIAlertAction (title: "Save", style: .default)
        {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }

        
        let cancelAction = UIAlertAction ( title: "Back",
                                           style: .cancel)
    
    alert.addTextField()
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
    }
    
    func save(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
        
        let member = NSManagedObject(entity: entity, insertInto: managedContext)
        
        member.setValue(name, forKeyPath: "name")
        
        do
        {
            try managedContext.save()
            members.append(member)
        }
        catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let member = members[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = member.value(forKeyPath: "name") as? String
            return cell
    }
}



