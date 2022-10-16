#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HTMLComment.h"
#import "HTMLDocument+Private.h"
#import "HTMLEncoding+Private.h"
#import "HTMLEntities.h"
#import "HTMLOrderedDictionary.h"
#import "HTMLParser.h"
#import "HTMLPreprocessedInputStream.h"
#import "HTMLString.h"
#import "HTMLTokenizer.h"
#import "HTMLTokenizerState.h"
#import "HTMLTreeEnumerator.h"
#import "HTMLDocument.h"
#import "HTMLDocumentType.h"
#import "HTMLElement.h"
#import "HTMLEncoding.h"
#import "HTMLNamespace.h"
#import "HTMLNode.h"
#import "HTMLQuirksMode.h"
#import "HTMLReader.h"
#import "HTMLSelector.h"
#import "HTMLSerialization.h"
#import "HTMLSupport.h"
#import "HTMLTextNode.h"
#import "NSString+HTMLEntities.h"

FOUNDATION_EXPORT double HTMLReaderVersionNumber;
FOUNDATION_EXPORT const unsigned char HTMLReaderVersionString[];
