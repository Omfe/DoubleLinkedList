//
//  DLLNode.h
//  DoubleLinkedList
//
//  Created by Omar Gudino on 10/20/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLNode : UIView

@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) DLLNode *nextNode;

- (id)initWithValue:(NSString *)value;
- (void)flashBackground;

@end
