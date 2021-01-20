//
//  ContentView.swift
//  BasicSwiftUI
//
//  Created by Janarthan Subburaj on 20/01/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var NewTodo:String = ""
    
    var searchBar : some View{
        HStack{
            TextField("Enter Your Task", text: $NewTodo)
            Button(action: self.addNewToDo, label: {
                Text("Add New")
            })
        }
    }
    func addNewToDo(){
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: NewTodo))
    }
    var body: some View {
        NavigationView{
            VStack{
                searchBar.padding()
                List{
                    ForEach(self.taskStore.tasks){task in
                        Text(task.toDoItem)}.onMove(perform: self.Move).onDelete(perform:self.delete)
                }.navigationBarTitle("Add Tasks").navigationBarItems(trailing: EditButton())
            }
        }
    }
    
    func Move(from source : IndexSet,to destination: Int){
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
        print(IndexSet.self,Int.self)
    }
    func delete(at offsets : IndexSet){
        taskStore.tasks.remove(atOffsets: offsets)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
