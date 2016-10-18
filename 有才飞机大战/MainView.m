//
//  MainView.m
//  有才飞机大战
//
//  Created by 钩钩硬 on 16/3/5.
//  Copyright © 2016年 Mr.Yu. All rights reserved.
//

#import "MainView.h"
#import "WYSprite.h"

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 加载敌人图片
        direnImage = [UIImage imageNamed:@"enemy1"];
        // 加载子弹图片
        zidanImage = [UIImage imageNamed:@"bullet2"];
        // 加载爆炸图片
        baozhaImage = [UIImage imageNamed:@"enemy1_down3"];
        // 构建保存所有子弹对象的集合
        self.zidans = [[NSMutableArray alloc] initWithCapacity:100];
        // 构建保存所有敌人对象的集合
        self.direns = [[NSMutableArray alloc] initWithCapacity:100];
        // 构建保存所有爆炸对象的集合
        self.baozhas = [[NSMutableArray alloc] initWithCapacity:100];
    }
    return self;
}




- (void)drawRect:(CGRect)rect {
    
    /*子弹*/
    // 统计有多少要移除的子弹
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:100];
    
    // 遍历集合
    for (WYSprite *zd in self.zidans) {
        
        // 如果子弹无效
        if (!zd.isUsed) {
            // 放到要移除的集合里
            [arr addObject:zd];
        }
    }
    // 移除无效子弹
    [self.zidans removeObjectsInArray:arr];
    
    // 绘制子弹
    // 遍历子弹集合
    for (WYSprite *zd in self.zidans) {

            // 绘制每个子弹
            [zidanImage drawAtPoint:CGPointMake(zd.x, zd.y)];
    }
    
    
    
    /*敌人*/
    // 统计有多少要移除的敌人
    [arr removeAllObjects];
    
    // 遍历集合
    for (WYSprite *zd in self.direns) {
        
        // 如果敌人无效
        if (!zd.isUsed) {
            // 放到要移除的集合里
            [arr addObject:zd];
        }
    }
    // 移除无效敌人
    [self.direns removeObjectsInArray:arr];
    
    // 遍历敌人集合
    for (WYSprite *dr in self.direns) {
        
        // 绘制每个敌人
        [direnImage drawAtPoint:CGPointMake(dr.x, dr.y)];
    }
    
    /*爆炸*/
    // 统计有多少要移除的爆炸
    // 遍历集合
    [arr removeAllObjects];
    
    for (WYSprite *bz in self.baozhas) {
        
        // 如果爆炸有效
        if (bz.isUsed) {
            // 放到要移除的集合里
            [arr addObject:bz];
            // 绘制每个爆炸
            [baozhaImage drawAtPoint:CGPointMake(bz.x, bz.y)];
        }
    }
    // 移除无效爆炸
    [self.baozhas removeObjectsInArray:arr];
    
    
    NSLog(@"子弹总数 = %d, 敌人总数 = %d, 爆炸总数 = %d", self.zidans.count, self.direns.count, self.baozhas.count);
}


@end
