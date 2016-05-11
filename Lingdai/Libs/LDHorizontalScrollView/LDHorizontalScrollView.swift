//
//  LDHorizontalScrollView.swift
//  ScrollDate
//
//  Created by 钟其鸿 on 16/1/28.
//  Copyright © 2016年 Zhongqh. All rights reserved.
//

import UIKit

class LDHorizontalScrollView: UIScrollView {
    
    private let kDefaultLeftMargin:CGFloat = 5.0
    private let kMinMarginBetweenItems:CGFloat = 10.0
    private let kMinWidthAppearOfLastItem:CGFloat = 20.0
    
    private var itemY:CGFloat!
    private var items:NSMutableArray!
    private var uniformItemSize:CGSize!
    private var itemsMargin:Int!
    private var leftMarginPx:CGFloat!
    private var miniMarginPxBetweenItems:CGFloat!
    private var miniAppearPxOfLastItem:CGFloat!
    override init(frame: CGRect) {
        
        items = NSMutableArray()
        uniformItemSize = CGSizeMake(frame.size.height*0.8, frame.size.height*0.8)
        leftMarginPx = kDefaultLeftMargin
        miniMarginPxBetweenItems = kMinMarginBetweenItems
        miniAppearPxOfLastItem = kMinWidthAppearOfLastItem
        
        super.init(frame: frame)
        
        setItemsMarginOnce()
        
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollViewDecelerationRateFast
        
        self.delegate = self
        
    }
    
    override var frame:CGRect{
        didSet{
            
            var oldValue = self.frame;
            itemY = (frame.size.height-self.uniformItemSize.height)/2;
            if(frame.size.width != oldValue.size.width){
                  refreshSubView()
             }
            
//            CGRect oldValue = self.frame;
//            [super setFrame:frame];
//            itemY = (frame.size.height-self.uniformItemSize.height)/2;
//            if(frame.size.width != oldValue.size.width){
//                [self refreshSubView];
//            }
        }
    }
    func refreshSubView(){
        self.setItemsMarginOnce()
        var itemX:CGFloat = self.leftMarginPx
        
        for i in 0...self.items.count-1 {
            var item:UIView =  self.items[i] as! UIView
            item.frame = CGRectMake(itemX, item.frame.origin.y, item.frame.size.width, item.frame.size.height);
            itemX += item.frame.size.width + CGFloat(self.itemsMargin);
        }
        itemX = itemX - CGFloat(self.itemsMargin) + self.leftMarginPx;
        self.contentSize = CGSizeMake(itemX, self.frame.size.height);
    }
    
    func setUniformItemSize(uniformItemSize:CGSize){
        self.uniformItemSize = uniformItemSize;
        self.itemY = (self.frame.size.height - uniformItemSize.height) / CGFloat(2)
    }
    
    func addItem(item:UIView){
        if(self.items.count > 0){
            var lastItemRect:CGRect = self.items.lastObject!.frame;
            item.frame = CGRectMake(lastItemRect.origin.x + self.uniformItemSize.width + CGFloat(self.itemsMargin), itemY, self.uniformItemSize.width, self.uniformItemSize.height);
        }
        else{
            
            item.frame = CGRectMake(self.leftMarginPx, itemY, self.uniformItemSize.width, self.uniformItemSize.height)
            
        }
        self.items.addObject(item)
        self.addSubview(item)
        self.contentSize = CGSizeMake(item.frame.origin.x + self.uniformItemSize.width + self.leftMarginPx, self.frame.size.height);
    
    }
    func addItems(items:NSArray){
        for i in 0...items.count - 1{
            self.addItem(items.objectAtIndex(i) as! UIView)
        }
    }
    func removeItem(item:UIView)->Bool{
        var index:NSInteger = self.items.indexOfObject(item)
        if(index != NSNotFound){
            return self.removeItemAtIndex(index)
        }
        else
        {
            return false
        }
    }
    
    func removeAllItems()->Bool{
        for i in 0...self.items.count-1{
            var view = self.items.objectAtIndex(i) as! UIView
            view.removeFromSuperview()
        }
        self.items.removeAllObjects()
        self.contentSize = CGSizeMake(self.contentSize.width-CGFloat(self.itemsMargin)-self.uniformItemSize.width, self.frame.size.height)
        return true
    }
    
    func removeItemAtIndex(index:NSInteger)->Bool{
        if(index < 0 || index > self.items.count - 1)
        {
            return false
        }
        for  i in (index+1)...self.items.count-1
        {
            var item = self.items.objectAtIndex(i) as! UIView
            item.frame = CGRectMake(CGRectGetMidX(item.frame) - CGFloat(self.itemsMargin)-self.uniformItemSize.width,CGRectGetMinY(item.frame) , CGRectGetWidth(item.frame), CGRectGetHeight(item.frame))
        }
        var item  = self.items.objectAtIndex(index)
        item.removeFromSuperview()
        self.items.removeObject(index)
        self.contentSize =  CGSizeMake(self.contentSize.width-CGFloat(self.itemsMargin)-self.uniformItemSize.width, self.frame.size.height);
        return true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setItemsMarginOnce(){
        itemsMargin = calculateMarginBetweenItems()
    }
    
    func calculateMarginBetweenItems() ->Int{
        var numberOfItemForCurrentWidth = floorf(Float((frame.size.width - self.leftMarginPx!-miniAppearPxOfLastItem)/(self.uniformItemSize.width+self.miniMarginPxBetweenItems)))
        
        return Int(round(Double((self.frame.size.width-self.leftMarginPx-self.miniAppearPxOfLastItem)/CGFloat(numberOfItemForCurrentWidth) - uniformItemSize.width)))
        
    }
    
    
    

}

extension LDHorizontalScrollView:UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var sv = scrollView as! LDHorizontalScrollView
        
       
        
        if (targetContentOffset.memory.x + scrollView.frame.size.width < scrollView.contentSize.width) {
            targetContentOffset.memory.x = self.getClosestItemByX(targetContentOffset.memory.x, scrollView:sv) - CGFloat(sv.leftMarginPx);
        }

        
        
    }
    func getClosestItemByX(xPosition:CGFloat, scrollView:LDHorizontalScrollView)->CGFloat
    {
    //get current cloest item on the left side
        var index:Int = (Int)((xPosition - scrollView.leftMarginPx)/(CGFloat(scrollView.itemsMargin)+scrollView.uniformItemSize.width));
        var item:UIView  = scrollView.items.objectAtIndex(index) as! UIView
    //check if target position is over half of current left item, if so, move to next item
    if (xPosition-item.frame.origin.x > item.frame.size.width / 2) {
        item = scrollView.items.objectAtIndex(index+1) as! UIView
    //check if target position plus scroll view width over content width, if so, move back to last item
        if (item.frame.origin.x + scrollView.frame.size.width > scrollView.contentSize.width) {
            item = scrollView.items.objectAtIndex(index) as! UIView
        }
    }
    
        return item.frame.origin.x;
    }

}
