//
//  FilterVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 3/1/23.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var ColorsView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var categoryNames: [String] = ["All", "Women", "Men", "Boys", "Girls"]
    private var colors: [UIColor] = [.black, .red, .gray, .purple, .orange, .blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow()
        configCollectionView()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

//MARK: - Private Methods
extension FilterVC {
    private func addShadow() {
        ColorsView.addShadow()
        categoryView.addShadow()
    }
    
    private func configCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: Cells.subCategoriesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.subCategoriesCollectionViewCell)
        
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        colorsCollectionView.register(UINib(nibName: Cells.colorsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.colorsCollectionViewCell)
        colorsCollectionView.allowsMultipleSelection = true
    }
}

//MARK: - CollectionView Delegate & DataSource
extension FilterVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoryNames.count
        } else {
            return colors.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.subCategoriesCollectionViewCell, for: indexPath) as! SubCategoriesCollectionViewCell
        cell.subCategoryView.backgroundColor = .white
        cell.subCategoryView.layer.borderWidth = 0.2
        cell.subCategoryNameLabel.textColor = .black
        cell.subCategoryNameLabel.text = categoryNames[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.colorsCollectionViewCell, for: indexPath) as! ColorsCollectionViewCell
            cell.colorView.backgroundColor = colors[indexPath.row]
            return cell
        }
            
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.cellForItem(at: indexPath) as! SubCategoriesCollectionViewCell
            cell.subCategoryView.backgroundColor = .red
            cell.subCategoryNameLabel.textColor = .white
            cell.subCategoryNameLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.cellForItem(at: indexPath) as! SubCategoriesCollectionViewCell
            cell.subCategoryView.backgroundColor = .white
            cell.subCategoryNameLabel.textColor = .black
            cell.subCategoryNameLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        }
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension FilterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: self.view.frame.width / 3 - 30, height: 50)
        }
        return CGSize(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == colorsCollectionView {
            let totalCellWidth = 30 * collectionView.numberOfItems(inSection: 0)
            let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
            
            let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
