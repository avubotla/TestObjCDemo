//
//  ViewController.m
//  TestObjCDemo
//
//  Created by VIPadm on 17/05/18.
//  Copyright © 2018 botla. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *jsonStr = @"[{\"id\": \"1\", \"name\": \"Venkatesh\"}]";
    
    // calling staticJSONDataReading
    [self staticJSONDataReading:jsonStr];
    
    
    NSString *urlString = @"https://api.github.com/users/hadley/orgs";
    NSURL *jsonUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", urlString]];

    // calling daynamicJSONDataReading
    [self dynamicJSONDataReading:jsonUrl];
}


// JSONObjectWithData:  A data object containing JSON data
//            options:  Optoins for reading the JSON data and creating the Foundation objects
//              error:  If an error occurs, upon return contains an NSError object that describes the problem

// ==> [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]

-(void)staticJSONDataReading: (NSString *)jsonString {
    NSError *error = nil;
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    } else {
        if ([json isKindOfClass:[NSString class]] == YES) {
            NSLog(@"Response is in string format");
        }
        else if ([json isKindOfClass:[NSDictionary class]] == YES) {
            NSLog(@"Response is in dictionary format");
        }
        else if ([json isKindOfClass:[NSArray class]] == YES) {
            NSLog(@"Response is in array format");
            for (NSDictionary *item in json) {
                NSLog(@"Item: %@", item);
            }
        }
    }
}


-(void)dynamicJSONDataReading:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //NSLog(@"json data from url: %@", json);
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    } else {
        if ([json isKindOfClass:[NSString class]] == YES) {
            NSLog(@"Response is in string format");
        }
        else if ([json isKindOfClass:[NSDictionary class]] == YES) {
            NSLog(@"Response is in dictionary format");
        }
        else if ([json isKindOfClass:[NSArray class]] == YES) {
            NSLog(@"Response is in array format");
//            for (NSDictionary *restData in [json valueForKey:@"id"]) { // get values from array use "valueForkey"
//                NSLog(@"Rest Data: %@", restData);
//            }
            for (NSDictionary *restData in json) {
                //NSLog(@"Rest Data: %@", restData);
                
                NSString *idStr = [restData objectForKey:@"id"]; // get values from dictionary use "objectForkey"
                NSString *description = [restData objectForKey:@"description"];
               
                NSLog(@"Id: %@, \nDescription: %@\n", idStr, description);
                
            }
        }
    }
    
    
    
}

@end
