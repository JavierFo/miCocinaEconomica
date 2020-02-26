//
//  CalendarRecipesViewController.swift
//  miCocinaEconomica
//
//  Created by Javier Ferrer on 2/19/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit
import CalendarKit
import DateToolsSwift

class CalendarViewController: DayViewController {
    
     var generatedEvents = [EventDescriptor]()
     var alreadyGeneratedSet = Set<Date>()

     var colors = [UIColor.blue,
                   UIColor.yellow,
                   UIColor.green,
                   UIColor.red]

     lazy var customCalendar: Calendar = {
        let customNSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
       customNSCalendar.timeZone = TimeZone(abbreviation: "CEST")!
       let calendar = customNSCalendar as Calendar
       return calendar
     }()

     override func loadView() {
       calendar = customCalendar
       dayView = DayView(calendar: calendar)
       view = dayView
     }

     override func viewDidLoad() {
       super.viewDidLoad()
       //title = "CalendarKit Demo"
       navigationController?.navigationBar.isTranslucent = false
       dayView.autoScrollToFirstEvent = true
       reloadData()
     }

    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? RecipesTableViewController {
          if segue.identifier == "recipeToCalendarTableCell" {
           slideInTransitioningDelegate.direction = .right
          }
          slideInTransitioningDelegate.disableCompactHeight = false
          controller.transitioningDelegate = slideInTransitioningDelegate
          controller.modalPresentationStyle = .custom
        }
        
    }
    
     @objc func changeStyle() {

       navigationItem.rightBarButtonItem!.title = title

       reloadData()
     }

     func dateOnly(date: Date, calendar: Calendar) -> Date {
       let yearComponent = calendar.component(.year, from: date)
       let monthComponent = calendar.component(.month, from: date)
       let dayComponent = calendar.component(.day, from: date)
       let zone = calendar.timeZone

        let newComponents = DateComponents(timeZone: zone,
                                          year: yearComponent,
                                          month: monthComponent,
                                          day: dayComponent)
        let returnValue = calendar.date(from: newComponents)

       return returnValue!
     }

     // MARK: EventDataSource

     override func eventsForDate(_ date: Date) -> [EventDescriptor] {
       if !alreadyGeneratedSet.contains(date) {
         alreadyGeneratedSet.insert(date)
       }
       return generatedEvents
     }

     // MARK: DayViewDelegate

     private var createdEvent: EventDescriptor?

     override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard (eventView.descriptor as? Event) != nil else {
         return
       }
       //print("Event has been selected: \(descriptor) \(String(describing: descriptor.userInfo))")
     }

     override func dayViewDidLongPressEventView(_ eventView: EventView) {
       guard let descriptor = eventView.descriptor as? Event else {
         return
       }
       endEventEditing()
       //print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
       beginEditing(event: descriptor, animated: true)
       print(Date())
     }

     override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
       endEventEditing()
       performSegue(withIdentifier: "recipeToCalendarTableCell", sender: self)
       print("Did Tap at date: \(date)")
            
     }

     override func dayViewDidBeginDragging(dayView: DayView) {
        //print("DayView did begin dragging")
     }

     override func dayView(dayView: DayView, willMoveTo date: Date) {
       //print("DayView = \(dayView) will move to: \(date)")
     }

     override func dayView(dayView: DayView, didMoveTo date: Date) {
       //print("DayView = \(dayView) did move to: \(date)")
     }

     override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
       //print("Did long press timeline at date \(date)")
       endEventEditing()

     }

     override func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
       //print("did finish editing \(event)")
       //print("new startDate: \(event.startDate) new endDate: \(event.endDate)")

       if let _ = event.editedEvent {
         event.commitEditing()
       }

       if let createdEvent = createdEvent {
         createdEvent.editedEvent = nil
         generatedEvents.append(createdEvent)
         self.createdEvent = nil
         endEventEditing()
       }
       reloadData()
     }
    
}
