//
//  ContentView.swift
//  TaskManager
//
//  Created by Aysel on 6/28/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPresented: Bool = false
    @State private var title = ""
    @State private var description = ""
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    
    var body: some View {
        
        NavigationView {
            
            //MARK: - List of all tasks
            List {
                ForEach(tasks, id: \.self) { task in
                    NavigationLink(destination: TaskDetails(task: task)){
                        
                        VStack(alignment: .leading){
                            Text(task.wrappedTitle)
                                .font(.title2.bold())
                                .lineLimit(1)
                            
                            HStack{
                                Text(task.wrappedDate,style: .date)
                                Text(task.wrappedDescription)
                            }
                            .font(.footnote)
                            .lineLimit(1)
                            .foregroundColor(.gray)
                        }
                        .padding(5)
                    }
                    
                //MARK: - Swap to delete task
                }.onDelete(perform: deleteTask)
            }
            .onAppear(perform: loadDefaultTasks)
            .navigationBarTitle("Tasks",displayMode: .large)
            .listStyle(PlainListStyle())
            .toolbar{
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        Button(action: {
                            self.isPresented = true
                        }, label: {
                            Label("Add Task", systemImage: "plus")
                        })
                    }
                }.sheet(isPresented: $isPresented, onDismiss: addTask){
                    AddTaskView(title: self.$title, description: self.$description,isPresented: self.$isPresented)
                }
        }
    }
    
    //MARK: - Add new task
    private func addTask(){
        if !title.isEmpty {
        let newTask = Task(context: viewContext)
        newTask.title = title
        newTask.date = Date.now
        newTask.desciption = description
        newTask.comments = []
        
            try? self.viewContext.save()
            title = ""
            description = ""
        }
    }
    
    //MARK: - Delete task
    private func deleteTask(offsets: IndexSet) {
        withAnimation{
            offsets.map {tasks[$0]}.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    //MARK: - Function to have one default task when we start app
    private func loadDefaultTasks(){
        
        if tasks.count == 0 {
        let cmnt1 = Comment(context: viewContext)
        let cmnt2 = Comment(context: viewContext)
        
        cmnt1.name = "Prepare required docs"
        cmnt2.name = "Visit the office"
        let task1 = Task(context: viewContext)
        task1.title = "Apply for a job"
        task1.date = Date.now
        task1.desciption = "Pass the interview"
        task1.comments = [cmnt1,cmnt2]
        
        try? self.viewContext.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
