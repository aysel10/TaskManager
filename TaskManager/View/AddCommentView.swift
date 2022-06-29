//
//  AddCommentView.swift
//  TaskManager
//
//  Created by Aysel on 6/29/22.
//

import SwiftUI

struct AddCommentView: View {
    
    @Binding var comment: String
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")){
                    TextField("Enter comment", text: $comment)
                        .foregroundColor(.black)
                    Button("Add"){
                        self.isPresented = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                }
            }.navigationTitle("New Comment")
        }
    }
}

