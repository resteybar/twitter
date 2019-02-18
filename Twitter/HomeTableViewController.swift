//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Raymond Esteybar on 2/16/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweet_array = [NSDictionary]()
    var num_of_tweets: Int!
    
    let my_refresh_control = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load_tweets()
        
        // When user loads for more tweets
        //  - (What screen to apply it to, What to action to do, )
        my_refresh_control.addTarget(self, action: #selector(load_tweets), for: .valueChanged)
        tableView.refreshControl = my_refresh_control
    }
    
    // Load Tweets
    @objc func load_tweets() {
        num_of_tweets = 20
        
        let my_url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let my_params = ["count": num_of_tweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: my_url, parameters: my_params, success: { (tweets: [NSDictionary]) in
            
            // Remove old tweets
            self.tweet_array.removeAll()
            
            // Refresh list
            for tweet in tweets {
                self.tweet_array.append(tweet)
            }
            
            // Update table
            self.tableView.reloadData()
            
            // Stops loading circle for new tweets
            self.my_refresh_control.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets! oh no!!")
        })
    }
    
    // Load more Tweets
    func load_more_tweets() {
        let my_url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        num_of_tweets += 20
        let my_params = ["count": num_of_tweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: my_url, parameters: my_params, success: { (tweets: [NSDictionary]) in
            
            // Remove old tweets
            self.tweet_array.removeAll()
            
            // Refresh list
            for tweet in tweets {
                self.tweet_array.append(tweet)
            }
            
            // Update table
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets! oh no!!")
        })
    }
    
    // Notifies us when 'user' reaches bottom/end of table
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweet_array.count {
            load_more_tweets()
        }
    }

    // Logout button
    @IBAction func on_logout(_ sender: Any) {
        
        // Logout of Twitter - Backend
        TwitterAPICaller.client?.logout()
        
        // Screen will dismiss itself - Frontend
        self.dismiss(animated: true, completion: nil)
        
        // When User clicks 'Logout'
        //  - Notifies 'Home' page that user is logged out
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweet_cell", for: indexPath) as! TweetTableViewCell
        
        // Name & Profile Image are w/in a dictionary
        //  - Used to grab them
        let user = tweet_array[indexPath.row]["user"] as! NSDictionary
        
        // Get Image
        let image_url = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: image_url!)
        
        // Store Values
        cell.user_name_label.text = user["name"] as? String
        cell.tweet_content.text = tweet_array[indexPath.row]["text"] as? String
        
        if let image_data = data {
            cell.profile_image_view.image = UIImage(data: image_data)
        }
        
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tweet_array.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
