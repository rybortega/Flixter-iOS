//
//  MoviesViewController.swift
//  flixter-ios
//
//  Created by Sara Kazemi on 9/22/20.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // properties
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]() // Create an Array of Dictionaries with a String key and Any as value

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            // print(dataDictionary)
            
            // TODO: Get the array of movies
            self.movies = dataDictionary["results"] as! [[String:Any]] // cast as Array of Dictionaries
            self.tableView.reloadData() // tells tableView to update
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    // Following two methods required to work with a Table View
    
    // Returns number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    // Returns cell for particular cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue when cell is off screen, recycle that cell for reuse
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String // Cast title as String
        cell.titleLabel!.text = title
        let synopsis = movie["overview"] as! String
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185/"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterImage.af_setImage(withURL: posterUrl)
        
        
      
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
