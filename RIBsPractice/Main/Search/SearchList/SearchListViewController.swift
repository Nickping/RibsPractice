//
//  SearchListViewController.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs
import RxSwift
import UIKit

protocol SearchListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    var repoList: Observable<[Repository]> { get }
    var repos: [Repository] { get }
    var favoriteRepos: [String: Bool] { get }
    
    func search(_ keyword: String)
    func didSelect(_ repository: Repository)
}

final class SearchListViewController: UIViewController, SearchListPresentable, SearchListViewControllable {
    
    weak var listener: SearchListPresentableListener?
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")
        
        
    }
    
    func didGetSearchResult() {
        tableView.reloadData()
    }
    
    func didUpdateFavorite(_ repoId: [String: Bool]) {
        
        guard let repos = listener?.repos else { return }

        
        for (index, repository) in repos.enumerated() {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? RepositoryTableViewCell
            
            cell?.updateFavorite(repoId[String(repository.id)] == true ? true : false)
        }
        
        
    }
    

    @IBAction func didTapSearchBtn(_ sender: Any) {
        guard let keyword = searchTextField.text,
              !keyword.isEmpty else {
            return
        }
        
        listener?.search(keyword)
    }
}


extension SearchListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        guard let repo = listener?.repos[indexPath.row] else {
            return
        }
        listener?.didSelect(repo)
    }
}

extension SearchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listener = self.listener else { return 0 }
        return listener.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell") as? RepositoryTableViewCell,
              let repos = listener?.repos,
              let favorites = listener?.favoriteRepos else {
            return UITableViewCell()
        }
        
        let repo = repos[indexPath.row]
        
        cell.updateUI(repo, isFavorite: favorites[String(repo.id)] == true ? true : false)
        
        return cell
        
    }
    
    
}

extension Array where Element == Repository {
    internal subscript(safe index: Int) -> Repository? {
        return self.indices.contains(index) == true ? self[index] : nil
    }
}
