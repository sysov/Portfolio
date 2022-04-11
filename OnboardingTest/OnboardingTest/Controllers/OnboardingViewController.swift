//
//  OnboardingViewController.swift
//  OnboardingTest
//
//  Created by Valera Sysov on 9.04.22.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var slides: [OnboardingSlide] = []
    lazy var selectedIndex = IndexPath(row: 1, section: 0)
    lazy var selectedIndex2 = IndexPath(row: 2, section: 0)
    
    lazy var currentPage = 0 {
        didSet {
            if currentPage == 0 {
                nextButton.setTitle("INIZIA", for: .normal)
                nextButton.setTitleColor(.white, for: .normal)
                backButton.isHidden = true
                footerView.backgroundColor = .orange
            } else if currentPage == slides.count - 1 {
                nextButton.setTitle("COMPLETAR", for: .normal)
                nextButton.setTitleColor(.orange, for: .normal)
                backButton.setTitle("RIFIUTA", for: .normal)
                backButton.setTitleColor(.lightGray, for: .normal)
                backButton.isHidden = false
                footerView.backgroundColor = .white
            } else {
                nextButton.setTitle("ACCETTA", for: .normal)
                nextButton.setTitleColor(.orange, for: .normal)
                footerView.backgroundColor = .white
                backButton.setTitle("RIFIUTA", for: .normal)
                backButton.setTitleColor(.lightGray, for: .normal)
                backButton.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [OnboardingSlide(title: "Ordina a domicilio senza limiti di distanza. Non e magia, e Moovenda!",
                                  subtitle: "PRONTO?",
                                  image: UIImage(named: "image1")!),
                  OnboardingSlide(title: "Ogni tanto inviamo degli sconti esclusivi tramite notifiche push, ci stai?",
                                  subtitle: "PROMOZIONI",
                                  image: UIImage(named: "image2")!),
                  OnboardingSlide(title: "Per sfruttare al massimo l'app, puoi condividerci la tua posizione?",
                                  subtitle: "POSIZIONE",
                                  image: UIImage(named: "image3")!)]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        footerView.layer.backgroundColor = UIColor.orange.cgColor
    }
    
    @IBAction private func backButtonClick(_ sender: Any) {
        
        if currentPage == 1 {
            print("this point Back \(currentPage)")
            currentPage -= 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.footerView.backgroundColor = .orange
            self.nextButton.setTitle("INIZIA", for: .normal)
            self.nextButton.setTitleColor(.white, for: .normal)
            self.backButton.isHidden = true
        } else {
            currentPage -= 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction private func nextButtonClick(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
            print("this point Next \(currentPage)")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.footerView.backgroundColor = .white
            self.nextButton.setTitleColor(.orange, for: .normal)
            self.backButton.isHidden = false
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.indentifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setUp(slides[indexPath.row])
        if selectedIndex == indexPath { cell.lastBackgroundView.isHidden = true}
        if selectedIndex2 == indexPath { cell.lastBackgroundView.isHidden = true;
            cell.firstBackgroundView.isHidden = true }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexesToRedraw = [indexPath]
        selectedIndex = indexPath
        selectedIndex2 = indexPath
        collectionView.reloadItems(at: indexesToRedraw)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }

}
