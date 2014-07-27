// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SimpleObject.m instead.

#import "_SimpleObject.h"

const struct SimpleObjectAttributes SimpleObjectAttributes = {
	.additionalInteger = @"additionalInteger",
	.someMandatoryString = @"someMandatoryString",
};

const struct SimpleObjectRelationships SimpleObjectRelationships = {
};

const struct SimpleObjectFetchedProperties SimpleObjectFetchedProperties = {
};

@implementation SimpleObjectID
@end

@implementation _SimpleObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SimpleObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SimpleObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SimpleObject" inManagedObjectContext:moc_];
}

- (SimpleObjectID*)objectID {
	return (SimpleObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"additionalIntegerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"additionalInteger"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic additionalInteger;



- (int64_t)additionalIntegerValue {
	NSNumber *result = [self additionalInteger];
	return [result longLongValue];
}

- (void)setAdditionalIntegerValue:(int64_t)value_ {
	[self setAdditionalInteger:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveAdditionalIntegerValue {
	NSNumber *result = [self primitiveAdditionalInteger];
	return [result longLongValue];
}

- (void)setPrimitiveAdditionalIntegerValue:(int64_t)value_ {
	[self setPrimitiveAdditionalInteger:[NSNumber numberWithLongLong:value_]];
}





@dynamic someMandatoryString;











@end
