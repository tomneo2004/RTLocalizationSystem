//
//  RTLocalizationSystem.h
//  RTLocalizationSystem
//
//  Created by tomneo2004 on 2015/8/10.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Return localiztion string
 * Example: RTLocalizeString(@"Hello", @"Hello!!")
 *
 * @param key the key of word in language
 * @param value if there is no match key or key is nil then it will return comment
 */
#define RTLocalizeString(key, comment) \
[[RTLocalizationSystem localizationSystem] localizeStringForKey:(key) value:(comment)]

/**
 * Set system's language
 */
#define RTSetLanguage(lang) \
[[RTLocalizationSystem localizationSystem] setLanguage:(lang)]

/**
 * Get system's current language
 */
#define RTGetLanguage \
[[RTLocalizationSystem localizationSystem] getCurrentLanguage]

/**
 * Reset system
 */
#define RTResetSystem \
[[RTLocalizationSystem localizationSystem] resetSystem]

@interface RTLocalizationSystem : NSObject

/**
 * Return an instance of this localization system
 */
+ (RTLocalizationSystem *)localizationSystem;

/**
 * Return localized string for the key of language
 * It is recommend to use RTLocalizeString(key, comment)
 *
 * @param key the key of word in language
 * @param value if there is no match key or key is nil then it will return comment
 */
- (NSString *)localizeStringForKey:(NSString *)key value:(NSString *)comment;

/**
 * Set language
 */
- (void)setLanguage:(NSString *)lang;

/**
 * Get current language
 */
- (NSString *)getCurrentLanguage;

/**
 * Reset system
 */
- (void)resetSystem;

@end
