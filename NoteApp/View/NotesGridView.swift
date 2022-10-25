//
//  NotesGridView.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 10/09/22.
//

import SwiftUI

struct NotesGridView<Content: View, Data: Identifiable>: View where Data: Hashable{
    
    var content: (Data) -> Content
    var list: [Data]
    var columns: Int
    init(list: [Data], column: Int, @ViewBuilder content: @escaping (Data)-> Content){
        self.list = list
        self.columns = column
        self.content = content
        
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack{
                ForEach(gridSetUp(), id:\.self){ gridData in
                    LazyVStack(spacing: 4){
                        ForEach(gridData){ noteGrid in
                            content(noteGrid)
                        }
                    }
                }
            }.padding(2)
        }
    }
    
    func gridSetUp() ->[[Data]]{
        //Empty Array Creation
        var gridArray: [[Data]] = Array(repeating: [], count: self.columns)
        
        var currentIndex: Int = 0
        
        for values in list{
            gridArray[currentIndex].append(values)
            
            if currentIndex == (columns - 1){
                currentIndex = 0
            }else{
                currentIndex += 1
            }
        }
        return gridArray
    }
}

struct NotesGridView_Previews: PreviewProvider{
    
    static var previews: some View{
        NewNoteView()
    }
}
