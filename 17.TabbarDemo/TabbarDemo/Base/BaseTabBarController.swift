//
//  BaseTabBarController.swift
//  YifengEnergy
//
//  Created by 吴强 on 17/3/14.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        
    }
}


// MARK: - 设置界面
extension BaseTabBarController {
    
    func setupChildControllers() {
        
        let array = [
            ["clsName" : "ChangeBatteriesViewController", "title" : "换电池", "image" : "MyOrderIcon", "storyboardName" : "ChangeBatteries"],
            ["clsName" : "BatteryRescueViewController", "title" : "电池救援", "image" : "tab_live", "storyboardName" : "BatteryRescue"],
            ["clsName" : "NewsViewController", "title" : "消息", "image" : "PowerExchangeIcon", "storyboardName" : "News"],
            ["clsName" : "MyViewController", "title" : "我的", "image" : "PowerExchangeIcon", "storyboardName" : "My"],
        ]
        
        // 遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for i in 0..<array.count {
            let dict = array[i]
            arrayM.append(controller(dict: dict, index: i, totalCount: array.count))
        }
        
        // 设置 tabBar 的子控制器
        viewControllers = arrayM
    }
    
    
    /// 使用字典创建一个子控制器
    private func controller(dict: [String: String], index : Int, totalCount: Int) -> UIViewController {
        
        // 1. 取得字典内容
        guard let title = dict["title"] ,
            let image = dict["image"] ,
            let storyboardName = dict["storyboardName"],
            let clsName = dict["clsName"] ,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) 
            
            else {
                
                return UIViewController()
        }
        
        
        // 2. 创建视图控制器
        
        let vc = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: clsName)
//        if storyboardName == "PowerExchange" {
//            vc = cls.init()
//        }
        
//        let vc = cls.init()?
        vc.title = title
//        vc.tabBarItem.image = UIImage(named: "clearImage")
//        vc.tabBarItem.selectedImage = UIImage(named: "clearImage")
//
//        
//        // 设置 tabbar 的标题字体（大小）
//        vc.tabBarItem.setTitleTextAttributes(
//            [NSForegroundColorAttributeName: UIColor.clear],
//            for: .normal)
//        vc.tabBarItem.setTitleTextAttributes(
//            [NSForegroundColorAttributeName: UIColor.clear],
//            for: .highlighted)
//  
//        let imageNormal = UIImage(named: image)
//        let imageSelected = UIImage(named: "\(image)_selected")
//        let btn = UIButton()
//        let screenWidth = UIScreen.cz_screenWidth()
//        btn.frame = CGRect(x: (Double(index)*Double(screenWidth)/Double(totalCount)), y: 0, width: (Double(screenWidth)/Double(totalCount)), height: Double(tabBar.height))
//        btn.set(image: imageNormal, title: title,titleColor: color666, titlePosition: .right, additionalSpacing: 5, state: .normal)
//        btn.set(image: imageSelected, title: title,titleColor: colorMain, titlePosition: .right, additionalSpacing: 5, state: .selected)
//        btn.updateConstraints()
//        tabBar.addSubview(btn)
//        btn.tag = 191 + index
//        bottomButtonArray.append(btn)
//        
//        // 第一个按钮设置为选中状态
//        if index == 0 {
//            btn.isSelected = true
//        }
//        // 第二个位置添加小红点
//        if title == "换电操作" {
//            let titleLableFrame = btn.titleLabel?.convert((btn.titleLabel?.bounds)!, to: tabBar)
//            redIcon.frame = CGRect(x: (titleLableFrame?.maxX)! + 3.0, y: (titleLableFrame?.minY)! - 7.0, width: 14.0, height: 14.0)
//            redIcon.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//            redIcon.layer.cornerRadius = 6.0
//            redIcon.textColor = colorWhite
//            redIcon.text = "0"
//            redIcon.isHidden = true
//            redIcon.font = UIFont.systemFont(ofSize: 10)
//            redIcon.textAlignment = .center
//            redIcon.layer.masksToBounds = true
//            tabBar.addSubview(redIcon)
//        }
        
        
        // 实例化导航控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = BaseNavigationController(rootViewController: vc)
        
        return nav
    }
    
}
