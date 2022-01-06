//
//  BaseViewController.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import UIKit

class BaseViewController: UIViewController {
    var refreshControl = UIRefreshControl()

    let maxToRefresh: CGFloat = 50.0
    var panGestureRecognizer: UIPanGestureRecognizer!
    lazy var refreshIndicatorView: UIView = {
        let view = UIView(frame: CGRect(x: UIScreen.main.bounds.midX - 15, y: 44, width: 30, height: 30))
        view.alpha = 0
        
        let firstView = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        firstView.backgroundColor = .white
        
        firstView.layer.cornerRadius = 15
        firstView.layer.shadowRadius = 3
        firstView.layer.shadowOpacity = 0.5
        firstView.layer.shadowOffset = CGSize(width: 1, height: 1)
        firstView.layer.shadowColor = UIColor.lightGray.cgColor
        firstView.setImage(#imageLiteral(resourceName: "active love icon"), for: .normal)
        firstView.imageView?.contentMode = .scaleToFill
        
        view.addSubview(firstView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tableView = view.subviews.first(where: { $0.isKind(of: UITableView.self) }) {
            refreshControl.endRefreshing()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
            tableView.addSubview(refreshControl) // not required when using UITableViewController
        } else if (view.subviews.first(where: { $0.isKind(of: UIScrollView.self) })) != nil {
            self.view.addSubview(refreshIndicatorView)
            panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: #selector(panGestureChanged(_:)))
            view.addGestureRecognizer(panGestureRecognizer)
        }

        DispatchQueue.main.async {
            self.setupViews()
        }
        self.hideKeyboardWhenTappedAround()
    }

    func setupViews() {}
    
    @objc func panGestureChanged(_ sender: UIPanGestureRecognizer) {
        let dragPoint = sender.translation(in: self.view)
        if self.refreshIndicatorView.transform.ty <= (UIScreen.main.bounds.height * 0.1) {
            self.refreshIndicatorView.alpha = (dragPoint.y / maxToRefresh)
            self.refreshIndicatorView.transform = CGAffineTransform(rotationAngle: (dragPoint.y / maxToRefresh))
            
            self.refreshIndicatorView.transform.ty += dragPoint.y
        }
        
        if sender.state == .ended {
            if dragPoint.y >= maxToRefresh {
                viewDidLoad()
            }
            UIView.animate(withDuration: TimeInterval(0.1 + (dragPoint.y / self.view.frame.maxY)), delay: 0, options: .curveEaseOut, animations: {
                self.refreshIndicatorView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.refreshIndicatorView.alpha = 0
            }, completion: nil)
        }
    }
    
    @objc func refresh(sender: AnyObject) {
       // Code to refresh table view
        viewDidLoad()
        viewWillAppear(true)
    }

}
