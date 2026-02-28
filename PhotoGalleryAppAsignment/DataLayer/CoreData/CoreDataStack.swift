//
//  CoreDataStack.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()

    let container: NSPersistentContainer

    private init() {
        //container = NSPersistentContainer(name: "PhotoApp")
        container = NSPersistentContainer(name: "PhotoGalleryAppAsignment")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
