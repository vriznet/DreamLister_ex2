//
//  ItemDetailsVC.swift
//  DreamLister_ex2
//
//  Created by vriz on 2018. 6. 28..
//  Copyright © 2018년 vriz. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImg: UIImageView!
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    
    var stores = [Store]()
    var types = [ItemType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.delegate = self
        storePicker.dataSource = self
        typePicker.delegate = self
        typePicker.dataSource = self
//        let store1 = Store(context: context)
//        store1.name = "Amazon"
//        let store2 = Store(context: context)
//        store2.name = "K mart"
//        let store3 = Store(context: context)
//        store3.name = "Fry"
//        ad.saveContext()
//        let type1 = ItemType(context: context)
//        type1.type = "Computer"
//        let type2 = ItemType(context: context)
//        type2.type = "Car"
//        let type3 = ItemType(context: context)
//        type3.type = "Camera"
//        ad.saveContext()
        getStores()
        getTypes()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == storePicker{
            return stores.count
        }else if pickerView == typePicker{
            return types.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == storePicker{
            return stores[row].name
        }else if pickerView == typePicker{
            return types[row].type
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update later
    }
    
    func getStores(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
        }catch{
            let error = error as NSError
            print(error)
        }
    }
    func getTypes(){
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        do{
            self.types = try context.fetch(fetchRequest)
        }catch{
            let error = error as NSError
            print(error)
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
    }
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
    }
    @IBAction func addImage(_ sender: UIButton) {
    }
}
