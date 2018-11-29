//
//  RichTextController.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/28.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import Foundation
import UIKit

class RichTextController: UIViewController {
//    @IBOutlet weak var textview: UITextView!
    let textview = UITextView()
    let textViewFont = UIFont.systemFont(ofSize: 17)
    var initText: String = ""
    var newId: String = "-1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Rich Text"
        
        view.addSubview(textview)
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        textview.font = UIFont.systemFont(ofSize: 17)
        if newId != "-1" {
            let initAttr = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(Data(base64Encoded: initText)!) as! NSAttributedString
            textview.attributedText = initAttr
        }
        // Do any additional setup after loading the view.
        
        //在键盘上添加按钮
        addDoneButtonKeyboard()
    }
    
    
    //在键盘上添加按钮
    func addDoneButtonKeyboard(){
        let doneToolbar = UIToolbar()
        
        //左侧空隙
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        //UIBarButtonItem    按钮
        let finish: UIBarButtonItem = UIBarButtonItem(title: "完成", style: .done,target: self,action: #selector(donefinishActio))
        
        let bold: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "bold")?.withRenderingMode(.alwaysOriginal), style: .plain,target: self,action: #selector(doneBoldAction))
        
        let italic: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "italic")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(doneitalicAction))
        
        let red: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "redword")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(doneRedwordAction))
        
        let blue: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "blueword")?.withRenderingMode(.alwaysOriginal),  style: .done,target:     self,action: #selector(doneBluewordAction))
        
        let photo:UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "image")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(doneNONEAction))
        
        let strike:UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "strike")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(donedeleteAction))
        
        let underline: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "underline")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(doneunderlineAction))
        
        let header: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "header")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(doneNONEAction))
        
        let black: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "blackword")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(doneBlackwordAction))
        
        let fontsize: UIBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "font")?.withRenderingMode(.alwaysOriginal),  style: .done,target: self,action: #selector(doneNONEAction))
        
        var  items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(fontsize)
        items.append(bold)
        items.append(italic)
        items.append(black)
        items.append(blue)
        items.append(red)
        items.append(photo)
        items.append(strike)
        items.append(underline)
        items.append(header)
        items.append(finish)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.textview.inputAccessoryView = doneToolbar
        
        
    }
    
    //测试函数
    @objc func doneNONEAction(){

    }
    
    //"图片"按钮点击响应
    @objc func donepictureAction() {
        insertPicture(UIImage(named: "bold")!, mode: ImageAttachmentMode.fitTextView)
    }
    
    //“加粗”按钮点击响应
    @objc func doneBoldAction() {
        
        
        //获得目前光标的位置
        let selectedRange = textview.selectedRange
        let a:Int
        let b:Int
        a = selectedRange.location
        b = selectedRange.length
        if(b>0){
            print(selectedRange)
            let str = textview.text
            let attrStr = NSMutableAttributedString.init(string: str!)
            attrStr.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange.init(location:a, length:b))
            
            //再次记住新的光标的位置
            let newSelectedRange = NSMakeRange(selectedRange.location + selectedRange.length, 0)
            
            //重新给文本赋值
            textview.attributedText = attrStr
            
            //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
            textview.selectedRange = newSelectedRange
        }
        
    }
    
    //收起键盘
    @objc func donefinishActio() {
        self.textview.resignFirstResponder()
    }
    
    //变蓝
    @objc func doneBluewordAction(){
        let selectedRange = textview.selectedRange
        let a:Int
        let b:Int
        a = selectedRange.location
        b = selectedRange.length
        if(b>0){
            print(selectedRange)
            let str = textview.text
            let attrStr = NSMutableAttributedString.init(string: str!)
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange.init(location:a, length:b))
            let newSelectedRange = NSMakeRange(selectedRange.location + selectedRange.length, 0)
            textview.attributedText = attrStr
            textview.selectedRange = newSelectedRange
            textview.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    
    //“斜体”按钮点击响应
    @objc func doneitalicAction(){
        let selectedRange = textview.selectedRange
        let a:Int
        let b:Int
        a = selectedRange.location
        b = selectedRange.length
        if(b>0){
            print(selectedRange)
            let str = textview.text
            let attrStr = NSMutableAttributedString.init(string: str!)
            attrStr.addAttribute(NSAttributedString.Key.font, value: UIFont.italicSystemFont(ofSize: 17), range: NSRange.init(location:a, length:b))
            
            let newSelectedRange = NSMakeRange(selectedRange.location + selectedRange.length, 0)
            
            textview.attributedText = attrStr
            textview.selectedRange = newSelectedRange
        }
    }
    
    //设置删除线
    @objc func donedeleteAction(){
        let selectedRange = textview.selectedRange
        let a:Int
        let b:Int
        a = selectedRange.location
        b = selectedRange.length
        if(b>0){
            print(selectedRange)
            let str = textview.text
            let attrStr = NSMutableAttributedString.init(string: str!)
            attrStr.addAttribute(NSAttributedString.Key.strikethroughStyle,value: NSNumber.init(value: 1), range: NSRange.init(location:a, length:b))
            
            let newSelectedRange = NSMakeRange(selectedRange.location + selectedRange.length, 0)
            
            textview.attributedText = attrStr
            textview.selectedRange = newSelectedRange
            textview.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    //设置下划线
    @objc func doneunderlineAction(){
        print(textview)
        let selectedRange = textview.selectedRange
        let a:Int
        let b:Int
        a = selectedRange.location
        b = selectedRange.length
        if(b>0){
            print(selectedRange)
            let str = textview.text
            let attrStr = NSMutableAttributedString.init(string: str!)
            attrStr.addAttribute(NSAttributedString.Key.underlineStyle,value: NSNumber.init(value: 1), range: NSRange.init(location:a, length:b))
            
            let newSelectedRange = NSMakeRange(selectedRange.location + selectedRange.length, 0)
            
            textview.attributedText = attrStr
            textview.selectedRange = newSelectedRange
            textview.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    //“变红”按钮点击响应
    @objc func doneRedwordAction(){
        let selectedRange = textview.selectedRange
        let a:Int
        let b:Int
        a = selectedRange.location
        b = selectedRange.length
        if(b>0){
            print(selectedRange)
            let str = textview.text
            let attrStr = NSMutableAttributedString.init(string: str!)
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange.init(location:a, length:b))
            
            let newSelectedRange = NSMakeRange(selectedRange.location + selectedRange.length, 0)
            
            textview.attributedText = attrStr
            textview.selectedRange = newSelectedRange
            textview.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    //变黑字体
    @objc func doneBlackwordAction() {
        let selectedRange = textview.selectedRange
        let a:Int
        let b:Int
        a = selectedRange.location
        b = selectedRange.length
        if(b>0){
            print(selectedRange)
            let str = textview.text
            let attrStr = NSMutableAttributedString.init(string: str!)
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange.init(location:a, length:b))
            
            let newSelectedRange = NSMakeRange(selectedRange.location + selectedRange.length, 0)
            
            textview.attributedText = attrStr
            textview.selectedRange = newSelectedRange
            textview.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    
    //插入文字
    //    func insertString(_ text:String) {
    //        let mutableStr = NSMutableAttributedString(attributedString: textview.attributedText)
    //        //获得目前光标的位置
    //        let selectedRange = textview.selectedRange
    //        //插入文字
    //        let attStr = NSAttributedString(string: text)
    //        mutableStr.insert(attStr, at: selectedRange.location)
    //
    //        //设置可变文本的字体属性
    //        mutableStr.addAttribute(NSAttributedString.Key.font, value: textViewFont,
    //                                range: NSMakeRange(0,mutableStr.length))
    //        //再次记住新的光标的位置
    //        let newSelectedRange = NSMakeRange(selectedRange.location + attStr.length, 0)
    //
    //        //重新给文本赋值
    //        textview.attributedText = mutableStr
    //        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
    //        textview.selectedRange = newSelectedRange
    //    }
    
    //插入图片
    func insertPicture(_ image:UIImage, mode:ImageAttachmentMode = .default){
        //获取textView的所有文本，转成可变的文本
        let mutableStr = NSMutableAttributedString(attributedString: textview.attributedText)
        
        //创建图片附件
        let imgAttachment = NSTextAttachment(data: nil, ofType: nil)
        var imgAttachmentString: NSAttributedString
        imgAttachment.image = image
        
        //设置图片显示方式
        if mode == .fitTextLine {
            //与文字一样大小
            imgAttachment.bounds = CGRect(x: 0, y: -4, width: textview.font!.lineHeight,
                                          height: textview.font!.lineHeight)
        } else if mode == .fitTextView {
            //撑满一行
            let imageWidth = textview.frame.width - 10
            let imageHeight = image.size.height/image.size.width*imageWidth
            imgAttachment.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        }
        
        imgAttachmentString = NSAttributedString(attachment: imgAttachment)
        
        //获得目前光标的位置
        let selectedRange = textview.selectedRange
        //插入文字
        mutableStr.insert(imgAttachmentString, at: selectedRange.location)
        //设置可变文本的字体属性
        mutableStr.addAttribute(NSAttributedString.Key.font, value: textViewFont,
                                range: NSMakeRange(0,mutableStr.length))
        //再次记住新的光标的位置
        let newSelectedRange = NSMakeRange(selectedRange.location+1, 0)
        
        //重新给文本赋值
        textview.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        textview.selectedRange = newSelectedRange
        //移动滚动条（确保光标在可视区域内）
        self.textview.scrollRangeToVisible(newSelectedRange)
        
    }
    
    //传递数据
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
////        if segue.identifier == "GoTOViewGontroller"{
////            let message_NEW:String = textview.text
////            let vc = segue.destination as! ViewController
////            vc.message = message_NEW
////        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if textview.attributedText.string == "" {
            if newId != "-1" {
                CoreDataManager.shared.destoryOneNote(id: newId)
            }
            return
        }
        
        let data = try! NSKeyedArchiver.archivedData(withRootObject: textview.attributedText, requiringSecureCoding: true)
        let newStr = data.base64EncodedString()
        
        if newId == "-1" {
            CoreDataManager.shared.addNoteWith(body: newStr, type: 1, mark: 0)
        } else {
            CoreDataManager.shared.updateNote(id: newId, body: newStr)
        }
        
    }
}

//插入的图片附件的尺寸样式
enum ImageAttachmentMode {
    case `default`  //默认（不改变大小）
    case fitTextLine  //使尺寸适应行高
    case fitTextView  //使尺寸适应textView
}
