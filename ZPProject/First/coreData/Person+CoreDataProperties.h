//
//  Person+CoreDataProperties.h
//  ZPProject
//
//  Created by lizp on 16/8/7.
//  Copyright © 2016年 LZP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Department *relationship;

@end

NS_ASSUME_NONNULL_END
