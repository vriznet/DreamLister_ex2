//
//  ViewController.swift
//  DreamLister_ex2
//
//  Created by vriz on 2018. 6. 27..
//  Copyright © 2018년 vriz. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    // IBOutlet
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // custom variables & let
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptFetch()

        tableView.delegate = self
        tableView.dataSource = self
    }

    // tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell{
            configureCell(cell: cell, indexPath: indexPath)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects , objs.count > 0 {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "addItem", sender: item)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"{
            if let destination = segue.destination as? ItemDetailsVC{
                if let item = sender as? Item{
                    destination.itemToEdit = item
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // fetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type){
        case.insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath{
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath)
            }
            break
        case.move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    // custom function
    func attemptFetch(){
        let fetchReqeust: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchReqeust.sortDescriptors = [dateSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchReqeust, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        do{
            try controller.performFetch()
        }catch{
            let error = error as NSError
            print(error)
        }
    }
    func configureCell(cell: ItemCell, indexPath: IndexPath){
        let item = controller.object(at: indexPath)
        cell.configureCell(item: item)
    }
}
