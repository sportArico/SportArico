
//

import Foundation
import Alamofire
import KRProgressHUD

final class NotificationManager {
    
    static let shared: NotificationManager = {
        let instance = NotificationManager()
        return instance
    }()

    //MARK: Get Notification List
    func GetNotificationList(UserId: String = "", completion:@escaping([NotificationData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserId]
        Alamofire.request(Endpoints.NotificationList, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(NotificationRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }

    
    //MARK: Get Provider Notification List
    func GetProviderNotificationList(UserId: String = "", completion:@escaping([ProviderNotificationData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["user_id":UserId]
        Alamofire.request(Endpoints.GetProviderNotification, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responce = try jsonDecoder.decode(ProviderNotificationRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion([nil], error.localizedDescription)
                        }
                    }
                    else{
                        completion([nil], "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion([nil], error.localizedDescription)
            }
        }
    }
    
}

