

import Foundation

struct MarketHomeProductRoot : Codable {
    
    let data : MarketHomeProductData?
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
        data = try values.decodeIfPresent(MarketHomeProductData.self, forKey: .data)
        messageAr = try values.decodeIfPresent(String.self, forKey: .messageAr)
        messageEn = try values.decodeIfPresent(String.self, forKey: .messageEn)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
}

struct MarketHomeProductData : Codable {
    
    var productList : [MarketHomeProductList]?
    let recommandProduct : [MarketHomeRecommandProduct]?
    
    enum CodingKeys: String, CodingKey {
        case productList = "product_list"
        case recommandProduct = "recommand_product"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productList = try values.decodeIfPresent([MarketHomeProductList].self, forKey: .productList)
        recommandProduct = try values.decodeIfPresent([MarketHomeRecommandProduct].self, forKey: .recommandProduct)
    }
    
}

struct MarketHomeRecommandProduct : Codable {
    
    let createdAt : String?
    let isActive : String?
    let isBookmark : Int?
    let isDelete : String?
    let mCatId : String?
    let mProductId : String?
    let productDescription : String?
    let productImages : [MarketHomeRecommandProductImage]?
    let productPrice : String?
    let productTitle : String?
    let recommended : String?
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
        case recommended = "recommended"
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
        productImages = try values.decodeIfPresent([MarketHomeRecommandProductImage].self, forKey: .productImages)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productTitle = try values.decodeIfPresent(String.self, forKey: .productTitle)
        recommended = try values.decodeIfPresent(String.self, forKey: .recommended)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        vender = try values.decodeIfPresent(String.self, forKey: .vender)
    }
    
}

struct MarketHomeRecommandProductImage : Codable {
    
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
struct MarketHomeProductList : Codable {
    
    let createdAt : String?
    let isActive : String?
    let isBookmark : Int?
    let isDelete : String?
    let mCatId : String?
    let mProductId : String?
    let productDescription : String?
    let productImages : [MarketHomeProductImage]?
    let productPrice : String?
    let productTitle : String?
    let recommended : String?
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
        case recommended = "recommended"
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
        productImages = try values.decodeIfPresent([MarketHomeProductImage].self, forKey: .productImages)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productTitle = try values.decodeIfPresent(String.self, forKey: .productTitle)
        recommended = try values.decodeIfPresent(String.self, forKey: .recommended)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        vender = try values.decodeIfPresent(String.self, forKey: .vender)
    }
    
}
struct MarketHomeProductImage : Codable {
    
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

