//
//  BaseViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    
    func showActivityIndicator() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showPainelView(show:Bool, emptyPainelView:UIView, contentView:UIView){
        DispatchQueue.main.async {
            emptyPainelView.isHidden = !show
            if show {
                contentView.bringSubviewToFront(emptyPainelView)
            }
            else {
                contentView.sendSubviewToBack(emptyPainelView)
            }
        }
    }
}
