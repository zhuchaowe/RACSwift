//
//  GoodsListRequest.swift
//  here
//
//  Created by 朱潮 on 14-8-7.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

import UIKit

class GoodsListRequest: Request {
    var type = "1"
    var page = NSNumber.numberWithInt(1)
    var pageSize = NSNumber.numberWithInt(10)
    var categoryId = "-1"
    var areaName = "浙江"
    
    override func loadRequest() {
        HOST = "test-leway.zjseek.com.cn:8000"
        PATH = "/api/goods/goodsList"
    }
}
