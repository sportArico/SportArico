
//

import Foundation
import Alamofire
import KRProgressHUD

final class SettingManager {
    
    static let shared: SettingManager = {
        let instance = SettingManager()
        return instance
    }()
    
    
    //Change Notification Status
    func ChangeNotificationStatus(withID UserID: String = "",Status: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"notification_status":Status]
        Alamofire.request(Endpoints.NotificationStatusChange, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["data"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }

    
    //Get Help And Support
    func GetHelpAndSupport(completion:@escaping(NSDictionary?, String?)->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.GetHelpSupportDetails, method: .get, parameters: nil, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(json["data"] as? NSDictionary ?? nil, "")
                    }
                    else{
                        completion(nil, "\(json["data"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
    //Change Password
    func ChangePassword(withID UserID: String = "",Old_Pass: String = "",New_Pass: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserID,"old_password":Old_Pass,"password":New_Pass]
        Alamofire.request(Endpoints.Changepassword, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "\(json["message_en"] as? String ?? "")")
                    }
                    else{
                        completion(false, "\(json["message_en"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
}

