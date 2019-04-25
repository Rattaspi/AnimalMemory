//
//  DBManager.swift
//  FirstGameSwift
//
//  Created by Alex Canut on 25/04/2019.
//  Copyright © 2019 Alex Canut. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DBManager {
    //Unique identifier
    //UUID().uuidString
    
    static let k_COLLECTION_SCORES = "scores"
    
    static func writeUserScore(name: String, score: Int){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES).addDocument(data: [
            "name": name,
            "score": score])
    }
    
    static func getUserScore(){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES).whereField("score", isGreaterThan: 0)
            .getDocuments{(snapshot,error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        snapshot?.documents.forEach({ print($0.data()) })
                    }
                }
                
    }
    
    static func UpdateInfo(score: Int, username: String?, userId: String){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES)
            .document(userId)
            .setData([
                "score": score, "username": username ?? "", "userId":userId
                ], merge: true)
    }
}
