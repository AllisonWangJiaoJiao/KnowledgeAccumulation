//
//  LiveViewController.swift
//  XMGTV
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

private let kChatToolsViewHeight : CGFloat = 44
private let kGiftlistViewHeight : CGFloat = kScreenH * 0.5
private let kChatContentViewHeight : CGFloat = 200


class RoomViewController: UIViewController, Emitterable {
    
    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    
    fileprivate lazy var chatToolsView : ChatToolsView = ChatToolsView.loadFromNib()
    fileprivate lazy var giftlistView : GiftListView = GiftListView.loadFromNib()
    fileprivate lazy var chatContentView :ChatContentView = ChatContentView.loadFromNib()
    fileprivate lazy var socket : HYSocket = HYSocket.init(addr: "0.0.0.0", port: 7878)

    fileprivate var heatBeatTimer : Timer?
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        if socket.connectServer() {
            print("连接上服务器")
            addHeartBeatTimer()
            socket.sendJoinRoom()
            socket.delegate  = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.sendLeaveRoom()
    }
    
    deinit {
        heatBeatTimer?.invalidate()
        heatBeatTimer = nil
    }
    
    
}
// MARK: -给服务器发送及时消息
extension RoomViewController {
    
    fileprivate func addHeartBeatTimer(){
        heatBeatTimer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeartBeat), userInfo: nil, repeats: true)
        RunLoop.main.add(heatBeatTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    @objc fileprivate func sendHeartBeat() {
        
        socket.sendHeartBeat()
        
    }
}

// MARK: -接收聊天服务器返回的消息
extension RoomViewController : HYSocketDelegate {
    
    func socket(_ socket: HYSocket, joinRom user: UserInfo) {
        print("\(user.name)进入房间")
    }

    func socket(_ socket: HYSocket, leaveRom user: UserInfo) {
        print("\(user.name)离开房间")

    }
    
    func socket(_ socket: HYSocket, textMsg : TextMessage) {
        print("\(textMsg.user.name):\(textMsg.text)")
    }
    
    func socket(_ socket: HYSocket, giftMsg : GiftMessage) {
        print("\(giftMsg.user.name)赠送\(giftMsg.giftname)\(giftMsg.giftUrl)")
        
    }
    
    
}

// MARK:- 设置UI界面内容
extension RoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
        setupBottomView()
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
        //1.设置chatToolsView
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kChatToolsViewHeight)
        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
        
        //2.设置giftlistView
        giftlistView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftlistViewHeight)
        giftlistView.autoresizingMask = [.flexibleTopMargin,.flexibleWidth]
        giftlistView.delegate = self
        view.addSubview(giftlistView)
        
        //3.设置chat内容的view
        chatContentView.frame = CGRect(x: 0, y: view.bounds.height - 44 - kChatContentViewHeight, width: view.bounds.width, height: kChatContentViewHeight)
        chatContentView.autoresizingMask = [.flexibleWidth,.flexibleTopMargin]
        view.addSubview(chatContentView)
    }
}


// MARK:- 事件监听
extension RoomViewController {
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolsView.inputTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.35, animations: {
            self.giftlistView.frame.origin.y = self.view.bounds.height
        })

    }
    
    @IBAction func bottomMenuClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            chatToolsView.inputTextField.becomeFirstResponder()
              print("点击了聊天")
        case 1:
            print("点击了分享")
        case 2:
            print("点击了礼物")
            UIView.animate(withDuration: 0.35, animations: { 
                 self.giftlistView.frame.origin.y = self.view.bounds.height - kGiftlistViewHeight
            })
        case 3:
            print("点击了更多")
        case 4:
            sender.isSelected = !sender.isSelected
            let point = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            sender.isSelected ? startEmittering(point) : stopEmittering()
        default:
            fatalError("未处理按钮")
        }
    }
}


// MARK:- 监听键盘的弹出
extension RoomViewController {
    @objc fileprivate func keyboardWillChangeFrame(_ note : Notification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputViewY = endFrame.origin.y - kChatToolsViewHeight
        
        UIView.animate(withDuration: duration, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            let endY = inputViewY == (kScreenH - kChatToolsViewHeight) ? kScreenH : inputViewY
            self.chatToolsView.frame.origin.y = endY
        })
    }
}



// MARK:- 监听用户输入的内容
extension RoomViewController : ChatToolsViewDelegate ,GiftListViewDelegate{
    func chatToolsView(toolView: ChatToolsView, message: String) {
        socket.sendTextMsg(message: message)
    }
    
    func giftListView(giftView: GiftListView, giftModel: GiftModel) {
        socket.sendGiftMsg(giftname: giftModel.subject, giftURL: giftModel.img2, giftCount: "1")
    }
}
