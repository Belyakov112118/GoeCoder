//
//  TransportLayer.m
//  GoeCoder
//
//  Created by Student on 14.02.2020.
//  Copyright © 2020 Student. All rights reserved.
//

#import "TransportLayer.h"

@implementation TransportLayer

static NSString *const SERVER =@"https://geocode-maps.yandex.ru/1.x/";


static NSString *t = @"https://geocode-maps.yandex.ru/1.x/?apikey=&format=json&geocode=";

+(NSString *) getAPIKey{
    return @"a880cf10-7c51-4526-9e32-517f6e45c777";
}

+(NSString *) getURLWithName: (NSString *) name withCount: (int) count{
    NSMutableString *url = [[NSMutableString alloc] initWithString: SERVER];
    [url appendString:@"?"];
    [url appendString:@"format=json&"];
    [url appendFormat:@"apikey=%@&", [self getAPIKey] ];
    [url appendFormat:@"results=%d&", count];
    name = [name stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLHostAllowedCharacterSet];
    [url appendFormat:@"geocode=%@", name];
    return url;
}

+(NSData*) getQuery: (NSString *) name{
    NSString *s = [self getURLWithName:name withCount:100];
    NSURL *url = [NSURL URLWithString:s];
    NSLog(@"%@", url);
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return data;
}

+(NSDictionary *) getData: (NSString *) name{
    NSData *data = [self getQuery: name];
    NSDictionary *ans = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return ans;
}

+(NSArray *) getObjectList: (NSString *) name{
    NSDictionary *d = [self getData: name];
    return d[@"response"][@"GeoObjectCollection"][@"featureMember"];
}

@end
