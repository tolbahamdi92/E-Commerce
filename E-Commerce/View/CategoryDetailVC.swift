//
//  CategoryDetailVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/27/23.
//

import UIKit

class CategoryDetailVC: UIViewController {

    private var isGrid: Bool = false
    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var typeGridBtn: UIButton!
    @IBOutlet weak var detailCategoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        typeGridBtn.setImage(UIImage(named: "grid"), for: .normal)

    }
    
    @IBAction func typeGridBtnTapped(_ sender: UIButton) {
        if typeGridBtn.imageView?.image == UIImage(named: "grid") {
            typeGridBtn.setImage(UIImage(named: "grid-rows"), for: .normal)
            isGrid = true
        } else {
            typeGridBtn.setImage(UIImage(named: "grid"), for: .normal)
            isGrid = false
        }
        detailCategoryCollectionView.reloadData()
    }
}

//MARK: - Private Methods
extension CategoryDetailVC {
    private func setupCollectionView(){
        subCategoriesCollectionView.delegate = self
        subCategoriesCollectionView.dataSource = self
        subCategoriesCollectionView.register(UINib(nibName: Cells.subCategoriesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.subCategoriesCollectionViewCell)
        
        detailCategoryCollectionView.delegate = self
        detailCategoryCollectionView.dataSource = self
        detailCategoryCollectionView.register(UINib(nibName: Cells.detailCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.detailCategoryCollectionViewCell)
    }
}

//MARK: - CollectionView Delegate & DataSource
extension CategoryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == subCategoriesCollectionView {
            return 5
        } else {
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == subCategoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.subCategoriesCollectionViewCell, for: indexPath) as! SubCategoriesCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.detailCategoryCollectionViewCell, for: indexPath) as! DetailCategoryCollectionViewCell
            if isGrid {
                cell.containerStackView.axis = .vertical
            } else {
                cell.containerStackView.axis = .horizontal
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == subCategoriesCollectionView {
            
        } else {
            
        }
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension CategoryDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == subCategoriesCollectionView {
            return CGSize(width: self.view.frame.width / 3, height: 50)
        } else {
            if isGrid {
                return CGSize(width: (self.view.frame.width / 2) - 5 , height: 300)
            }
            return CGSize(width: self.view.frame.width, height: 150)
        }
        
    }
}
