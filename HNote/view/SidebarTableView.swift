//
//  SidebarTableView.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/26.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SidebarTableView: UITableView, UITableViewDelegate,
UITableViewDataSource  {
    let sidebarList = ["Notes", "Mark", "Trash"]
    let sidebarIconList = ["home_white.png", "tag_white.png", "trash_white.png"]
    var curSelected: Int = 0
    var noteTableView: NotesTableView? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidebarList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SidebarTableCellView = tableView.dequeueReusableCell(withIdentifier:
            "SideCell", for: indexPath) as! SidebarTableCellView
        cell.iconSidebar!.image = UIImage(named: sidebarIconList[indexPath.row])
        cell.labelSidebar!.text = sidebarList[indexPath.row]
        
        if indexPath.row == curSelected {
            cell.contentView.backgroundColor = UIColor.blue
        } else {
            cell.contentView.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curSelected = indexPath.row
        tableView.reloadData()
        if curSelected == 0 {
            noteTableView?.updateTable()
        } else if curSelected == 1 {
            noteTableView?.updateMarkNote()
        } else if curSelected == 2 {
            noteTableView?.updateTrashNote()
        }
    }
}
