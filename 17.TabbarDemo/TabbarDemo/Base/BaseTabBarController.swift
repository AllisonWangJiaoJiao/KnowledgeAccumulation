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
            ["clsName" : "BatteryRescueViewController", "title" : "电池救援", "image" : "tab_live", "storyboardName" : "BatteryRescue"]
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
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName)  as? BaseViewController.Type
            
            else {
                
                return UIViewController()
        }
        
        
        // 2. 创建视图控制器
        
//        let vc = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: clsName)
//        if storyboardName == "PowerExchange" {
//            vc = cls.init()
//        }
        
        let vc = cls.init()
        vc.title = title
//        vc.tabBarItem.image = UIImage(named: "clearImage")
//        vc.tabBarItem.selectedImage = UIImage(named: "clearImage")
//
//        

        // 实例化导航控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = BaseNavigationController(rootViewController: vc)
        
        return nav
    }
    
}
