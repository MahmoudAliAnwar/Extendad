//
//  RepositoriesPresenter.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation

class RepositoriesPresenter: BasePresenter {
    
    private var repositoriesUseCase: RepositoriesUseCase!
    private weak var view: BaseViewProtocol?
    var repoistories = [RepositoryModel]()
    var searchRepoistories = [RepositoryModel]()
    
    
    override func attachView(view: BaseViewProtocol) {
        self.view = view
        viewDidAttach()
        
    }
    
    override func viewDidAttach() {
        getData()
        
        
    }
    
    
    func getData() {
        
        self.view?.showLoader()
        
        repositoriesUseCase = RepositoriesUseCase()
        
        repositoriesUseCase.execute([RepositoryModel].self) {[weak self] (result) in
            switch result {
            case let .success(response):
                
                
                self?.repoistories = response
                self?.searchRepoistories = response
                
                self?.view?.reloadView()
                
                self?.view?.hideLoader()
                
            case let .failure(error):
                print(error)
                self?.view?.hideLoader()
                self?.view?.showAlertWith(title: nil, text: error.localizedDescription)
            }
        }
    }
    
    func numberOfRepositories() -> Int {
        return self.repoistories.count
    }
    
    func objectOfRepositoies(index: Int) -> RepositoryModel {
        
        return repoistories[index]
    }
    
    func search(keyword: String){
        if keyword.count > 1 {
            self.repoistories = searchRepoistories.filter({$0.owner?.login?.lowercased().contains(keyword.lowercased()) ?? false})
            self.view?.reloadView()
        }else if keyword.count == 0{
            self.repoistories = searchRepoistories
            self.view?.reloadView()
        }
      
    }
    
    
}
