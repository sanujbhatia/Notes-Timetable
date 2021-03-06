import Foundation
import Firebase

struct NoteItem {
    
    let dbRef: DatabaseReference?
    let description : String
    var completed : String
    
    init(description : String, completed : String) {
        self.dbRef = nil
        self.completed = completed
        self.description = description
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String: AnyObject],
            let description = value["description"] as? String,
            let completed = value["completed"] as? String else {
                return nil
            }
        
        self.dbRef = snapshot.ref
        self.completed = completed
        self.description = description
    }
    
    func toAnyObject() -> Any {
        return [
            "completed": completed,
            "description": description,
        ]
    }
}
