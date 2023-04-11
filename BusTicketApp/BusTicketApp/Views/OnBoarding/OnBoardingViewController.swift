//
//  OnBoardingViewController.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 6.04.2023.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnBoardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        slides = [
            
            OnBoardingSlide(title: "İstediğiniz Yere",
                            description: "İstedeğiniz yere gidebilirsiniz",
                            animationName: "location2"),
            OnBoardingSlide(title: "İstediğiniz Otobüsle",
                            description: "50+ dan fazla otobüs firması çeşitliliğine sahibiz",
                            animationName: "bus2"),
            OnBoardingSlide(title: "İstediğiniz Zaman",
                            description: "Size uygun tarihi seçebilirsiniz",
                            animationName: "calendar2"),
            OnBoardingSlide(title: "Güvenli Ödeme",
                            description: "Güvenle kartınızı kullanarak ödemenizi gerçekleştirebilirsiniz",
                            animationName: "payment2")
        
        ]
        
    }
    

    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "loginNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true,completion: nil)
        }else {
            
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
        
       
        
    }
    
}


extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return slides.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
        
    }
    
    
}
