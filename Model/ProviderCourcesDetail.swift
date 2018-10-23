

import Foundation

struct ProviderCourcesDetailRoot : Codable {
    
    let data : [ProviderCourcesDetailData]?
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
        data = try values.decodeIfPresent([ProviderCourcesDetailData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct ProviderCourcesDetailData : Codable {
    
    let city : String?
    let contactInfo : ContactInfo?
    let country : String?
    let courseId : String?
    let courseTitle : String?
    let coverPhoto : String?
    let createdAt : String?
    let createdBy : String?
    let descriptionField : String?
    let Facilities_id : String?
    let icon : String?
    let includePlacePrice : String?
    let isAcademy : String?
    let isActive : String?
    let isDelete : String?
    let isRecommended : String?
    let latitude : String?
    let location : String?
    let longitude : String?
    let packages : String?
    let sportDetails : [SportCategoryData]?
    let sportToolsPrice : String?
    let sports : String?
    let termsAndCondition : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case contactInfo = "contact_info"
        case country = "country"
        case courseId = "course_id"
        case courseTitle = "course_title"
        case coverPhoto = "cover_photo"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case descriptionField = "description"
        case Facilities_id = "facilities_id"
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
        case sportDetails = "sport_details"
        case sportToolsPrice = "sport_tools_price"
        case sports = "sports"
        case termsAndCondition = "terms_and_condition"
        case updatedAt = "updated_at"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        contactInfo = try values.decodeIfPresent(ContactInfo.self, forKey: .contactInfo)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        courseId = try values.decodeIfPresent(String.self, forKey: .courseId)
        courseTitle = try values.decodeIfPresent(String.self, forKey: .courseTitle)
        coverPhoto = try values.decodeIfPresent(String.self, forKey: .coverPhoto)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        Facilities_id = try values.decodeIfPresent(String.self, forKey: .Facilities_id)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        includePlacePrice = try values.decodeIfPresent(String.self, forKey: .includePlacePrice)
        isAcademy = try values.decodeIfPresent(String.self, forKey: .isAcademy)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isRecommended = try values.decodeIfPresent(String.self, forKey: .isRecommended)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        packages = try values.decodeIfPresent(String.self, forKey: .packages)
        sportDetails = try values.decodeIfPresent([SportCategoryData].self, forKey: .sportDetails)
        sportToolsPrice = try values.decodeIfPresent(String.self, forKey: .sportToolsPrice)
        sports = try values.decodeIfPresent(String.self, forKey: .sports)
        termsAndCondition = try values.decodeIfPresent(String.self, forKey: .termsAndCondition)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct ContactInfo : Codable {
    
    let accountType : String?
    let age : String?
    let contactInfoId : String?
    let courseId : String?
    let gender : String?
    let mobile : String?
    let nationality : String?
    
    enum CodingKeys: String, CodingKey {
        case accountType = "account_type"
        case age = "age"
        case contactInfoId = "contact_info_id"
        case courseId = "course_id"
        case gender = "gender"
        case mobile = "mobile"
        case nationality = "nationality"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        contactInfoId = try values.decodeIfPresent(String.self, forKey: .contactInfoId)
        courseId = try values.decodeIfPresent(String.self, forKey: .courseId)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
    }
    
}
