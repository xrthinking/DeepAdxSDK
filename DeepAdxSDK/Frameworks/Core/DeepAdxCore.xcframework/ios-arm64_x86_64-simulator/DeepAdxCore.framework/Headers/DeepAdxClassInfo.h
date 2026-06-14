
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, DeepAdxEncodingType) {
    DeepAdxEncodingTypeMask       = 0xFF, ///< mask of type value
    DeepAdxEncodingTypeUnknown    = 0, ///< unknown
    DeepAdxEncodingTypeVoid       = 1, ///< void
    DeepAdxEncodingTypeBool       = 2, ///< bool
    DeepAdxEncodingTypeInt8       = 3, ///< char / BOOL
    DeepAdxEncodingTypeUInt8      = 4, ///< unsigned char
    DeepAdxEncodingTypeInt16      = 5, ///< short
    DeepAdxEncodingTypeUInt16     = 6, ///< unsigned short
    DeepAdxEncodingTypeInt32      = 7, ///< int
    DeepAdxEncodingTypeUInt32     = 8, ///< unsigned int
    DeepAdxEncodingTypeInt64      = 9, ///< long long
    DeepAdxEncodingTypeUInt64     = 10, ///< unsigned long long
    DeepAdxEncodingTypeFloat      = 11, ///< float
    DeepAdxEncodingTypeDouble     = 12, ///< double
    DeepAdxEncodingTypeLongDouble = 13, ///< long double
    DeepAdxEncodingTypeObject     = 14, ///< id
    DeepAdxEncodingTypeClass      = 15, ///< Class
    DeepAdxEncodingTypeSEL        = 16, ///< SEL
    DeepAdxEncodingTypeBlock      = 17, ///< block
    DeepAdxEncodingTypePointer    = 18, ///< void*
    DeepAdxEncodingTypeStruct     = 19, ///< struct
    DeepAdxEncodingTypeUnion      = 20, ///< union
    DeepAdxEncodingTypeCString    = 21, ///< char*
    DeepAdxEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    DeepAdxEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    DeepAdxEncodingTypeQualifierConst  = 1 << 8,  ///< const
    DeepAdxEncodingTypeQualifierIn     = 1 << 9,  ///< in
    DeepAdxEncodingTypeQualifierInout  = 1 << 10, ///< inout
    DeepAdxEncodingTypeQualifierOut    = 1 << 11, ///< out
    DeepAdxEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    DeepAdxEncodingTypeQualifierByref  = 1 << 13, ///< byref
    DeepAdxEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    DeepAdxEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    DeepAdxEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    DeepAdxEncodingTypePropertyCopy         = 1 << 17, ///< copy
    DeepAdxEncodingTypePropertyRetain       = 1 << 18, ///< retain
    DeepAdxEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    DeepAdxEncodingTypePropertyWeak         = 1 << 20, ///< weak
    DeepAdxEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    DeepAdxEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    DeepAdxEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

DeepAdxEncodingType DeepAdxEncodingGetType(const char *typeEncoding);

@interface DeepAdxClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;              ///< ivar opaque struct
@property (nonatomic, strong, readonly) NSString *name;         ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;       ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) DeepAdxEncodingType type;    ///< Ivar's type

- (instancetype)initWithIvar:(Ivar)ivar;
@end


/**
 Method information.
 */
@interface DeepAdxClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;                  ///< method opaque struct
@property (nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nonatomic, assign, readonly) SEL sel;                        ///< method's selector
@property (nonatomic, assign, readonly) IMP imp;                        ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding;         ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;   ///< return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; ///< array of arguments' type
- (instancetype)initWithMethod:(Method)method;
@end


/**
 Property information.
 */
@interface DeepAdxClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property; ///< property's opaque struct
@property (nonatomic, strong, readonly) NSString *name;           ///< property's name
@property (nonatomic, assign, readonly) DeepAdxEncodingType type;      ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding;   ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName;       ///< property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls;      ///< may be nil
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols; ///< may nil
@property (nonatomic, assign, readonly) SEL getter;               ///< getter (nonnull)
@property (nonatomic, assign, readonly) SEL setter;               ///< setter (nonnull)

- (instancetype)initWithProperty:(objc_property_t)property;
@end


/**
 Class information for a class.
 */
@interface DeepAdxClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; ///< class object
@property (nullable, nonatomic, assign, readonly) Class superCls; ///< super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  ///< class's meta class object
@property (nonatomic, readonly) BOOL isMeta; ///< whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; ///< class name
@property (nullable, nonatomic, strong, readonly) DeepAdxClassInfo *superClassInfo; ///< super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, DeepAdxClassIvarInfo *> *ivarInfos; ///< ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, DeepAdxClassMethodInfo *> *methodInfos; ///< methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, DeepAdxClassPropertyInfo *> *propertyInfos; ///< properties
- (void)setNeedUpdate;

- (BOOL)needUpdate;

+ (nullable instancetype)classInfoWithClass:(Class)cls;

+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
