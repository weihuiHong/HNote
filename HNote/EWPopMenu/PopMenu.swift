//
//  PopMenu.swift
//  HNote
//
//  Created by 洪伟辉 on 2018/11/28.
//  Copyright © 2018 hongweihui. All rights reserved.
//

import UIKit

let NavigationMenuShared = PopMenu.shared

class PopMenu: NSObject {
    static let shared = PopMenu()
    private var menuView: PopMenuView?

    public func showPopMenuSelecteWithFrameWidth(width: CGFloat, height: CGFloat, point: CGPoint, item: [String], imgSource: [String], action: @escaping ((Int) -> ())){
        weak var weakSelf = self
        /// 每次重置保证显示效果
        if self.menuView != nil{
            weakSelf?.hideMenu()
        }
        let window = UIApplication.shared.windows.first
        self.menuView = PopMenuView(width: width, height: height, point: point, items: item, imgSource: imgSource, action: { (index) in
            ///点击回调
            action(index)
            weakSelf?.hideMenu()
        })
        menuView?.touchBlock = {
            weakSelf?.hideMenu()
        }
        self.menuView?.backgroundColor = UIColor.black.withAlphaComponent(0)
        window?.addSubview(self.menuView!)
    }
    public func hideMenu(){
        self.menuView?.removeFromSuperview()
        self.menuView = nil
    }
}
