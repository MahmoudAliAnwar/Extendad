//
//  BaseViewProtocol.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    func showLoader()
    func hideLoader ()
    func showAlertWith(title: String?, text: String)
    func displayConnectionError()
    func reloadView()
    
}
