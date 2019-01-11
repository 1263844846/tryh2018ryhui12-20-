//
//  RHmaintestAfn.m
//  ryhui
//
//  Created by 糊涂虫 on 15/11/26.
//  Copyright © 2015年 stefan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RHmaintestAfn.h"

@implementation RHmaintestAfn

//- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    // completionBlock is manually nilled out in AFURLConnectionOperation to break the retain cycle.
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-retain-cycles"
//#pragma clang diagnostic ignored "-Wgnu"
//    self.completionBlock = ^{
//        if (self.completionGroup) {
//            dispatch_group_enter(self.completionGroup);
//        }
//        
//        
//        dispatch_async(http_request_operation_processing_queue(), ^{
//            if (self.error) {
//                if (failure) {
//                    dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
//                        failure(self, self.error);
//                        
//                    });
//                }
//            } else {
//                id responseObject = self.responseObject;
//                if (self.error) {
//                    if (failure) {
//                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
//                            failure(self, self.error);
//                        });
//                    }
//                } else {
//                    if (success) {
//                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
//                            success(self, responseObject);
//                        });
//                    }
//                }
//            }
//            
//            if (self.completionGroup) {
//                dispatch_group_leave(self.completionGroup);
//            }
//        });
//    };
//#pragma clang diagnostic pop
//}
@end
