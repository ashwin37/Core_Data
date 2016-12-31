//
//  DataViewController.h
//  Core_Data
//
//  Created by Rakesh Viparla on 12/6/16.
//  Copyright © 2016 adroit37. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *carMakeTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *carModelTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *carYearTxtFld;

@property (strong)NSManagedObjectModel *deviceObjModel;

@end