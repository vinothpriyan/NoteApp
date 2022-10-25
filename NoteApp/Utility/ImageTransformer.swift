//
//  ImageTransformer.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 15/09/22.
//

import Foundation
import UIKit

class ImageTransformer: ValueTransformer{
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let images = value as? UIImage else{return nil}
        do{
            let imgData = try NSKeyedArchiver.archivedData(withRootObject: images, requiringSecureCoding: true)
            return imgData
        }catch{
           return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        
        guard let data = value as? Data else {return nil}
        do{
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
            return image
        }catch{
            return nil
        }
    }
}
