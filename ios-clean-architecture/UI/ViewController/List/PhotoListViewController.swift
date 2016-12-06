//
//  PhotoListViewController.swift
//  ios-clean-architecture
//
//  Created by Eiji Kushida on 2016/12/01.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

private extension Selector {
    static let didLoadPhotos = #selector(PhotoListViewController.didLoadPhotos)
}

final class PhotoListViewController: UIViewController {

    @IBOutlet weak var photoListCollectionView: UICollectionView!
    var presenter: PhotoListPresenter?
    var photoListDataSource = PhotoListCollectionView()
    var photos: [Photo] = []
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPhotos()
    }

    //MARK:- Notification Callbak
    func didLoadPhotos(notification: Notification) {
        
        photos = PhotosLoadEvent.parse(userInfo: notification.userInfo) as! [Photo]
        photoListDataSource.update(photos: photos)
        photoListCollectionView.reloadData()
    }

    //MARK:- private
    fileprivate func setup() {
        setupPhotoListView()
        setupPresenter()
        addCallBackEvent()
    }

    fileprivate func loadPhotos() {
        presenter?.loadPhotos()
    }

    fileprivate func setupPhotoListView() {
        photoListCollectionView.dataSource = photoListDataSource
        photoListCollectionView.delegate = self
    }

    fileprivate func setupPresenter() {
        presenter = PhotoListPresenter(usecase: PhotoListUsecaseImpl())
    }

    fileprivate func addCallBackEvent() {
        PhotosLoadEvent.add(self, Selector.didLoadPhotos)
    }
}

//MARK:- UICollectionViewDelegate
extension PhotoListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetail(indexPath: indexPath)
    }
    
    fileprivate func showDetail(indexPath: IndexPath) {
        presenter?.showDetail(photo: photos[indexPath.row], topOf: self)
    }
}

