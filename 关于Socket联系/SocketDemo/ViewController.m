//
//  ViewController.m
//  SocketDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/ip.h>
#import <arpa/inet.h>


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *IpTextField;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;
@property (weak, nonatomic) IBOutlet UILabel *msgLab;
@property (nonatomic, assign) int clientSocket;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)connent:(id)sender {
    [self connent:self.IpTextField.text port:[self.portTextField.text intValue]];
}

- (IBAction)send:(id)sender {
    [self sendAndRevc:self.msgTextField.text];
}

- (IBAction)close:(id)sender {
    close(self.clientSocket);
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

- (void)sendAndRevc:(NSString *)msg{
    /// >3. 向服务器放数据
    const char *msgChar = msg.UTF8String;
    ssize_t sendCount =  send(self.clientSocket, msgChar, strlen(msgChar), 0);
    NSLog(@"发送的字节数：%zd", sendCount);
    
    /// >4. 接受服务器返回的数据
    uint8_t buffer[1024];
    ssize_t revcCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"s接受的字节数：%zd", revcCount);
    
    /// >5. 将字节数组转换成字符串
    NSData *data = [NSData dataWithBytes:buffer length:revcCount];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"======  %@", str);
    self.msgLab.text = str;

}

@end
