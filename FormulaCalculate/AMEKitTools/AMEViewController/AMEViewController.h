//
//  AMEViewController.h
//  AMEKit
//
//  Created by AME on 2017/9/8.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMENavigationItemMaker.h"
#import "AMEHeader.h"


@interface AMEViewController : UIViewController{
    AMENavigationItemMaker * _navigationItemMaker;
}


/**
 navigation制造器
 */
@property (nonatomic, strong, readonly) AMENavigationItemMaker * navigationItemMaker;



@end
