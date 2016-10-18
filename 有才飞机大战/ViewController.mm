//
//  ViewController.m
//  有才飞机大战
//
//  Created by 钩钩硬 on 16/3/5.
//  Copyright © 2016年 Mr.Yu. All rights reserved.
//

#import "ViewController.h"
#import "WYSprite.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    drawView = [[MainView alloc] init];
    self.view = drawView;
    
    [MainView appearance];
    
    // 定时器
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)onTimer:(NSTimer *)sender {
    
    // 调整每个子弹坐标
    // 遍历每个子弹对象
    for (WYSprite *zd in drawView.zidans) {
        
        // 调整y坐标, 减少就是往上走
        zd.y -= 1;
        // 判断子弹是否超出屏幕
        if (!zd.y) {
            
            // 设定这个子弹为无效
            zd.isUsed = NO;
        }
    }
    
    
    // 调整每个敌人坐标
    // 遍历每个敌人对象
    for (WYSprite *dr in drawView.direns) {
        
        // 调整y坐标, 增加就是往下走
        dr.y += 1;
        // 判断敌人是否超出屏幕
        if (dr.y > self.view.frame.size.height) {
            
            // 设定这个敌人为无效
            dr.isUsed = NO;
        }
    }
    
    static int c = 0; // 记录次数
    c++;
    
    // 够5次了 产生敌人
    if (c == 30) {
        
        // 产生敌人
        // 随机产生一个x坐标
        int x = arc4random() % 300;
        
        // 构建敌人对象
        WYSprite *dr = [[WYSprite alloc] init];
        // 设定敌人的x坐标
        dr.x = x;
        // 设定敌人的y坐标
        dr.y = -10;
        // 标示这个敌人是有效的
        dr.isUsed = YES;
        // 把敌人对象放到视图的敌人集合中
        [drawView.direns addObject:dr];
        
        c = 0; // 清零 重新计数
    }
    
    
    // 碰撞检测 检测子弹和敌人两个图片的矩形区域是否相交
    // 遍历每个子弹
    for (WYSprite *zd in drawView.zidans) {
        // 得到当前子弹的矩形范围
        CGRect zdRect = CGRectMake(zd.x, zd.y, 5, 11);
        
        // 遍历每个敌人对象
        for (WYSprite *dr in drawView.direns) {
            
            // 得到当前敌人的矩形范围
            CGRect drRect = CGRectMake(dr.x, dr.y, 57, 43);
            
            // 如果两个矩形相交了
            if (CGRectIntersectsRect(zdRect, drRect)) {
                
                zd.isUsed = NO;  // 子弹无效了
                dr.isUsed = NO;  // 敌人也无效了
                
                // 产生爆炸
                // 构建爆炸对象
                WYSprite *bz = [[WYSprite alloc] init];
                // 设定爆炸的x坐标
                bz.x = dr.x;
                // 设定敌人的y坐标
                bz.y = dr.y;
                // 标示这个敌人是有效的
                bz.isUsed = YES;
                // 把敌人对象放到视图的敌人集合中
                [drawView.baozhas addObject:bz];
            }
        }
    }
    
    
    // 重新绘制屏幕
    [self.view setNeedsDisplay];
}

// 触摸开始事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 获得触摸对象
    UITouch *touch = [touches anyObject];
    // 得到触摸点坐标
    CGPoint p = [touch locationInView:self.view];
    
    // 如果点击点的Y坐标大于400
    if (p.y > 400) {
        
        // 构建子弹对象
        WYSprite *zd = [[WYSprite alloc] init];
        // 设定子弹的x坐标
        zd.x = p.x;
        // 设定子弹的y坐标
        zd.y = p.y;
        // 标示这个子弹是有效的
        zd.isUsed = YES;
        // 把子弹对象放到视图的子弹集合中
        [drawView.zidans addObject:zd];
        
        // 重新绘制视图
        [self.view setNeedsDisplay];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
