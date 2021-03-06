
/**
 *
 * Created by https://github.com/mythkiven/ on 19/05/29.
 * Copyright © 2019年 mythkiven. All rights reserved.
 *
 */


#import "MKFunctions.h"


NSString* MKStringSearch(NSString* string, NSString* pattern) {
    if (!string)
        return nil;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        return nil;
    }
    
    NSRange range = {.location=0, .length=string.length};
    NSTextCheckingResult* result = [regex firstMatchInString:string options:0 range:range];
    
    return result ? [string substringWithRange:result.range] : nil;
}

NSString* MKStringReplace(NSString* string, NSString* pattern, NSString* replaceString) {
    if (!string)
        return string;
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        return nil;
    }
    
    NSRange range = {.location=0, .length=string.length};
    return [regex stringByReplacingMatchesInString:string
                                           options:NSMatchingReportProgress
                                             range:range
                                      withTemplate:replaceString];
}

NSString* MKStringRemovePrefix(NSString* string, NSString* prefix) {
    if ([string hasPrefix:prefix]) {
        string = [string substringFromIndex:prefix.length];
    }
    
    return string;
}

NSString* MKStringRemoveSuffix(NSString* string, NSString* suffix) {
    if ([string hasSuffix:suffix]) {
        string = [string substringToIndex:string.length - suffix.length];
    }
    
    return string;
}


BOOL MKPathExists(NSString* path, NSString** fileType) {
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    
    if (error) {
        return NO;
    }
    
    if (fileType) {
        *fileType = attributes[NSFileType];
    }
    
    return YES;
}

BOOL MKPathFileExists(NSString* path) {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

BOOL MKPathDirectoryExists(NSString* path) {
    BOOL isDirectory;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return exists && isDirectory;
}
