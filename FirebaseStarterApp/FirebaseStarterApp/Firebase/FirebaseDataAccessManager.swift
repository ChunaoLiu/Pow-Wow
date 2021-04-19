import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit

class FirebaseDataAccessManager {
    
    private let database = Database.database().reference()
    private let storage = Storage.storage().reference()

    func addNewUser(UserName: String, UserEmail: String, UserPhoneNum: Int, uid: String) -> Bool {
        
        var Success = true
        
        database.child("Increment").observeSingleEvent(of: .value, with: { snapshot in
            guard let Increment = snapshot.value as? Int else {
                print("Error in Receiving Incrementation number")
                Success = false
                return
            }
            let User: [String: String] = [
                "uid" : uid,
                "UserName" : UserName,
                "UserEmail" : UserEmail,
                "UserPhoneNumber" : String(UserPhoneNum),
                "UserType" : "NULL",
                "UserBannerURL" : "NULL",
                "UserPictureURL" : "NULL",
                "ProIndustry" : "NULL",
                "ProKeywords" : "NULL",
                "ProBio" : "NULL"
            ]
            self.database.child(uid).setValue(User)
            self.database.child("Increment").setValue(Increment + 1)
            Success = true
        })
        return Success
    }
    
    func getUserInfo(uid: String, completion: @escaping (_ UserInfo: [String: String]) -> Void) {
        
        print("UID: " + uid)
        database.child(uid).observeSingleEvent(of: .value, with:
            { snapshot in
                guard let UserInfo = snapshot.value as? [String: String] else {
                    print("Error in Receiving Incrementation number")
                    return
            }
            completion(UserInfo)
        })
        print("Im Later!")
    }
}



