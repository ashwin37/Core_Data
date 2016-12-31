//
//  DataViewController.m
//  Core_Data
//
//  Created by Rakesh Viparla on 12/6/16.
//  Copyright © 2016 adroit37. All rights reserved.
//

#import "DataViewController.h"
#import <CoreData/CoreData.h>

@interface DataViewController ()

@end

@implementation DataViewController
@synthesize deviceObjModel;

-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate  = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.deviceObjModel) {
        [self.carMakeTxtFld setText:[self.deviceObjModel valueForKey:@"item1"]];
        [self.carModelTxtFld setText:[self.deviceObjModel valueForKey:@"item2"]];
        [self.carYearTxtFld setText:[self.deviceObjModel valueForKey:@"itme3"]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)carMakeTxtActn:(id)sender {
    
    // Go to Story Board and click on Data View Controller and go back to the right side last connections inspector and then toggle the Did End on Exit connection to the second and third Text Field //
    
    [self resignFirstResponder];
}

- (IBAction)saveDataBtn:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.deviceObjModel) {
        [self.deviceObjModel setValue:self.carMakeTxtFld.text forKey:@"item1"];
        [self.deviceObjModel setValue:self.carModelTxtFld.text forKey:@"item2"];
        [self.deviceObjModel setValue:self.carYearTxtFld.text forKey:@"itme3"];
    }
    else{
        NSManagedObject *newmanagedObj = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        [newmanagedObj setValue:self.carMakeTxtFld.text forKey:@"item1"];
        [newmanagedObj setValue:self.carModelTxtFld.text forKey:@"item2"];
        [newmanagedObj setValue:self.carYearTxtFld.text forKey:@"itme3"];
    }
   
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@ %@", error, [error localizedDescription]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end