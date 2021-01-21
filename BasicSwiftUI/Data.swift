//
//  Data.swift
//  BasicSwiftUI
//
//  Created by Janarthan Subburaj on 20/01/21.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    
    var id:String = UUID().uuidString
    var toDoItem = String()
}

class TaskStore: ObservableObject {
    @Published var tasks = [Task]()
}
