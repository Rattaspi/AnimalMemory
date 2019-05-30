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
    let k_COLLECTION_SCORES = "scores"
    
    func writeUserScore(name: String, score: Int){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES).addDocument(data: [
            "name": name,
            "score": score])
    }

    func getHighscores(block: @escaping ([String] ) -> Void) {
        let db = Firestore.firestore()
        
        var info = [String]()
        db.collection(k_COLLECTION_SCORES).order(by: "score", descending: true).limit(to: 3)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error)
                }
                else {
                    snapshot?.documents.forEach({
                        if let score = $0.data()["score"], let name = $0.data()["username"]{
                            info.append("\(name)")
                            info.append("\(score)")
                        }
                    })
                    block(info)
                }
        }
    }
    
    func updateInfo(score: Int, username: String?, userId: String){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES)
            .document(userId).getDocument {(snapshot, error) in
                if let error = error {
                    print(error)
                }
                else {
                    if let score = snapshot?.data()?["score"]{
                        db.collection(self.k_COLLECTION_SCORES)
                            .document(userId)
                            .setData([
                                "score": score, "username": username ?? "", "userId":userId
                                ], merge: true)
                        }
                    }
                    
                }
        }
}
