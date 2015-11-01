//
//  MyStyleViewController.h
//  MyStatus
//
//  Created by NengQuan on 15/10/31.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyStyleViewController;
@protocol MyStyleViewControllerDelegate <NSObject>

@optional
- (void)styleView:(MyStyleViewController *)styleview didChoseColor:(NSString *)coclor;

@end
@interface MyStyleViewController : UIViewController

@property (nonatomic,weak) id <MyStyleViewControllerDelegate> delegate;

@end
