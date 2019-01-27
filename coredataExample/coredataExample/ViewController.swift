//
//  ViewController.swift
//  coredataExample
//
//  Created by mac on 26/01/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

class DataCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
}

class ViewController: UIViewController {
 
    @IBOutlet weak var tblData: UITableView!
    var people : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        getData()
    }

    func addData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: manageContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: manageContext)
        
        person.setValue("ravi", forKey: "name")
        person.setValue("raviseta@gmail.com", forKey: "email")
        person.setValue("123456", forKey: "password")
        
        do {
            
            try manageContext.save()
            people.append(person)
        }catch let err as NSError{
            print("error",err)
        }
        
        
    }
    
    func getData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else{
            return
        }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchContext = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do{
            people = try manageContext.fetch(fetchContext)
            tblData.reloadData()
        }catch let err as NSError{
            print("hello",err)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DataCell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as! DataCell
        
        let person = people[indexPath.row]
        
        cell.lblName.text = person.value(forKey: "name") as? String
        cell.lblEmail.text = person.value(forKey: "email") as? String
        cell.lblPassword.text = person.value(forKey: "password") as? String
        return cell
    }
    
    
    
}
