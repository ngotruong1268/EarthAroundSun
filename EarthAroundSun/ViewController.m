//
//  ViewController.m
//  EarthAroundSun
//
//  Created by Ngô Sỹ Trường on 4/27/16.
//  Copyright © 2016 ngotruong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSTimer *timer;
    UIImageView *sun;
    UIImageView *sunny;
    UIImageView *earth;
    UIImageView *moon;
    CGPoint sunCenter;
    CGFloat distanceEarthToSun;
    CGFloat distanceMoonToEarth;
    CGFloat angle;
    CGFloat angle2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addSunWithMoonAndEarth];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(spinEarth)
                                           userInfo:nil
                                            repeats:true];
    
}
-(void) addSunWithMoonAndEarth {
    sun  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun.png"]];
    earth  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth.png"]];
    moon  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon.png"]];
    
    CGSize mainViewSize = self.view.bounds.size;
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    sunCenter = CGPointMake(mainViewSize.width * 0.5,
                            (mainViewSize.height + statusNavigationBarHeight) * 0.5 );
    distanceEarthToSun = mainViewSize.width * 0.5 - 60;
    distanceMoonToEarth = mainViewSize.width * 0.5 - distanceEarthToSun - 15;
    
    [self animateSun:sun];
    
    angle = 0.0;
    earth.center = [self computePositionOfEarth:angle];
    [self.view addSubview:earth];
    
    angle = 0.0;
    angle2 = 0.0;
    moon.center = [self computePositionOfMoon:angle2];

    [self.view addSubview:moon];
}

-(CGPoint) computePositionOfEarth : (CGFloat) _angle {
    return CGPointMake(sunCenter.x + distanceEarthToSun * cos(_angle),
                       sunCenter.y + distanceEarthToSun * sin(_angle));
}

-(CGPoint) computePositionOfMoon : (CGFloat) _angle {
    return CGPointMake(earth.center.x + distanceMoonToEarth * cos(_angle),
                       earth.center.y + distanceMoonToEarth * sin(_angle));
}


-(void) animateSun : (UIImageView*) _sun{
    _sun.center = sunCenter;
    _sun.animationImages = @[[UIImage imageNamed:@"sun.png"],
                             [UIImage imageNamed:@"sunny.png"]
                             ];
    _sun.animationRepeatCount = -1;
    _sun.animationDuration = 1;
    [self.view addSubview:_sun];
    [_sun startAnimating];
}

-(void) spinEarth {
    angle += 0.01;
    earth.center = [self computePositionOfEarth:angle];
    
    [self spinMoon];
    
}

-(void) spinMoon {
    angle2 += 0.03;
    moon.center = [self computePositionOfMoon:angle2];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
    
}


@end
