//
//  DetailedViewController.swift
//  ProfileView
//
//  Created by sambath on 18/05/23.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phnoLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    var list: Results?
    override func viewDidLoad() {
        super.viewDidLoad()
        valuesToLabels()
    }
    
    func valuesToLabels() {
        nameLbl.text = (list?.name.title ?? "") + ". " + (list?.name.first ?? "")  + " " + (list?.name.last ?? "")
        phnoLbl.text = list?.phone
        emailLbl.text = list?.email
        dobLbl.text = "\(list?.dob.age ?? 0)"
        addressLbl.text = (list?.location.street.name ?? "") + "," + (list?.location.city ?? "") + "."
        if let imageUrl = URL(string: list?.picture.large ?? ""){
            self.profilePic.downloadImageFrom(url: imageUrl, imageMode: .scaleAspectFill)
        }
        profilePic.layer.cornerRadius = 75
    }
    
}
