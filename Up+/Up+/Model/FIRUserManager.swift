//
//  FIRUserManager.swift
//  Up+
//
//  Created by Dreamup on 3/3/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FIRUserManager: NSObject {

    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    func createUser(user:User){
        
        let newUserData = [
            "userId": user.userId,
            "username":user.username
        ]
        
        let newUserRef = self.ref.child("account").child(user.userId)
        newUserRef.setValue(newUserData)
    }
    
    
    func updateUser(user:User) {
        
        let userRef = self.ref.child("account").child(user.userId)
        
        let newData = [
            "lat": user.lat,
            "lgn":user.lgn,
            "photoURL":user.photoURL,
            "updateAt":user.updateAt
        ]
        
        userRef.updateChildValues(newData)
        
    }
    
    
}
