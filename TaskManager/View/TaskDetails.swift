//
//  TaskDetails.swift
//  TaskManager
//
//  Created by Aysel on 6/29/22.
//

import SwiftUI

struct TaskDetails: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    
    var task: Task
    
    @State var isPresented: Bool = false
    @State private var newTitle = ""
    @State private var newDescription = ""
    @State private var comment = ""
    @State private var isShown = false

    //To focus on TextField when appears
    enum FocusField: Hashable {
        case field
      }
    @FocusState private var focusedField: FocusField?

    var body: some View {
        
        VStack {
            //MARK: - Title text editor
            
            TextField(task.title ?? "", text: $newTitle,onCommit:{
                task.title = self.newTitle
                try? self.viewContext.save()
            })
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.focusedField = .field
                }
                self.newTitle = self.task.title != nil ? "\(self.task.title!)" : ""
            }
            .onDisappear {
                self.task.title = self.newTitle
                try? self.viewContext.save()
            }
            .focused($focusedField, equals: .field)
            .accentColor(.orange)
            .font(.title2.bold())
            .textFieldStyle(PlainTextFieldStyle())
            
           //MARK: - Description text editor
            
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
            
            //MARK: - In review hidden field
            
            if isShown {
                Text("In Review").bold()
            }
            
            //MARK: - Comments view
            
            ForEach(task.commentArray, id: \.self) { comment in
                VStack(alignment: .leading){
                    Text(comment.wrappedName).font(.custom("Avenir Next Regular", size: 12))
                    Divider()
                }.padding(.horizontal, 8)
                .font(.title3)
            }
            Spacer()
            
            //MARK: - Comment button
            
            Button("Comment"){
                self.isPresented = true
            }.sheet(isPresented: $isPresented, onDismiss: addComment){
                AddCommentView(comment: self.$comment,isPresented: self.$isPresented)
            }
            .frame(maxWidth: .infinity, alignment: .center).padding()

            //MARK: - Date
            
            Text(task.date!.formatted(date: .long, time: .shortened))
                .font(.footnote)
                .foregroundColor(Color.black)
            
        }
        .toolbar {
                Button("Send to review") {
                    if !isShown {
                        isShown = true
                    }
                }
        }
        .navigationBarTitle("", displayMode: .inline)
        .padding()
            
        
     
}
    //Add comment function
    private func addComment(){
        if !comment.isEmpty {
            let newComment = Comment(context: viewContext)
            newComment.name = comment
            
            task.addToComments(newComment)
            
            try? self.viewContext.save()
        }
    }
}

struct TaskDetails_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetails(task: Task())
    }
}
