//
//  ViewController.swift
//  SearchDemo
//
//  Created by Allison on 2017/4/8.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let reuseIdentifier = "reuseIdentifier"
    
    //展示列表
    lazy var tableView = UITableView()
    //搜索控制器
    var countrySearchController = UISearchController()
    var shouldShowSearchResults = false //是否显示搜索结果

    
    //原始数据集
    let schoolArray = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                       "华东师范大学","上海大学","河北工业大学"]
    
    
    //搜索过滤后的结果集
    var searchArray:[String] = [String](){
        didSet  {self.tableView.reloadData()}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController{
    func setupTableView() {
        self.title = "搜索框🔍"
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        
        
        //配置搜索控制器
        self.countrySearchController = ({
            let searchController = UISearchController(searchResultsController: nil)
            //设置searchBar的代理
            searchController.searchBar.delegate = self
            //设置代理，searchResultUpdater是UISearchController的一个属性，它的值必须实现UISearchResultsUpdating协议，这个协议让我们的类在UISearchBar文字改变时被通知到
            searchController.searchResultsUpdater = self
            
            searchController.hidesNavigationBarDuringPresentation = false //设置开始搜索时导航条是否隐藏
            searchController.dimsBackgroundDuringPresentation = false //设置开始搜索时背景颜色是否显示
            //设置默认显示内容
            searchController.searchBar.placeholder = "请输入搜索的站点"
            searchController.searchBar.searchBarStyle = .minimal
            searchController.searchBar.sizeToFit()
            self.tableView.tableHeaderView = searchController.searchBar
            
            return searchController
        })()
    }
}
//MARK:- <UISearchBarDelegate>
extension ViewController: UISearchBarDelegate ,UISearchResultsUpdating{
    //开始进行文本编辑，设置显示搜索结果，刷新列表
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    //点击搜索按钮
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.searchArray = self.schoolArray.filter { (school) -> Bool in
//            return school.contains(searchBar.text!)
//        }
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        countrySearchController.searchBar.resignFirstResponder()
    }
    
    //点击取消按钮
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        shouldShowSearchResults = false
        self.searchArray = self.schoolArray
    }
    
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray = self.schoolArray.filter { (school) -> Bool in
            return school.contains(searchController.searchBar.text!)
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldShowSearchResults {
            return self.searchArray.count
        } else {
            return self.schoolArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath)
        if shouldShowSearchResults {
            cell.textLabel?.text = self.searchArray[indexPath.row]
            return cell
        } else {
            cell.textLabel?.text = self.schoolArray[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
