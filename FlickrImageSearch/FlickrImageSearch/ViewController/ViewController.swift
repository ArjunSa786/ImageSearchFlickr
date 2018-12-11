//
//  ViewController.swift
//  FlickrImageSearch
//


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var m_photoTableView: UITableView!
    
    @IBOutlet weak var m_photosearchBar: UISearchBar!

    private var searchString:String!
    private var int_Page:Int = 1
    private let cellID = "PhotoCellIdentifier"
    private var photosArray = [Photo]()
    {
        didSet {
            self.m_photoTableView.reloadData()
        }
    }

    let service = Photoservice()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        m_photosearchBar.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

// Generic method
    
    private func getPhotosList<S: GetPhotos>(fromService service: S) where S.T == Array<Photo?> {
        service.getPhotosList(page: String(int_Page),searchStr: searchString, completion: { [weak self] (result) in
            switch result {
            case .Success(let Photos):
                for Photos in Photos {
                    if let Photos = Photos {
                        self?.photosArray.append(Photos)
                    }
                }
            case .Error(let error):
                print(error)
            }
            self?.view.removeBluerLoader()

        })
    }

    
    
    
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PhotosTableViewCell
        cell.selectionStyle = .none
        cell.configureCell(result: photosArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == photosArray.count - 1 {
            int_Page += 1
            self.view.showBlurLoader()
            getPhotosList(fromService: service)

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
        
    }
    
    
    
    
    
    // MARK: - Search Bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchString = searchBar.text
        self.m_photosearchBar.endEditing(true)
        self.view.showBlurLoader()
        self.photosArray.removeAll()
        // Call Service class using Generic Function
        getPhotosList(fromService: service)
    }
    
    
    
    
    
    
    
    
}

