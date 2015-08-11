//
//  ViewController.m
//  RTLocalizationSystem
//
//  Created by tomneo2004 on 2015/8/10.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "ViewController.h"
#import "RTLocalizationSystem.h"

@interface ViewController ()

- (IBAction)ChangeToEn:(id)sender;
- (IBAction)ChangeToChT:(id)sender;

@end

@implementation ViewController

@synthesize textLabel = _textLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    _textLabel.text = RTLocalizeString(@"Hello", @"Hello");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ChangeToEn:(id)sender{
    
    RTSetLanguage(@"en");
    
    [self viewWillAppear:YES];
}

- (IBAction)ChangeToChT:(id)sender{
    
    RTSetLanguage(@"zh-Hant");
    
    [self viewWillAppear:YES];
}

@end
