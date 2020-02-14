//
//  ViewController.m
//  NetWorkingDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/ip.h>
#import <arpa/inet.h>
#import "NSArray+Ex.h"
#import "NSDictionary+Ex.h"
#import "CCPerson.h"

@interface ViewController ()<NSXMLParserDelegate>
    
@property (weak, nonatomic) IBOutlet UIWebView *webView;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self networking];
    //NSLog(@"%@", [self time]);
}

- (void)networking {
    /// >1.无法设置请求头 无法设置缓存 无法设置超时
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/demo.xml"];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"______   %@", string);
    
    /// >2.
    /// NSURLRequest *request = [NSURLRequest requestWithURL:url]
    /*
     NSURLRequestUseProtocolCachePolicy = 0,                http协议缓存
     
     NSURLRequestReloadIgnoringLocalCacheData = 1,          忽略本地缓存，永远获取最新数据
     NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4, // Unimplemented    未实现
     NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,忽略本地缓存
     
     NSURLRequestReturnCacheDataElseLoad = 2,   如果有缓存，返回，否则重新加载
     NSURLRequestReturnCacheDataDontLoad = 3,   就读网路数据 离线数据
     
     NSURLRequestReloadRevalidatingCacheData = 5, // Unimplemented 未实现
     */
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    //[request setValue:@"" forHTTPHeaderField:@""];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {

        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
//                id json = [NSPropertyListSerialization propertyListWithData:data options:0 format:0 error:NULL];
//                NSLog(@"%@", json);
//                NSLog(@"%@", [json class]);
                NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
                parser.delegate = self;
                [parser parse];
                
            }else{
                NSLog(@"网络请求错误");
            }
        }else{
            NSLog(@"error : %@", connectionError);
        }
    }];
}

#pragma mark - NSXMLParserDelegate
/// >1. 开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
}
/// >2. 结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
}
/// >3. 解析错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
}
/// >4. 开始找节点
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    NSLog(@"---- %@ %@", elementName, attributeDict);
}
/// >5. 找节点之间的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"找节点之间的内容 ： %@", string);
}
/// >6. 找结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
}

- (void)logoText{
    
    CCPerson *p = [[CCPerson alloc] init];
    p.name = @"含么么";
    p.sex = @"1";
    NSArray *array = @[@"韩梅梅", @"流泪"];
    NSLog(@"%@", p);
}
- (void)socket{
    /// >1. 创建socket
    /*
     int socket(int domain, int type, int protocol);
     参数： domain 协议域         指定IPv4
     参数： type                 socket类型 流socket 数据报socket
     参数： protocol。            协议
     创建成功返回socket的描述符，否则-1
     */
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    /// >2. 连接服务器
    /*
     参数1:socket的描述符
     参数2:结构体 IP和端口号
     参数3:结构体的长度 sizeof
     返回值：成功0 失败非0
     */
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    addr.sin_port = htons(12345);
    
    int result = connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (result != 0) {
        NSLog(@"连接失败");
        return;
    }
    
    /// >3. 向服务器放数据
    const char *msg = "hello world";
    ssize_t sendCount =  send(clientSocket, msg, strlen(msg), 0);
    NSLog(@"发送的字节数：%zd", sendCount);
    
    /// >4. 接受服务器返回的数据
    uint8_t buffer[1024];
    ssize_t revcCount = recv(clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"s接受的字节数：%zd", revcCount);
    
    /// >5. 将字节数组转换成字符串
    NSData *data = [NSData dataWithBytes:buffer length:revcCount];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"======  %@", str);
    
    /// >6. 关闭连接
    close(clientSocket);

}
- (void)connectionRequest{
    
    /// >1. 创建请求的地址
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    //NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
    
    /// >2. 创建请求对象，告诉服务器一些信息
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /// >3. 建立网络连接，向服务器发送请求，并接受服务器返回的响应
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        /// >1. 网络请求后完成执行的方法
        /// >2. NSURLResponse * response    服务器返回的响应对象
        /// >3. NSData * data               服务器返回的二进制数据
        /// >4. NSError * connectionError   如果错误，返回错误信息
        if (!connectionError) {
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", str);
            self.webView.backgroundColor = [UIColor redColor];
            [self.webView loadHTMLString:str baseURL:nil];
        }else{
            NSLog(@"error :%@", connectionError);
        }
    }];
}
    
@end
