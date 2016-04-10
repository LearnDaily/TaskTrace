//
//  DeadLineCalendarViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/13.
//
//

import UIKit


protocol DeadlineSetting{
    
    func  setDeadline(time:String?)

}





class DeadLineCalendarViewController: UIViewController,JTCalendarDataSource {
    
    var delegate:DeadlineSetting?

    var calendar:JTCalendar = JTCalendar()
    
    var deadline:String?
    
    @IBOutlet weak var calendarContentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
  
    @IBOutlet weak var calendarContentView: JTCalendarContentView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.automaticallyAdjustsScrollViewInsets = false
        
       self.title = "截止日期"
        
       self.calendar.calendarAppearance().calendar().firstWeekday = 1; // Sunday == 1, Saturday == 7
       self.calendar.calendarAppearance().dayCircleRatio = 9.0/10.0;
       self.calendar.calendarAppearance().ratioContentMenu = 1.0;

       self.calendar.dataSource = self
      
       
       self.calendar.menuMonthsView = self.calendarMenuView
       self.calendar.contentView = self.calendarContentView
        
        
        
        if(!deadline!.isEmpty){
            
            
       
            
            self.calendar.currentDateSelected = NSDateFormatter.dateFormatterWithFormat("YYYY-MM-dd").dateFromString(deadline!)
            
         
        }
        self.calendar.reloadData()


    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.setDeadline(deadline)
    }
    
    
    func calendarHaveEvent(calendar: JTCalendar!, date: NSDate!) -> Bool {
        //return (rand() % 10) == 1;
        
        return false
    
    }
    
    
    
    func calendarDidDateSelected(calendar: JTCalendar!, date: NSDate!) {
        
       deadline = NSDateFormatter.dateFormatterWithFormat("YYYY-MM-dd").stringFromDate(date)
        
    }
    @IBAction func didChangeModeTouch(sender: AnyObject) {
        
        self.calendar.calendarAppearance().isWeekMode = !self.calendar.calendarAppearance().isWeekMode;
        
        transitionModel()
    }
    
    
    @IBAction func didGoTodayTouch(sender: AnyObject) {
        
        self.calendar.currentDate = NSDate()
    }
    
    func transitionModel()
    {
        var newHeight:CGFloat = 300.0;
        if(self.calendar.calendarAppearance().isWeekMode){
                newHeight = 75.0;
        }
        
        UIView.animateWithDuration(0.5, animations: {
              self.calendarContentViewHeight.constant = newHeight;
            self.view.layoutIfNeeded()
        })
        
        UIView.animateWithDuration(0.25, animations: {
            self.calendarContentView.layer.opacity = 0;
            }, completion:{
                (Bool)->Void in
                
                self.calendar.reloadAppearance()
                UIView.animateWithDuration(0.25, animations: {
                    self.calendarContentView.layer.opacity = 1;
                })

            })
        
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
