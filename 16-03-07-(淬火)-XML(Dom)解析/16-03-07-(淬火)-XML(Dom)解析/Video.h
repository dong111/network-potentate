#import <Foundation/Foundation.h>

@interface Video : NSObject



//@property(nonatomic,assign) int videoId;
// 使用NSNumber 防止服务器端返回null，我们kvc赋值的时候 崩溃
@property (nonatomic, copy) NSNumber *videoId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *length;
@property (nonatomic, copy) NSString *videoURL;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *teacher;

@property (nonatomic, readonly) NSString *time;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)videoWithDict:(NSDictionary *)dict;

@end
