//
//  HelloTableViewController.swift
//  Hello App
//
//  Created by zappycode on 6/16/18.
//  Copyright © 2018 Nick Walter. All rights reserved.
//

import UIKit

class HelloTableViewController: UITableViewController {

    var allHellos : [Hello] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getHellos()
    }
    
    func getHellos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let hellos = try? context.fetch(Hello.fetchRequest()) {
                if let theHellos = hellos as? [Hello] {
                    allHellos = theHellos
                    tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func helloTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let hello = Hello(context: context)
            hello.name = "Bye bye"
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hello = allHellos[indexPath.row]
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            context.delete(hello)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allHellos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let hello = allHellos[indexPath.row]
        
        cell.textLabel?.text = hello.name

        return cell
    }
    
}
