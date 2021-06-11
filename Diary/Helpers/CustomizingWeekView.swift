//
//  CustomizingWeekView.swift
//  Diary
//
//  Created by Alexander Sobolev on 11.06.2021.
//

import UIKit
import QVRWeekView
import FSCalendar

extension MainViewController {
    // Меняю внешний вид weekView
    func customizingWeekView() {
        selectDate(date: currentDate)
        calendear.delegate = self
        calendear.dataSource = self
        weekView.delegate = self
        weekView.mainBackgroundColor = .white
        weekView.todayViewColor = .white
        weekView.visibleDaysInPortraitMode = 1
        weekView.topBarColor = #colorLiteral(red: 0.9523287416, green: 0.9492221475, blue: 0.9522970319, alpha: 1)
        weekView.defaultDayViewColor = .white
        weekView.passedDayViewColor = .white
        weekView.weekendDayViewColor = .white
        weekView.dayViewDashedSeparatorColor = .white
        weekView.passedWeekendDayViewColor = .white
        weekView.sideBarWidth = 40
        weekView.dayViewHourIndicatorColor = .blue
    }
    // Метод синхронизирует выбранную дату в calendear и weekView
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDate = date
        selectDate(date: currentDate)
}
    // Метод меняет дату в calendear при листании страниц weekView
    func activeDayChanged(in weekView: WeekView, to date: Date) {
        currentDate = date
        calendear.select(date)
}
    // Метод выбора даты для calendear и weekView
    func selectDate(date: Date) {
        calendear.select(date)
        weekView.showDay(withDate: date)
    }
}
