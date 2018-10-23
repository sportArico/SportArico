

import Foundation

struct CourtRatingListRoot : Codable {
    
    let data : [CourtRatingListData]?
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
        data = try values.decodeIfPresent([CourtRatingListData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
struct CourtRatingListData : Codable {
    
    let courseId : String?
    let courseRatingId : String?
    let courtId : String?
    let courtRatingId : String?
    let createdAt : String?
    let images : [String]?
    let place : String?
    let profileImage : String?
    let rating : String?
    let recommend : String?
    let review : String?
    let service : String?
    let timeAgo : String?
    let userId : String?
    let userName : String?
    
    enum CodingKeys: String, CodingKey {
        case courseId = "course_id"
        case courseRatingId = "course_rating_id"
        case courtId = "court_id"
        case courtRatingId = "court_rating_id"
        case createdAt = "created_at"
        case images = "images"
        case place = "place"
        case profileImage = "profile_image"
        case rating = "rating"
        case recommend = "recommend"
        case review = "review"
        case service = "service"
        case timeAgo = "time_ago"
        case userId = "user_id"
        case userName = "user_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        courseId = try values.decodeIfPresent(String.self, forKey: .courseId)
        courseRatingId = try values.decodeIfPresent(String.self, forKey: .courseRatingId)
        courtId = try values.decodeIfPresent(String.self, forKey: .courtId)
        courtRatingId = try values.decodeIfPresent(String.self, forKey: .courtRatingId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        place = try values.decodeIfPresent(String.self, forKey: .place)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        recommend = try values.decodeIfPresent(String.self, forKey: .recommend)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        service = try values.decodeIfPresent(String.self, forKey: .service)
        timeAgo = try values.decodeIfPresent(String.self, forKey: .timeAgo)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }
    
}
