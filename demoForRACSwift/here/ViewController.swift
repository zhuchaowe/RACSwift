//
//  ViewController.swift
//  here
//
//  Created by 朱潮 on 14-8-7.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

import UIKit

class ViewController: Scene,SceneCollectionViewDelegate{
    var demoSceneModel:DemoSceneModel!
    
    @IBOutlet var collectView: SceneCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectView.registerClass(GoodsCell.self, forCellWithReuseIdentifier: "GoodsCell")
        collectView.SceneDelegate = self
        collectView.backgroundColor = UIColor.whiteColor()
        collectView.addHeader()
        collectView.addFooter()

        demoSceneModel = DemoSceneModel.SceneModel() as DemoSceneModel
        
        RACObserve(demoSceneModel, "goodsArray")
        .filterAs{ (newGoodsArray:GoodsArray!) -> Bool in
                return newGoodsArray != nil
        }.subscribeNextAs { (newGoodsArray:GoodsArray!) -> () in
            self.collectView.successWithNewArray(newGoodsArray.goodsList)
            self.collectView.total = newGoodsArray.total
            self.collectView.reloadData()
        }
        
        RACObserve(demoSceneModel.goodsListRequest, "state")
            .subscribeNextAs { (state:NSNumber!) -> () in
                if self.demoSceneModel.goodsListRequest.failed() {
                    SVProgressHUD.showErrorWithStatus("数据加载失败!")
                }else if self.demoSceneModel.goodsListRequest.sending() {
                    SVProgressHUD.showWithStatus("数据加载中!")
                }else if self.demoSceneModel.goodsListRequest.succeed() {
                    SVProgressHUD.dismiss()
                }
        }
        RAC(demoSceneModel.goodsListRequest, "page") <= RACObserve(collectView, "page")
        RAC(demoSceneModel.goodsListRequest, "pageSize") <= RACObserve(collectView, "pageSize")
              // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func handlePullLoader(view: MJRefreshBaseView!, state: PullLoaderState) {
       super.handlePullLoader(view, state: state)
        if state.value == HEADER_REFRESH.value {
            collectView.page = 1
        }else if state.value == REACH_BOTTOM.value {
            collectView.page = collectView.page + 1
        }
    }
    
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int{
        if self.collectView.dataArray == nil {
            return 0
        }else{
            return self.collectView.dataArray.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int{
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!{
        var cell:GoodsCell = collectionView.dequeueReusableCellWithReuseIdentifier("GoodsCell", forIndexPath: indexPath) as GoodsCell
        var goods =  self.collectView.dataArray.objectAtIndex(indexPath.row) as GoodsEntity;
        cell.reload(goods)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        return CGSizeMake(150, 230)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!){
    }
    
}
