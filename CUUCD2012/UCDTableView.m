//
//  ERNavigationPaneTableView.m
//  Erudio
//
//  Created by Eric Horacek on 6/19/12.
//  Copyright (c) 2012 Monospace Ltd. All rights reserved.
//

#import "UCDTableView.h"

@interface UCDTableView ()

@property (nonatomic, strong) UIView *topShadow;
@property (nonatomic, strong) UIView *bottomHighlight;
@property (nonatomic, strong) UIView *bottomShadow;

@end

@implementation UCDTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.highlightColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        self.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.selectionColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        
        self.lineOffset = 0.0;
        
        self.topShadow = [[UIView alloc] init];
        [self addSubview:self.topShadow];
        
        self.bottomShadow = [[UIView alloc] init];
        [self addSubview:self.bottomShadow];
        
        self.bottomHighlight = [[UIView alloc] init];
        [self addSubview:self.bottomHighlight];
        
        self.layer.masksToBounds = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bottomHighlight.backgroundColor = self.highlightColor;
    self.bottomShadow.backgroundColor = self.shadowColor;
    self.topShadow.backgroundColor = self.shadowColor;
    
    if ((self.numberOfSections != 0) && ([self numberOfRowsInSection:0] != 0)) {
        
        NSInteger maxSection = ([self.dataSource numberOfSectionsInTableView:self] - 1);
        NSInteger maxRow = ([self.dataSource tableView:self numberOfRowsInSection:maxSection] - 1);
        CGRect bottomCellRect = [self rectForRowAtIndexPath:[NSIndexPath indexPathForRow:maxRow inSection:maxSection]];
        CGRect topCellRect = [self rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        self.bottomHighlight.frame = CGRectMake(0.0, CGRectGetMaxY(bottomCellRect) + 1.0, self.bounds.size.width, 1.0);
        self.bottomShadow.frame = CGRectMake(0.0, CGRectGetMaxY(bottomCellRect), self.bounds.size.width, 1.0);
        self.topShadow.frame = CGRectMake(0.0, CGRectGetMinY(topCellRect) - 1.0, self.bounds.size.width, 1.0);
    }
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    [self setNeedsLayout];
    [super setContentOffset:contentOffset];
}

-(void)setFrame:(CGRect)frame
{
    [self setNeedsLayout];
    [super setFrame:frame];
}

@end
