

import Foundation

struct SocialGroupChatRoot : Codable {
    
    let data : [SocialGroupChatData]?
    let messageAr : String?
    let messageEn : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case messageAr = "message_ar"
        case messageEn = "message_en"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([SocialGroupChatData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct SocialGroupChatData : Codable {
    
    let chatText : String?
    let createdAt : String?
    let chatTime : String?
    let groupId : String?
    let sendByUser : Int?
    let sptGroupChatId : String?
    let userId : String?
    let userInfo : SocialGroupChatUserInfo?
    
    enum CodingKeys: String, CodingKey {
        case chatText = "chat_text"
        case createdAt = "created_at"
        case chatTime = "chat_time"
        case groupId = "group_id"
        case sendByUser = "send_by_user"
        case sptGroupChatId = "spt_group_chat_id"
        case userId = "user_id"
        case userInfo = "user_info"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chatText = try values.decodeIfPresent(String.self, forKey: .chatText)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        chatTime = try values.decodeIfPresent(String.self, forKey: .chatTime)
        groupId = try values.decodeIfPresent(String.self, forKey: .groupId)
        sendByUser = try values.decodeIfPresent(Int.self, forKey: .sendByUser)
        sptGroupChatId = try values.decodeIfPresent(String.self, forKey: .sptGroupChatId)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        userInfo = try values.decodeIfPresent(SocialGroupChatUserInfo.self, forKey: .userInfo)
    }
    
}

struct SocialGroupChatUserInfo : Codable {
    
    let about : String?
    let firstName : String?
    let fullName : String?
    let gender : String?
    let handicapped : String?
    let lastName : String?
    let latitude : String?
    let longitude : String?
    let profileImage : String?
    let userId : String?
    let usersInfoId : String?
    
    enum CodingKeys: String, CodingKey {
        case about = "about"
        case firstName = "first_name"
        case fullName = "full_name"
        case gender = "gender"
        case handicapped = "handicapped"
        case lastName = "last_name"
        case latitude = "latitude"
        case longitude = "longitude"
        case profileImage = "profile_image"
        case userId = "user_id"
        case usersInfoId = "users_info_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        about = try values.decodeIfPresent(String.self, forKey: .about)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        handicapped = try values.decodeIfPresent(String.self, forKey: .handicapped)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        usersInfoId = try values.decodeIfPresent(String.self, forKey: .usersInfoId)
    }
    
}
