//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Алина Бондарчук on 25.03.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var titleText = ""
    var text = ""
    var dateText = 0
    
    var postDetail = [Post]()
    
    private var imagesStr = [String]()
    var shareUrl = ""
    var selectedId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareButton"), style: .plain, target: self, action: #selector(shareAppAction))
        
        guard let idToLoad = selectedId else { return }
            let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/posts/\(idToLoad).json"
        shareUrl = urlString
            guard let url = URL(string: urlString) else {return}
            if let data  = try? Data(contentsOf: url) {
                parseDetail(json: data)
        }
    }
    
    func parseDetail(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPosts = try? decoder.decode(Posts.self, from: json) {
            let posts = jsonPosts.post
            titleText = posts.title
            text = posts.text
            dateText = posts.timeshamp
            imagesStr = posts.images ?? []
        }
    }
    @IBAction func shareNewsAction(_ sender: Any) {
        DispatchQueue.main.async() { [weak self] in
            self?.shareAppAction()
        }
    }
    
    @objc func shareAppAction() {
        let vc = UIActivityViewController(activityItems: [shareUrl], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesStr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        
        let image = imagesStr[indexPath.item]
        cell.imageView.downloaded(from: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        header.initDetail(titleName: titleText, textName: text, timeShamp: dateText)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.size.width - 56
        return .init(width: itemWidth, height: itemWidth)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}
