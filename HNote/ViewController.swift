//
//  ViewController.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/26.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sideTableView: SidebarTableView!
    @IBOutlet weak var notesTableView: NotesTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        sideTableView.dataSource = sideTableView
        sideTableView.delegate = sideTableView
        sideTableView.noteTableView = notesTableView
        
        notesTableView.dataSource = notesTableView
        notesTableView.delegate = notesTableView
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.notesTableView.updateTable()
    }
    
    @IBAction func createNewNote(_ sender: Any) {
        let items: [String] = ["Rich Text","Markdown"]
        let imgSource: [String] = ["repository_white", "markdown_white"]
        NavigationMenuShared.showPopMenuSelecteWithFrameWidth(width: itemWidth, height: 160, point: CGPoint(x: ScreenInfo.Width - 30, y: 0), item: items, imgSource: imgSource) { (index) in
            switch index{
            case 0:
                self.navigationController?.pushViewController(RichTextController(), animated: true)
                break
            case 1:
                self.navigationController?.pushViewController(NoteContentController(), animated: true)
                break
            default:
                break
            }
        }
    }
}

