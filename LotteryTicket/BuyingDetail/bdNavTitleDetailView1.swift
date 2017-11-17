//
//  bdNavTitleDetailView1.swift
//  LotteryTicket
//
//  Created by Cheng Li on 2017/11/7.
//  Copyright © 2017年 李诚. All rights reserved.
//

class bdNavTitleDetailView1: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kSCREEN_WIDTH/3-1, height: 100)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //collectionView.dataSource = self
        //collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        //collectionView.register(bdNavTitleDetailView_Button_CollectionCell.classForCoder(), forCellWithReuseIdentifier: "Cell_Button")
        //collectionView.register(bdNavTitleDetailView_Label_CollectionCell.self, forCellWithReuseIdentifier: "Cell_Label")
        return collectionView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
