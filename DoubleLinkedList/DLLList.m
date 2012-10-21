//
//  DLLList.m
//  DoubleLinkedList
//
//  Created by Omar Gudino on 10/20/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import "DLLList.h"
#import "DLLNode.h"

@implementation DLLList

- (id)init
{
    self = [super init];
    if (self) {
        self.numberOfNodes = 0;
    }
    return self;
}

- (void)insertNodeWithValue:(NSString *)value
{
    DLLNode *newNode;
    DLLNode *currentNode;
    
    newNode = [[DLLNode alloc] initWithValue:value];
    
    if (self.headNode == nil) {
        self.headNode = newNode;
        self.tailNode = newNode;
    } else {
        currentNode = self.headNode;
        while (currentNode.nextNode ) {
            currentNode = currentNode.nextNode;
        }
        currentNode.nextNode = newNode;
        newNode.previousNode = currentNode;
        self.tailNode = newNode;
    }
    self.numberOfNodes++;
    [self.delegate list:self didInsertNode:newNode];
}

- (void)deleteNodeAtIndex:(NSInteger)index
{
    DLLNode *deleteNode;
    DLLNode *currentNode;
    if (index != 0) {
        currentNode = [self findNodeAtIndex:index - 1];
        deleteNode = currentNode.nextNode;
        currentNode.nextNode = deleteNode.nextNode;
        deleteNode.nextNode.previousNode = currentNode;
    } else {
        deleteNode = self.headNode;
        self.headNode = deleteNode.nextNode;
    }
    
    if (deleteNode == self.tailNode) {
        self.tailNode = deleteNode.previousNode;
    }
    
    self.numberOfNodes--;
    [self.delegate list:self didDeleteNode:deleteNode];
}

- (DLLNode *)findNodeAtIndex:(NSInteger)index
{
    DLLNode *currentNode;
    
    if (index > self.numberOfNodes/2) {
        currentNode = self.tailNode;
        for (NSInteger i = self.numberOfNodes-1; i >= index ; i--) {
            if (i == index) {
                return currentNode;
            }
            currentNode = currentNode.previousNode;
        }
    } else {
        currentNode = self.headNode;
        for (NSInteger i = 0; i <= index ; i++) {
            if (i == index) {
                return currentNode;
            }
            currentNode = currentNode.nextNode;
        }
    }
    return nil;
}

- (NSString *)iterateListString
{
    DLLNode *currentNode;
    NSMutableString *iteratedListString;
    
    if (!self.headNode) {
        return  @"";
    }
    
    iteratedListString = [NSMutableString string];
    
    currentNode = self.headNode;
    [iteratedListString appendFormat:@"%@\n",currentNode.value];
    
    while (currentNode.nextNode) {
        currentNode = currentNode.nextNode;
        [iteratedListString appendFormat:@"%@\n",currentNode.value];
    }
    
    return iteratedListString;
}

@end
