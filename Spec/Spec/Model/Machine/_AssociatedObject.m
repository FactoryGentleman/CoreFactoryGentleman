// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AssociatedObject.m instead.

#import "_AssociatedObject.h"

const struct AssociatedObjectAttributes AssociatedObjectAttributes = {
	.anotherString = @"anotherString",
};

const struct AssociatedObjectRelationships AssociatedObjectRelationships = {
	.simpleObject = @"simpleObject",
};

@implementation AssociatedObjectID
@end

@implementation _AssociatedObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AssociatedObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AssociatedObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AssociatedObject" inManagedObjectContext:moc_];
}

- (AssociatedObjectID*)objectID {
	return (AssociatedObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic anotherString;

@dynamic simpleObject;

@end

