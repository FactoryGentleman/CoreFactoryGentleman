#import <Foundation/Foundation.h>
#import <FactoryGentleman/FactoryGentleman.h>

#import "CFGDefinitionBuilder.h"

@interface CFGFactoryDefiner : FGFactoryDefiner
@end

#define CFGFactoryBegin(__CLASS__) \
@interface __CLASS__##CFGFactoryDefiner : CFGFactoryDefiner \
@property (nonatomic, retain) Class class; \
@end \
@implementation __CLASS__##CFGFactoryDefiner \
- (instancetype)init \
{ \
    self = [super initWithObjectClass:[__CLASS__ class]]; \
    return self; \
} \
- (void)registerDefinitions \
{ \
    CFGDefinitionBuilder *builder = (CFGDefinitionBuilder *)[CFGDefinitionBuilder builder]; \
    NSMutableDictionary *traitDefiners = [[NSMutableDictionary alloc] init]; \

#define CFGFactoryEnd \
    [self registerBaseDefinition:[builder build] \
                   traitDefiners:traitDefiners]; \
} \
\
@end
