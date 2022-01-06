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
    var repoistories = [RepositoryEntity]()
    var searchRepoistories = [RepositoryEntity]()
    var numberOfItems = 10
    var totalItems: Int!
    var isFetch = true
    
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
                self?.totalItems = response.count
                CoreDataManager.fetchRepository(callback: { repoistories, error in
                    if repoistories?.count == 0 {
                        CoreDataManager.addNew(Repositories: response)
                       
                        
                        
                    }
                    self?.showData()
//                    print(repoistories)
                })
               
                self?.view?.hideLoader()
                
            case let .failure(error):
                print(error)
                self?.view?.hideLoader()
                self?.view?.showAlertWith(title: nil, text: error.localizedDescription)
            }
        }
    }
    
    func showData(){
        isFetch = true
        CoreDataManager.fetchRepository { repoistories, error in
            if error ==  nil {
                guard let repoistories = repoistories else {
                    return
                }
//                self.repoistories += repoistories
                for (index, item) in repoistories.enumerated() {
                    if index + 1 <= self.numberOfItems {
                        self.repoistories.append(item)
                        self.searchRepoistories.append(item)
                    }
                }
                self.isFetch = false
            }
            
        }
        self.view?.reloadView()
        
    }
    
    func numberOfRepositories() -> Int {
        return self.repoistories.count
    }
    
    func objectOfRepositoies(index: Int) -> RepositoryEntity {
        
        return repoistories[index]
    }
    
    func search(keyword: String){
        if keyword.count > 1 {
            self.repoistories = searchRepoistories.filter({$0.ownerName.lowercased().contains(keyword.lowercased()) })
            self.view?.reloadView()
        }else if keyword.count == 0{
            self.repoistories = searchRepoistories
            self.view?.reloadView()
        }
      
    }
    func didReachLastIndex() {
        if numberOfItems <= totalItems && isFetch == false{
            self.numberOfItems += 10
            self.showData()
        }
      
    }
    
   
    
}
