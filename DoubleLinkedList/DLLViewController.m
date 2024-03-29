//
//  DLLViewController.m
//  DoubleLinkedList
//
//  Created by Omar Gudino on 10/20/12.
//  Copyright (c) 2012 Omar Gudino. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DLLViewController.h"
#import "DLLList.h"
#import "DLLNode.h"

@interface DLLViewController () <UIPickerViewDataSource, UIPickerViewDelegate, DLLListDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *nodesScrollView;
@property (weak, nonatomic) IBOutlet UITextView *iteratedNodesTextView;
@property (weak, nonatomic) IBOutlet UITextField *insertPositionTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *positionFinderPickerView;
@property (weak, nonatomic) IBOutlet UIButton *insertButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *findButton;
@property (weak, nonatomic) IBOutlet UIButton *iterateButton;

@property (strong, nonatomic) DLLList *list;

@end

@implementation DLLViewController


#pragma mark - Views didLoad/unLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.list = [[DLLList alloc] init];
    self.list.delegate = self;
    
    self.iteratedNodesTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.iteratedNodesTextView.layer.borderWidth = 2;
    
    self.nodesScrollView.layer.borderColor = [UIColor blackColor].CGColor;
    self.nodesScrollView.layer.borderWidth = 2;
    
    self.nodesScrollView.contentSize = CGSizeMake(20, 40);
    self.nodesScrollView.contentInset = UIEdgeInsetsMake(20, 10, 20, 10);
}



#pragma mark - UIPickerViewDataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.list.numberOfNodes;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%i", row];
}


#pragma mark - LLListDelegate Methods
- (void)list:(DLLList *)list didInsertNode:(DLLNode *)node
{
    CGFloat x;
    CGRect frame;
    CGSize size;
    
    x = 0;
    for (UIView *subview in self.nodesScrollView.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) { //Hay una subvista que arruina la lógica.
            continue;
        }
        x += subview.frame.size.width;
    }
    frame = node.frame;
    frame.origin.x = x;
    node.frame = frame;
    
    //Hay que crecer el contenido del scroll view para que pueda hacer scroll.
    size = self.nodesScrollView.contentSize;
    size.width += node.frame.size.width;
    self.nodesScrollView.contentSize = size;
    [self.nodesScrollView addSubview:node];
    
    [self.nodesScrollView flashScrollIndicators];
}

- (void)list:(DLLList *)list didDeleteNode:(DLLNode *)node
{
    CGSize size;
    CGRect frame;
    DLLNode *currentNode;
    
    [node removeFromSuperview];
    
    currentNode = node;
    while (currentNode.nextNode) {
        frame = currentNode.frame;
        frame.origin.x -= node.frame.size.width;
        currentNode.frame = frame;
        
        currentNode = currentNode.nextNode;
    }
    frame = currentNode.frame;
    frame.origin.x -= node.frame.size.width;
    currentNode.frame = frame;
    
    //Hay que crecer el contenido del scroll view para que pueda hacer scroll.
    size = self.nodesScrollView.contentSize;
    size.width -= node.frame.size.width;
    self.nodesScrollView.contentSize = size;
    
    [self.nodesScrollView flashScrollIndicators];
}


#pragma mark - IBAction Methods
- (IBAction)insertWasPressed:(id)sender
{
    if (self.insertPositionTextField.text.length != 0) {
        [self.list insertNodeWithValue:self.insertPositionTextField.text];
        [self.positionFinderPickerView reloadAllComponents];
    }
}

- (IBAction)deleteWasPressed:(id)sender
{
    NSInteger position = [[self positionFinderPickerView] selectedRowInComponent:0];
    [self.list deleteNodeAtIndex: position ];
    [self.positionFinderPickerView reloadAllComponents];
}

- (IBAction)findWasPressed:(id)sender
{
    DLLNode *node;
    
    node = [self.list findNodeAtIndex:[self.positionFinderPickerView selectedRowInComponent:0]];
    [node flashBackground];
}

- (IBAction)iterateWasPressed:(id)sender
{
    self.iteratedNodesTextView.text = [self.list iterateListString];
}

@end
