//
//  ViewController.swift
//  GoingTo
//
//  Created by My Mac on 19/05/21.
//  Copyright © 2021 My Mac. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManager
import FirebaseCore
import Firebase


//  MARK:-  MAIN CLASS
class ChatVC: UIViewController {
    
    //  MARK:-  OUTLETS
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtEditView: UIView!
    @IBOutlet weak var txtView: IQTextView!
    @IBOutlet weak var txtViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: KeyboardLayoutConstraint!

    //  MARK:-  VARIABLES
    var chatHistory  = [Message]()

    //  MARK:-  LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        observer()
    }
    
    func setupView() {
        tblView.register(UINib(nibName: "TxtReceiverCell", bundle: nil), forCellReuseIdentifier: "TxtReceiverCell")
        tblView.register(UINib(nibName: "TxtSenderCell", bundle: nil), forCellReuseIdentifier: "TxtSenderCell")
        txtView.delegate = self
        let indexPath:IndexPath = IndexPath(row:(self.chatHistory.count - 1), section:0)
        guard chatHistory.count > 0 else { return }
        tblView.scrollToRow(at: indexPath , at: .bottom, animated: true)
    }
    
    func observer() {
        Constant.refs.databaseUser = Constant.refs.databaseChats.child("16-30")
        let query = Constant.refs.databaseUser
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            if let data = snapshot.value as? [String: String] {
                let mediaName = data["mediaName"] ?? ""
                let mediaType = data["mediaType"] ?? ""
                let messageText = data["messageText"] ?? ""
                let messageTime = data["messageTime"] ?? ""
                let messageDate = data["messageDate"] ?? ""
                let senderId = data["senderId"] ?? ""
                self?.chatHistory.append(Message(mediaName: mediaName, mediaType: mediaType, messageText: messageText, messageTime: messageTime, messageDate: messageDate, senderId: senderId))
            }
            self?.tblView.reloadData()
        })

    }
    
    deinit {
       NotificationCenter.default.removeObserver(self)
   }

    //  MARK:-  BUTTON ACTION

    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAction_Receive(_ sender: Any) {
        let getTime = "\(Date().get(.hour)):\(Date().get(.minute))"
        let getDate = "\(Date().fullDate)"
        let messageData = Message(mediaName: "", mediaType: "text", messageText: txtView.text ?? "", messageTime: getTime, messageDate: getDate, senderId: "30")
        let ref = Constant.refs.databaseUser.childByAutoId()
        ref.setValue(messageData.toDict())
        txtView.text = ""

    }
    
    @IBAction func btnAction_Send(_ sender: Any) {
        guard txtView.text.count > 0 else { return }
        let getTime = "\(Date().get(.hour)):\(Date().get(.minute))"
        let getDate = "\(Date().fullDate)"
        let messageData = Message(mediaName: "", mediaType: "text", messageText: txtView.text ?? "", messageTime: getTime, messageDate: getDate, senderId: "16")
        let ref = Constant.refs.databaseUser.childByAutoId()
        ref.setValue(messageData.toDict())
        txtView.text = ""
    }
}

//  MARK:-  TABLEVIEW EXTENSION
extension ChatVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageData = chatHistory[indexPath.row]
        if messageData.senderId == "30" {
            guard let cell = tblView.dequeueReusableCell(withIdentifier: "TxtReceiverCell") as? TxtReceiverCell else { return UITableViewCell() }
            cell.setupMessage(messageModel: messageData)
            return cell
        } else {
            guard let cell = tblView.dequeueReusableCell(withIdentifier: "TxtSenderCell") as? TxtSenderCell else { return UITableViewCell() }
            cell.setupMessage(messageModel: messageData)
            return cell
        }
    }
}

extension ChatVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let indexPath:IndexPath = IndexPath(row:(self.chatHistory.count - 1), section:0)
        guard chatHistory.count > 0 else { return }
        tblView.scrollToRow(at: indexPath , at: .bottom, animated: true)
    }
        
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location == 0 && (text == " ") {
            return false
        }
        return true
    }
}
