//
//  CustomButton.swift
//  NoteApp
//
//  Created by Vinoth Priyan on 15/09/22.
//

import SwiftUI

struct CustomButtons: View{
    var imageButtonIcon: String

    var action: ()-> Void
    var body: some View{
        
        Button {
            self.action()
        } label: {
            Image(systemName: imageButtonIcon)
                .resizable()
                .foregroundColor(.blue)

        }
        .padding(8)
        .frame(width: 50, height: 40, alignment: .center)
    }
}

