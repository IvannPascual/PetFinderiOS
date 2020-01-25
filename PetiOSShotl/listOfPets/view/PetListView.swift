//
//  PetListView.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import Nuke
private let headerIdentifier = "ProfileHeader"
private let cellIdentifier = "ProfileCell"


class PetListView: UICollectionViewController {
    
    
    var presenter: PetListPresenterProtocol?
    var petListViewModel = PetListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.retrievePets()
        
        collectionView.backgroundColor = .white
        collectionView!.register(PetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(PetCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func presentOrganizationsMapScreen() {
        self.navigationController?.pushViewController(OrganizationsMapViewController(), animated: true)
    }
    
}


extension PetListView {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! PetHeader
        header.setDelegate(mapOrganizationsDelegate: self)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petListViewModel.urlImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PetCell
        print("Index path is \(indexPath.row)")
        
        guard let url = URL(string: petListViewModel.urlImages[indexPath.row]) else {
            return cell
        }
        
        if let imageData = try? Data(contentsOf: url),
          let image = UIImage(data: imageData) {
          cell.image = image
        } else {
          cell.image = nil
        }
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PetListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
}


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension PetListView: PetListViewProtocol {
    
    func showOrganizations() {
        presentOrganizationsMapScreen()
    }
    
    func showPets(with pets: PetModelDomain) {
        self.petListViewModel.pets = pets
        
        for animal in self.petListViewModel.pets.animals {
            for photo in animal.photos {
                self.petListViewModel.urlImages.append(photo.mediumUrl)
          }
        }
        collectionView.reloadData()
    }
    
    func showError(_ message: String) {
        self.petListViewModel.messageError = message
        HUD.flash(.label(message), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
}

extension PetListView: MapOrganizationsDelegate {

    func navigateToMapView(){
        presenter?.retrieveOrganizations()
    }
    
}

