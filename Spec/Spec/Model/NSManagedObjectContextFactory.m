#import "NSManagedObjectContextFactory.h"

@implementation NSManagedObjectContextFactory

+ (NSManagedObjectContext *)testContext
{
    NSBundle *bundle = [NSBundle bundleForClass:self];
    NSString* path = [bundle pathForResource:@"Model" ofType:@"mom"];
    NSURL *modelURL = [NSURL URLWithString:path];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:coordinator];
    return context;
}

@end
