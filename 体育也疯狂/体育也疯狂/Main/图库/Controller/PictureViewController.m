//
//  PictureViewController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureViewController.h"
#import "BasePictureViewController.h"
#import "MyButton.h"

@interface PictureViewController ()
{
    
    BasePictureViewController *_currentViewController;
    NSMutableArray *_btnArray;

}
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _btnArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createSectedButton];
    
    [self _createSubViewContrillers];
}


//创建上面的切换按钮
- (void)_createSectedButton
{
    UIColor *color = [UIColor colorWithRed:180 / 255.0 green:53 / 255.0 blue:55 / 255.0 alpha:1];
    
    NSArray *names = @[
                       @"热门",
                       @"足球",
                       @"篮球",
                       @"综合",
                       @"明星"
                       ];
    
    CGFloat buttonWudth = kScreenWidth / names.count;
    for(int i =0 ;i<names.count ; i++)
    {
        Mybutton *button = [Mybutton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWudth * i, 64, buttonWudth, 35);
        
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //选中状态
        [button setTitleColor:color forState:UIControlStateSelected];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(clickSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        [_btnArray addObject:button];
        
    }
    
    
}

//创建子视图
- (void)_createSubViewContrillers
{
    BasePictureViewController *bvc1 = [[BasePictureViewController alloc] init];
    bvc1.view.backgroundColor = [UIColor redColor];
    bvc1.hot = @"1";
    bvc1.feedID = @"15";
    bvc1.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    BasePictureViewController *bvc2 = [[BasePictureViewController alloc] init];
    bvc2.view.backgroundColor = [UIColor purpleColor];
    bvc2.feedID = @"54";
    bvc2.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    BasePictureViewController *bvc3 = [[BasePictureViewController alloc] init];
    bvc3.view.backgroundColor = [UIColor orangeColor];
    bvc3.feedID = @"55";
    bvc3.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    BasePictureViewController *bvc4 = [[BasePictureViewController alloc] init];
    bvc4.view.backgroundColor = [UIColor greenColor];
    bvc4.feedID = @"58";
    bvc4.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    BasePictureViewController *bvc5 = [[BasePictureViewController alloc] init];
    bvc5.view.backgroundColor = [UIColor yellowColor];
    bvc5.feedID = @"59";
    bvc5.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    
    [self addChildViewController:bvc1];
    [self addChildViewController:bvc2];
    [self addChildViewController:bvc3];
    [self addChildViewController:bvc4];
    [self addChildViewController:bvc5];
    
    //需要显示的子视图 将其view 显示到 父视图的view上
    [self.view addSubview:bvc1.view];
    
    _currentViewController = bvc1;
    
    
    Mybutton *button = _btnArray[0];
    button.selected = YES;
    _willButton = button;

    
}



//方法
- (void)clickSelectedAction:(Mybutton *)button
{
    
    NSLog(@"%ld",button.tag);
    BasePictureViewController *bvc1 = [self.childViewControllers objectAtIndex:0];
    BasePictureViewController *bvc2 = [self.childViewControllers objectAtIndex:1];
    BasePictureViewController *bvc3 = [self.childViewControllers objectAtIndex:2];
    BasePictureViewController *bvc4 = [self.childViewControllers objectAtIndex:3];
    BasePictureViewController *bvc5 = [self.childViewControllers objectAtIndex:4];
    
    if((_currentViewController == bvc1 && button.tag ==0) || (_currentViewController == bvc2 && button.tag == 1) || (_currentViewController == bvc3 && button.tag == 2) || (_currentViewController == bvc4 && button.tag ==3) || (_currentViewController == bvc5 && button.tag ==4))
    {
        return;
    }
    else
    {
        BasePictureViewController *oldViewController = _currentViewController;
        
        switch(button.tag)
        {
            case 0:
            {
                [self btnSelect:button];
                
                [self transitionFromViewController:_currentViewController toViewController:bvc1 duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    if(finished)
                    {
                        _currentViewController = bvc1;
                    }
                    else
                    {
                        _currentViewController = oldViewController;
                    }
                }];
            }
                break;
                
            case 1:
            {
                [self btnSelect:button];
                
                [self transitionFromViewController:_currentViewController toViewController:bvc2 duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    if(finished)
                    {
                        _currentViewController = bvc2;
                    }
                    else
                    {
                        _currentViewController = oldViewController;
                    }
                }];
            }
                break;
                
            case 2:
            {
                [self btnSelect:button];
                
                [self transitionFromViewController:_currentViewController toViewController:bvc3 duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    if(finished)
                    {
                        _currentViewController = bvc3;
                    }
                    else
                    {
                        _currentViewController = oldViewController;
                    }
                }];
            }
                break;
                
            case 3:
            {
                [self btnSelect:button];
                
                [self transitionFromViewController:_currentViewController toViewController:bvc4 duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    if(finished)
                    {
                        _currentViewController = bvc4;
                    }
                    else
                    {
                        _currentViewController = oldViewController;
                    }
                }];
            }
                break;
                
            default:
            {
                [self btnSelect:button];
                
                [self transitionFromViewController:_currentViewController toViewController:bvc5 duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    if(finished)
                    {
                        _currentViewController = bvc5;
                    }
                    else
                    {
                        _currentViewController = oldViewController;
                    }
                }];
            }
                break;
        }
        
    }
    
    
}

- (void)btnSelect:(Mybutton*)btn
{
    _willButton.selected = NO;
    
    btn.selected = YES;
    
    _willButton = btn;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
