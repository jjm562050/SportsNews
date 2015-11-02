//
//  NewsViewController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "NewsViewController.h"
#import "BaseNewsViewController.h"

@interface NewsViewController ()
{
    BaseNewsViewController *_currentViewController;
    NSMutableArray *_btnArray;

}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _btnArray = [[NSMutableArray alloc] init];
    
    [self _createSectedButton];
    
    [self _createSubViewContrillers];
}


//创建上面的切换按钮
- (void)_createSectedButton
{
     UIColor *color = [UIColor colorWithRed:180 / 255.0 green:53 / 255.0 blue:55 / 255.0 alpha:1];
    
    NSArray *names = @[
                       @"头条",
                       @"足球",
                       @"篮球",
                       @"综合",
                       ];
    
    CGFloat buttonWudth = kScreenWidth / names.count;
    for(int i =0 ;i<names.count ; i++)
    {
        Mybutton *button = [Mybutton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWudth * i, 64, buttonWudth, 35);
        
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[button setBackgroundColor:[UIColor cyanColor]];
        
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
    BaseNewsViewController *bvc1 = [[BaseNewsViewController alloc] init];
    bvc1.view.backgroundColor = [UIColor redColor];
    bvc1.aName = @"headline";
    bvc1.catid = @"aef";
    bvc1.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    BaseNewsViewController *bvc2 = [[BaseNewsViewController alloc] init];
    bvc2.view.backgroundColor = [UIColor purpleColor];
    bvc2.aName = @"getList";
    bvc2.catid = @"6";
    bvc2.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    BaseNewsViewController *bvc3 = [[BaseNewsViewController alloc] init];
    bvc3.view.backgroundColor = [UIColor orangeColor];
    bvc3.aName = @"getList";
    bvc3.catid = @"7";
    bvc3.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    BaseNewsViewController *bvc4 = [[BaseNewsViewController alloc] init];
    bvc4.view.backgroundColor = [UIColor greenColor];
    bvc4.aName = @"getList";
    bvc4.catid = @"12";
    bvc4.view.frame = CGRectMake(0, 99, kScreenWidth, kScreenHeight);
    
    
    [self addChildViewController:bvc1];
    [self addChildViewController:bvc2];
    [self addChildViewController:bvc3];
    [self addChildViewController:bvc4];
    
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
    BaseNewsViewController *bvc1 = [self.childViewControllers objectAtIndex:0];
    BaseNewsViewController *bvc2 = [self.childViewControllers objectAtIndex:1];
    BaseNewsViewController *bvc3 = [self.childViewControllers objectAtIndex:2];
    BaseNewsViewController *bvc4 = [self.childViewControllers objectAtIndex:3];
    
    if((_currentViewController == bvc1 && button.tag ==0) || (_currentViewController == bvc2 && button.tag == 1) || (_currentViewController == bvc3 && button.tag == 2) || (_currentViewController == bvc4 && button.tag ==3))
    {
        return;
    }
    else
    {
        BaseNewsViewController *oldViewController = _currentViewController;
        
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
                
            default:
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
