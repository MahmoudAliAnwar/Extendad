//
//  RepositoryCell.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryOwnerNameLabel: UILabel!
    @IBOutlet weak var repositoryDateLabel: UILabel!
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var holderView: UIView!
    

    override func draw(_ rect: CGRect) {
        holderView.layer.cornerRadius = 15
        holderView.clipsToBounds = true
        repositoryImageView.layer.cornerRadius = 5
        repositoryImageView.clipsToBounds = true
    }
    func confige(repository: RepositoryModel){
        self.repositoryNameLabel.text = repository.name
        self.repositoryOwnerNameLabel.text = repository.owner?.login
        self.repositoryImageView.addImageFromURL(urlString: repository.owner?.avatarURL ?? "")
    
        
    }
   
    
}
