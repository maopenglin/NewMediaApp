//
//  NMBaseEntity.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@interface NMBaseEntity : JSONModel
@property(nonatomic, strong) NSNumber *testNumber;
@property(nonatomic, strong) NSString *testCase;
@end
