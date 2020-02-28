//
//  ViewController.swift
//  MyCoreDataTutorial
//
//  Created by Joakim Sjöstedt on 2020-02-28.
//  Copyright © 2020 Joakim Sjöstedt. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = setContext().viewContext

        setData()
        fetchMyData()
        saveData()
    }
    
    func setData() {
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let myEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        myEntity.setValue("Bob", forKey: "name")
        myEntity.setValue(4, forKey: "age")
    }
    
    func saveData() {
        do {
            try context.save()
            print("saved")
        } catch {
            let nserror = error as NSError
            print(nserror)
        }
    }
    
    func fetchMyData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let myDataName = data.value(forKey: "name") as! String
                let myDataAge = data.value(forKey: "age") as! Int
                
                print(myDataAge)
                print(myDataName)
            }
        } catch {
            let nserror = error as NSError
            print(nserror)
        }
    }
    
     func setContext() -> NSPersistentContainer {
         let persistentContainer: NSPersistentContainer = {
             let container = NSPersistentContainer(name: "MyCoreDataTutorial")
             container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                 if let error = error as NSError? {
                     fatalError("Unresolved error \(error), \(error.userInfo)")
                 }
             })
             return container
         }()
        return persistentContainer
     }
}

