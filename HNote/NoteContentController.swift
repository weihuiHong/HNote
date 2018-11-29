//
//  NoteContentController.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/28.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import Foundation
import UIKit
import MarkdownView

class NoteContentController: UIViewController {
    var preview: Bool = false
    var previewBtn: UIBarButtonItem? = nil
//    var markdownStr: String = ""
    var initText: String = ""
    var newId: String = "-1"
    let textView = UITextView()
    let mdView = MarkdownView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Markdown"
        
        previewBtn = UIBarButtonItem(title: "preview", style: UIBarButtonItem.Style.plain, target: self, action: #selector(chgPreview))
        navigationItem.rightBarButtonItem = previewBtn
        
//        let path = Bundle.main.path(forResource: "sample", ofType: "md")!
        
//        let url = URL(fileURLWithPath: path)
//        markdownStr = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        
        addTextView()
    }
    
    @objc func chgPreview () {
        view.subviews.forEach({ $0.removeFromSuperview()})
        var curTitle: String = ""
        if preview {
            curTitle = "preview"
            addTextView()
        } else {
            curTitle = "edit"
            addMarkdownView()
        }
        previewBtn?.title = curTitle
        preview = !preview
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if textView.text == "" {
            if newId != "-1" {
                CoreDataManager.shared.destoryOneNote(id: newId)
            }
            return
        }
        if newId == "-1" {
            CoreDataManager.shared.addNoteWith(body: textView.text, type: 2, mark: 0)
        } else {
            CoreDataManager.shared.updateNote(id: newId, body: textView.text)
        }
    }
    
    private func addMarkdownView () {
        view.addSubview(mdView)
        mdView.translatesAutoresizingMaskIntoConstraints = false
        mdView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mdView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mdView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mdView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mdView.load(markdown: textView.text, enableImage: true)
    }
    
    private func addTextView () {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        textView.font = UIFont.systemFont(ofSize: 17)
        if newId != "-1" {
            textView.text = initText
        }
    }
}
