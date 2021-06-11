//
//  MainViewController.swift
//  Diary
//
//  Created by Alexander Sobolev on 02.05.2021.
//

import UIKit
import QVRWeekView
import FSCalendar
import RealmSwift
    // Прочтите файл Readme
    // Не решенная еще задача как с БД добавить данные в поля выбранные для событий
class MainViewController: UIViewController {
    // Создаю автообновляемый тип контейнера который возвращает текущее состояние хранилища
    var model: Results<Model>!
    var currentDate = Date()
    // Три строки с GitHub разработчика фреймворка QVRWeekView для сохранения в CoreData
    // Не решена еще задача как приспособить для Realm
    var allEvents: [Int: EventData] = [:]
    var eventsSortedByDay: [Date: [EventData]] = [:]
    var id: Int = 0
    
    @IBOutlet weak var calendear: FSCalendar!
    @IBOutlet weak var weekView: WeekView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Делаю запрос данных из Realm
        model = realm.objects(Model.self)
        // Меняю внешний вид weekView
        customizingWeekView()
    }
}
    // Использую для возврата со второго View и одновременного сохранения событий
extension MainViewController {
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let descroptionVC = segue.source as? DescriptionViewController else { return }
        descroptionVC.saveDescription()
    }
}
