#import <FactoryGentleman/FGFactoryDefiner.h>

#import "CFGDefinitionBuilder.h"

#define CFGFactoryDefine(__CLASS__, __DEFINITION_BLOCK__) \
@interface __CLASS__##FGFactoryDefiner : FGFactoryDefiner \
@property (nonatomic, retain) Class class; \
@end \
@implementation __CLASS__##FGFactoryDefiner \
- (instancetype)init \
{ \
    self = [super initWithObjectClass:[__CLASS__ class]]; \
    return self; \
} \
- (void)registerDefinitions \
{ \
    CFGDefinitionBuilder *builder = (CFGDefinitionBuilder *)[CFGDefinitionBuilder builder]; \
    NSMutableDictionary *traitDefiners = [[NSMutableDictionary alloc] init]; \
    void (^definitionBlock)(CFGDefinitionBuilder *, NSMutableDictionary *traitDefiners) = __DEFINITION_BLOCK__; \
    definitionBlock(builder, traitDefiners); \
    [self registerBaseDefinition:[builder build] \
                   traitDefiners:traitDefiners]; \
} \
\
@end
