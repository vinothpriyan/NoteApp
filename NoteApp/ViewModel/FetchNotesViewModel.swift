//
//  FetchNotesViewModel.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 10/09/22.
//

import UIKit
import Combine
import CoreData

class FetchNotesViewModel: ObservableObject{

    let dataContainer: NSPersistentContainer
    private let notesApiCall = GetNotes()
    @Published var records: [NotesData] = []
    @Published var errorAccured: String?
    var cancellable: AnyCancellable?
    @Published var existingData: [NotesEntity] = []
   
    init(){
        ValueTransformer.setValueTransformer(ImageTransformer(), forName: NSValueTransformerName("ImageTransformer"))
        self.dataContainer = NSPersistentContainer(name: "NotesAppModel")
        dataContainer.loadPersistentStores { dataDescpt, error in
            if let error = error {
                print("There is an error on data load with \(String(describing: error.localizedDescription))")
            }
        }
    }
    
    func fetchRecords(){
        
        self.cancellable = notesApiCall.fetchNotesRecord(endPoint: "notes")
            .sink(receiveCompletion: { error in
                switch error{
                case .finished:
                    print("There is no error accured ")
                case .failure(let err):
                    self.errorAccured = err.localizedDescription
                }
            }, receiveValue: { [weak self] notesData in
                self?.records = notesData
                DispatchQueue.main.async {
                    self?.saveNotesInCoreData()
                }
            })
        }
    
    func fetchExistingNotes(){
       let getRequest = NSFetchRequest<NotesEntity>(entityName: "NotesEntity")
       let getDecendingOrder = NSSortDescriptor(keyPath: \NotesEntity.created_time, ascending: false)
       getRequest.sortDescriptors = [getDecendingOrder]
        do{
            self.existingData = try self.dataContainer.viewContext.fetch(getRequest)
          
       }catch let error{
           print("While the \(error.localizedDescription) is accured")
       }
   }
    
    func saveNotesInCoreData(){
        fetchExistingNotes()
        records.forEach{ note in
            let noteEntity = NotesEntity(context: dataContainer.viewContext)
            noteEntity.uid = note.id
            noteEntity.title = note.title
            noteEntity.body = note.body
            noteEntity.created_time = note.created_time
            if note.image != nil {
                let getImage = URL(string: note.image!)!
                URLSession.shared.dataTask(with: getImage){ imgData, _,error in
                    guard let dataImage = imgData, error == nil else{return}
                    let fullImage = UIImage(data: dataImage)
                    fullImage?.jpegData(compressionQuality: 0.2)
                    noteEntity.image = fullImage
                    self.existingData.forEach { itemsOf in
                        if itemsOf.uid != note.id {
                            self.saveData()
                        }
                    }
                }.resume()
            }
            
            existingData.forEach { itemsOf in
                if itemsOf.uid != note.id {
                   saveData()
                }
            }
        }
    }
    
    func saveData(){
        do{
            try self.dataContainer.viewContext.save()
        }catch{
            print("Data storage from API error with \(error.localizedDescription)")
        }
    }
}
