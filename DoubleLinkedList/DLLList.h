//
//  DLLList.h
//  DoubleLinkedList
//
//  Created by Omar Gudino on 10/20/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLLList;
@class DLLNode;

@protocol DLLListDelegate

- (void)list:(DLLList *)list didInsertNode:(DLLNode *)node;
- (void)list:(DLLList *)list didDeleteNode:(DLLNode *)node;

@end

@interface DLLList : NSObject

@property (strong, nonatomic) DLLNode *headNode;
@property (assign, nonatomic) NSInteger numberOfNodes;
@property (assign, nonatomic) id<DLLListDelegate> delegate;

- (void)insertNodeWithValue:(NSString *)value;
- (void)deleteNodeAtIndex:(NSInteger)index;
- (DLLNode *)findNodeAtIndex:(NSInteger)index;
- (NSString *)iterateListString;

@end
