//
//  CoreDataProcess.swift
//  hw3
//
//  Created by Berksu Kısmet on 10.10.2022.
//

import UIKit
import CoreData

// This is a singelton for all of the core data
struct CoreDataProcess {
    static var shared = CoreDataProcess()
    
    private var managedContext: NSManagedObjectContext?
    private var fetchRequest: NSFetchRequest<NSFetchRequestResult>?
    var favouritesArray: [Favourites] = []
    
    var favouritesMediaNames: [Int]{
        get{
            CoreDataProcess.shared.favouritesArray.map{$0.trackId!}
        }
    }
    
    // initialize database and fetch items
    private init() {
        initializeCoreData()
        fetchCoreData()
    }
    
    // initialize database
    mutating func initializeCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteItem")
    }
    
    //fetching
    mutating func fetchCoreData(){
        favouritesArray = []
        
        guard let managedContext = managedContext else { return }
        guard let fetchRequest = fetchRequest else { return }
        
        do{
            let fetchResults = try managedContext.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject]{
                guard let trackID = item.value(forKey: "trackID") else { return }
                guard let name = item.value(forKey: "name") else { return }
                guard let artworkLarge = item.value(forKey: "artworkLarge") else { return }
                guard let releaseDate = item.value(forKey: "releaseDate") else { return }
                guard let price = item.value(forKey: "price") else { return }

                favouritesArray.append(Favourites(trackId: trackID as? Int,
                                            name: name as? String,
                                            artworkLarge: URL(string: artworkLarge as? String ?? ""),
                                            releaseDate: releaseDate as? String,
                                            price: price as? Double ))
            }
        }catch let error{
                print(error.localizedDescription)
        }

    }
    
    //remove all data from database
    mutating func deleteAllData() {
        guard let managedContext = managedContext else { return }
        guard let fetchRequest = fetchRequest else { return }
        
        do{
            let fetchResults = try managedContext.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject]{
                managedContext.delete(item)
            }
        }catch let error{
                print(error.localizedDescription)
        }
        
        save()
    }
    
    //remove selected item from database
    mutating func delete(_ chosenitemID: Int) {
        guard let managedContext = managedContext else { return }
        guard let fetchRequest = fetchRequest else { return }
        
        do{
            let fetchResults = try managedContext.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject]{
                if let trackId = item.value(forKey: "trackID") as? Int,
                   trackId == chosenitemID {
                    managedContext.delete(item)
                    break
                }
            }
        }catch let error{
                print(error.localizedDescription)
        }
        
        save()
    }
    
    // save changes
    mutating func save(){
        guard let managedContext = managedContext else { return }
        do{
            try managedContext.save()
        }catch let error{
            print("Item cannot be created: \(error.localizedDescription)")
        }
        fetchCoreData()
    }
    
    // Add item to database
    mutating func addItem(trackID: Int?, name: String?, price: Double?, releaseDate: String?, artworkLarge: String?){
        guard let managedContext = managedContext else { return }
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteItem", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(trackID, forKey: "trackID")
        item.setValue(name, forKey: "name")
        item.setValue(price, forKey: "price")
        item.setValue(releaseDate, forKey: "releaseDate")
        item.setValue(artworkLarge, forKey: "artworkLarge")
        
        save()
    }
    
}

