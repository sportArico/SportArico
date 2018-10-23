

import Foundation
struct TrainingDetailRoot : Codable {
    
    let data : TrainingDetailData?
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
        data = try values.decodeIfPresent(TrainingDetailData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
struct TrainingDetailData : Codable {
    
    var availableTime : [TrainingSportAvailableTimeRoot]?
    let city : String?
    let contactInfo : TrainingSportContactInfo?
    let country : String?
    let courseId : String?
    let courseTitle : String?
    let coverPhoto : String?
    let createdAt : String?
    let createdBy : String?
    let distance : Float?
    let icon : String?
    let includePlacePrice : String?
    let isAcademy : String?
    let isActive : String?
    let isDelete : String?
    let isRecommended : String?
    let latitude : String?
    let location : String?
    let longitude : String?
    let packages : [TrainingSportPackage]?
    let sportToolsPrice : String?
    let sports : [TrainingSportDetail]?
    let termsAndCondition : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case availableTime = "available_time"
        case city = "city"
        case contactInfo = "contact_info"
        case country = "country"
        case courseId = "course_id"
        case courseTitle = "course_title"
        case coverPhoto = "cover_photo"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case distance = "distance"
        case icon = "icon"
        case includePlacePrice = "include_place_price"
        case isAcademy = "is_academy"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isRecommended = "is_recommended"
        case latitude = "latitude"
        case location = "location"
        case longitude = "longitude"
        case packages = "packages"
        case sportToolsPrice = "sport_tools_price"
        case sports = "sports"
        case termsAndCondition = "terms_and_condition"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        availableTime = try values.decodeIfPresent([TrainingSportAvailableTimeRoot].self, forKey: .availableTime)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        contactInfo = try values.decodeIfPresent(TrainingSportContactInfo.self, forKey: .contactInfo)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        courseId = try values.decodeIfPresent(String.self, forKey: .courseId)
        courseTitle = try values.decodeIfPresent(String.self, forKey: .courseTitle)
        coverPhoto = try values.decodeIfPresent(String.self, forKey: .coverPhoto)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        distance = try values.decodeIfPresent(Float.self, forKey: .distance)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        includePlacePrice = try values.decodeIfPresent(String.self, forKey: .includePlacePrice)
        isAcademy = try values.decodeIfPresent(String.self, forKey: .isAcademy)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isRecommended = try values.decodeIfPresent(String.self, forKey: .isRecommended)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        packages = try values.decodeIfPresent([TrainingSportPackage].self, forKey: .packages)
        sportToolsPrice = try values.decodeIfPresent(String.self, forKey: .sportToolsPrice)
        sports = try values.decodeIfPresent([TrainingSportDetail].self, forKey: .sports)
        termsAndCondition = try values.decodeIfPresent(String.self, forKey: .termsAndCondition)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct TrainingSportDetail : Codable {
    
    let createdAt : String?
    let isActive : String?
    let isDelete : String?
    let sportId : String?
    let sportImage : String?
    let sportName : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case sportId = "sport_id"
        case sportImage = "sport_image"
        case sportName = "sport_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        sportId = try values.decodeIfPresent(String.self, forKey: .sportId)
        sportImage = try values.decodeIfPresent(String.self, forKey: .sportImage)
        sportName = try values.decodeIfPresent(String.self, forKey: .sportName)
    }
    
}

struct TrainingSportPackage : Codable {
    
    let courtId : String?
    let courtPackageId : String?
    let createdAt : String?
    let isActive : String?
    let packageName : String?
    let price : String?
    
    enum CodingKeys: String, CodingKey {
        case courtId = "court_id"
        case courtPackageId = "court_package_id"
        case createdAt = "created_at"
        case isActive = "is_active"
        case packageName = "package_name"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        courtId = try values.decodeIfPresent(String.self, forKey: .courtId)
        courtPackageId = try values.decodeIfPresent(String.self, forKey: .courtPackageId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        packageName = try values.decodeIfPresent(String.self, forKey: .packageName)
        price = try values.decodeIfPresent(String.self, forKey: .price)
    }
    
}

struct TrainingSportContactInfo : Codable {
    
    let accountType : String?
    let age : String?
    let contactInfoId : String?
    let courseId : String?
    let gender : String?
    let mobile : String?
    
    enum CodingKeys: String, CodingKey {
        case accountType = "account_type"
        case age = "age"
        case contactInfoId = "contact_info_id"
        case courseId = "course_id"
        case gender = "gender"
        case mobile = "mobile"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        contactInfoId = try values.decodeIfPresent(String.self, forKey: .contactInfoId)
        courseId = try values.decodeIfPresent(String.self, forKey: .courseId)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
    }
    
}

struct TrainingSportAvailableTimeRoot : Codable {
    
    var availableTime : [TrainingSportAvailableTime]?
    let bookAvailDate : String?
    var isDayselect : Bool
    
    enum CodingKeys: String, CodingKey {
        case availableTime = "available_time"
        case bookAvailDate = "book_avail_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        availableTime = try values.decodeIfPresent([TrainingSportAvailableTime].self, forKey: .availableTime)
        bookAvailDate = try values.decodeIfPresent(String.self, forKey: .bookAvailDate)
        isDayselect = false
    }
    
}

struct TrainingSportAvailableTime : Codable {
    
    let bookAvailDate : String?
    let bookAvailId : String?
    let bookAvailTime : String?
    let createdAt : String?
    let isAvailable : Int?
    let referenceId : String?
    let type : String?
    let updatedAt : String?
    var isDayselect: Bool
    var isTimeselect: Bool
    
    enum CodingKeys: String, CodingKey {
        case bookAvailDate = "book_avail_date"
        case bookAvailId = "book_avail_id"
        case bookAvailTime = "book_avail_time"
        case createdAt = "created_at"
        case isAvailable = "is_available"
        case referenceId = "reference_id"
        case type = "type"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookAvailDate = try values.decodeIfPresent(String.self, forKey: .bookAvailDate)
        bookAvailId = try values.decodeIfPresent(String.self, forKey: .bookAvailId)
        bookAvailTime = try values.decodeIfPresent(String.self, forKey: .bookAvailTime)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isAvailable = try values.decodeIfPresent(Int.self, forKey: .isAvailable)
        referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        isDayselect = false
        isTimeselect = false
    }
    
}
