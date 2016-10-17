//
//  CategoryViewController.swift
//  BookStore
//
//  Created by apple on 16/9/30.
//  Copyright © 2016年 刘朝龙. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let Identifier = "Cell"
    var collection:UICollectionView!
    var layout:UICollectionViewLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layout = UICollectionViewFlowLayout()
        collection = UICollectionView(frame:self.view.frame , collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.clear
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Identifier)
        self.view.addSubview(collection)
    }
    
    /// collection delegate flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH)/2-5, height: 80)
    }
    
    /// collection delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookList  = storyboard?.instantiateViewController(withIdentifier: "BookListViewControllerID") as! BookListViewController
        bookList.type = BookCategory(rawValue: cgnArray[indexPath.row])!
        self.navigationController?.pushViewController(bookList, animated: true)
    }
    
    /// collection dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return cgArray.count-2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell   = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.title = cgArray[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
