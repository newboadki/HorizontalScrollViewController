#import "Kiwi.h"
#import "PageController.h"
#import "CustomViewControllerProtocol.h"

SPEC_BEGIN(PageControllerSpec)

describe(@"PageController", ^{

    beforeEach(^{
        
    });
    
    afterEach(^{
        
    });
    
    it(@"should conform the CustomViewController protocol", ^{
        PageController* pc = [[PageController alloc] init];
        [[pc should] conformToProtocol:@protocol(CustomViewControllerProtocol)];
        [pc release];
    });    
});

SPEC_END