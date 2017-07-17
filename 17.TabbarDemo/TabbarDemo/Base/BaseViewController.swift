//
//  BaseViewController.swift
//  YifengEnergy
//
//  Created by 吴强 on 17/3/14.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    /// 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    lazy var navItem = UINavigationItem()
    /// 自定义的导航条目 - 蓝色导航条
    lazy var navItemBlue = UINavigationItem()
    /// 所有代码创建的view都添加到contentView上
    lazy var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
        
    }
    
    override var title: String? {
        // 重写title的set方法
        didSet {
            navItem.title = title
            navItemBlue.title = title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 友盟分析
//        let className = NSStringFromClass(type(of: self))
//        let classStr = String.init(className)
//        MobClick.endLogPageView(classStr?.components(separatedBy: ".").last!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 友盟分析
//        let className = NSStringFromClass(type(of: self))
//        let classStr = String.init(className)
//        MobClick.endLogPageView(classStr?.components(separatedBy: ".").last!)
    }
}


extension BaseViewController {
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        contentView.frame = CGRect(x: 0, y: 64, width: UIScreen.cz_screenWidth(), height: UIScreen.cz_screenHeight()-64)
        view.insertSubview(contentView, at: 0)
        setupNavBar()
    }
    
    /// 设置导航条
    private func setupNavBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        // 将item设置给bar
        navigationBar.items = [navItem]
        // 设置navbar的渲染颜色
        navigationBar.barTintColor = colorNavBG
        // 设置navbar的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: color333]
    }
    
    func setupNavBarBlue() {
        // 将蓝色导航条设置给bar
        navigationBar.items = [navItemBlue]
        // 设置蓝色导航条的渲染颜色
        navigationBar.barTintColor = colorMain
        // 设置蓝色导航条的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colorWhite]
    }
}
