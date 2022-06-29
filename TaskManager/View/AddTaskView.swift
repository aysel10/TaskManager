//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Aysel on 6/29/22.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var title: String
    @Binding var description: String
    
    @Binding var isPresented: Bool
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Information")){
                    TextField("Enter title", text: $title)
                    TextField("Enter description", text: $description)
                    
                    Button("Create"){
                        self.isPresented = false
                    }
                }
            }.navigationTitle("New Task")
        }
    }
}
