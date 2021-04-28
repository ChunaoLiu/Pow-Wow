import FirebaseAuth
import UIKit

class FirebaseAuthManager {

    func login(credential: AuthCredential, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(with: credential, completion: { (firebaseUser, error) in
            print(firebaseUser)
            user = Auth.auth().currentUser
            completionBlock(error == nil)
        })
    }

    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ userid: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true, String(user.uid))
            } else {
                completionBlock(false, "NULL")
            }
        }
    }

    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                print(result)
                completionBlock(true)
            }
        }
    }
    
    func signOut(completionBlock: @escaping (_ success: Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            user = nil
            completionBlock(true)
            print("Signing out")
        } catch {
            completionBlock(false)
        }
    }
}
