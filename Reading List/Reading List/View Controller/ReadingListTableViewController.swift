//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Welinkton on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    // when App is loading
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // when user updates something
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    var bookController = BookController()
    
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(book: book)
        tableView.reloadData()
    }
    
    
    
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.unreadBooks[indexPath.row]
            
        } else {
            
            return bookController.readBooks[indexPath.row]
        }
    }
        
  
        
        
        
    // MARK: - Table view data source
        
    // set a title for the books you want have read and the ones you have not read so far.
        
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                if bookController.readBooks.count == 0 {
                    return nil
                } else {
                    return "Book's I've Read"
                }
            } else {
                if bookController.unreadBooks.count == 0 {
                    return nil
                } else {
                    return "Books I still need to read"
                }
            }
        }
        
    // set number of section.  In this case 2
    override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 2
        }
    
    // for this one because we have more than 1 section. Use a switch / case should be cleaner.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // remember we have to have two sections now
            // use a conditional statement - Switch
        
            switch section {
            case 0:
                return bookController.unreadBooks.count
            case 1:
                return bookController.readBooks.count
            default:
                return bookController.readBooks.count
            }
        }
        
        // add the delegate between the custom cell and the TVC
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}
            
            let book = bookFor(indexPath: indexPath)
            
            cell.book = book
            cell.delegate = self
        
            // Configure the cell...
        
            return cell
        }
        
        // enable the delete option
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let book = bookFor(indexPath: indexPath)
                
                bookController.deleteBook(book: book)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }

         // MARK: - Navigation
         
        // this is the segueway set up
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "AddBook" {
                
                guard let  destinationVC = segue.destination as? BookDetailViewController else {return}
                
                destinationVC.bookController = bookController
                
            } else if segue.identifier == "ShowBook" {
                
                guard let destinationVC = segue.destination as? BookDetailViewController ,
                let indexPath = tableView.indexPathForSelectedRow else { return }
                destinationVC.bookController = bookController
                
               let book = bookFor(indexPath: indexPath)
                
                destinationVC.book = book
            }
         }
        
        
    }

