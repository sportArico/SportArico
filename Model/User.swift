

import Foundation

struct User: Codable {
    var user_id : String
    var email : String
    var phone : String
    var role_id : String
    var role_name : String
    var category_id : String
    var profile_image : String
    var fcm_token : String
    var provider_categories : String
    var course_count : String
    var court_count : String
    var market_product_count : String
    var offer_count : String
}

struct UserProfileRoot : Codable {
    
    let data : UserProfileData?
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
        data = try values.decodeIfPresent(UserProfileData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct UserProfileData : Codable {
    
    let basicInfo : UserProfileBasicInfo?
    let categoryId : String?
    let countryCode : String?
    let createdAt : String?
    let email : String?
    let fbId : String?
    let fcmToken : String?
    let isActive : String?
    let isDelete : String?
    let isEmailVerified : String?
    let isPhoneVerified : String?
    let loginType : String?
    let notificationStatus : String?
    let phone : String?
    let updatedAt : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case basicInfo = "basic_info"
        case categoryId = "category_id"
        case countryCode = "country_code"
        case createdAt = "created_at"
        case email = "email"
        case fbId = "fb_id"
        case fcmToken = "fcm_token"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isEmailVerified = "is_email_verified"
        case isPhoneVerified = "is_phone_verified"
        case loginType = "login_type"
        case notificationStatus = "notification_status"
        case phone = "phone"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        basicInfo = try values.decodeIfPresent(UserProfileBasicInfo.self, forKey: .basicInfo)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fbId = try values.decodeIfPresent(String.self, forKey: .fbId)
        fcmToken = try values.decodeIfPresent(String.self, forKey: .fcmToken)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isEmailVerified = try values.decodeIfPresent(String.self, forKey: .isEmailVerified)
        isPhoneVerified = try values.decodeIfPresent(String.self, forKey: .isPhoneVerified)
        loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
        notificationStatus = try values.decodeIfPresent(String.self, forKey: .notificationStatus)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}

struct UserProfileBasicInfo : Codable {
    
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
