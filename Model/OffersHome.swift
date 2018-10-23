

import Foundation

struct OffersRoot : Codable {
    
    let data : [OffersData]?
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
        data = try values.decodeIfPresent([OffersData].self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct OffersData : Codable {
    
    let categoryData : [OffersCategoryData]?
    let categoryId : String?
    let categoryItemId : String?
    let createdAt : String?
    let descriptionField : String?
    let discount : String?
    let discountType : String?
    let image : String?
    let isActive : String?
    let isDelete : String?
    let offerId : String?
    let offerTitle : String?
    let updatedAt : String?
    let validTo : String?
    
    var opened: Bool
    
    enum CodingKeys: String, CodingKey {
        case categoryData = "category_data"
        case categoryId = "category_id"
        case categoryItemId = "category_item_id"
        case createdAt = "created_at"
        case descriptionField = "description"
        case discount = "discount"
        case discountType = "discount_type"
        case image = "image"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case offerId = "offer_id"
        case updatedAt = "updated_at"
        case offerTitle = "offer_title"
        case validTo = "valid_to"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryData = try values.decodeIfPresent([OffersCategoryData].self, forKey: .categoryData)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        categoryItemId = try values.decodeIfPresent(String.self, forKey: .categoryItemId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        discountType = try values.decodeIfPresent(String.self, forKey: .discountType)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        offerId = try values.decodeIfPresent(String.self, forKey: .offerId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        offerTitle = try values.decodeIfPresent(String.self, forKey: .offerTitle)
        validTo = try values.decodeIfPresent(String.self, forKey: .validTo)
        opened = false
    }
    
}

struct OffersCategoryData : Codable {
    
    let categoryIcon : String?
    let categoryId : String?
    let categoryImage : String?
    let categoryName : String?
    let categorySlug : String?
    let createdAt : String?
    let isActive : String?
    let isDelete : String?
    let parentCategory : String?
    let updatedAt : String?
    
    
    enum CodingKeys: String, CodingKey {
        case categoryIcon = "category_icon"
        case categoryId = "category_id"
        case categoryImage = "category_image"
        case categoryName = "category_name"
        case categorySlug = "category_slug"
        case createdAt = "created_at"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case parentCategory = "parent_category"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryIcon = try values.decodeIfPresent(String.self, forKey: .categoryIcon)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        categoryImage = try values.decodeIfPresent(String.self, forKey: .categoryImage)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        categorySlug = try values.decodeIfPresent(String.self, forKey: .categorySlug)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        parentCategory = try values.decodeIfPresent(String.self, forKey: .parentCategory)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}
