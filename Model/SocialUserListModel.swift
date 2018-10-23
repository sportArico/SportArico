
import Foundation

struct SocialUserListRoot : Codable {
    
    let data : SocialUserListData?
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
        data = try values.decodeIfPresent(SocialUserListData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct SocialUserListData : Codable {
    
    let groupDetails : [SocialUserListGroupDetail]?
    var members : [SocialUserListMember]?
    
    enum CodingKeys: String, CodingKey {
        case groupDetails = "group_details"
        case members = "members"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        groupDetails = try values.decodeIfPresent([SocialUserListGroupDetail].self, forKey: .groupDetails)
        members = try values.decodeIfPresent([SocialUserListMember].self, forKey: .members)
    }
    
}

struct SocialUserListMember : Codable {
    
    let about : String?
    let categoryId : String?
    let code : String?
    let countryCode : String?
    let createdAt : String?
    var dataObj : DataObj?
    let email : String?
    let fbId : String?
    let fcmToken : String?
    let firstName : String?
    let forgotCode : String?
    let fullName : String?
    let gender : String?
    let groupId : String?
    let handicapped : String?
    let iD : String?
    let isActive : String?
    let isDelete : String?
    let isEmailVerified : String?
    let isOnline : Int?
    let isPhoneVerified : String?
    let lastName : String?
    let latitude : String?
    let loginFrom : String?
    let loginType : String?
    let longitude : String?
    let notificationStatus : String?
    let phone : String?
    let profileImage : String?
    let status : String?
    let updatedAt : String?
    let userId : String?
    let usersInfoId : String?
    
    enum CodingKeys: String, CodingKey {
        case about = "about"
        case categoryId = "category_id"
        case code = "code"
        case countryCode = "country_code"
        case createdAt = "created_at"
        case dataObj = "data_obj"
        case email = "email"
        case fbId = "fb_id"
        case fcmToken = "fcm_token"
        case firstName = "first_name"
        case forgotCode = "forgot_code"
        case fullName = "full_name"
        case gender = "gender"
        case groupId = "group_id"
        case handicapped = "handicapped"
        case iD = "ID"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isEmailVerified = "is_email_verified"
        case isOnline = "is_online"
        case isPhoneVerified = "is_phone_verified"
        case lastName = "last_name"
        case latitude = "latitude"
        case loginFrom = "login_from"
        case loginType = "login_type"
        case longitude = "longitude"
        case notificationStatus = "notification_status"
        case phone = "phone"
        case profileImage = "profile_image"
        case status = "status"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case usersInfoId = "users_info_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        about = try values.decodeIfPresent(String.self, forKey: .about)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        dataObj = try values.decodeIfPresent(DataObj.self, forKey: .dataObj)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fbId = try values.decodeIfPresent(String.self, forKey: .fbId)
        fcmToken = try values.decodeIfPresent(String.self, forKey: .fcmToken)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        forgotCode = try values.decodeIfPresent(String.self, forKey: .forgotCode)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        groupId = try values.decodeIfPresent(String.self, forKey: .groupId)
        handicapped = try values.decodeIfPresent(String.self, forKey: .handicapped)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isEmailVerified = try values.decodeIfPresent(String.self, forKey: .isEmailVerified)
        isOnline = try values.decodeIfPresent(Int.self, forKey: .isOnline)
        isPhoneVerified = try values.decodeIfPresent(String.self, forKey: .isPhoneVerified)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        loginFrom = try values.decodeIfPresent(String.self, forKey: .loginFrom)
        loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        notificationStatus = try values.decodeIfPresent(String.self, forKey: .notificationStatus)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        usersInfoId = try values.decodeIfPresent(String.self, forKey: .usersInfoId)
    }
    
}
struct SocialUserListGroupDetail : Codable {
    
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
struct DataObj : Codable {
    
    var chatCount : String?
    let chatText : String?
    let chatTime : String?
    let createdAt : String?
    let groupId : String?
    let isRead : String?
    let receiverId : String?
    let sendByUser : Int?
    let sptGroupChatId : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case chatCount = "chat_count"
        case chatText = "chat_text"
        case chatTime = "chat_time"
        case createdAt = "created_at"
        case groupId = "group_id"
        case isRead = "is_read"
        case receiverId = "receiver_id"
        case sendByUser = "send_by_user"
        case sptGroupChatId = "spt_group_chat_id"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        chatCount = try values.decodeIfPresent(String.self, forKey: .chatCount)
        chatText = try values.decodeIfPresent(String.self, forKey: .chatText)
        chatTime = try values.decodeIfPresent(String.self, forKey: .chatTime)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        groupId = try values.decodeIfPresent(String.self, forKey: .groupId)
        isRead = try values.decodeIfPresent(String.self, forKey: .isRead)
        receiverId = try values.decodeIfPresent(String.self, forKey: .receiverId)
        sendByUser = try values.decodeIfPresent(Int.self, forKey: .sendByUser)
        sptGroupChatId = try values.decodeIfPresent(String.self, forKey: .sptGroupChatId)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}
