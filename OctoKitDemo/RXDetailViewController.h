//
//  RXDetailViewController.h
//  OctoKitDemo
//
//  Created by Naoki Tsutsui on 2014/01/04.
//  Copyright (c) 2014年 nkapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
