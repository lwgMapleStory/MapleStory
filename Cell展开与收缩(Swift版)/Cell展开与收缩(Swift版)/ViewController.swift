//
//  ViewController.swift
//  Cell展开与收缩(Swift版)
//
//  Created by youzhu002 on 16/4/27.
//  Copyright © 2016年 Liwengang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //分区数组:[标题]
    var sectionArray:NSMutableArray?
    //展开row的个数
    var rowCountArray:NSMutableArray?
    //保存section是否展开的标识符[0:表示收缩, 1:表示展开]
    var isOpenSectionArray:NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionArray = ["现场情况", "新加任务", "实际薪酬", "售后服务", "评价"]
        //设置每个section下row的初始行数
        rowCountArray = ["5", "6", "7", "8", "9"]
        //设置每个section的初始状态 0为关闭状态, 1为展开状态
        isOpenSectionArray = ["0", "0", "0", "0", "1"]
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(tableView)
    }
    
    //创建tableView
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        //签订代理
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//扩展 实现代理和数据源方法
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 分()个区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return sectionArray!.count
    }
    
    // 分()行/区
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //根据isOpenSectionArray的标识符 判断section是否是展开状态
        //true: 返回rowCountArray里存放的个数
        if isOpenSectionArray!.objectAtIndex(section).isEqualToString("1") {
            return rowCountArray!.objectAtIndex(section).integerValue
        }
        return 0
    }
    
    //设置每head的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    //设置每row的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 40
    }
    
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = rowCountArray?.objectAtIndex(indexPath.section) as? String

        return cell
    }
    //设置head的内容 -> UIView
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let width = UIScreen.mainScreen().bounds.width
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        view.backgroundColor = UIColor.blackColor()
        
        let button = UIButton()
        button.frame = view.frame
        button.tag = 100 + section
        button.addTarget(self, action: "conversionClick:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        let label = UILabel(frame: button.frame)
        label.text = sectionArray?.objectAtIndex(section) as? String
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(20)
        button.addSubview(label)
        
        return view
    }
    //button 点击方法实现
    func conversionClick(button: UIButton) {
        
        // 判断 标识符是否为0, 如果是把标识符转换成1,刷新TableView; else 再转换成0, 刷新TableView
        if isOpenSectionArray!.objectAtIndex(button.tag - 100).isEqualToString("0") {
            
        //此方法是实现: 展开一个section, 收缩其他section
/*
            for i in 0..<sectionArray!.count
            {
                isOpenSectionArray?.replaceObjectAtIndex(i, withObject: "0")
                tableView.reloadSections(NSIndexSet(index: i), withRowAnimation: UITableViewRowAnimation.Fade)
            }
 */
            isOpenSectionArray?.replaceObjectAtIndex(button.tag - 100, withObject: "1")
            tableView.reloadSections(NSIndexSet(index: button.tag - 100), withRowAnimation: UITableViewRowAnimation.Fade)
        } else {
            
            isOpenSectionArray?.replaceObjectAtIndex(button.tag - 100, withObject: "0")
            tableView.reloadSections(NSIndexSet(index: button.tag - 100), withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("幽默百晓生")
    }
    
    
}
