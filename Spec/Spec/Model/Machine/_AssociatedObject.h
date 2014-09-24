// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AssociatedObject.h instead.

#import <CoreData/CoreData.h>

extern const struct AssociatedObjectAttributes {
	__unsafe_unretained NSString *anotherString;
} AssociatedObjectAttributes;

extern const struct AssociatedObjectRelationships {
	__unsafe_unretained NSString *simpleObject;
} AssociatedObjectRelationships;

@class SimpleObject;

@interface AssociatedObjectID : NSManagedObjectID {}
@end

@interface _AssociatedObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AssociatedObjectID* objectID;

@property (nonatomic, strong) NSString* anotherString;

//- (BOOL)validateAnotherString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) SimpleObject *simpleObject;

//- (BOOL)validateSimpleObject:(id*)value_ error:(NSError**)error_;

@end

@interface _AssociatedObject (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAnotherString;
- (void)setPrimitiveAnotherString:(NSString*)value;

- (SimpleObject*)primitiveSimpleObject;
- (void)setPrimitiveSimpleObject:(SimpleObject*)value;

@end
