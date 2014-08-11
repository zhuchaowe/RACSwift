//
//  GoodsEntity.swift
//  here
//
//  Created by 朱潮 on 14-8-7.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

import UIKit

class GoodsEntity: Model {
    var goodsDesc = ""
    var areaId = ""
    var webSite:WebSiteEntity?
    var saleAmount:NSNumber?
    var link = ""
    var goodsRecommend:NSNumber?
    var priceOriginal:NSNumber?
    var price:NSNumber?
    var summary = ""
    var image:ImageEntity?
    var commentCount:NSNumber?
    var goodsId = ""
    var name = ""
}
