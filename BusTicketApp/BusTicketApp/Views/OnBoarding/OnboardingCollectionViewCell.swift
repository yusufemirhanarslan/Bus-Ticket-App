//
//  OnboardingCollectionViewCell.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 6.04.2023.
//

import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    @IBOutlet weak var slideTitleLabel: UILabel!
    
    @IBOutlet weak var slideDescription: UILabel!
    
    
    
    func setup(_ slide: OnBoardingSlide) {
        
        lottieAnimationView.animation = LottieAnimation.named(slide.animationName)
        slideTitleLabel.text = slide.title
        slideDescription.text = slide.description
        
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
    }
}
