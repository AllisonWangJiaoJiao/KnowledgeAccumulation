//
//  YFTitleView.swift
//  YFPageViewDemo
//
//  Created by Allison on 2017/4/27.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

protocol YFTitleViewDelegate : class {
    func titleView(_ titleView : YFTitleView, targetIndex : Int)
}


class YFTitleView: UIView {
    
    weak var delegate : YFTitleViewDelegate?

    
    fileprivate var titlesArr : [String]
    fileprivate var style : YFPageStyle
    fileprivate lazy var titleLabelsArr : [UILabel] = [UILabel]()
    fileprivate var currentIndex :Int = 0

    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    init(frame: CGRect,titles:[String],style:YFPageStyle) {
        self.titlesArr = titles
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YFTitleView {
    fileprivate func setupUI() {
        //1.将UIScorllView添加到view中
        addSubview(scrollView)
        
        //2.将titleLabel添加到UIScorllView中
        setupTitleLabels()
        
        //3.设置titleLabel的frame
        setupTitleLabelsFrame()
        
        
    }
    private func setupTitleLabels(){
        for (i ,title) in titlesArr.enumerated() {
             // 1.创建Label
            let titleLabel  = UILabel()
             // 2.设置label的属性
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: style.fontSize)
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
             // 3.添加到父控件中
            scrollView.addSubview(titleLabel)
             // 4.保存label
            titleLabelsArr.append(titleLabel)
            
            //给UILabel添加点击手势
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
            
        }
    }

    
    private func setupTitleLabelsFrame() {
        let count = titlesArr.count
        
        for (i, label) in titleLabelsArr.enumerated() {
            var w : CGFloat = 0
            let h : CGFloat = bounds.height
            var x : CGFloat = 0
            let y : CGFloat = 0
            
            if style.isScrollEnable { // 可以滚动
                w = (titlesArr[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil).width
                if i == 0 {
                    x = style.itemMargin * 0.5
                } else {
                    let preLabel = titleLabelsArr[i - 1]
                    x = preLabel.frame.maxX + style.itemMargin
                }
            } else { // 不能滚动
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
            }
            
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        scrollView.contentSize = style.isScrollEnable ? CGSize(width: titleLabelsArr.last!.frame.maxX + style.itemMargin * 0.5, height: 0) : CGSize.zero
    }
    
}


// MARK:- 监听事件
extension YFTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
       //1.取出用户点击的View
        let targetLabel = tapGes.view as! UILabel

        //2.调整title
        adjustTitleLabel(targetIndex: targetLabel.tag)
        
        //3.通知ContentView进行调整
        delegate?.titleView(self, targetIndex: currentIndex)
        

    }
    
    fileprivate func adjustTitleLabel(targetIndex : Int) {
        //1.取出label
        let targetLabel = titleLabelsArr[targetIndex]
        let sourceLabel = titleLabelsArr[currentIndex]
        
        //2.切换文字的颜色
        targetLabel.textColor = style.selectColor
        sourceLabel.textColor = style.normalColor
        
        //3.记录下值
        currentIndex = targetLabel.tag
        
        //5.调整位置 -- 选中的按钮居中
        if style.isScrollEnable {
            var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
            if offsetX < 0 {
                offsetX = 0
            }
            if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
                offsetX = scrollView.contentSize.width - scrollView.bounds.width
            }
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            
        }
        
    }
    
}

//MARK:-遵循YFContentViewDelegate 滑动contentView标签调整
extension YFTitleView : YFContentViewDelegate{
    func contentView(_ contentView: YFContentView, targetIndex: Int) {
     
        adjustTitleLabel(targetIndex: targetIndex)
        
    }
}














