//
//  GoodsCell.swift
//  here
//
//  Created by 朱潮 on 14-8-7.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

import UIKit

class GoodsCell: UICollectionViewCell {
    var imageView:UIImageView!
    override func prepareForReuse() {
        self.backgroundColor = UIColor.whiteColor();
        imageView = UIImageView(frame: CGRectMake(0, 0, 150, 150));
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true;
        imageView.backgroundColor = UIColor.whiteColor();
        self.addSubview(imageView)
    }
    func reload(goods:GoodsEntity?){
        imageView.setImageFromURL(NSURL.URLWithString(goods?.image?.img))
    }
}
