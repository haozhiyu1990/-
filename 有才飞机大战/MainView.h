//
//  MainView.h
//  有才飞机大战
//
//  Created by 钩钩硬 on 16/3/5.
//  Copyright © 2016年 Mr.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
{
    UIImage *zidanImage;   ///< 子弹图像
    UIImage *direnImage;   ///< 敌人图像
    UIImage *baozhaImage;  ///< 爆炸图像
}

@property(nonatomic, strong)NSMutableArray *zidans;   ///< 所有子弹
@property(nonatomic, strong)NSMutableArray *direns;   ///< 所有敌人
@property(nonatomic, strong)NSMutableArray *baozhas;  ///< 所有爆炸


@end
