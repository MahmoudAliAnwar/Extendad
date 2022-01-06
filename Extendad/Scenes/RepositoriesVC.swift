//
//  RepositoriesVC.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import UIKit

class RepositoriesVC: UIViewController {
    
    //    MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var presenter = RepositoriesPresenter()
    struct Constants {
        static let repositoryCell = "RepositoryCell"
        
    }
    
    //    MARK:- Lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attachView(view: self)
        registerCells()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
    }
    
    
    func registerCells() {
        self.tableView.register(UINib(nibName: Constants.repositoryCell, bundle: nil), forCellReuseIdentifier: Constants.repositoryCell)
    }
    
    
}

extension RepositoriesVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRepositories()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repositoryCell, for: indexPath) as! RepositoryCell
        cell.confige(repository: self.presenter.objectOfRepositoies(index: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIScreen.main.bounds.height < 800 {
            return UIScreen.main.bounds.height / 6
        } else {
            return UIScreen.main.bounds.height / 9
        }
    }
    //        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //            self.navigationController?.pushViewController(MovieDetailsVC(movie: self.presenter.object(index: indexPath.row)), animated: true)
    //    //        self.navigationController?.pushViewController(ShopeDetailsVC(presenter: ShopeDeatilsPresenter(shopID: self.presenter.shope[indexPath.row].id ?? "" )), animated: true)
    //        }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //         indexPath.row == (self.presenter.shope.count - 1) ? self.presenter.didReachLastIndex() : nil
        //        self.presenter.didReachLastIndex()
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    
}

extension RepositoriesVC: BaseViewProtocol {
    
    
    func showLoader() {
        print("SHOW LOADER")
        //        animateLoader()
    }
    
    func hideLoader() {
        print("HIDE LOADER")
        //        stopLoader()
    }
    
    func showAlertWith(title: String?, text: String) {
        //        self.presentAlert(title: title, message: text)
    }
    
    func displayConnectionError() {
        // TODO: IMPLEMENT CONNECTION ERROR
    }
    
    func reloadView() {
        
        tableView.reloadData()
        
    }
    
    
    
    
}




extension RepositoriesVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.search(keyword: searchText)
    }
    
}
