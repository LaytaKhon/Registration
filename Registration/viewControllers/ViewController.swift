//
//  ViewController.swift
//  Registration
//
//  Created by MIT App Dev on 11/30/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var studentsCollectionView: UICollectionView!
    var stuList : [StudentVos] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.studentsCollectionView.delegate = self
        self.studentsCollectionView.dataSource = self
        studentsCollectionView?.backgroundColor = .clear
        studentsCollectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        getStudents()
    }
    
    func getStudents() {
        
        DataModel.shared.getStu(success: { (data) in
            
            self.stuList.removeAll()
            self.stuList.append(contentsOf: data)
            print("list=>\(self.stuList.count)")
            self.studentsCollectionView.reloadData()
            
        }, failure: {
            
        })
        
    }

    @IBAction func getLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
        self.present(nc, animated: true, completion: nil)
    }
    
    @IBAction func addStudent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! UINavigationController
        self.present(nc, animated: true, completion: nil)
    }
    
}

extension ViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = studentsCollectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath)as! StudentCollectionViewCell
        
        let user = self.stuList[indexPath.row]
        cell.image.sd_setImage(with: URL(string: user.image ?? "user-icon"), placeholderImage: UIImage(named: "user-icon"))
        return cell
    }
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //  let nav = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController")as! UINavigationController
        // let cv = nav.viewControllers[0] as! DetailsViewController
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")as! UINavigationController
        let cv = nav.viewControllers[0] as! RegisterViewController
        let data = self.stuList[indexPath.row]
        
        print("array=>\(data)")
        cv.stu = data
        self.present(nav, animated: true, completion: nil)
    }
}
