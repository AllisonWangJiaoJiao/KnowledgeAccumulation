//
//  BaseNavigationController.swift
//  YifengEnergy
//
//  Created by 吴强 on 17/3/14.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationBar.isHidden = true
        
        addPan()
        
    }
    
    /// 重写 push 方法，所有的 push 动作都会调用此方法！
    /// viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器的类型
            if let vc = viewController as? BaseViewController {
                
                // FIXME: - 此处应该是返回按钮的图片
                // 取出自定义的 navItem，设置左侧按钮作为返回按钮
                vc.navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "arrow_l"), style: .plain, target: self, action: #selector(popToParent))
            }
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    /// POP 返回到上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }
    
    // 设置通用右滑返回手势
    private func addPan(){
        let target = interactivePopGestureRecognizer?.delegate
        
        let handler = NSSelectorFromString("handleNavigationTransition:")
        
        let targetView = interactivePopGestureRecognizer?.view
        
        let pan = UIPanGestureRecognizer(target: target, action: handler)
        pan.delegate = self
        
        targetView?.addGestureRecognizer(pan)
        
        interactivePopGestureRecognizer?.isEnabled = false
    }

}

extension BaseNavigationController : UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let translation = gestureRecognizer.location(in: gestureRecognizer.view)
        if translation.x <= 0 {
            return false
        }
        return childViewControllers.count == 1 ? false : true
    }
}
