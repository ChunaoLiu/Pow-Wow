import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit

class FirebaseDataAccessManager {
    
    private let database = Database.database().reference()
    private let storage = Storage.storage().reference()

    func addNewUser(UserName: String, UserEmail: String, UserPhoneNum: Int) -> Bool {
        
        var Success = true
        
        database.child("Increment").observeSingleEvent(of: .value, with: { snapshot in
            guard let Increment = snapshot.value as? Int else {
                print("Error in Receiving Incrementation number")
                Success = false
                return
            }
            let User: [String: Any] = [
                "UserObjectID" : Increment,
                "UserName" : UserName,
                "UserEmail" : UserEmail,
                "UserPhoneNumber" : UserPhoneNum,
                "UserType" : "NULL",
                "UserBannerURL" : "NULL",
                "UserPictureURL" : "NULL",
                "ProIndustry" : "NULL",
                "ProKeywords" : ["NULL"],
                "ProBio" : "NULL"
            ]
            self.database.child("User_" + String(Increment)).setValue(User)
            self.database.child("Increment").setValue(Increment + 1)
            Success = true
        })
        return Success
    }
}



