//
//  ChatViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 16.03.2023.
//

import UIKit
import MessageKit


struct Sender: SenderType {
    
    var senderId: String
    
    var displayName: String
}

struct Message: MessageType {
    
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind

}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "Ibragim")
    
    let otherUser = Sender(senderId: "2", displayName: "OtherUser")
    
    var messages = [MessageType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Сообщения"
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        addMessagesData()
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goBackAction))
        navigationItem.leftBarButtonItem?.tintColor = Tint.greenBlack
    }
    
    @objc func goBackAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func addMessagesData() {
        
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Привет")))
        
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-76400), kind: .text("Привет")))
        
        messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-66400), kind: .text("Как дела?")))
        
        messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-56400), kind: .text("Все хорошо, у тебя?")))
        
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-46400), kind: .text("Отлично")))
    }
    
    func currentSender() -> MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
}
