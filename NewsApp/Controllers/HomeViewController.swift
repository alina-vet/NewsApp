//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Алина Бондарчук on 25.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortedButton: UIButton!
    
    var posts = [PostItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        sortedButton.showsMenuAsPrimaryAction = true
        sortedButton.menu = menuItems()
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: PostTableViewCell.identifier)
        
        let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/main.json"
        guard let url = URL(string: urlString) else {return}
        if let data  = try? Data(contentsOf: url) {
            parse(json: data)
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

            if let jsonPosts = try? decoder.decode(PostItems.self, from: json) {
                posts = jsonPosts.posts
                tableView.reloadData()
            }
    }
    
    func menuItems() -> UIMenu {
        let menu = UIMenu(title: "Сортировать по:", options: .displayInline, children: [
            UIAction(title: "Самые новые", image: UIImage(systemName: "calendar")) { _ in
                self.posts.sort {
                    $0.timeshamp < $1.timeshamp
                }
                self.tableView.reloadData()
            },
            UIAction(title: "Популярные", image: UIImage(systemName: "star.fill")) { _ in
                self.posts.sort {
                    $0.likesCount > $1.likesCount
                }
                self.tableView.reloadData()
            },
            UIAction(title: "Сбросить сортировку", image: UIImage(systemName: "multiply.circle")) { _ in
                self.posts.sort {
                    $0.postID < $1.postID
                }
                self.tableView.reloadData()
            }
        ])
        return menu
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.commonInit(titleName: post.title, previewTextName: post.previewText, timeShamp: post.timeshamp)
        cell.previewTextLabel.lineBreakMode = .byTruncatingTail
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        let post = posts[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        vc.selectedId = post.postID
    }
}

extension HomeViewController: PostCellDelegate {
    func moreTapped(cell: PostTableViewCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
