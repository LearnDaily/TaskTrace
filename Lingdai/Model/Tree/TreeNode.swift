//
//  TreeNode.swift
//  TreeTableVIewWithSwift
//
//  Created by Robert Zhang on 15/10/24.
//  Copyright © 2015年 robertzhang. All rights reserved.
//

import Foundation


public class TreeNode {
    
    static let NODE_TYPE_G: Int = 0 //表示该节点不是叶子节点
    static let NODE_TYPE_N: Int = 1 //表示节点为叶子节点
    var type: Int?
    var desc: String? // 对于多种类型的内容，需要确定其内容
    var id: String = "11111"
    var pId: String?
    var name: String?
    var level: Int?
    var isExpand: Bool = false
    var icon: String?
    var children: [TreeNode] = []
    var parent: TreeNode?
    
    
    
    init (desc: String?, id:String , pId: String? , name: String?) {
        self.desc = desc
        self.id = id
        self.pId = (pId == nil ? NULL:pId)
        self.name = name
    }
    
    //是否为根节点
    func isRoot() -> Bool{
        return parent == nil
    }
    
    //判断父节点是否打开
    func isParentExpand() -> Bool {
        if parent == nil {
            return false
        }
        return (parent?.isExpand)!
    }
    
    //是否是叶子节点
    func isLeaf() -> Bool {
        return children.count == 0
    }
    
    //获取level,用于设置节点内容偏左的距离
    func getLevel() -> Int {
        return parent == nil ? 0 : (parent?.getLevel())!+1
    }
    
    //设置展开
    func setExpand(isExpand: Bool) {
        self.isExpand = isExpand
        if !isExpand {
            for (var i=0;i<children.count;i++) {
                children[i].setExpand(isExpand)
            }
        }
    }
    
}