//
//  NotesTableView.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/26.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class NotesTableView: UITableView, UITableViewDelegate,
UITableViewDataSource  {
    var dataArray: [NoteItem] = CoreDataManager.shared.getAllNote()
    var curSelected: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotesTableCellView = tableView.dequeueReusableCell(withIdentifier:
            "NotesCell", for: indexPath) as! NotesTableCellView
        var content = ""
        if dataArray[indexPath.row].type == 1 {
            let contentAttr = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(Data(base64Encoded: dataArray[indexPath.row].body!)!) as! NSAttributedString
            content = contentAttr.string
        } else {
            content = dataArray[indexPath.row].body!
        }
        cell.contentLabel!.text = content
        let date = dataArray[indexPath.row].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var stringTime = dateFormatter.string(from: date! as Date)
        if stringTime == dateFormatter.string(from: Date()) {
            dateFormatter.dateFormat = "HH:mm:ss"
            stringTime = dateFormatter.string(from: date! as Date)
        }
        cell.dateLabel!.text = stringTime
        
        cell.img!.image = nil
        if dataArray[indexPath.row].mark == 1 {
            cell.img!.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "check_white", ofType: "png")!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if curSelected == 2 {
            let restore = UITableViewRowAction(style: .normal, title: "restore") {
                action, index in
                let id = self.dataArray[index.row].id
                CoreDataManager.shared.restoreOneNote(id: id!)
                self.updateTrashNote()
            }
            let destory = UITableViewRowAction(style: .normal, title: "destory") {
                action, index in
                let id = self.dataArray[index.row].id
                CoreDataManager.shared.destoryOneNote(id: id!)
                self.updateTrashNote()
            }
            destory.backgroundColor = UIColor.red
            
            return [destory, restore]
        }
        
        var markTitle = ""
        if self.dataArray[indexPath.row].mark == 0 {
            markTitle = "mark"
        } else if self.dataArray[indexPath.row].mark == 1 {
            markTitle = "unmark"
        }
        let mark = UITableViewRowAction(style: .normal, title: markTitle) {
            action, index in
            let id = self.dataArray[index.row].id
            CoreDataManager.shared.toMark(id: id!)
            if self.curSelected == 0 {
                self.updateTable()
            } else if self.curSelected == 1{
                self.updateMarkNote()
            }
            
        }
        let delete = UITableViewRowAction(style: .normal, title: "delete") {
            action, index in
            let id = self.dataArray[index.row].id
            CoreDataManager.shared.deleteOneNote(id: id!)
            if self.curSelected == 0 {
                self.updateTable()
            } else if self.curSelected == 1{
                self.updateMarkNote()
            }
        }
        mark.backgroundColor = UIColor.black
        delete.backgroundColor = UIColor.red
        
        return [delete, mark]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav: UINavigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
        if self.dataArray[indexPath.row].type == 1 {// 富文本
            let vc = RichTextController()
            vc.newId = self.dataArray[indexPath.row].id!
            vc.initText = self.dataArray[indexPath.row].body!
            nav.pushViewController(vc, animated: true)
        } else if self.dataArray[indexPath.row].type == 2 {// markdown
            let vc = NoteContentController()
            vc.newId = self.dataArray[indexPath.row].id!
            vc.initText = self.dataArray[indexPath.row].body!
            nav.pushViewController(vc, animated: true)
        }
    }
    
    public func updateTable () {
        curSelected = 0
        dataArray = CoreDataManager.shared.getAllNormalNote()
        self.reloadData()
    }
    
    public func updateMarkNote () {
        curSelected = 1
        dataArray = CoreDataManager.shared.getAllMarkNote()
        self.reloadData()
    }
    
    public func updateTrashNote () {
        curSelected = 2
        dataArray = CoreDataManager.shared.getAllTrashNote()
        self.reloadData()
    }
}
