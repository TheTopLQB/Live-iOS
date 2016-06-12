//
//  JWLiveAudienceViewController.m
//  live
//
//  Created by Jungle Wind on 6/12/16.
//  Copyright © 2016 Jungle Wind. All rights reserved.
//

#import "JWLiveAudienceViewController.h"

@interface JWLiveAudienceViewController()

@property (weak, nonatomic) IBOutlet UIView *playerView;

@end

@implementation JWLiveAudienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"room id : %@", self.room.roomId);
}

#pragma mark - Event Handlers

- (IBAction)endWatching:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
