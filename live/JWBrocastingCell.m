//
//  JWBrocastingCell.m
//  live
//
//  Created by Jungle Wind on 6/12/16.
//  Copyright © 2016 Jungle Wind. All rights reserved.
//

#import "JWBrocastingCell.h"

@interface JWBrocastingCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *audienceLabel;

@end

@implementation JWBrocastingCell

- (void)setRoom:(JWRoom *)room {
    _room = room;
    self.titleLabel.text = _room.title;
    self.audienceLabel.text = [NSString stringWithFormat:@"%ld正在观看",(long)_room.audienceCount];
}

@end
