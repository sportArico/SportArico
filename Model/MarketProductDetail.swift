

import Foundation

struct MarketProductDetailRoot : Codable {
    
    let data : MarketProductDetailData?
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
        data = try values.decodeIfPresent(MarketProductDetailData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

struct MarketProductDetailData : Codable {
    
    let createdAt : String?
    let isActive : String?
    let isBookmark : Int?
    let isDelete : String?
    let mCatId : String?
    let mProductId : String?
    let productDescription : String?
    let productImages : [ProductImageDetail]?
    let productPrice : String?
    let productTitle : String?
    let providerInfo : [ProductProviderInfo]?
    let providerNumber : String?
    let recommended : String?
    let relatedProduct : [RelatedProductDetail]?
    let rating : String?
    let sku : String?
    let updatedAt : String?
    let vender : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case isActive = "is_active"
        case isBookmark = "is_bookmark"
        case isDelete = "is_delete"
        case mCatId = "m_cat_id"
        case mProductId = "m_product_id"
        case productDescription = "product_description"
        case productImages = "product_images"
        case productPrice = "product_price"
        case productTitle = "product_title"
        case providerInfo = "provider_info"
        case providerNumber = "provider_number"
        case recommended = "recommended"
        case relatedProduct = "related_product"
        case rating = "rating"
        case sku = "sku"
        case updatedAt = "updated_at"
        case vender = "vender"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isBookmark = try values.decodeIfPresent(Int.self, forKey: .isBookmark)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        mCatId = try values.decodeIfPresent(String.self, forKey: .mCatId)
        mProductId = try values.decodeIfPresent(String.self, forKey: .mProductId)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        productImages = try values.decodeIfPresent([ProductImageDetail].self, forKey: .productImages)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productTitle = try values.decodeIfPresent(String.self, forKey: .productTitle)
        providerInfo = try values.decodeIfPresent([ProductProviderInfo].self, forKey: .providerInfo)
        providerNumber = try values.decodeIfPresent(String.self, forKey: .providerNumber)
        recommended = try values.decodeIfPresent(String.self, forKey: .recommended)
        relatedProduct = try values.decodeIfPresent([RelatedProductDetail].self, forKey: .relatedProduct)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        vender = try values.decodeIfPresent(String.self, forKey: .vender)
    }
    
}

struct RelatedProductDetail : Codable {
    
    let createdAt : String?
    let isActive : String?
    let isDelete : String?
    let mCatId : String?
    let mProductId : String?
    let productDescription : String?
    let productImages : [ProductImageDetail]?
    let productPrice : String?
    let productTitle : String?
    let recommended : String?
    let sku : String?
    let updatedAt : String?
    let vender : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case isActive = "is_active"
        case isDelete = "is_delete"
        case mCatId = "m_cat_id"
        case mProductId = "m_product_id"
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
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        isDelete = try values.decodeIfPresent(String.self, forKey: .isDelete)
        mCatId = try values.decodeIfPresent(String.self, forKey: .mCatId)
        mProductId = try values.decodeIfPresent(String.self, forKey: .mProductId)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        productImages = try values.decodeIfPresent([ProductImageDetail].self, forKey: .productImages)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productTitle = try values.decodeIfPresent(String.self, forKey: .productTitle)
        recommended = try values.decodeIfPresent(String.self, forKey: .recommended)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        vender = try values.decodeIfPresent(String.self, forKey: .vender)
    }
    
}

struct ProductImageDetail : Codable {
    
    let createdAt : String?
    let image : String?
    let isActive : String?
    let marketProductId : String?
    let marketProductMetaId : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case image = "image"
        case isActive = "is_active"
        case marketProductId = "market_product_id"
        case marketProductMetaId = "market_product_meta_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
        marketProductId = try values.decodeIfPresent(String.self, forKey: .marketProductId)
        marketProductMetaId = try values.decodeIfPresent(String.self, forKey: .marketProductMetaId)
    }
    
}
struct ProductProviderInfo : Codable {
    
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
