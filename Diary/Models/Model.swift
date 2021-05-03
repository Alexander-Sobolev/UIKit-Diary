//
//  Model.swift
//  Diary
//
//  Created by Alexander Sobolev on 02.05.2021.
//

import Foundation
import RealmSwift

class Model: Object {
    
    @objc dynamic var id : String?
    @objc dynamic var dateStart: Date?
    @objc dynamic var dateStartDay: String?
    @objc dynamic var dateFinish: Date?
    @objc dynamic var dateFinishDay: String?
    @objc dynamic var name: String = ""
    @objc dynamic var descript: String? 
    // 3й уровень: Возможность прикрепить к событию файлы (например, изображения) добовляю в модель новое свойство
    @objc dynamic var imageData: Data?
    
    
    convenience init(id: String, dateStart: Date, dateStartDay: String, dateFinish: Date, name: String, descript: String, imageData: Data?) {
        self.init()
        
        self.id = id
        self.dateStart = dateStart
        self.dateStartDay = dateStartDay
        self.dateFinish = dateFinish
        self.dateFinishDay = dateFinishDay
        self.name = name
        self.descript = descript
        self.imageData = imageData
        
    }
}
