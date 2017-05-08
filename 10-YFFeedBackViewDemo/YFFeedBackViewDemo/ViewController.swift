//
//  ViewController.swift
//  YFFeedBackViewDemo
//
//  Created by Allison on 2017/5/8.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var feedBackTextView: UITextView! //意见反馈框
    
    @IBOutlet weak var placeHolderLab: UILabel! //占位符文字
    
    @IBOutlet weak var commitButton: UIButton! //提交按钮
    
    @IBOutlet weak var stirngLenghLabel: UILabel! //右下角数字
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "意见反馈"
      
        
        feedBackTextView.delegate = self
       
       
        commitButton.isUserInteractionEnabled = false
        feedBackTextView.layer.borderWidth = 0.5
        feedBackTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        self.placeHolderLab.isHidden = true
        //允许点击提交按钮操作
        self.commitButton.backgroundColor = UIColor.blue
        self.commitButton.isUserInteractionEnabled = true
        //实时显示字数
        self.stirngLenghLabel.text = String(format: "%lu/100", textView.text.characters.count)
        
        //字数限制操作
        if textView.text.characters.count >= 100 {
            let range = NSRange(location: 0, length: 100)
            textView.text = (textView.text as NSString).substring(with: range)
            self.stirngLenghLabel.text = "100/100"
        }
        //取消按钮点击权限 并显示提示问文字
        if textView.text.characters.count == 0 {
            self.placeHolderLab.isHidden = false
            self.commitButton.backgroundColor = UIColor.lightGray
            self.commitButton.isUserInteractionEnabled = false
            
        }

    }
  
}



