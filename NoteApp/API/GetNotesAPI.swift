//
//  GetNotesAPI.swift
//  NoteApp
//
//  Created by Vinoth Priayn on 10/09/22.
//

import Foundation
import Combine

class GetNotes{
    
    func fetchNotesRecord(endPoint: String) -> AnyPublisher<[NotesData], Error>{
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: NotesRecordEndpoint.endpoint+endPoint)!)
            .map{$0.data}
            .decode(type: [NotesData].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct NotesRecordEndpoint{
   static let endpoint: String = "https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/"

}
