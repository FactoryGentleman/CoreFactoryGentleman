// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SimpleObject.h instead.

#import <CoreData/CoreData.h>


extern const struct SimpleObjectAttributes {
	__unsafe_unretained NSString *additionalInteger;
	__unsafe_unretained NSString *someMandatoryString;
} SimpleObjectAttributes;

extern const struct SimpleObjectRelationships {
} SimpleObjectRelationships;

extern const struct SimpleObjectFetchedProperties {
} SimpleObjectFetchedProperties;





@interface SimpleObjectID : NSManagedObjectID {}
@end

@interface _SimpleObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SimpleObjectID*)objectID;





@property (nonatomic, strong) NSNumber* additionalInteger;



@property int64_t additionalIntegerValue;
- (int64_t)additionalIntegerValue;
- (void)setAdditionalIntegerValue:(int64_t)value_;

//- (BOOL)validateAdditionalInteger:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* someMandatoryString;



//- (BOOL)validateSomeMandatoryString:(id*)value_ error:(NSError**)error_;






@end

@interface _SimpleObject (CoreDataGeneratedAccessors)

@end

@interface _SimpleObject (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAdditionalInteger;
- (void)setPrimitiveAdditionalInteger:(NSNumber*)value;

- (int64_t)primitiveAdditionalIntegerValue;
- (void)setPrimitiveAdditionalIntegerValue:(int64_t)value_;




- (NSString*)primitiveSomeMandatoryString;
- (void)setPrimitiveSomeMandatoryString:(NSString*)value;




@end
