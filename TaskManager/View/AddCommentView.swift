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
                    
                    
                    
                    Button("Create"){
                        self.isPresented = false
                    }
                }
            }.navigationTitle("New Comment")
        }
    }
}

