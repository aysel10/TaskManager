//
//  TaskDetails.swift
//  TaskManager
//
//  Created by Aysel on 6/29/22.
//

import SwiftUI

struct TaskDetails: View {
    
    @State var isPresented: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    var task: Task
    @State private var newTitle = ""
    @State private var newDescription = ""
    @State private var comment = ""

    enum FocusField: Hashable {
        case field
      }

    @FocusState private var focusedField: FocusField?

    
    var body: some View {
        
        
        VStack {
            TextField(task.title ?? "", text: $newTitle,onCommit:{
                task.title = self.newTitle
                try? self.viewContext.save()
            })
            .focused($focusedField, equals: .field)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {  /// Anything over 0.5 seems to work
                    self.focusedField = .field
                }
                self.newTitle = self.task.title != nil ? "\(self.task.title!)" : ""
            }
            .onDisappear {
                self.task.title = self.newTitle
                try? self.viewContext.save()
            }
            
            .accentColor(.orange)
            .font(.title2.bold())
            .textFieldStyle(PlainTextFieldStyle())
            
           
            TextEditor(text: $newDescription)
                .onAppear{
                    self.newDescription = self.task.desciption != nil ? "\(self.task.desciption!)" : ""
                }
                .onChange(of: newDescription){ value in
                    task.desciption = self.newDescription
                    try? self.viewContext.save()
                }
                
                .accentColor(.orange)
            
            Spacer()
            
            Text("Comments")
                 
            
            
            List {
               
                ForEach(task.commentArray, id: \.self) { comment in
                    VStack(alignment: .leading){
                    Text(comment.wrappedName)
                        
                    }
                }.font(.caption)
                
                Button("Comment"){
                    self.isPresented = true
                }.sheet(isPresented: $isPresented, onDismiss: addComment){
                    AddCommentView(comment: self.$comment,isPresented: self.$isPresented)
                    
                }
            }
            
            .frame( maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
            .listStyle(GroupedListStyle())
            .background(Color.white)
                
            
            
            Text(task.date!.formatted(date: .long, time: .shortened))
                .font(.footnote)
                .foregroundColor(Color.orange)
            
        }.navigationBarTitle("", displayMode: .inline)
            .padding()
            .accentColor(Color.orange)
        
     
}
    
    private func addComment(){
        let newComment = Comment(context: viewContext)
        newComment.name = comment
        
        task.addToComments(newComment)
        
        
        
        try? self.viewContext.save()
    }
}

struct TaskDetails_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetails(task: Task())
    }
}
