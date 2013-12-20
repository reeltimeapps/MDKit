//
//  MDTransaction.h
//  MDKit
//
//  Created by Matthew Dicembrino on 2012-08-17.
//
//

#import <StoreKit/StoreKit.h>

typedef NS_ENUM(NSInteger, MDPaymentTransactionState) {
    MDPaymentTransactionStateStarted = 0,
    MDPaymentTransactionStateChanged,
    MDPaymentTransactionStateCanceled,
    MDPaymentTransactionStateFinished,
    MDPaymentTransactionStateDownloading,
    MDPaymentTransactionStateFailed
};

@interface MDTransactionObserver : NSObject <SKPaymentTransactionObserver>

@property (nonatomic, copy) void (^didChangeTransactionState)(MDPaymentTransactionState state, SKPaymentTransaction *transaction);
@property (nonatomic, copy) void (^didChangeRestoreTransactionState)(MDPaymentTransactionState state, NSError *error);
@property (nonatomic, copy) void (^didChangeTransactionDownloadState)(MDPaymentTransactionState state, SKDownload *download);

@property (strong, nonatomic) SKPaymentTransaction *currentTransaction;

+ (MDTransactionObserver *)sharedObserver;

- (void)purchaseProduct:(SKProduct *)product;
- (void)restorePurchases;

@end
