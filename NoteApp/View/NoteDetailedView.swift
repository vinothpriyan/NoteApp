//
//  NoteDetailedView.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 10/09/22.
//

import SwiftUI

struct NoteDetailedView: View {
    let notesDetails: NotesEntity
    @State var fullImageViewVisible: Bool = false
    @ObservedObject var getImageOnly = CoreDataControllViewModel()
    @Namespace private var imagePopup
    
    init(notesDetails: NotesEntity){
        self.notesDetails = notesDetails
    }
    
    var body: some View {
       
        ZStack {
            if fullImageViewVisible == false {
                VStack {
                    ScrollView(showsIndicators: false) {
                    
                        if let urlImage = notesDetails.image{
                            Image(uiImage: urlImage)
                                .resizable()
                                .frame(height: UIScreen.main.bounds.height * 0.25)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        self.fullImageViewVisible.toggle()
                                    }
                                }
                                .matchedGeometryEffect(id: "image_standard", in: imagePopup)
                            }
                        
                        VStack(alignment: .leading,spacing: 10){
                            
                            Text(notesDetails.title ?? "")
                                .fontWeight(.bold)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                            
                            Text(notesDetails.created_time ?? Date(), formatter: itemFormatter)
                                .fontWeight(.bold)
                                .font(.callout)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                            
                            Text(notesDetails.body ?? "")
                                .font(.callout)
                                .multilineTextAlignment(.leading)
                            
                        }.padding()
                    }
                    
                    
                    .navigationBarTitleDisplayMode(.inline)
                }
                
            }else {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(getImageOnly.notesFromCoreData, id:\.self){ image in
                            if let urlImage = image.image{
                                Image(uiImage: urlImage)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.40)
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                    }
                    .padding([.top, .bottom], 100)
                    .background(Color.gray.opacity(0.8))
                    .matchedGeometryEffect(id: "image_standard", in: imagePopup)
                }
            }
        }.onAppear{
            self.getImageOnly.fetchNotesRecords()
        }
        .onTapGesture {
            withAnimation(.spring()) {
                self.fullImageViewVisible.toggle()
            }
        }
    }
}

