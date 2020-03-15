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

class CalendarViewController: DayViewController, selectedRecipesFromModalTableView {
    
    var recipeFromTable_ : Recipe?
    
    func sendDataToCalendarViewController(recipe: Recipe) {
        self.recipeFromTable_ = recipe
    }
    
    var generatedEvents = [EventDescriptor]()
    var alreadyGeneratedSet = Set<Date>()
        
    var passedRecipe : [Recipe] = []
    
    var data : [String] = []
    
    var colors = [UIColor.lightGray]

    lazy var customCalendar: Calendar = {
        let customNSCalendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
       customNSCalendar.timeZone = TimeZone(abbreviation: "CST")!
       let calendar = customNSCalendar as Calendar
       return calendar
     }()

     override func loadView() {
       calendar = customCalendar
       dayView = DayView(calendar: calendar)
       view = dayView
     }

    override func viewWillAppear(_ animated: Bool) {
        data.append(recipeFromTable_?.titulo ?? "")
    }
    
     override func viewDidLoad() {
       super.viewDidLoad()
       navigationController?.navigationBar.isTranslucent = false
       dayView.autoScrollToFirstEvent = true
       reloadData()
     }

    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? RecipesTableViewController {
          if segue.identifier == "recipeToCalendarTableCell" {
            controller.recipeDelegate = self
            slideInTransitioningDelegate.direction = .right
          }
          slideInTransitioningDelegate.disableCompactHeight = false
          controller.transitioningDelegate = slideInTransitioningDelegate
          controller.modalPresentationStyle = .custom
        }
        
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
       print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
       beginEditing(event: descriptor, animated: true)
        
     }

     override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
       endEventEditing()
        let event = generateEventNearDate(date)
        print("Creating a new event")
        create(event: event, animated: true)
        createdEvent = event
        print(recipeFromTable_)
//        print(recipeFromTable_?.titulo)
//        print(passedRecipe)
       //print("Did Tap at date: \(date)")
            
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
       performSegue(withIdentifier: "recipeToCalendarTableCell", sender: self)
       endEventEditing()
        
        if data.count > 0{
            let event = generateEventNearDate(date)
            print("Creating a new event")
            create(event: event, animated: true)
            createdEvent = event
        }
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
    
    private func generateEventNearDate(_ date: Date) -> EventDescriptor {
      let duration = Int(arc4random_uniform(160) + 60)
      let startDate = date.subtract(TimeChunk.dateComponents(minutes: Int(CGFloat(duration) / 2)))
      let event = Event()
      let datePeriod = TimePeriod(beginning: startDate,
                                  chunk: TimeChunk.dateComponents(minutes: duration))
      event.startDate = datePeriod.beginning!
      event.endDate = datePeriod.end!

      var info = data[Int(arc4random_uniform(UInt32(data.count)))]
      let timezone = dayView.calendar.timeZone
      info.append(datePeriod.beginning!.format(with: "dd.MM.YYYY", timeZone: timezone))
      info.append("\(datePeriod.beginning!.format(with: "HH:mm", timeZone: timezone)) - \(datePeriod.end!.format(with: "HH:mm", timeZone: timezone))")
      //event.text = info.reduce("", {$0 + $1 + "\n"})
      event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
      event.editedEvent = event

      return event
    }
    
    private func generateEventsForDate(_ date: Date) -> [EventDescriptor] {
      var workingDate = date.add(TimeChunk.dateComponents(hours: Int(arc4random_uniform(10) + 5)))
      var events = [Event]()

      for i in 0...4 {
        let event = Event()
        let duration = Int(arc4random_uniform(160) + 60)
        let datePeriod = TimePeriod(beginning: workingDate,
                                    chunk: TimeChunk.dateComponents(minutes: duration))

        event.startDate = datePeriod.beginning!
        event.endDate = datePeriod.end!

        var info = data[Int(arc4random_uniform(UInt32(data.count)))]

        let timezone = dayView.calendar.timeZone
        print(timezone)
        info.append(datePeriod.beginning!.format(with: "dd.MM.YYYY", timeZone: timezone))
        info.append("\(datePeriod.beginning!.format(with: "HH:mm", timeZone: timezone)) - \(datePeriod.end!.format(with: "HH:mm", timeZone: timezone))")
        //event.text = info.reduce("", {$0 + $1 + "\n"})
        event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        event.isAllDay = Int(arc4random_uniform(2)) % 2 == 0

        events.append(event)

        let nextOffset = Int(arc4random_uniform(250) + 40)
        workingDate = workingDate.add(TimeChunk.dateComponents(minutes: nextOffset))
        event.userInfo = String(i)
      }

      print("Events for \(date)")
      return events
    }
    
}

