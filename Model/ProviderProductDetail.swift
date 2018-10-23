

import Foundation

struct ProviderProductDetailRoot : Codable {
    
    let data : ProviderProductDetailData?
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
        data = try values.decodeIfPresent(ProviderProductDetailData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct ProviderProductDetailData : Codable {
    
    let categoryName : String?
    let createdAt : String?
    let isActive : String?
    let isDelete : String?
    let isOffer : Int?
    let mCatId : String?
    let mProductId : String?
    let offerData : ProviderProductDetailOfferData?
    let productDescription : String?
    let productImages : [ProviderMarketProductImage]?
    let productPrice : String?
    let productTitle : String?
    let recommended : String?
    let sku : String?
    let updatedAt : String?
    let vender : String?
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case createdAt = "created_at"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case isOffer = "is_offer"
        case mCatId = "m_cat_id"
        case mProductId = "m_product_id"
        case offerData = "offer_data"
        case productDescription = "product_description"
        case productImages = "product_images"
        case productPrice = "product_price"
        case productTitle = "product_title"
        case recommended = "recommended"
        case sku = "sku"
        case updatedAt = "updated_at"
        case vender = "vender"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        isOffer = try values.decodeIfPresent(Int.self, forKey: .isOffer)
        mCatId = try values.decodeIfPresent(String.self, forKey: .mCatId)
        mProductId = try values.decodeIfPresent(String.self, forKey: .mProductId)
        offerData = try values.decodeIfPresent(ProviderProductDetailOfferData.self, forKey: .offerData)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        productImages = try values.decodeIfPresent([ProviderMarketProductImage].self, forKey: .productImages)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productTitle = try values.decodeIfPresent(String.self, forKey: .productTitle)
        recommended = try values.decodeIfPresent(String.self, forKey: .recommended)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        vender = try values.decodeIfPresent(String.self, forKey: .vender)
    }
}

struct ProviderProductDetailOfferData : Codable {
    
    let categoryId : String?
    let categoryItemId : String?
    let createdAt : String?
    let createdBy : String?
    let descriptionField : String?
    let discount : String?
    let discountType : String?
    let image : String?
    let isActive : String?
    let isDelete : String?
    let offerId : String?
    let referenceId : String?
    let sportId : String?
    let updatedAt : String?
    let validFrom : String?
    let validTo : String?
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case categoryItemId = "category_item_id"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case descriptionField = "description"
        case discount = "discount"
        case discountType = "discount_type"
        case image = "image"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case offerId = "offer_id"
        case referenceId = "reference_id"
        case sportId = "sport_id"
        case updatedAt = "updated_at"
        case validFrom = "valid_from"
        case validTo = "valid_to"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        categoryItemId = try values.decodeIfPresent(String.self, forKey: .categoryItemId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        discountType = try values.decodeIfPresent(String.self, forKey: .discountType)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        offerId = try values.decodeIfPresent(String.self, forKey: .offerId)
        referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
        sportId = try values.decodeIfPresent(String.self, forKey: .sportId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        validFrom = try values.decodeIfPresent(String.self, forKey: .validFrom)
        validTo = try values.decodeIfPresent(String.self, forKey: .validTo)
    }
    
}
