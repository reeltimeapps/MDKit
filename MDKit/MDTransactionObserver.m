//
//  MDTransactionObserver.m
//  MDKit
//
//  Created by Matthew Dicembrino on 2012-08-17.
//
//

#import "MDTransactionObserver.h"
#import "MDBase64.h"

@interface MDTransactionObserver ()

@property (getter = isRestoring) BOOL restore;
@property (strong, nonatomic) NSMutableArray *transactions;

@end

@implementation MDTransactionObserver

#pragma mark - Public Methods

+ (MDTransactionObserver *)sharedObserver {
    static MDTransactionObserver *_sharedObserver = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObserver = [[MDTransactionObserver alloc] init];
    });
    return _sharedObserver;
}

- (id)init {
    self = [super init];
    if (self) {
        self.transactions = [NSMutableArray array];
    }
    return self;
}

- (void)purchaseProduct:(SKProduct *)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)restorePurchases {
    self.restore = YES;
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    [self changeRestoreTransactionState:MDPaymentTransactionStateStarted error:nil];
}

#pragma mark - Private

- (void)verifyReceipt:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] startDownloads:transaction.downloads];
    
   /* __block SKPaymentTransaction *thisTransaction = transaction;
    
    NSData *data = [NSData dataWithData:thisTransaction.transactionReceipt];
    NSString *encodedString = [Base64 base64forData:data];

    NSDictionary *params = @{ @"receipt" : encodedString };
    
    [[BSHTTPClient sharedClient] POST:@"receipts/validate.json"
                           parameters:params
                              success:^(NSURLSessionDataTask *task, id responseObject) {
                                  NSDictionary *dict = responseObject;
                                  if ([[dict objectForKey:@"status"] isEqualToNumber:@0]) {
                                      [[SKPaymentQueue defaultQueue] startDownloads:transaction.downloads];
                                  } else {
                                      [self didFailWithError:nil];
                                      [self failedTransaction:thisTransaction];
                                  }
                              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                  NSLog(@"error: %@", error);
                                  [self failedTransaction:thisTransaction];
                              }];*/
}


- (void)changeTransactionState:(MDPaymentTransactionState)state transaction:(SKPaymentTransaction *)transaction {
    if (self.didChangeTransactionState) {
        self.didChangeTransactionState(state, transaction);
    }
}

- (void)changedTransactionDownloadState:(MDPaymentTransactionState)state download:(SKDownload *)download {
    switch (state) {
        case MDPaymentTransactionStateFinished:
            [self finishTransaction:download.transaction success:YES];
            break;
        case MDPaymentTransactionStateCanceled:
        case MDPaymentTransactionStateFailed:
            [self finishTransaction:download.transaction success:NO];
            break;
        default:
            break;
    }
    if (self.didChangeTransactionDownloadState) {
        self.didChangeTransactionDownloadState(state, download);
    }
}

- (void)changeRestoreTransactionState:(MDPaymentTransactionState)state error:(NSError *)error {
    if (self.didChangeRestoreTransactionState) {
        self.didChangeRestoreTransactionState(state, error);
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [self changeTransactionState:MDPaymentTransactionStateStarted transaction:transaction];
    [_transactions addObject:transaction];
    [self verifyReceipt:transaction];
}

- (void)finishTransaction:(SKPaymentTransaction *)transaction success:(BOOL)success {
	if (success == YES) {
        [self changeTransactionState:MDPaymentTransactionStateFinished transaction:transaction];
	}
    
	[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [_transactions removeObject:transaction];
    if ([_transactions count] == 0 && [self isRestoring]) {
        [self changeRestoreTransactionState:MDPaymentTransactionStateFinished error:nil];
        self.restore = NO;
    }
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
	//[self recordTransaction:transaction];
    [self completeTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    [self changeTransactionState:MDPaymentTransactionStateFailed transaction:transaction];
    [self finishTransaction:transaction success:NO];
}


#pragma mark - SKPaymentTransactionObserver Methods

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads {
    for (SKDownload *download in downloads) {
        switch (download.downloadState) {
            case SKDownloadStateWaiting:
            case SKDownloadStateActive:
                [self changedTransactionDownloadState:MDPaymentTransactionStateDownloading download:download];
                break;
            case SKDownloadStateCancelled:
                [self changedTransactionDownloadState:MDPaymentTransactionStateCanceled download:download];
                break;
            case SKDownloadStateFailed:
                [self changedTransactionDownloadState:MDPaymentTransactionStateFailed download:download];
                break;
            case SKDownloadStateFinished:
                [self changedTransactionDownloadState:MDPaymentTransactionStateFinished download:download];
                break;
            default:
                break;
        }
    }
}

@end
