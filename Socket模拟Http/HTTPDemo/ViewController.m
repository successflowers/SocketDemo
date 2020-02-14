//
//  ViewController.m
//  HTTPDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/ip.h>
#import <arpa/inet.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, assign) int clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///ping www.baidu.com
    BOOL result = [self connent:@"220.181.38.149" port:80];
    if (!result) {
        NSLog(@"失败");
        return;
    }
    /*
     GET / HTTP/1.1
     Host: www.baidu.com
     请求头
     */
    NSString *request = @"GET / HTTP/1.1\r\n"
                        "Host: www.baidu.com\r\n"
//                        "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 12_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1\r\n"
                        "Connection: keep-alive\r\n\r\n";
    ///响应头
    NSString *response =  [self sendAndRevc:request];
    close(self.clientSocket);
    /// >. 截取字符串
    NSRange range = [response rangeOfString:@"\r\n\r\n"];
    NSString *html = [response substringFromIndex:range.length + range.location];
    [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
}

- (BOOL)connent:(NSString *)ip port:(int)port{
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    /// >2. 连接服务器
    /*
     参数1:socket的描述符
     参数2:结构体 IP和端口号
     参数3:结构体的长度 sizeof
     返回值：成功0 失败非0
     */
    self.clientSocket = clientSocket;
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr(ip.UTF8String);
    addr.sin_port = htons(port);
    
    int result = connect(clientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (result != 0) {
        NSLog(@"连接失败");
        return NO;
    }
    return YES;
}

- (NSString *)sendAndRevc:(NSString *)msg{
    /// >3. 向服务器放数据
    const char *msgChar = msg.UTF8String;
    ssize_t sendCount =  send(self.clientSocket, msgChar, strlen(msgChar), 0);
    NSLog(@"发送的字节数：%zd", sendCount);
    
    /// >4. 接受服务器返回的数据
    uint8_t buffer[1024];
    NSMutableData *mData = [NSMutableData data];
    ssize_t revcCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    [mData appendBytes:buffer length:revcCount];
    NSLog(@"接受的字节数：%zd", revcCount);
    while (revcCount != 0) {
        revcCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
        [mData appendBytes:buffer length:revcCount];
    }
    
    /// >5. 将字节数组转换成字符串
    //NSData *data = [NSData dataWithBytes:buffer length:revcCount];
    NSString *str = [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    NSLog(@"======  %@", str);
    //self.msgLab.text = str;
    return  str;
}
@end
