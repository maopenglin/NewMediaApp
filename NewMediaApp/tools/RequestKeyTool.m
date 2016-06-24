//
//  RequestKeyTool.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/30.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "RequestKeyTool.h"
#import <Base64.h>
#import "HBRSAHandler.h"

@interface RequestKeyTool()
    @property(nonatomic,strong)HBRSAHandler* handler ;
@end
@implementation RequestKeyTool
SYNTHESIZE_SINGLETON_FOR_CLASS(RequestKeyTool)

-(NSString *)decryptBase64Data:(NSString *)requestData{
  NSUInteger length = [requestData length];
    for (NSUInteger i = 0; i < length; i++) {
        int a=(int)[requestData characterAtIndex:i];
         NSRange range = NSMakeRange(i, 1);
        if (a==65) {
             requestData=[requestData stringByReplacingCharactersInRange:range withString:@"Z"];
        }else if(a==97){
            requestData=[requestData stringByReplacingCharactersInRange:range withString:@"z"];
        }else if((a>65&&a<=90)||(a>97&&a<=122)||(a>48&&a <=57)){
           int ch= (a-1);
            NSString *tmp=[NSString stringWithFormat:@"%C",(unichar)ch];
            requestData=[requestData stringByReplacingCharactersInRange:range withString:tmp];
        }
    }

    return  [requestData base64DecodedString];
}

-(BOOL)rsaValidata:(NSString *)input withSign:(NSString *)sign{
    if (!self.handler){
        NSString *publicKey=@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCti2ntrFQA+9aeoloWIOlS2IJK16pDH1mBv1YK5Elav428XumD0TVqnDTZxWwtrteGngU1K+ka5rskd1UDxmZTQ7EDU9RVwAr4fDQbKdDWe1LWkYgubPFmQQ8qizicOjkbFxWsNWEZMb4Blq8hz55KOMpsuaVJa18r3gX4VNFL8QIDAQAB";
        
        self.handler = [HBRSAHandler new];
        [self.handler importKeyWithType:KeyTypePublic andkeyString:publicKey];
    }
    
    return [self.handler verifyString:input withSign:sign];
    /**
     NSString *content=@"JnGiZXKjZjJ=";
     NSString *nusign=@"U27pDz4zlPOdTI66ur9PQfDXFsKzSY82TtvaGsRyajCm6gn0rJK62H45U1zM2u+VMkH7r8hX6l5PGRPhIm8itwf5XKmbJuFC6nFrOgD8ZPH8AM3Yv0JahDIi6cvVY1kQ1arMdJBLjS+BgYIpPufSVfvt3v7EXrUHYM8XDr92j\/U=";
     BOOL result=[[RequestKeyTool sharedRequestKeyTool] rsaValidata:content withSign:nusign];
     **/
}
@end
