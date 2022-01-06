//
//  RepositoryDetailsVC.swift
//  Extendad
//
//  Created by mahmoud ali on 07/01/2022.
//

import UIKit

class RepositoryDetailsVC: UIViewController {
    // MARK: - OutLet
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryOwnerNameLabel: UILabel!
    @IBOutlet weak var repositoryDateLabel: UILabel!
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var descriptionLable: UILabel!
   
    
   
    var repository: RepositoryEntity!
    convenience init(repository: RepositoryEntity){
        self.init()
        self.repository = repository
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repositoryNameLabel.text = repository.name
        self.repositoryOwnerNameLabel.text = repository.ownerName
        self.repositoryDateLabel.text = "2021-08-06 14:54:00+0200".determine
        self.repositoryImageView.addImageFromURL(urlString: repository.image)
        self.descriptionLable.text = repository.repoDescription
        
        
        descriptionLable.layer.cornerRadius = 5
        descriptionLable.clipsToBounds = true
    }


   

}
