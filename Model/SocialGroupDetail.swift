

import Foundation

struct SocialGroupDetailRoot : Codable {
    
    let data : [SocialGroupDetailData]?
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
        data = try values.decodeIfPresent([SocialGroupDetailData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct SocialGroupDetailData : Codable {
    
    let createdAt : String?
    let createdBy : SocialGroupDetailCreatedBy?
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
    let memberCount : Int?
    let memberList : [SocialGroupDetailMemberList]?
    let price : String?
    let sportId : String?
    let type : String?
    let updatedAt : String?
    let userInfo : SocialGroupDetailUserInfo?
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
        case memberCount = "member_count"
        case memberList = "member_list"
        case price = "price"
        case sportId = "sport_id"
        case type = "type"
        case updatedAt = "updated_at"
        case userInfo = "user_info"
        case venue = "venue"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(SocialGroupDetailCreatedBy.self, forKey: .createdBy)
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
        memberCount = try values.decodeIfPresent(Int.self, forKey: .memberCount)
        memberList = try values.decodeIfPresent([SocialGroupDetailMemberList].self, forKey: .memberList)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        sportId = try values.decodeIfPresent(String.self, forKey: .sportId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userInfo = try values.decodeIfPresent(SocialGroupDetailUserInfo.self, forKey: .userInfo)
        venue = try values.decodeIfPresent(String.self, forKey: .venue)
    }
    
}

struct SocialGroupDetailUserInfo : Codable {
    
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
struct SocialGroupDetailMemberList : Codable {
    
    let about : String?
    let code : String?
    let countryCode : String?
    let createdAt : String?
    let email : String?
    let fbId : String?
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
    let isPhoneVerified : String?
    let lastName : String?
    let latitude : String?
    let loginType : String?
    let longitude : String?
    let phone : String?
    let profileImage : String?
    let status : String?
    let updatedAt : String?
    let userId : String?
    let usersInfoId : String?
    
    enum CodingKeys: String, CodingKey {
        case about = "about"
        case code = "code"
        case countryCode = "country_code"
        case createdAt = "created_at"
        case email = "email"
        case fbId = "fb_id"
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
        case isPhoneVerified = "is_phone_verified"
        case lastName = "last_name"
        case latitude = "latitude"
        case loginType = "login_type"
        case longitude = "longitude"
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
        code = try values.decodeIfPresent(String.self, forKey: .code)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fbId = try values.decodeIfPresent(String.self, forKey: .fbId)
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
        isPhoneVerified = try values.decodeIfPresent(String.self, forKey: .isPhoneVerified)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        usersInfoId = try values.decodeIfPresent(String.self, forKey: .usersInfoId)
    }
    
}
struct SocialGroupDetailCreatedBy : Codable {
    
    let countryCode : String?
    let createdAt : String?
    let email : String?
    let fbId : String?
    let forgotCode : String?
    let isActive : String?
    let isDelete : String?
    let isEmailVerified : String?
    let isPhoneVerified : String?
    let loginType : String?
    let phone : String?
    let updatedAt : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case createdAt = "created_at"
        case email = "email"
        case fbId = "fb_id"
        case forgotCode = "forgot_code"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isEmailVerified = "is_email_verified"
        case isPhoneVerified = "is_phone_verified"
        case loginType = "login_type"
        case phone = "phone"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fbId = try values.decodeIfPresent(String.self, forKey: .fbId)
        forgotCode = try values.decodeIfPresent(String.self, forKey: .forgotCode)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isEmailVerified = try values.decodeIfPresent(String.self, forKey: .isEmailVerified)
        isPhoneVerified = try values.decodeIfPresent(String.self, forKey: .isPhoneVerified)
        loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}
