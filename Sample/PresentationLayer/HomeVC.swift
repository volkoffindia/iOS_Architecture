//
//  DashBoardVC.swift
//  Sample
//
//  Created by Volkoff India on 15/06/21.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK:- Variables Declaration
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var searchBar:UISearchBar = UISearchBar()

    var productList = [ProductData]()

    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.getProductDataAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.configureUI()
        self.setupCollectionView()
        self.setupTableView()
    }
        
    func setupNavigation() {
        self.title = "Home"
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
    }

    //MARK:- Helper
    func configureUI() {
        self.hideKeyboardWhenTappedAround()
        self.pageController.currentPageIndicatorTintColor = .red
        self.pageController.pageIndicatorTintColor = .darkGray
        self.pageController.numberOfPages = HomeData.getBannerImages().count
        
        searchBar.placeholder = " Search"
        searchBar.backgroundImage = UIImage.imageWithColor(color: .white)
        searchBar.delegate = self
    }

    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: BannerCell.cellIdentifier(), bundle: nil), forCellWithReuseIdentifier: BannerCell.cellIdentifier())
        self.collectionView.reloadData()
    }
    
    func setupTableView() {
        self.tblView.estimatedRowHeight = 150
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.tableFooterView = UIView()
        self.tblView.register(UINib(nibName: MenuCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: MenuCell.cellIdentifier())
        self.tblView.reloadData()
    }
}

//MARK:- UISearchBar
extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text: String = searchBar.text ?? ""
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        if text.count > 0 {
            let filtered = HOME_MODEL.productList?.filter({ object in
                return object.name?.contains(text) ?? false
            })
            self.productList = filtered ?? []
        } else {
            self.productList = HOME_MODEL.productList ?? []
        }
        self.tblView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
    
//MARK:- UICollectionViewDataSource || UICollectionViewDelegate
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeData.getBannerImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.cellIdentifier(), for: indexPath as IndexPath) as! BannerCell
        cell.imageUrl = HomeData.getBannerImages()[indexPath.row]
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        return CGSize(width: width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- UIScrollView Delegate
extension HomeVC: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let page = Int(round(scrollView.contentOffset.x/width))
        self.pageController?.currentPage = page
    }
}

//MARK:- UITableView DataSource
extension HomeVC : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: MenuCell.cellIdentifier(), for: indexPath) as!
            MenuCell
        cell.item = self.productList[indexPath.row]
        cell.selectionStyle = .none
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

//MARK:- Network Services
extension HomeVC {
    
    func getProductDataAPI() {
        
        HOME_MODEL.getProdutData() {
            self.productList = HOME_MODEL.productList ?? []
            self.delay(0) {
                self.tblView.reloadData()
            }
        }
    }
}
