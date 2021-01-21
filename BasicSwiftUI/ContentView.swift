//
//  ContentView.swift
//  BasicSwiftUI
//
//  Created by Janarthan Subburaj on 20/01/21.
//

import SwiftUI
import Combine
import Firebase

struct ContentView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var NewTodo:String = ""
    var db = Firestore.firestore()
    
   
    var searchBar : some View{
        HStack{
            TextField("Enter Your Task", text: $NewTodo).border(Color.gray, width: 1).cornerRadius(3)
            Button(action: self.addNewToDo, label: {
                Text("Add New").border(Color.gray, width: 1).foregroundColor(.white)
            }).background(Color.black).cornerRadius(5)
        }.background(Color.yellow)
    }
    func addNewToDo(){
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: NewTodo))
        db.collection("ToDoSwiftUI").document().setData(["Task_Data":NewTodo])
    }
    var body: some View {
        NavigationView{
            VStack{
                searchBar.padding()
                List{
                    ForEach(self.taskStore.tasks){task in
                        Text(task.toDoItem)}.onMove(perform: self.Move).onDelete(perform:self.delete)
                }.background(Color.pink).border(Color.gray, width: 1).navigationBarTitle("Add Tasks").navigationBarItems(trailing: EditButton()).foregroundColor(.black)
            }.background(Color.green)
        }
    }
    
    func Move(from source : IndexSet,to destination: Int){
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
        print(source.self,destination.self)
    }
    func delete(at offsets : IndexSet){
        taskStore.tasks.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
