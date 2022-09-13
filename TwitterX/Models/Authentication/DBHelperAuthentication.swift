//
//  DBHelperAuthentication.swift
//  TwitterX
//
//  Created by Xavier on 9/12/22.
//

import Foundation
import CoreData

class DBHelperAuthentication {
    static let shared = DBHelperAuthentication()
    
    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }
    init() {
        container = NSPersistentContainer(name: "TwitterXAuthentication")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Couldn't load container. Error: \(error.localizedDescription)")
            }
        }
    }
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Context saved.")
            } catch {
                let error = error as NSError
                fatalError("Couldn't save context. Error: \(error.localizedDescription)")
            }
        }
    }
    
    func createAuthentication(
        username internalname: String,
        fullname externalname: String,
        email: String,
        password: String
    ) {
        let authentication = Authentication(context: context)
        authentication.internalid = UUID().uuidString
        authentication.externalid = TimeStamp.shared.timestamp17(date: Date())
        authentication.internalname = internalname
        authentication.externalname = externalname
        authentication.email = email
        authentication.password = email
        authentication.desc = ""
        authentication.color = 0
        
        saveContext()
    }
    
    func readAll<T: NSManagedObject>(
        _ objectType: T.Type,
        _ predicate: NSPredicate? = nil,
        _ limit: Int? = nil
    ) -> Result<[T], Error> {
        let fetchRequest = objectType.fetchRequest()
        fetchRequest.predicate = predicate
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        do {
            let result = try context.fetch(fetchRequest)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    
    func readOne<T: NSManagedObject>(
        _ objectType: T.Type,
        _ filterKey: String,
        _ filterValue: String
    ) -> Result<[T], Error> {
        let fetchRequest = objectType.fetchRequest()
        fetchRequest.entity = objectType.entity()
        fetchRequest.predicate = NSPredicate(format: "\(filterKey) MATCHES %@", filterValue)
        do {
            let result = try context.fetch(fetchRequest)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    
    func update<T: NSManagedObject>(
        _ objectType: T.Type,
        _ filterKey: String,
        _ filterValue: String,
        _ updateKey: String,
        _ updateValue: String
    ) {
        let fetchRequest = objectType.fetchRequest()
        fetchRequest.entity = objectType.entity()
        fetchRequest.predicate = NSPredicate(format: "\(filterKey) MATCHES %@", filterValue)
        do {
            if let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject] {
                if fetchedResults.count != 0 {
                    let object = fetchedResults[0]
                    object.setValue(updateValue, forKey: updateKey)
                    saveContext()
                }
            }
        } catch {
            fatalError("Could'nt update NSMO. Error: \(error.localizedDescription)")
        }
    }
    
    func delete<T: NSManagedObject>(
        _ objectType: T.Type,
        _ filterKey: String,
        _ filterValue: String
    ) {
        let fetchRequest = objectType.fetchRequest()
        fetchRequest.entity = objectType.entity()
        fetchRequest.predicate = NSPredicate(format: "\(filterKey) MATCHES %@", filterValue)
        do {
            if let fetchedResults = try context.fetch(fetchRequest) as? [NSManagedObject] {
                if fetchedResults.count != 0 {
                    for obj in fetchedResults {
                        context.delete(obj)
                    }
                    saveContext()
                }
            }
        } catch {
            fatalError("Couldn't delete NSMO. Error \(error.localizedDescription)")
        }
    }
    
    func printFilePath() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }
}
