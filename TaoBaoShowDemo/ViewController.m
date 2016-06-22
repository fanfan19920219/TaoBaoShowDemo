//
//  ViewController.m
//  TaoBaoShowDemo
//
//  Created by zhangzhihua on 15/12/23.
//  Copyright © 2015年 zhangzhihua. All rights reserved.
//

#import "ViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface ViewController ()
{
    UIImageView*_showView;
    UIButton *_buyButton;
    BOOL  orBig;
    UIView *_jumpView;
    UILabel *_label;
    UIImageView *_imageview;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化View
    
    
    _label = [[UILabel alloc]init];
    _label.text = @"";
    _label.backgroundColor = [UIColor blackColor];
    _label.bounds = CGRectMake(0, 0, 200, 100);
    _label.center = CGPointMake(WIDTH/2, HEIGHT/6);
    _label.textAlignment = NSTextAlignmentCenter;
    
    orBig = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _showView = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT)];
    _showView.image = [UIImage imageNamed:@"越女1.jpg"];
    _showView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _showView.clipsToBounds = NO;
    //[_showView addSubview:_label];
    //_showView.layer.position = CGPointMake(0,0.5);
    _showView.layer.anchorPoint = CGPointMake(0.5,1);
//    _imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"越女.jpg"]];
//    _imageview.frame = self.view.frame;
//    _imageview.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [_showView addSubview:_imageview];
    [self.view addSubview:_showView];
    [self create_buybutton];
}
-(void)create_buybutton{
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.frame = CGRectMake(0, HEIGHT - 50,  WIDTH, 50);
    _buyButton.backgroundColor = [UIColor orangeColor];
    [_buyButton addTarget:self action:@selector(animationMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buyButton];
    
    //初始化弹出view
    _jumpView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, HEIGHT)];
    _jumpView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_jumpView];
}

-(void)animationMethod{
    
    _buyButton.hidden = YES;
    [self animation];
    [UIView animateWithDuration:0.7 animations:^{
        _jumpView.frame = CGRectMake(-WIDTH*0.1, HEIGHT*0.3, WIDTH*3, HEIGHT);
        _label.bounds = CGRectMake(0, 0, _label.bounds.size.width*0.9, _label.bounds.size.height*0.9);
        _label.center = CGPointMake((WIDTH/2)*0.9, (HEIGHT/6)*0.9);
//        _imageview.bounds = CGRectMake(0, 0, WIDTH*0.85, HEIGHT*0.97);
        _imageview.center = CGPointMake((WIDTH*0.85)/2, (HEIGHT*0.97)/2);
    }];
}

-(void)animation{
    CAAnimationGroup *animationgroup = [[CAAnimationGroup alloc]init];
    
    //创建改变角度的动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    //制作角度
    CATransform3D Transform1 = CATransform3DIdentity;
    Transform1.m34 = -0.01;
    Transform1 = CATransform3DRotate(Transform1,M_PI / 180 * 0, 1000, 0, 0);
    
    CATransform3D Transform2 = CATransform3DIdentity;
    Transform2.m34 = -0.01;
    Transform2 = CATransform3DRotate(Transform1,M_PI / 180 * 0.8, 1000, 0, 0);
    
    CATransform3D Transform3 = CATransform3DIdentity;
    Transform3.m34 = -0.01;
    Transform3 = CATransform3DRotate(Transform1,M_PI / 180 * 0, 1000, 0, 0);
    
    keyAnimation.values = @[[NSValue valueWithCATransform3D:Transform1],[NSValue valueWithCATransform3D:Transform2],[NSValue valueWithCATransform3D:Transform3]];
    keyAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:1.0f]];
    
    CAKeyframeAnimation *boundsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    if(orBig){
        boundsAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH*0.85, HEIGHT*0.95)]];
        boundsAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.4f], [NSNumber numberWithFloat:1.0f]];
    }else{
        boundsAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH*0.85, HEIGHT*0.95)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)]];
        boundsAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:1.0f]];
    }
    
    animationgroup.animations = @[keyAnimation,boundsAnimation];
    animationgroup.duration = 0.7;
    animationgroup.delegate = self;
    animationgroup.removedOnCompletion = NO;
    animationgroup.fillMode = kCAFillModeForwards;
    [_showView.layer addAnimation:animationgroup forKey:@"23"];
    
    //imageAnimation
    CAKeyframeAnimation *imageboundsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    if(orBig){
        imageboundsAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH*0.85, HEIGHT*0.97)]];
        imageboundsAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.4f], [NSNumber numberWithFloat:1.0f]];
    }else{
        imageboundsAnimation.values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH*0.85, HEIGHT*0.97)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)],[NSValue valueWithCGRect:CGRectMake(0, 0, WIDTH, HEIGHT)]];
        imageboundsAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:1.0f]];
    }
    
    
    imageboundsAnimation.duration = 0.7;
    imageboundsAnimation.delegate = self;
    imageboundsAnimation.removedOnCompletion = NO;
    imageboundsAnimation.fillMode = kCAFillModeForwards;
    [_imageview.layer addAnimation:imageboundsAnimation forKey:@"234"];
    
    
    
    
    
    
    orBig  = !orBig;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _buyButton.hidden = !orBig;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"222");
    [self animationMethod];
    [UIView animateWithDuration:0.7 animations:^{
        _jumpView.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHT);
        _label.bounds = CGRectMake(0, 0, 200, 100);
        _label.center = CGPointMake(WIDTH/2, HEIGHT/6);
//        _imageview.bounds = CGRectMake(0, 0, WIDTH, HEIGHT);
        _imageview.center = CGPointMake(WIDTH/2, HEIGHT/2);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
