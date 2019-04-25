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
    static func writeUserScore(name: String, score: Int){
        let db = Firestore.firestore()
        
        db.collection("scores").addDocument(data: [
            "name": name,
            "score": score])
    }
}
