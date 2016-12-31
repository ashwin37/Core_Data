//
//  ViewController.m
//  Core_Data
//
//  Created by Rakesh Viparla on 12/4/16.
//  Copyright © 2016 adroit37. All rights reserved.
//

#import "ViewController.h"
#import "DataViewController.h"
#import <CoreData/CoreData.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong) NSMutableArray *deviceArray;
@property (strong, nonatomic) IBOutlet UITableView *contentTBV;

@end

@implementation ViewController

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

}

-(void)viewDidAppear:(BOOL)animated{
    
    NSManagedObjectContext *managedObjContext = [self managedObjectContext];
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]initWithEntityName:@"Device"];
    self.deviceArray = [[managedObjContext executeFetchRequest:fetchReq error:nil] mutableCopy];
    [self.contentTBV reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_contentTBV dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSManagedObjectModel *device = [self.deviceArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"item1"], [device valueForKey:@"item2"]]];
    [cell.detailTextLabel setText:[device valueForKey:@"itme3"]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [context deleteObject:[self.deviceArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@ %@", error, [error localizedDescription]);
        }
        
        [self.deviceArray removeObjectAtIndex:indexPath.row];
        [self.contentTBV deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([[segue identifier] isEqualToString:@"updateCarDetails"]) {
        
        NSManagedObjectModel *selectedDevice = [self.deviceArray objectAtIndex:[[self.contentTBV indexPathForSelectedRow] row]];
        DataViewController *dataView  = segue.destinationViewController;
        dataView.deviceObjModel = selectedDevice;
    }
}

@end