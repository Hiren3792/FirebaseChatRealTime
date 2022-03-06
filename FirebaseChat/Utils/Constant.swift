//
//  Constant.swift
//  FirebaseChat
//
//  Created by Mac on 07/01/22.
//

import Foundation
import Firebase

struct Constant {
    static let firebaseUrl: String = "Your firebase realtime database base url"
    
    struct refs {
     static let databaseRoot = Database.database().reference()
     static let databaseChats = databaseRoot.child("messges")
     static var databaseUser  = DatabaseReference()

    }
}

struct Message {
    var mediaName: String
    var mediaType: String
    var messageText: String
    var messageTime: String
    var messageDate: String
    var senderId: String
    
    func toDict() -> [String: Any] {
        return [
            "mediaName" : mediaName,
            "mediaType": mediaType,
            "messageText": messageText,
            "messageTime": messageTime,
            "messageDate": messageDate,
            "senderId": senderId ]
    }
}
