//
//  ViewController.swift
//  tomato
//
//  Created by Theo Phillips on 3/7/16.
//  Copyright © 2016 DurlApps. All rights reserved.
//

import UIKit

class TomatoCell: UICollectionViewCell {
    @IBOutlet var imageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let w = self.frame.size.width
        let h = self.frame.size.height
        let ss = min(w,h)
        imageView = UIImageView(frame:CGRect(x: 0, y: 10, width: ss, height: ss))
        imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        imageView?.backgroundColor = UIColor.clearColor()
        
        self.addSubview(imageView!)
        self.clipsToBounds = true
    }
    
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView:UICollectionView?
    var detailsView: TomatoDetailView?
    var tomatos:Array<Tomato> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Results", comment: "Results")
        
        let w = self.view.frame.size.width
        let h = self.view.frame.size.height
        let cellw = w-20
        let cellh = h-20
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: (w-cellw)/2, bottom: 0, right: (w-cellw)/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = ((w - cellw))
        layout.itemSize = CGSize(width: cellw, height: cellh)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: w, height: h+50), collectionViewLayout: layout)
        collectionView?.registerClass(TomatoCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = UIColor.clearColor()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.scrollEnabled = true
        collectionView?.pagingEnabled = true
        self.view.addSubview(collectionView!)
        
        
        Tomato.getTomatos("Witch",completion: {results in
            self.tomatos = results
            self.collectionView!.reloadData()
        })
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("refreshing table with \(tomatos.count) records")
        return tomatos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! TomatoCell
        let tomato = tomatos[indexPath.row]
        let photoData = NSData(contentsOfURL: NSURL(string: tomato.photoUrl!)!)
        cell.imageView?.image = UIImage(data: photoData!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let tomato = tomatos[indexPath.row]
        detailsView = TomatoDetailView(frame: self.view.bounds, tomato: tomato)
        self.view.addSubview(detailsView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

