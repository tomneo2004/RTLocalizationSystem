//
//  RTLocalizationSystem.m
//  RTLocalizationSystem
//
//  Created by tomneo2004 on 2015/8/10.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "RTLocalizationSystem.h"

@interface RTLocalizationSystem ()

- (NSString *)getSettingFilePath;
- (BOOL)saveSettingFile;
- (NSString *)getDocumentsDirectory;

@end

@implementation RTLocalizationSystem{

    NSString *_currentLang;
    NSMutableDictionary *_setting;
}

//setting file name
static NSString *_rtSettingFileName = @"RTLocalizationSystemSetting";
static RTLocalizationSystem *_instance;
static NSBundle *_currentBundle;

#pragma mark - get instance
+ (RTLocalizationSystem *)localizationSystem{

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (id)init{
    
    self = [super init];
    
    if(self){
        
        //get main bundle
        _currentBundle = [NSBundle mainBundle];
        
        NSString *settingFilePath = [self getSettingFilePath];
        
        //if setting file exist in documents directory then we load it otherwise use pre-made one in main bundle;
        if(settingFilePath != nil){
        
            _setting = [[NSMutableDictionary alloc] initWithContentsOfFile:settingFilePath];
        }
        else{
        
            _setting = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_rtSettingFileName ofType:@"plist"]];
            
            //make one copy to documents directory
            [self saveSettingFile];
        }
        
        //set language
        [self setLanguage:[_setting objectForKey:@"language"]];
    }
    
    return self;
}

- (NSString *)localizeStringForKey:(NSString *)key value:(NSString *)comment{
    
    return [_currentBundle localizedStringForKey:key value:comment table:nil];
}

- (void)setLanguage:(NSString *)lang{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    
    //if no match bundle use default language otherwise use custom set
    if(path == nil){
        
        [self resetSystem];
        
        [_setting setValue:[_setting objectForKey:@"default"] forKey:@"language"];
    }
    else{
        
        _currentBundle = [NSBundle bundleWithPath:path];
        
        [_setting setValue:lang forKey:@"language"];
    }
    
    //save setting
    [self saveSettingFile];

}

- (NSString *)getCurrentLanguage{
    
    /*
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    
    for(int i=0; i<languages.count; i++){
        
        NSLog(@"%@", [languages objectAtIndex:i]);
    }
    
    NSString *preferLanguage = [languages objectAtIndex:0];
    
    return preferLanguage;
     */
    
    return [_setting objectForKey:@"language"];
}

- (void)resetSystem{
    
    _currentBundle = [NSBundle mainBundle];
}

- (NSString *)getSettingFilePath{
    
    NSString *settingPlistPath = [[self getDocumentsDirectory] stringByAppendingPathComponent:[_rtSettingFileName stringByAppendingString:@".plist"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:settingPlistPath]){
        
        return settingPlistPath;
    }
    else{
        
        return  nil;
    }
}

- (BOOL)saveSettingFile{

    return [_setting writeToFile:[[self getDocumentsDirectory] stringByAppendingPathComponent:[_rtSettingFileName stringByAppendingString:@".plist"]] atomically:NO];
}

- (NSString *)getDocumentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

@end
