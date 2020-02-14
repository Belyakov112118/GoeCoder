//
//  ViewController.h
//  GoeCoder
//
//  Created by Student on 14.02.2020.
//  Copyright © 2020 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

