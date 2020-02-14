//
//  ViewController.m
//  GoeCoder
//
//  Created by Student on 14.02.2020.
//  Copyright © 2020 Student. All rights reserved.
//

#import "ViewController.h"
#import "TransportLayer.h"

@interface ViewController (){

    NSMutableArray *data;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchTF.delegate = self;
    _table.delegate = self;
    _table.dataSource = self;
    data = [NSMutableArray new];
    //NSData *data = [TransportLayer getQuery: @"Смоленск"];
    //NSLog(@"%@", data);
    //[self schowResponse];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"return Tapped");
    [self.view endEditing:YES];
    [self schowResponse: [textField text]];
    [_table reloadData];
    return true;
}

-(void) schowResponse: (NSString *) name {
    NSArray *geoObjects = [TransportLayer getObjectList: name];
    data = [NSMutableArray new];
    for (NSDictionary *obj in geoObjects) {
        NSDictionary *d = obj[@"GeoObject"];
        NSString *name = d[@"name"];
        NSString *descr = d[@"description"];
        NSString *pos = d[@"Point"][@"pos"];
        NSString *ans = [NSString stringWithFormat:@"%@, %@, pos: %@", name, descr, pos];
        NSLog(@"%@", ans);
        [data addObject:ans];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell.textLabel setText:data[indexPath.row]];
    return cell;
}

@end
