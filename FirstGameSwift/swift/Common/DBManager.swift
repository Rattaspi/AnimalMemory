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
    
    //import FirebaseAnalytics
    //Analytics.logEvent("nextLevel", parameters: ["levelNumber: 2])
    
    let k_COLLECTION_SCORES = "scores"
    
    func writeUserScore(name: String, score: Int){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES).addDocument(data: [
            "name": name,
            "score": score])
    }
    
    /*
    func getUserScore(){
        let db = Firestore.firestore()
        let doc = db.document("scores/F558BC34-DB3E-43A0-B230-4B02908B3943")
        doc.getDocument { (snapshot, error) in
            if let snapshot = snapshot {
                //print(snapshot.data()?["score1"])
            }
        }
        db.collection(k_COLLECTION_SCORES).whereField("score", isGreaterThan: 0)
            .getDocuments{ (snapshot, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        snapshot?.documents.forEach({ print($0.data()) })
                    }
                }
                
    }
    */
    
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
