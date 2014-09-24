#import "CFGCoreFactoryGentleman.h"

#import "SimpleObject.h"

#import "NSManagedObjectContextFactory.h"

SpecBegin(CFGFactoryGentleman)
    __block NSManagedObjectContext *moc;
    __block SimpleObject *builtObject;

    before(^{
        moc = [NSManagedObjectContextFactory testContext];
    });

    describe(@"CFGBuild", ^{
        before(^{
            builtObject = CFGBuild(moc, [SimpleObject class]);
        });

        it(@"builds an object from the definition", ^{
            expect(builtObject.managedObjectContext).to.equal(moc);
            expect(builtObject.someMandatoryString).to.equal(@"foo");
            expect(builtObject.additionalInteger).to.equal(@2);
        });

        it(@"doesn't save the context", ^{
            expect(moc.hasChanges).to.beTruthy();
        });

    });

    describe(@"CFGBuildTrait", ^{
        before(^{
            builtObject = CFGBuildTrait(moc, [SimpleObject class], @"trait");
        });

        it(@"builds an object from the trait definition", ^{
            expect(builtObject.managedObjectContext).to.equal(moc);
            expect(builtObject.someMandatoryString).to.equal(@"foo");
            expect(builtObject.additionalInteger).to.equal(@7);
        });

        it(@"doesn't save the context", ^{
            expect(moc.hasChanges).to.beTruthy();
        });
    });

    describe(@"CFGBuildWith", ^{
        context(@"when definer is dictionary", ^{
            before(^{
                builtObject = CFGBuildWith(moc, [SimpleObject class], @{ @"someMandatoryString" : @"overriden" });
            });

            it(@"builds an object from the overriden definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@2);
            });

            it(@"doesn't save the context", ^{
                expect(moc.hasChanges).to.beTruthy();
            });
        });

        context(@"when definer is block", ^{
            before(^{
                builtObject = CFGBuildWith(moc, [SimpleObject class], ^(CFGDefinitionBuilder *builder) {
                    [builder field:@"someMandatoryString" value:@"overriden"];
                });
            });

            it(@"builds an object from the overriden definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@2);
            });

            it(@"doesn't save the context", ^{
                expect(moc.hasChanges).to.beTruthy();
            });
        });
    });

    describe(@"CFGBuildTraitWith", ^{
        context(@"when definer is dictionary", ^{
            before(^{
                builtObject = CFGBuildTraitWith(moc, [SimpleObject class], @"trait", @{ @"someMandatoryString" : @"overriden" });
            });

            it(@"builds an object from the overriden trait definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@7);
            });

            it(@"doesn't save the context", ^{
                expect(moc.hasChanges).to.beTruthy();
            });
        });

        context(@"when definer is block", ^{
            before(^{
                builtObject = CFGBuildTraitWith(moc, [SimpleObject class], @"trait", ^(CFGDefinitionBuilder *builder) {
                    [builder field:@"someMandatoryString" value:@"overriden"];
                });
            });

            it(@"builds an object from the overriden trait definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@7);
            });

            it(@"doesn't save the context", ^{
                expect(moc.hasChanges).to.beTruthy();
            });
        });
    });

    describe(@"CFGCreate", ^{
        before(^{
            builtObject = CFGCreate(moc, [SimpleObject class]);
        });

        it(@"builds an object from the definition", ^{
            expect(builtObject.managedObjectContext).to.equal(moc);
            expect(builtObject.someMandatoryString).to.equal(@"foo");
            expect(builtObject.additionalInteger).to.equal(@2);
        });

        it(@"saves the context", ^{
            expect(moc.hasChanges).to.beFalsy();
        });
    });

    describe(@"CFGCreateTrait", ^{
        before(^{
            builtObject = CFGCreateTrait(moc, [SimpleObject class], @"trait");
        });

        it(@"builds an object from the trait definition", ^{
            expect(builtObject.managedObjectContext).to.equal(moc);
            expect(builtObject.someMandatoryString).to.equal(@"foo");
            expect(builtObject.additionalInteger).to.equal(@7);
        });

        it(@"saves the context", ^{
            expect(moc.hasChanges).to.beFalsy();
        });
    });

    describe(@"CFGCreateWith", ^{
        context(@"when definer is dictionary", ^{
            before(^{
                builtObject = CFGCreateWith(moc, [SimpleObject class], @{ @"someMandatoryString" : @"overriden" });
            });

            it(@"builds an object from the overriden definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@2);
            });

            it(@"saves the context", ^{
                expect(moc.hasChanges).to.beFalsy();
            });
        });

        context(@"when definer is block", ^{
            before(^{
                builtObject = CFGCreateWith(moc, [SimpleObject class], ^(CFGDefinitionBuilder *builder) {
                    [builder field:@"someMandatoryString" value:@"overriden"];
                });
            });

            it(@"builds an object from the overriden definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@2);
            });

            it(@"saves the context", ^{
                expect(moc.hasChanges).to.beFalsy();
            });
        });
    });

    describe(@"CFGCreateTraitWith", ^{
        context(@"when definer is dictionary", ^{
            before(^{
                builtObject = CFGCreateTraitWith(moc, [SimpleObject class], @"trait", @{ @"someMandatoryString" : @"overriden" });
            });

            it(@"builds an object from the overriden trait definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@7);
            });

            it(@"saves the context", ^{
                expect(moc.hasChanges).to.beFalsy();
            });
        });

        context(@"when definer is block", ^{
            before(^{
                builtObject = CFGCreateTraitWith(moc, [SimpleObject class], @"trait", ^(CFGDefinitionBuilder *builder) {
                    [builder field:@"someMandatoryString" value:@"overriden"];
                });
            });

            it(@"builds an object from the overriden trait definition", ^{
                expect(builtObject.managedObjectContext).to.equal(moc);
                expect(builtObject.someMandatoryString).to.equal(@"overriden");
                expect(builtObject.additionalInteger).to.equal(@7);
            });

            it(@"saves the context", ^{
                expect(moc.hasChanges).to.beFalsy();
            });
        });
    });
SpecEnd
