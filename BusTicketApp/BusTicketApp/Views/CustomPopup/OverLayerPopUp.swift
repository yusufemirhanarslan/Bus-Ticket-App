//
//  OverLayerPopUp.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 7.04.2023.
//

import UIKit
import Lottie

class OverLayerPopUp: UIViewController {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lottieAnimation: LottieAnimationView!
    @IBOutlet weak var contentView: UIView!
    
    
    var popupModel: PopUpModel!
    
    init() {
        super.init(nibName: "OverLayerPopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        //designAnimation(PopUpModel())
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        configView()

    }
  
    
    func configView() {

        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        //self.contentView.layer.cornerRadius = 20
        
        descriptionLabel?.text = popupModel.description
        
        
        lottieAnimation?.animation = LottieAnimation.named(popupModel.animationName)
        lottieAnimation?.contentMode = .scaleAspectFit
        lottieAnimation?.loopMode = .loop
        lottieAnimation?.play()

    }
    
    func appear(sender: UIViewController) {
        
        sender.present(self, animated: false) {
            self.show()
        }
        
    }
    
    private func show() {
        
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
        
    }
    
    func hide() {
       
        UIView.animate(withDuration: 1, delay: 0.0,options: .curveEaseOut) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
      }

    }

}

