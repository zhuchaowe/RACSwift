//
//  DemoSceneModel.swift
//  here
//
//  Created by 朱潮 on 14-8-7.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

import UIKit

class DemoSceneModel: SceneModel {
    var goodsArray:GoodsArray!
    var goodsListRequest:GoodsListRequest!
    
    override func loadSceneModel() {
        super.loadSceneModel()
        goodsArray = nil
        goodsListRequest = GoodsListRequest.Request() as GoodsListRequest
        action.useCache()
        
        RACObserve(goodsListRequest, "page")
        .filterAs { (newPage:NSNumber!) -> Bool in
            return newPage != nil && newPage.integerValue > 0
        }.subscribeNextAs { (newPage:NSNumber!) -> () in
            self.SEND_NO_CACHE_ACTION(self.goodsListRequest)
        }
        
        RACObserve(goodsListRequest, "state")
            .filterAs { (state:NSNumber!) -> Bool in
            return self.goodsListRequest.succeed()
            }.subscribeNextAs { (state:NSNumber!) -> () in
                self.action.saveCache()
                var output =  self.goodsListRequest.output as NSDictionary;
                self.goodsArray = GoodsArray.objectFromDictionary(output["data"] as NSDictionary) as GoodsArray
        }
    }
}