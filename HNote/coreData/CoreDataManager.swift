//
//  CoreDataManager.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/28.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager:NSObject {
    static let shared = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
        return context
    }()
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func addNoteWith(body: String, type: Int, mark: Int) {
        let note = NSEntityDescription.insertNewObject(forEntityName: "NoteItem", into: context) as! NoteItem
        note.body = body
        note.type = Int16(type)
        note.mark = Int16(mark)
        let date = Date()
        note.date = date as NSDate
        let timeInterval: TimeInterval  = date.timeIntervalSince1970
        note.id = String(timeInterval)
        saveContext()
    }
    
    func getAllNote() -> [NoteItem] {
        let fetchRequest: NSFetchRequest = NoteItem.fetchRequest()
        do {
            var result = try context.fetch(fetchRequest)
            result.sort(by: {(item1: NoteItem, item2: NoteItem) -> Bool in return item1.date!.timeIntervalSince1970 > item2.date!.timeIntervalSince1970 })
            return result
        } catch {
            fatalError();
        }
    }
    
    func getAllNormalNote () -> [NoteItem] {
        let temp = getAllNote()
        var result = [NoteItem]()
        for note in temp {
            if note.mark != -1 {
                result.append(note)
            }
        }
        return result
    }
    
    func getAllTrashNote () -> [NoteItem] {
        let temp = getAllNote()
        var result = [NoteItem]()
        for note in temp {
            if note.mark == -1 {
                result.append(note)
            }
        }
        return result
    }
    
    func getAllMarkNote () -> [NoteItem] {
        let temp = getAllNote()
        var result = [NoteItem]()
        for note in temp {
            if note.mark == 1 {
                result.append(note)
            }
        }
        return result
    }
    
    func deleteAllNote () {
        let result = getAllNote()
        for note in result {
            context.delete(note)
        }
        saveContext()
    }
    
    func updateNote (id: String, body: String) {
        let result = getAllNote()
        for note in result {
            if note.id == id {
                note.body = body
                let date = Date()
                note.date = date as NSDate
            }
        }
        saveContext()
    }
    
    func toMark (id: String) {
        let result = getAllNote()
        for note in result {
            if note.id == id {
                note.mark = (note.mark + 1) % 2
            }
        }
        saveContext()
    }
    
    func deleteOneNote (id: String) {
        let result = getAllNote()
        for note in result {
            if note.id == id {
                note.mark = -1
            }
        }
        saveContext()
    }
    
    func restoreOneNote (id: String) {
        let result = getAllNote()
        for note in result {
            if note.id == id {
                note.mark = 0
            }
        }
        saveContext()
    }
    
    func destoryOneNote (id: String) {
        let result = getAllNote()
        for note in result {
            if note.id == id {
                context.delete(note)
            }
        }
        saveContext()
    }
}
