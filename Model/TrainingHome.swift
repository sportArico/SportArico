

import Foundation

struct TrainingHomeRoot : Codable {
    
    let data : [TrainingHomeData]?
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
        data = try values.decodeIfPresent([TrainingHomeData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct TrainingHomeData : Codable {
    
    let city : String?
    let country : String?
    let courseId : String?
    let courseTitle : String?
    let coverPhoto : String?
    let createdAt : String?
    let createdBy : String?
    let distance : Float?
    let descriptionField : String?
    let facilities : String?
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
    let sportToolsPrice : String?
    let sports : [TrainingHomeSport]?
    let termsAndCondition : String?
    let updatedAt : String?
 
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case country = "country"
        case courseId = "course_id"
        case courseTitle = "course_title"
        case coverPhoto = "cover_photo"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case distance = "distance"
        case descriptionField = "description"
        case facilities = "facilities"
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
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        courseId = try values.decodeIfPresent(String.self, forKey: .courseId)
        courseTitle = try values.decodeIfPresent(String.self, forKey: .courseTitle)
        coverPhoto = try values.decodeIfPresent(String.self, forKey: .coverPhoto)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        distance = try values.decodeIfPresent(Float.self, forKey: .distance)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        facilities = try values.decodeIfPresent(String.self, forKey: .facilities)
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
        sportToolsPrice = try values.decodeIfPresent(String.self, forKey: .sportToolsPrice)
        sports = try values.decodeIfPresent([TrainingHomeSport].self, forKey: .sports)
        termsAndCondition = try values.decodeIfPresent(String.self, forKey: .termsAndCondition)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct TrainingHomeSport : Codable {
    
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
