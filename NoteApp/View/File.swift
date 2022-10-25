//
//  File.swift
//  NoteApp
//
//  Created by Prasanna Ramesh on 13/09/22.
//

import SwiftUI

struct ImagePickerGallery: UIViewControllerRepresentable{
    
    @Binding var closePicker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> Coordinator {
        return ImagePickerGallery.Coordinator(imagePicker: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var imagePicker: ImagePickerGallery
        
        init(imagePicker: ImagePickerGallery) {
            self.imagePicker = imagePicker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePicker.closePicker.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let getImage = info[.originalImage] as? UIImage
            self.imagePicker.imageData = (getImage?.jpegData(compressionQuality: 0.5))!
            self.imagePicker.closePicker.toggle()
        }
    }
}
