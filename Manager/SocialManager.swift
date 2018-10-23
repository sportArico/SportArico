
//

import Foundation
import Alamofire
import KRProgressHUD

final class SocialManager {
    
    static let shared: SocialManager = {
        let instance = SocialManager()
        return instance
    }()
    
    //MARK: Get Social Group List
    func GetSocialGroupList(Param:[String:String], completion:@escaping(SocialGroupData?, String?)->()) {
        KRProgressHUD.show()
        //let param:[String:String] = ["user_id":UserId]
        print(Param)
        Alamofire.request(Endpoints.GetGroupList, method: .post, parameters: Param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(SocialGroupRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(nil, error.localizedDescription)
                        }
                    }
                    else{
                        completion(nil, "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: Get Social Group Detail
    func GetTrainingDetail(Group_id: String = "", completion:@escaping([SocialGroupDetailData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["group_id":Group_id]
        Alamofire.request(Endpoints.GetGroupDetails, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(SocialGroupDetailRoot.self, from: data!)
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
    
    //MARK: Join Group
    func JoinGroup(Group_id: String = "", user_id: String = "", completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["group_id":Group_id,"user_id":user_id]
        Alamofire.request(Endpoints.JoinGroup, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "Successfully joined this group")
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
    
    //MARK: Create Group
    func CreateGroup(param:[String:String] = [:], completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        Alamofire.request(Endpoints.CreateGroup, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "Successfully create this group")
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
    
    
    //MARK: Get Social Group Chat List
    func GetGroupChatList(User_Id: String = "",Group_id: String = "", completion:@escaping([SocialGroupChatData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["group_id":Group_id,"user_id":User_Id]
        Alamofire.request(Endpoints.GetGroupChat, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(SocialGroupChatRoot.self, from: data!)
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
    
    //MARK: Insert Group Chat
    func InsertGroupChat(User_id: String?,Group_id: String?,Chat_Text:String?, completion:@escaping(Bool, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["group_id":Group_id!,"user_id":User_id!,"chat_text":Chat_Text!]
        Alamofire.request(Endpoints.InsertGroupChat, method: .post, parameters: param, headers: nil).responseJSON { response in
            KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "Successfully insert chat")
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

    //MARK: Get Social Single Chat List
    func GetSingleChatList(User_Id: String = "",Group_id: String = "",Receiver_id: String, completion:@escaping(SocialSingleChatListData?, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["group_id":Group_id,"user_id":User_Id,"receiver_id":Receiver_id]
        print(param)
        Alamofire.request(Endpoints.Get_Personal_Chat, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(SocialSingleChatListRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(nil, error.localizedDescription)
                        }
                    }
                    else{
                        completion(nil, "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: Insert Single Message Chat
    func InsertSingleChatMSG(User_id: String?,Group_id: String?,Chat_Text:String?,Receiver_id : String?, completion:@escaping([SocialSingleChatData?], String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["group_id":Group_id!,"user_id":User_id!,"chat_text":Chat_Text!,"receiver_id":Receiver_id!]
        print(param)
        Alamofire.request(Endpoints.InsertPersonalChat, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(SocialSingleMessageSendRoot.self, from: data!)
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
    
    //MARK: Get Group Member List
    func GetGroupMemberList(User_Id: String = "",Group_id: String = "", completion:@escaping(SocialUserListData?, String?)->()) {
        KRProgressHUD.show()
        let param:[String:String] = ["group_id":Group_id,"user_id":User_Id]
        Alamofire.request(Endpoints.Get_Group_Member_List, method: .post, parameters: param, headers: nil).responseJSON { response in
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
                            let responce = try jsonDecoder.decode(SocialUserListRoot.self, from: data!)
                            completion(responce.data!, "")
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(nil, error.localizedDescription)
                        }
                    }
                    else{
                        completion(nil, "\(json["response"] as? String ?? "")")
                    }
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: Chat Read Status Change
    func ChatReadStatusChange(With URL: String?, completion:@escaping(Bool, String?)->()) {
        //KRProgressHUD.show()
        //let param:[String:String] = ["group_id":Group_id!,"user_id":User_id!,"chat_text":Chat_Text!]
        print(Endpoints.ChangeChatReadStatus + URL!)
        Alamofire.request(Endpoints.ChangeChatReadStatus + URL!, method: .get, parameters: nil, headers: nil).responseJSON { response in
            //KRProgressHUD.dismiss()
            switch(response.result) {
            case .success:
                if let json = response.result.value as? [String : Any] {
                    print(json)
                    if (json["status"] as? Bool) == true {
                        completion(true, "Successfully insert chat")
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
    
}
