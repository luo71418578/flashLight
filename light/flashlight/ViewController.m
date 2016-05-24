//
//  ViewController.m
//  flashlight
//
//  Created by luo on 16/5/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "ViewController.h"

#define MIN_FREQ   1
#define MAX_FREQ   10

@interface ViewController ()
{
    int shineFreq;
    NSTimer *timerShine;
    bool isShineOn;   //是否正在闪光
}
@property  bool isLightOn; //灯是否打开
@property (weak, nonatomic) IBOutlet UIButton *btnOnOff; //开关

@property (weak, nonatomic) IBOutlet UISwitch *switchBtn; //闪光开关
@property (weak, nonatomic) IBOutlet UISlider *flashSlider;//闪光滑块
@property (weak, nonatomic) IBOutlet UILabel *flashLabel;  //闪光频率



@property (weak, nonatomic) IBOutlet UIButton *complainBtn;  //说明





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _isLightOn = NO;
    _switchBtn.on = NO;
    
    shineFreq = MIN_FREQ;
    _flashLabel.text = [NSString stringWithFormat:@"%dhz",shineFreq];
    _flashSlider.value = shineFreq*1.0/(MAX_FREQ-MIN_FREQ);
    
    
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {
        //没有闪光灯
        
#if 1
        
        UIAlertController *alertControll = [UIAlertController alertControllerWithTitle:@"闪光灯" message:@"抱歉，该设备没有闪光灯而无法使用手电筒功能！" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertControll addAction:cancelAction];
        [alertControll addAction:okAction];
        [self presentViewController:alertControll animated:YES completion:nil];
        
        //NSString *strAlert = NSLocalizedString(@"add_joke_to_love",nil);
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"闪光灯" message:@"抱歉，该设备没有闪光灯而无法使用手电筒功能！" delegate:nil
//                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        
//        
//        [alert show];
        //[self performSelector:@selector(dimissAddAlert:) withObject:alert afterDelay:1.0];
#endif
        
    }
    
    
    
//    [self turnOnLed:YES];
    
}

-(void) turnOnLed:(bool)update
{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
    if (update)
    {
        [_btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
    }
    
    
}
-(void) turnOffLed:(bool)update
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
    if (update)
    {
        [_btnOnOff setImage:[UIImage imageNamed:@"BtnOff"] forState:UIControlStateNormal];
    }
    
}


//开关
- (IBAction)onBtnOnOff:(UIButton *)sender {
    
    _isLightOn = 1-_isLightOn;
    
    if (_isLightOn) {
        
        [self turnOnLed:YES];  //打开电筒
        
        if (_switchBtn.on) {   // 打开闪光
            
            [self SliderProgressUp:nil];
        }
        
    }else{
        
        [self turnOffLed:YES]; //关闭电筒
        
        if (_switchBtn.on) {
            
            _switchBtn.on = NO; //关闭闪光
        }
    }

}


//闪光开关
- (IBAction)onSwitch:(UISwitch *)sender {
   
    UISwitch *Switch = (UISwitch *)sender;
    
    NSLog(@"-----shanguang----%d",Switch.on);
    if (Switch.on) {  //打开闪光
        NSLog(@"-----打开闪光----");
        
        if (timerShine) {
            
            [timerShine invalidate];
            timerShine = nil;
        }
        [self SliderProgressUp:nil];
        
        if (!_isLightOn) {
            _isLightOn = YES;
            [_btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
        }
    }else{            //关闭闪光
        NSLog(@"-----关闭闪光----");
        if (_isLightOn) {       //电筒没关闭，依然是打开状态
            [self turnOnLed:NO];
        }

    }
    
    
}

//滑块控制闪光频率
- (IBAction)SliderProgressUp:(UISlider *)sender {
    
    //將slider的值加上0.5後轉為整數
    int percent=(int)(_flashSlider.value*100);
    
    NSLog(@"-----persent ===%d",percent);
    shineFreq = MIN_FREQ+(MAX_FREQ-MIN_FREQ)*percent/100.0;
    _flashLabel.text = [NSString stringWithFormat:@"%dhz",shineFreq];
    
    
    double time = 1.0/shineFreq;
    if (timerShine) {
        // [timerShine release];
        
        [timerShine invalidate];
        timerShine = nil;
        
        
    }
    timerShine= [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(onTimerShine) userInfo:nil repeats:YES];
}

-(void) onTimerShine
{
    static int count=0;
    
    if (!_switchBtn.on || !_isLightOn) {
        return;
    }

    
    if (count%2) {
        [self turnOnLed:NO];
    }else{
        [self turnOffLed:NO];
    }
    count ++;
    
    
}


//打开闪光灯
- (IBAction)turnOnFlash:(id)sender {

    _switchBtn.on = NO;
    [self onSwitch:_switchBtn];
    
}

//关闭闪光灯
- (IBAction)turnOffFlash:(id)sender {

    _switchBtn.on = YES;
    [self onSwitch:_switchBtn];
}

//说明
- (IBAction)complainClick:(UIButton *)sender {
    
    UIAlertController *alertControll = [UIAlertController alertControllerWithTitle:@"手电筒" message:@"本软件是一款手电筒软件，还可以打开闪光灯，出现闪光灯闪烁效果！！" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//    [alertControll addAction:cancelAction];
    [alertControll addAction:okAction];
    [self presentViewController:alertControll animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
