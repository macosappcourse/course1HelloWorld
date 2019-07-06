//
//  AppDelegate.swift
//  HelloWorld
//
//  Created by Di on 2019/7/6.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow


    override init() {
        /// 在swift中我们需要在调用父类的初始化方法前，先初始化好子类的相关参数

        window = NSWindow(
            contentRect: CGRect(x: 0, y: 0, width: 800, height: 500), // 展示的区域
            styleMask: [.closable, .titled], // 展示的类型，这里我们暂时选择 可以关闭 与 展示标题栏
            backing: .buffered, // 所有其他种类均被废弃了，只剩.buffered
            defer: false // 是否推迟创建window
        )
        super.init()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /// 设置label需要的宽度
        let width: CGFloat = 300
        /// 设置label需要的高度
        let height: CGFloat = 30
        /// 获取window的窗口的frame
        var frame = window.frame
        /// 设置x、y、width、height
        frame.origin.x = (frame.width - width) / 2
        frame.origin.y = (frame.height - height) / 2
        frame.size = CGSize(width: width, height: height)

        /// 因为MacOS中并无一个独立的Label组件，所以我们使用TextField替代
        let label = NSTextField(frame: frame)
        /// 设置字号
        label.font = .systemFont(ofSize: 30, weight: NSFont.Weight(rawValue: 3))
        /// 设置字符
        label.stringValue = "Hello World!"
        /// 设置居中
        label.alignment = .center
        /// 下面的都是取消NSTextField的一些与显示无关属性的
        /// 取消背景的边框
        label.isBezeled = false
        /// 不可编辑
        label.isEditable = false
        /// 不可被选中
        label.isSelectable = false
        /// 不展示背景颜色
        label.drawsBackground = false
        /// 将label加入到window的contentView上
        window.contentView?.addSubview(label)
        /// 展示ContentView
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
