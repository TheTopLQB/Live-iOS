//
//  JWDashboardViewController.m
//  live
//
//  Created by Jungle Wind on 6/12/16.
//  Copyright © 2016 Jungle Wind. All rights reserved.
//

#import "JWDashboardViewController.h"
#import "JWBrocastingCell.h"
#import "JWRoom.h"
#import "JWLiveAudienceViewController.h"

@interface JWDashboardViewController()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<JWRoom *> *rooms;

@end

@implementation JWDashboardViewController


#pragma mark - Event Handlers

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[JWLiveAudienceViewController class]]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath){
            JWRoom *room = self.rooms[indexPath.row];
            JWLiveAudienceViewController *audienceVC = (JWLiveAudienceViewController *)segue.destinationViewController;
            audienceVC.room = room;
        }
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JWBrocastingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JWBrocastingCell"];
    cell.room = self.rooms[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.rooms.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Getters & Setters

- (NSArray<JWRoom *> *)rooms{
    if (!_rooms){
        NSMutableArray *rooms = [NSMutableArray array];
        for (int i=0;i<5;i++){
            JWRoom *r = [[JWRoom alloc] init];
            r.roomId = [[NSUUID UUID] UUIDString];
            r.title = [NSString stringWithFormat:@"JWRoom-%d",i];
            r.audienceCount = ABS(arc4random() % 10000);
            [rooms addObject:r];
        }
        _rooms = rooms;
    }
    return _rooms;
}

@end
