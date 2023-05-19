//
//  ViewController.swift
//  ProfileView
//
//  Created by sambath on 18/05/23.
//

import UIKit

class ViewController: UIViewController {

    var Data = ProfileViewModel()
    
    @IBOutlet weak var ProfileCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionsetup()
        closureSetUp()
    }
    
    func closureSetUp()  {
        Data.reloadList = { [weak self] ()  in
            
            DispatchQueue.main.async {
                self?.ProfileCollectionView.reloadData()
            }
        }
    }
    
    func collectionsetup(){
        ProfileCollectionView.delegate = self
        ProfileCollectionView.dataSource = self
    }


}

extension ViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.arrayOfList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCell", for: indexPath) as! ViewCell
        let listObj = Data.arrayOfList[indexPath.row]
        cell.Name.text = (listObj.name.title + ". " + listObj.name.first + " " + listObj.name.last)
        cell.Street.text = listObj.location.street.name
        if let imageUrl = URL(string: listObj.picture.large){
            cell.Images.downloadImageFrom(url: imageUrl, imageMode: .scaleAspectFill)
        }
        cell.Images.layer.cornerRadius = 10
        cell.reloadInputViews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let linkobject = Data.arrayOfList[indexPath.row]
        let nextvc = self.storyboard?.instantiateViewController(identifier: "DetailedViewController") as! DetailedViewController
        nextvc.list = linkobject
        self.navigationController?.pushViewController(nextvc, animated: true)
    }
}


