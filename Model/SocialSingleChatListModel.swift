

import Foundation

struct SocialSingleChatListRoot : Codable {
    
    let data : SocialSingleChatListData?
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
        data = try values.decodeIfPresent(SocialSingleChatListData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

//MARK: Use for After Send Message Append Time...
struct SocialSingleMessageSendRoot : Codable {
    
    let data : [SocialSingleChatData]?
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
        data = try values.decodeIfPresent([SocialSingleChatData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
}
//==== End Append here...  ===///å

struct SocialSingleChatListData : Codable {
    
    var chatData : [SocialSingleChatData]?
    let groupDetails : [SocialSingleChatGroupDetail]?
    
    enum CodingKeys: String, CodingKey {
        case chatData = "chat_data"
        case groupDetails = "group_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chatData = try values.decodeIfPresent([SocialSingleChatData].self, forKey: .chatData)
        groupDetails = try values.decodeIfPresent([SocialSingleChatGroupDetail].self, forKey: .groupDetails)
    }
    
}

struct SocialSingleChatGroupDetail : Codable {
    
    let createdAt : String?
    let createdBy : String?
    let descriptionField : String?
    let eventDate : String?
    let eventTime : String?
    let gender : String?
    let groupId : String?
    let groupTitle : String?
    let isActive : String?
    let isDelete : String?
    let latitude : String?
    let location : String?
    let longitude : String?
    let maxSize : String?
    let notifyPlayball : String?
    let price : String?
    let sportId : String?
    let type : String?
    let updatedAt : String?
    let venue : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case createdBy = "created_by"
        case descriptionField = "description"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case gender = "gender"
        case groupId = "group_id"
        case groupTitle = "group_title"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case latitude = "latitude"
        case location = "location"
        case longitude = "longitude"
        case maxSize = "max_size"
        case notifyPlayball = "notify_playball"
        case price = "price"
        case sportId = "sport_id"
        case type = "type"
        case updatedAt = "updated_at"
        case venue = "venue"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        eventDate = try values.decodeIfPresent(String.self, forKey: .eventDate)
        eventTime = try values.decodeIfPresent(String.self, forKey: .eventTime)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        groupId = try values.decodeIfPresent(String.self, forKey: .groupId)
        groupTitle = try values.decodeIfPresent(String.self, forKey: .groupTitle)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        maxSize = try values.decodeIfPresent(String.self, forKey: .maxSize)
        notifyPlayball = try values.decodeIfPresent(String.self, forKey: .notifyPlayball)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        sportId = try values.decodeIfPresent(String.self, forKey: .sportId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        venue = try values.decodeIfPresent(String.self, forKey: .venue)
    }
}

struct SocialSingleChatData : Codable {
    
    let chatText : String?
    let chatTime : String?
    let createdAt : String?
    let groupId : String?
    let isRead : String?
    let receiverData : SocialSingleChatReceiverData?
    let receiverId : String?
    let sendByUser : Int?
    let sptGroupChatId : String?
    let userData : SocialSingleChatUserData?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case chatText = "chat_text"
        case chatTime = "chat_time"
        case createdAt = "created_at"
        case groupId = "group_id"
        case isRead = "is_read"
        case receiverData = "receiver_data"
        case receiverId = "receiver_id"
        case sendByUser = "send_by_user"
        case sptGroupChatId = "spt_group_chat_id"
        case userData = "user_data"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chatText = try values.decodeIfPresent(String.self, forKey: .chatText)
        chatTime = try values.decodeIfPresent(String.self, forKey: .chatTime)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        groupId = try values.decodeIfPresent(String.self, forKey: .groupId)
        isRead = try values.decodeIfPresent(String.self, forKey: .isRead)
        receiverData = try values.decodeIfPresent(SocialSingleChatReceiverData.self, forKey: .receiverData)
        receiverId = try values.decodeIfPresent(String.self, forKey: .receiverId)
        sendByUser = try values.decodeIfPresent(Int.self, forKey: .sendByUser)
        sptGroupChatId = try values.decodeIfPresent(String.self, forKey: .sptGroupChatId)
        userData = try values.decodeIfPresent(SocialSingleChatUserData.self, forKey: .userData)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}

struct SocialSingleChatUserData : Codable {
    
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

struct SocialSingleChatReceiverData : Codable {
    
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
