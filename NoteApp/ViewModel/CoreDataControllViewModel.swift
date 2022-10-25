//
//  CoreDataControllViewModel.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 14/09/22.
//

import SwiftUI
import CoreData
import UIKit

class CoreDataControllViewModel: ObservableObject{
    
    let dataContainer: NSPersistentContainer
    @Published var notesFromCoreData: [NotesEntity] = []
    
    init(){
        self.dataContainer = NSPersistentContainer(name: "NotesAppModel")
        dataContainer.loadPersistentStores { dataDescpt, error in
            if let error = error {
                print("There is an error on data load with \(String(describing: error.localizedDescription))")
            }
        }
    }
    
     func fetchNotesRecords(){
        let getRequest = NSFetchRequest<NotesEntity>(entityName: "NotesEntity")
        let getDecendingOrder = NSSortDescriptor(keyPath: \NotesEntity.created_time, ascending: false)
        getRequest.sortDescriptors = [getDecendingOrder]
         do{
             self.notesFromCoreData = try self.dataContainer.viewContext.fetch(getRequest)

            print("Successfully fetched data..")
        }catch let error{
            print("While the \(error.localizedDescription) is accured")
        }
    }

     func addItem(body: String, title: String, image: Data)-> Bool {
        
        let newItem = NotesEntity(context: self.dataContainer.viewContext)
            newItem.uid = UUID().uuidString
            newItem.created_time = Date()
            newItem.body = body
            newItem.title = title
            newItem.image = UIImage(data: image)
         do{
             try self.dataContainer.viewContext.save()
             print("The Records was saved successfully")
             fetchNotesRecords()
             return true
         }catch let error{
             print("While the \(error.localizedDescription) is accured")
             return false
         }
    }
   
}
