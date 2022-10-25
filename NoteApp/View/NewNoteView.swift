//
//  NewNoteView.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 10/09/22.
//

import SwiftUI

struct NewNoteView: View {
    @ObservedObject private var records = CoreDataControllViewModel()
    @ObservedObject private var network = NetworkManager()
    @ObservedObject private var recordsFromAPI = FetchNotesViewModel()
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                if let notesData = records.notesFromCoreData {
                    NotesGridView(list: notesData, column: 2, content: { listItems in
                        NavigationLink {
                            NoteDetailedView(notesDetails: listItems)
                        } label: {
                            NotesItemView(noteItems: listItems)
                        }
                    })
                    .background(Color.dynamicColor)
                    
                }else{
                    Text("Note Have Empty List")
                        .bold()
                        .font(.title2)
                        .padding()
                        .background(Color.secondary.opacity(0.7))
                        .cornerRadius(10)
                }
                
                NavigationLink {
                    CreateNewNoteView()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(.white)
                        .padding()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .bottomTrailing)
                        .background(.red)
                        .clipShape(Circle())
                        .padding(.trailing, 20)
                }
                
                .navigationTitle("My Notes")
            }.onAppear{
                self.records.fetchNotesRecords()
//                if network.networkConnected{
//                     self.recordsFromAPI.fetchRecords()
//                 }
            }
        }
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
    }
}

public let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

extension Color {
    static let dynamicColor = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .black : .white
    })
}
