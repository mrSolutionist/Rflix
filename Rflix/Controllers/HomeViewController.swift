//
//  HomeViewController.swift
//  Rflix
//
//  Created by Robin George on 10/11/21.
//

import UIKit


class HomeViewController: UIViewController{
    
    //base image from api models shared instance
    let baseImageUrl = ApiManager.shared.imageUrl
    //data from core data
    var apiResponse : ApiResponseData?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //TODO: should i make this just static or singleton? if not needed keep it
        let key = "28"
        ApiManager.shared.loadDataWithGenreKey(genreKeyValue: key)
        
        //TODO: MAKE THE OBJ SAVE IN DATA BASSE FOR OFLINE LOADING
        
        
        setupView()
        //        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    private func setupView(){
        setNavigationBarImage()
    }
    
    private func setNavigationBarImage(){
        let logo = UIImage(named: "NetflixLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
    }
    
    
}

//TABLE VIEW
extension HomeViewController:UITableViewDataSource{
    
    //SETTING NUMBER OF SECTION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    //NUMBER OF CELLS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: BASE IMAGE URL FOR FETCHING IMAGE
//        let baseImageUrl = apiManager.imageUrl
        
        if indexPath.row == 0 {             //IF INDEX == 0 MAIN IMAGE CELL
            let headCell = tableView.dequeueReusableCell(withIdentifier: "headCell", for: indexPath) as! HeadCell
            
            // configure headcell
            //chances of break or failure if fpre unwarpped homepaagedata
            if let imageData = apiResponse?.imageData {
                headCell.configCell(imageData: imageData, url: baseImageUrl)
            }
           
           
            return headCell
        }
        
        
        else {                              // ELSE REST OF THE ITEM CELLS
            let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
            
            // configure itemcell
            return itemCell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //configure headder file
        return String()
    }
    
    
}
