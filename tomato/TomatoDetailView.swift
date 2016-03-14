//
//  TomatoDetailsView.swift
//  Runes
//
//  Created by Theo Phillips on 3/7/16.
//  Copyright © 2016 DurlApps. All rights reserved.
//

import UIKit

/*class TomatoDetailsView: UIView {
    var titleLabel : UILabel
    var ratingLabel : UILabel
    var genreLabel : UILabel
    var runtimeLabel : UILabel
    var genreFieldLabel : UILabel
    var runtimeFieldLabel : UILabel
    
    override init(frame: CGRect) {
        titleLabel =  UILabel()
        ratingLabel =  UILabel()
        genreLabel =  UILabel()
        runtimeLabel =  UILabel()
        genreFieldLabel =  UILabel()
        runtimeFieldLabel =  UILabel()
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        
        self.addSubview(titleLabel)
        self.addSubview(ratingLabel)
        self.addSubview(genreLabel)
        self.addSubview(runtimeLabel)
        self.addSubview(runtimeFieldLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}*/

class TomatoDetailSubview: UIView {
    
    var tomato:Tomato
    var titleLabel : UILabel
    var ratingLabel : UILabel
    var genreLabel : UILabel
    var runtimeLabel : UILabel
    var genreFieldLabel : UILabel
    var runtimeFieldLabel : UILabel

    init(frame: CGRect, tomato: Tomato) {
        titleLabel =  UILabel()
        ratingLabel =  UILabel()
        genreLabel =  UILabel()
        runtimeLabel =  UILabel()
        genreFieldLabel =  UILabel()
        runtimeFieldLabel =  UILabel()
        self.tomato = tomato
        super.init(frame: frame)
        self.backgroundColor = UIColor(colorLiteralRed: 0.7, green: 0.7, blue: 0.7, alpha: 0.9)
        
        
        
        
        //let h = frame.height
        let w = frame.width
        
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
        self.clipsToBounds = true
        
        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: w-60, height: 30))
        titleLabel.text = self.tomato.name
        
        ratingLabel = UILabel(frame: CGRect(x: w-50, y: 10, width: 100, height: 30))
        ratingLabel.text = self.tomato.rating
        
        genreFieldLabel = UILabel(frame: CGRect(x: 10, y: 50, width: 100, height: 30))
        genreFieldLabel.text = NSLocalizedString("Genre:", comment: "Genre:")
        
        genreLabel = UILabel(frame: CGRect(x: 110, y: 50, width: 100, height: 30))
        genreLabel.text = self.tomato.genre
        
        runtimeFieldLabel = UILabel(frame: CGRect(x: 10, y: 90, width: 100, height: 30))
        runtimeFieldLabel.text = NSLocalizedString("Runtime:", comment: "Runtime:")
        
        runtimeLabel = UILabel(frame: CGRect(x: 110, y: 90, width: 100, height: 30))
        runtimeLabel.text = String(self.tomato.runtime!)
        
        self.addSubview(titleLabel)
        self.addSubview(ratingLabel)
        self.addSubview(genreLabel)
        self.addSubview(genreFieldLabel)
        self.addSubview(runtimeLabel)
        self.addSubview(runtimeFieldLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class TomatoDetailView: UIView {
    var closeButton:UIButton?
    var popupView:TomatoDetailSubview?
    
    init(frame: CGRect, tomato: Tomato) {
        let h = frame.size.height
        let w = frame.size.width
        let vh = CGFloat(150)
        let vw = CGFloat(w-100)
        super.init(frame: frame)
        
        closeButton = UIButton(frame: frame)
        closeButton?.addTarget(self, action: "closePressed", forControlEvents: .TouchDown)
        closeButton?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.addSubview(closeButton!)
        
        let container = UIView(frame: CGRect(x: (w-vw)/2, y: (h-vh)/2, width: vw, height: vh))
        self.addSubview(container)
        popupView = TomatoDetailSubview(frame: CGRect(x: 0, y: 0, width: vw, height: vh), tomato: tomato)
        container.addSubview(popupView!)
        
        popupView!.center = CGPoint(x: vw/2, y: vh/2-150-2*h)
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options:UIViewAnimationOptions.BeginFromCurrentState, animations: {
            self.popupView!.layer.position = CGPoint(x: vw/2, y: vh/2)
            }, completion: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func closePressed() {
        let h = self.frame.size.height
        let w = self.frame.size.width
        UIView.animateWithDuration(0.5, animations: {
            self.popupView!.center = CGPoint(x: w/2, y: 2*h)
            }, completion: {
                b in
                self.removeFromSuperview()
        })
    }
}
