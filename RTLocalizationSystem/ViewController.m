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

- (IBAction)changeToEn:(id)sender;
- (IBAction)changeToChT:(id)sender;
- (void)localizeView;

@end

@implementation ViewController

@synthesize textLabel = _textLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLanguageChanged:) name:RTOnLanguageChanged object:nil];
    
    [self localizeView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeToEn:(id)sender{
    
    RTSetLanguage(@"en");
    
}

- (IBAction)changeToChT:(id)sender{
    
    RTSetLanguage(@"zh-Hant");
    
}

- (void)onLanguageChanged:(NSNotification *)notify{
    
    [self localizeView];
}

- (void)localizeView{

    _textLabel.text = RTLocalizeString(@"Hello", @"Hello");
}



@end
