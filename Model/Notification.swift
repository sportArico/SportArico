

import Foundation

//==== MARK: User Notification Model ===//
struct NotificationRoot : Codable {
    
    let data : [NotificationData]?
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
        data = try values.decodeIfPresent([NotificationData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct NotificationData : Codable {
    
    let about : String?
    let createdAt : String?
    let firstName : String?
    let fullName : String?
    let gender : String?
    let handicapped : String?
    let isDelete : String?
    let isRead : String?
    let lastName : String?
    let latitude : String?
    let longitude : String?
    let notificationDescription : String?
    let notificationId : String?
    let notificationTitle : String?
    let notificationType : String?
    let profileImage : String?
    let timeAgo : String?
    let userId : String?
    let usersInfoId : String?
    
    enum CodingKeys: String, CodingKey {
        case about = "about"
        case createdAt = "created_at"
        case firstName = "first_name"
        case fullName = "full_name"
        case gender = "gender"
        case handicapped = "handicapped"
        case isDelete = "is_delete"
        case isRead = "is_read"
        case lastName = "last_name"
        case latitude = "latitude"
        case longitude = "longitude"
        case notificationDescription = "notification_description"
        case notificationId = "notification_id"
        case notificationTitle = "notification_title"
        case notificationType = "notification_type"
        case profileImage = "profile_image"
        case timeAgo = "time_ago"
        case userId = "user_id"
        case usersInfoId = "users_info_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        about = try values.decodeIfPresent(String.self, forKey: .about)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        handicapped = try values.decodeIfPresent(String.self, forKey: .handicapped)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isRead = try values.decodeIfPresent(String.self, forKey: .isRead)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        notificationDescription = try values.decodeIfPresent(String.self, forKey: .notificationDescription)
        notificationId = try values.decodeIfPresent(String.self, forKey: .notificationId)
        notificationTitle = try values.decodeIfPresent(String.self, forKey: .notificationTitle)
        notificationType = try values.decodeIfPresent(String.self, forKey: .notificationType)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        timeAgo = try values.decodeIfPresent(String.self, forKey: .timeAgo)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        usersInfoId = try values.decodeIfPresent(String.self, forKey: .usersInfoId)
    }
    
}
//==== End User Notification ====//

//=== Provider Notification List ===//
struct ProviderNotificationRoot : Codable {
    
    let data : [ProviderNotificationData]?
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
        data = try values.decodeIfPresent([ProviderNotificationData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
struct ProviderNotificationData : Codable {
    
    let createdAt : String?
    let isDelete : String?
    let isRead : String?
    let notificationDescription : String?
    let notificationId : String?
    let notificationTitle : String?
    let notificationType : String?
    let referenceId : String?
    let timeAgo : String?
    let userId : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case isDelete = "is_delete"
        case isRead = "is_read"
        case notificationDescription = "notification_description"
        case notificationId = "notification_id"
        case notificationTitle = "notification_title"
        case notificationType = "notification_type"
        case referenceId = "reference_id"
        case timeAgo = "time_ago"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isRead = try values.decodeIfPresent(String.self, forKey: .isRead)
        notificationDescription = try values.decodeIfPresent(String.self, forKey: .notificationDescription)
        notificationId = try values.decodeIfPresent(String.self, forKey: .notificationId)
        notificationTitle = try values.decodeIfPresent(String.self, forKey: .notificationTitle)
        notificationType = try values.decodeIfPresent(String.self, forKey: .notificationType)
        referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
        timeAgo = try values.decodeIfPresent(String.self, forKey: .timeAgo)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
    
}
//==== End Provider Notification ====//
