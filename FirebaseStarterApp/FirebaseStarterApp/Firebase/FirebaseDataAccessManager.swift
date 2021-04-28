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
            var proceed = true
            self.database.child("Users").observeSingleEvent(of: .value) { (DataSnapshot) in
                for snap in DataSnapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let uid_database = userSnap.key
                    let userDict = userSnap.value as! [String: String]
                    print(userDict["UserEmail"] as! String + "\nVersus\n" + UserEmail)
                    if userDict["UserEmail"] == UserEmail {
                        Success = false
                        proceed = false
                        break
                    }
                }
                print("We Should: " + String(proceed))
                if (proceed) {
                    let User: [String: String] = [
                        "uid" : uid,
                        "UserName" : UserName,
                        "UserEmail" : UserEmail,
                        "UserPhoneNumber" : String(UserPhoneNum),
                        "UserType" : "NULL",
                        "UserIconURL" : "NULL",
                        "UserBannerURL" : "NULL",
                        "ProIndustry" : "NULL",
                        "Userkeywords" : "NULL",
                        "UserBio" : "NULL",
                        "URL_ID" : String(Increment)
                    ]
                    self.database.child("Users").child(uid).setValue(User)
                    self.database.child("Increment").setValue(Increment + 1)
                    Success = true
                }
            }
        })
        return Success
    }
    
    func getUserInfo(uid: String, completion: @escaping (_ UserInfo: [String: String]) -> Void) {
        
        print("UID: " + uid)
        database.child("Users").child(uid).observeSingleEvent(of: .value, with:
            { snapshot in
                guard let UserInfo = snapshot.value as? [String: String] else {
                    print("Error in Receiving some Value")
                    return
            }
            completion(UserInfo)
        })
        print("Im Later!")
    }
    
    func updateUserIcon(URL_ID: String, image: UIImage, completion: @escaping (_ success: Bool, _ url: String) -> Void) {
        guard let imageData = image.pngData() else {
            return
        }
        
        let picRef = storage.child("UserIcon_" + URL_ID + ".png")
        
        picRef.putData(imageData, metadata: nil, completion: {_, UploadError in
                guard UploadError == nil else {
                    print ("Failed to Upload User Icon")
                    completion(false, "Nothing")
                    return
                }
                self.storage.child("UserIcon_" + URL_ID + ".png").downloadURL (completion: { (url, error) in
                    guard let url = url, error == nil else{
                        print("Failed to retrive user icon")
                        return
                }
                
                let urlString = url.absoluteString
                UserDefaults.standard.set(urlString, forKey: "ProfileURL")
                completion(true, urlString)
                })
        })
    }
    
    func updateUserBanner(URL_ID: String, image: UIImage, completion: @escaping (_ success: Bool, _ url: String) -> Void) {
        guard let imageData = image.pngData() else {
            return
        }
        
        let picRef = storage.child("UserBanner_" + URL_ID + ".png")
        
        picRef.putData(imageData, metadata: nil, completion: {_, error in
                guard error == nil else {
                    print ("Failed to Upload User Banner")
                    completion(false, "Nothing")
                    return
                }
            self.storage.child("UserBanner_" + URL_ID + ".png").downloadURL (completion: { (url, error) in
                guard let url = url, error == nil else{
                    print("Failed to retrive user Banner")
                    return
            }
            
            let urlString = url.absoluteString
            UserDefaults.standard.set(urlString, forKey: "BannerURL")
            completion(true, urlString)
            })
        })
    }
    
    func updateUserSetting(uid: String, UserName: String, UserBio: String, UserKeyword: String, UserType: String, completion: @escaping (_ success: Bool) -> Void) {
        
        let UpdateRef = database.child("Users").child(uid)
        
        UpdateRef.updateChildValues([
            "UserName": UserName,
            "UserBio": UserBio,
            "Userkeywords": UserKeyword,
            "UserType": UserType
        ]) { (error, DatabaseRef) in
            if let error = error {
                print("Failed to update User's profile: \(error)")
                completion(false)
            }
            else {
                print("Update Successful")
                completion(true)
            }
        }
    }
    
    func updateUserIconURL(uid: String, url: String) {
        let UpdateRef = database.child("Users").child(uid)
        
        UpdateRef.updateChildValues([
            "UserIconURL": url
        ]) { (error, DatabaseRef) in
            if let error = error {
                print("Failed to update User's profile: \(error)")
            }
            else {
                print("Update Successful")
            }
        }
    }
    
    func updateUserBannerURL(uid: String, url: String) {
        let UpdateRef = database.child("Users").child(uid)
        
        UpdateRef.updateChildValues([
            "UserBannerURL": url
        ]) { (error, DatabaseRef) in
            if let error = error {
                print("Failed to update User's Banner: \(error)")
            }
            else {
                print("Update Successful")
            }
        }
    }
    
    func getAllUser(completion: @escaping (_ UserList: [Pro]) -> Void) {
        let databaseRef = database.child("Users")
        var returnPro: [Pro] = []
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1920, height: 1080))
        let cgImage = CIContext().createCGImage(CIImage(color: .black), from: frame)!
        let BlackImage = UIImage(cgImage: cgImage)
        databaseRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            
            DispatchQueue.global(qos: .utility).async {
                let group = DispatchGroup()
                let queue = DispatchQueue.global(qos: .userInteractive)
                let semaphore = DispatchSemaphore(value: 2)
                
                for snap in dataSnapshot.children {
                    
                    group.enter()
                    semaphore.wait()
                    
                    queue.async {
                        var task: URLSessionDataTask
                        var task_Banner: URLSessionDataTask
                        let userSnap = snap as! DataSnapshot
                        let uid = userSnap.key
                        let userDict = userSnap.value as! [String: String]
                        
                        if (userDict["UserIconURL"] != "NULL") {
                            if (userDict["UserBannerURL"] != "NULL") {
                                let url = URL(string: userDict["UserIconURL"]!)
                                
                                task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
                                    guard let data = data, error == nil else {
                                        print("Error trying to download user icon")
                                        return
                                    }
                                    let image_Icon = UIImage(data: data)
                                    
                                    let url_Banner = URL(string: userDict["UserBannerURL"]!)
                                    
                                    let task_Banner = URLSession.shared.dataTask(with: url_Banner!, completionHandler: { (data2, _, error) in
                                        guard let data_2 = data2, error == nil else {
                                            print("Error trying to download user icon")
                                            return
                                        }
                                        
                                        let image_Banner = UIImage(data: data_2)

                                        let ProItem = Pro(image_Icon: image_Icon!, Banner: image_Banner!, name: userDict["UserName"]!, type: userDict["UserType"]!, description: userDict["UserBio"]!, keywords: userDict["Userkeywords"]!)
                                        returnPro.append(ProItem)
                                        semaphore.signal()
                                        group.leave()
                                        })
                                    task_Banner.resume()
                                    })
                                task.resume()
                            } else {
                                let url = URL(string: userDict["UserIconURL"]!)
                                
                                task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
                                    guard let data = data, error == nil else {
                                        print("Error trying to download user icon")
                                        return
                                    }
                                    let image_Icon = UIImage(data: data)
                                    
                                    let url_Banner = URL(string: userDict["UserBannerURL"]!)
                                    let ProItem = Pro(image_Icon: image_Icon!, Banner: BlackImage, name: userDict["UserName"]!, type: userDict["UserType"]!, description: userDict["UserBio"]!, keywords: userDict["Userkeywords"]!)
                                    returnPro.append(ProItem)
                                    semaphore.signal()
                                    group.leave()
                                })
                            }
                        } else {
                            if (userDict["UserBannerURL"] != "NULL") {
                                let url_Banner = URL(string: userDict["UserBannerURL"]!)
                                
                                let task_Banner = URLSession.shared.dataTask(with: url_Banner!, completionHandler: { (data2, _, error) in
                                    guard let data_2 = data2, error == nil else {
                                        print("Error trying to download user icon")
                                        return
                                    }
                                    
                                    let image_Banner = UIImage(data: data_2)
                                    let ProItem = Pro(image_Icon: UIImage(systemName: "person.fill")!, Banner: image_Banner!, name: userDict["UserName"]!, type: userDict["UserType"]!, description: userDict["UserBio"]!, keywords: userDict["Userkeywords"]!)
                                    returnPro.append(ProItem)
                                    semaphore.signal()
                                    group.leave()
                                })
                            } else {
                                let ProItem = Pro(image_Icon: UIImage(systemName: "person.fill")!, Banner: BlackImage, name: userDict["UserName"]!, type: userDict["UserType"]!, description: userDict["UserBio"]!, keywords: userDict["Userkeywords"]!)
                                returnPro.append(ProItem)
                                semaphore.signal()
                                group.leave()
                            }
                        }
                        }
                    }
                group.notify(queue: .main) {
                    completion(returnPro)
                }
            }
        }
    }
    
    func getFilteredUser(type: String, keyword: String, completion: @escaping (_ UserList: [Pro]) -> Void) {
        var FilteredList: [Pro] = []
        print("Type is" + type)
        print("keyword is" + keyword)
        self.getAllUser { (proList) in
            for profiles: Pro in proList {
                if (type != "All") {
                    if (keyword != "Select Type..." && keyword != "All") {
                        if (profiles.type == type && profiles.keywords == keyword) {
                            FilteredList.append(profiles)
                        }
                    } else {
                        if (profiles.type == type) {
                            FilteredList.append(profiles)
                        }
                    }
                } else if (keyword != "Select Type..." && keyword != "All") {
                    if (profiles.keywords == keyword) {
                        FilteredList.append(profiles)
                    }
                } else {
                    FilteredList = proList
                }
            }
            completion(FilteredList)
        }
    }
}


