import UIKit
import CoreData




class SelectCityPop: UIView {
    
    var countryNameArr = ["Afghanistan", "Albania", "Algeria", "American Samoa"]
    
    
    var searchCountry = [Result]()
    var searching = false
    
    var countryList = [Result]()
    
    var selectedcountry = ""
    var selectedcountryid = ""
        
    let viewSehirSec : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    let lblSehirSec : UILabel = {
        let lbl = UILabel()
        lbl.text = "Şehir Seç"
        lbl.textColor = .black
        lbl.textAlignment = . center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.layer.shadowColor = UIColor.customWhite().cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnTamam : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("TAMAM", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(btnTamamAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
           var indicator = UIActivityIndicatorView()
           indicator.hidesWhenStopped = true
           indicator.style = .large
           indicator.color = .black
           indicator.translatesAutoresizingMaskIntoConstraints = false
           return indicator
       }()
    
    let sehirTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutDuzenle()
        tableViewDuzenle()
        activityIndicator.startAnimating()
        
        let jsonUrlString = "https://marketindirimleri.com/api/v1/cities/?format=json"
        
         guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
          
            do {

                
                
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                
                 DispatchQueue.main.async {
                self.countryList = websiteDescription.results
                    self.sehirTableView.reloadData()
                    self.activityIndicator.stopAnimating()

                }
                                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
       
        
        
    }
    
    func layoutDuzenle() {
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubview(viewSehirSec)
        viewSehirSec.addSubview(lblSehirSec)
        addSubview(searchBar)
        addSubview(altView)
        altView.addSubview(btnTamam)
        addSubview(sehirTableView)
        sehirTableView.addSubview(activityIndicator)
        
        
        _ = viewSehirSec.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor)
        lblSehirSec.merkezKonumlamdirmaSuperView()
        _ = searchBar.anchor(top: viewSehirSec.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor)
        _ = altView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        btnTamam.centerYAnchor.constraint(equalTo: altView.centerYAnchor).isActive = true
        btnTamam.rightAnchor.constraint(equalTo: altView.rightAnchor,constant: -10).isActive = true
        _ = sehirTableView.anchor(top: searchBar.bottomAnchor, bottom: altView.topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        activityIndicator.centerXAnchor.constraint(equalTo: sehirTableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: sehirTableView.centerYAnchor).isActive = true
        
        
        
        
    }
    
    func tableViewDuzenle() {
        
        sehirTableView.separatorColor = .white
        sehirTableView.delegate = self
        sehirTableView.dataSource = self
        sehirTableView.register(UINib(nibName: "SehirlerCel", bundle: nil), forCellReuseIdentifier: "SehirlerCel")
        searchBar.delegate = self
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnTamamAction() {
        
        
        if self.selectedcountryid == "" || self.selectedcountry == "" {
            print("Lutfen sehir secin")
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newCity = NSEntityDescription.insertNewObject(forEntityName: "City", into: context)
        
        newCity.setValue(selectedcountryid, forKey: "id")
        newCity.setValue(selectedcountry, forKey: "name")
        
        do {
            try context.save()
        } catch {
            print("bir hata var")
        }
        
       
        
    
        
        let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
        let vc: SplashView = storyboard.instantiateViewController(withIdentifier: "SplashView") as! SplashView
        vc.modalPresentationStyle = .fullScreen
        let currentController = self.getCurrentViewController()
        currentController?.present(vc, animated: false, completion: nil)
        
        
        
    }
    
    func getCurrentViewController() -> UIViewController? {
        //ios 13 control
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
    
    
}


extension SelectCityPop : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchCountry.count
        }else{
            return countryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sehirTableView.dequeueReusableCell(withIdentifier: "SehirlerCel", for: indexPath) as! SehirlerCel
        cell.imgSucces.isHidden = true
        if searching {
            cell.lbl.text = searchCountry[indexPath.row].name
        }else{
            cell.lbl.text = countryList[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sehirTableView.reloadData()
        let cell = sehirTableView.cellForRow(at: indexPath) as! SehirlerCel
        cell.imgSucces.isHidden = false
        
        if searching {
            selectedcountry =  searchCountry[indexPath.row].name
            selectedcountryid = "\(searchCountry[indexPath.row].id)"
        } else{
            selectedcountry =  countryList[indexPath.row].name
            selectedcountryid = "\(countryList[indexPath.row].id)"
        }
        
    }
    
    
}

extension SelectCityPop : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchCountry = countryList.filter({$0.name == searchText})
        searchCountry = countryList.filter(
            {
                $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()
            }
        )
        searching = true
        sehirTableView.reloadData()
        
    }
    
    
    
    
    
}
