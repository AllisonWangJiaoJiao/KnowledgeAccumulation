//
//  GiftListView.swift
//  XMGTV
//
//  Created by apple on 16/11/13.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

private let kGiftCellID = "kGiftCellID"

protocol GiftListViewDelegate : class {
    func giftListView(giftView : GiftListView, giftModel : GiftModel)
}

class GiftListView: UIView, NibLoadable {
    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!
    
    fileprivate var pageCollectionView : YFPageCollectionView!
    fileprivate var currentIndexPath : IndexPath?
//    fileprivate var giftVM : GiftViewModel = GiftViewModel()
    
    weak var delegate : GiftListViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 1.初始化礼物的View
        setupGiftView()
        
        // 2.加载礼物的数据
//        loadGiftData()
    }
}

extension GiftListView {
    fileprivate func setupUI() {
        setupGiftView()
    }
    
    fileprivate func setupGiftView() {
        let style = YFPageStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        
        let layout = YFPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.cols = 4
        layout.rows = 2
        
        var pageViewFrame = giftView.bounds
        pageViewFrame.size.width = kScreenW
        pageCollectionView = YFPageCollectionView(frame: pageViewFrame, titles: ["热门", "高级", "豪华", "专属"], isTitleInTop: true, layout: layout, style: style)
 
        giftView.addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        
        pageCollectionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), identifier: kGiftCellID)
    }
}

// MARK:- 加载数据
extension GiftListView {
//    fileprivate func loadGiftData() {
//        giftVM.loadGiftData {
//            self.pageCollectionView.reloadData()
//        }
//    }
}



// MARK:- 数据设置
extension GiftListView : YFPageCollectionViewDataSource, YFPageCollectionViewDelegate {
    
    func numberOfSections(in pageCollectionView: YFPageCollectionView) -> Int {
//        return giftVM.giftlistData.count
        return 4
    }
    
    func pageCollectionView(_ collectionView: YFPageCollectionView, numberOfItemsInSection section: Int) -> Int {
//        let package = giftVM.giftlistData[section]
//        return package.list.count
        return 10
    }
    
    func pageCollectionView(_ pageCollectionView: YFPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftCellID, for: indexPath) as! GiftViewCell
        
//        let package = giftVM.giftlistData[indexPath.section]
//        cell.giftModel = package.list[indexPath.item]
        
        return cell
    }
    
    func pageCollectionView(_ pageCollectionView: YFPageCollectionView, didSelectItemAt indexPath: IndexPath) {
        sendGiftBtn.isEnabled = true
        currentIndexPath = indexPath
    }
}


// MARK:- 送礼物
extension GiftListView {
    @IBAction func sendGiftBtnClick() {
//        let package = giftVM.giftlistData[currentIndexPath!.section]
//        let giftModel = package.list[currentIndexPath!.item]
//        delegate?.giftListView(giftView: self, giftModel: giftModel)
    }
}
