//
//  DBProvider.swift
//  Park-dFirebasePods
//
//  Created by Sophia Pignatelli on 4/8/17.
//  Copyright © 2017 Sophia Pignatelli. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {
    private static let _instance =  DBProvider();
    
    static var Instance: DBProvider {
        return _instance;
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference();
    }
    
    var driversRef: FIRDatabaseReference {
        return dbRef.child(Constants.DRIVERS)
    }
    // with points?
    func saveUser(withID: String,email: String, password: String, points: Int) {
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password, Constants.POINTS: points];
        
        driversRef.child(withID).child(Constants.DATA).setValue(data);
       
    }
    
    
    
} //class
