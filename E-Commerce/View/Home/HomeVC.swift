//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/27/23.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var categoryImage: [String] = ["one", "two", "three", "four"]
    private let categoryNames: [String] = ["All", "Women", "Men", "Girls"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}

//MARK: - Private Methods
extension HomeVC {
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Cells.groupsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.groupsCollectionViewCell)
    }
}

//MARK: - CollectionView Delegate & DataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.groupsCollectionViewCell, for: indexPath) as! GroupsCollectionViewCell
        cell.categoryNameLabel.text = categoryNames[indexPath.row]
        cell.categoryImageView.image = UIImage(named: categoryImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.categoryDetailVC) as! CategoryDetailVC
        detailVC.categoryName = categoryNames[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: self.collectionView.frame.height)
    }
}
