//
//  StorageManager.swift
//  Diary
//
//  Created by Alexander Sobolev on 02.05.2021.
//

import RealmSwift
// Создаю объект realm согласно догументации с сайта realm.io
let realm = try! Realm()
// Для сохранения данных в базу, а так же удаления создаю класс
class StorageManager {
    static func saveObject(_ model: Model) {
        try! realm.write {
        realm.add(model)
        }
    }
    static func deleteObject(_ model: Model) {
        try! realm.write {
        realm.delete(model)
        }
    }
}
