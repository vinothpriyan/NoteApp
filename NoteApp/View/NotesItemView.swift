//
//  NotesItemView.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 10/09/22.
//

import SwiftUI

struct NotesItemView: View {
    
    var noteItems: NotesEntity
   
    var body: some View {
        ZStack {
            VStack{
                Text(noteItems.title ?? "")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Spacer()
                    Text(noteItems.created_time ?? Date(), formatter: itemFormatter)
                        .font(.caption2)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.48, alignment: .leading)
        .background(randomColorGenerat().opacity(0.6))
        .cornerRadius(10)
        
    }
    
    func randomColorGenerat()-> Color{
        let redColor = Double.random(in: 200...255)
        let greenColor = Double.random(in: 50...200)
        let blueColor = Double.random(in: 50...100)
        let color = Color(red: redColor/255, green: greenColor/255, blue: blueColor/255)
        return color
    }
}

