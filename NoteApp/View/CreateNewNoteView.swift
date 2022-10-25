//
//  CreateNewNoteView.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 12/09/22.
//

import SwiftUI
import SimpleToast

struct CreateNewNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var notesTitle: String = ""
    @State private var notesBody: String = ""
    @State private var openImageGallery: Bool = false
    @State private var pickedImage: Data = Data(count: 0)
    @StateObject private var notesCoreData = CoreDataControllViewModel()
    @State var buttonBackground: Bool = false
    @State var customMessage: Bool = false
    
    let messageOptions = SimpleToastOptions.init(
        alignment: .top,
        hideAfter: 3,
        backdrop: Color.black.opacity(0),
        animation: .easeIn,
        modifierType: .slide)
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                if pickedImage.count > 0 {
                    let image = UIImage(data: pickedImage)
                
                    Image(uiImage: image!)
                        .resizable()
                        .frame(height: 200)
                        .cornerRadius(10)
                }
                
                TextField("Title here..", text: $notesTitle)
                    .padding(6)
                    .font(.title2)
                    .frame(height: 60)
                    
                    
                TextEditor(text: $notesBody)
                    .colorMultiply(Color("blackColor"))
                    .cornerRadius(10)
                    .textFieldStyle(.roundedBorder)
                    .padding(2)

                Spacer()
    
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CustomButtons(imageButtonIcon: "paperclip") {
                        self.openImageGallery = true
                    }
                    .background((pickedImage.count == 0) ? Color.secondary.opacity(0.5): Color.green.opacity(0.7))
                    .cornerRadius(8)
                    .padding(10)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    CustomButtons(imageButtonIcon: "note.text.badge.plus",action: {
                        if !notesBody.isEmpty && !notesTitle.isEmpty{
                            self.customMessage = self.notesCoreData.addItem(body: notesBody, title: notesTitle, image: pickedImage)
                            if customMessage{
                                notesBody = ""
                                notesTitle = ""
                                pickedImage = Data(count: 0)
                            }
                        }
                    }).disabled(notesBody.isEmpty && notesTitle.isEmpty)
                        .background(Color.secondary.opacity(0.7))
                        .cornerRadius(8)
                        .padding(10)
                }
            }
            .fullScreenCover(isPresented: $openImageGallery, content: {
                ImagePickerGallery(closePicker: $openImageGallery, imageData: $pickedImage)
            })
            .simpleToast(isPresented: $customMessage, options: messageOptions, content: {
                Text("Note was saved successfully..")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green.opacity(0.8))
                    .cornerRadius(10)
            })
            
         .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}




