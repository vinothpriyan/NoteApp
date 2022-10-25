//
//  NotesData.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 10/09/22.
//

import Foundation

struct NotesData: Decodable, Identifiable, Hashable{
    
    let id: String
    let archived: Bool
    let title: String
    let body: String
    let created_time: Date
    let image: String?
    let expiry_time: Date?
    
}
