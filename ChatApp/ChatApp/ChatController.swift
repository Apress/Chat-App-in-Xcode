//
//  ChatController.swift
//  ChatApp
//
//  Created by Tihomir RAdeff on 11.03.24.
//

import UIKit

class ChatController: UIViewController {
    
    @IBOutlet weak var chatField: UITextView!
    @IBOutlet weak var messageField: UITextField!
    
    var name = ""
    var chatData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name = UserDefaults.standard.object(forKey: "name") as! String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        readChatData()
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        if messageField.text?.count ?? 0 > 0 {
            sendMessage(message: messageField.text!)
            messageField.text = ""
        }
    }
    
    func sendMessage(message: String) {
        DispatchQueue.main.async {
            let messageToSend = self.name + ": " + message
            NetworkHelper.sendData(fileName: "chat", message: messageToSend, completition: { (status) in
                if status == "SUCCESS" {
                    print("Message sent!")
                }
                
                if status == "ERROR" {
                    print("Try again!")
                }
            })
        }
    }
    
    func readChatData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.chatData = NetworkHelper.downloadData(fileName: "chat")
            self.chatField.text = self.chatData
            self.readChatData()
        })
    }
}
