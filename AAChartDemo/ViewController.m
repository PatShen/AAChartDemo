//
//  ViewController.m
//  AAChartDemo
//
//  Created by swx on 2019/11/23.
//  Copyright © 2019 tospur co,.ltd. All rights reserved.
//

#import "ViewController.h"
#import <AAChartKit/AAChartKit.h>

@interface ViewController ()

@property (nonatomic, strong) AAChartView* cvChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.lightGrayColor;
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.width;
    frame.size.width -= 20.0f;
    frame.origin.x += 10.0f;
    frame.origin.y += 30.0f;
    AAChartView* chartView = [[AAChartView alloc] initWithFrame:frame];
    chartView.scrollEnabled = NO;
    [self.view addSubview:chartView];
    self.cvChart = chartView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData {
    NSArray* xAxisValues = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    NSArray* yAxisValues = @[@7.0, @6.9, @2.5, @14.5, @18.2, @21.5, @5.2, @26.5, @23.3, @45.3, @13.9, @9.6];
    
    AAMarker* maker = AAMarker.new
    .fillColorSet(AAColor.whiteColor)
    .lineColorSet(AAColor.blackColor)
    .radiusSet(@4)
    .lineWidthSet(@2);
    
    AASeriesElement* element = AASeriesElement.new
    .nameSet(@"本案")
    .colorSet(@"#000000")
    .lineWidthSet(@2)
    .dataSet(yAxisValues)
    .markerSet(maker);
    
    AAChartModel* aaChartModel= AAChartModel.new
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"")
    .subtitleSet(@"")
    .stackingSet(AAChartStackingTypeNormal)
    .yAxisVisibleSet(true)
    .yAxisTitleSet(@"")
    .categoriesSet(xAxisValues)
    .markerRadiusSet(@0)
    .seriesSet(@[element])
    .xAxisCrosshairDashStyleTypeSet(AAChartLineDashStyleTypeLongDashDot);
    
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    
    AALabels *aaYAxisLabels = AALabels.new
    .enabledSet(true)//设置 y 轴是否显示数字
    .formatSet(@"{value:.2f}w")//让y轴的值完整显示 而不是100000显示为100k,同时单位后缀为°C
    .styleSet(AAStyle.new
              .colorSet(@"#000000")//yAxis Label font color
              .fontSizeSet(@"10px")//yAxis Label font size
              .fontWeightSet(AAChartFontWeightTypeRegular)//yAxis Label font weight
              );
    
    aaOptions.yAxis
    .lineWidthSet(@0)//Y轴轴线颜色
    .gridLineWidthSet(@1)//Y轴网格线宽度
    .gridLineColorSet(@"#D6D6D6")
    .gridLineDashStyleSet(AAChartLineDashStyleTypeDashDot)
    .labelsSet(aaYAxisLabels);
    //.labels.style.colorSet(AAColor.blackColor)//Y轴文字颜色
    
    // 十字准线
    AACrosshair* aaCrosshair = AACrosshair.new
    .widthSet(@1)
    .dashStyleSet(AAChartLineDashStyleTypeSolid)
    .colorSet(@"#000000");
    
    aaOptions.xAxis
    .lineWidthSet(@1)
    .lineColorSet(@"#BFBFBF")
    .crosshairSet(aaCrosshair);
    
    // 浮动框
    AATooltip* tooltip = aaOptions.tooltip;
    tooltip
    .useHTMLSet(true)
    .headerFormatSet(@"{point.x}<br>")
    .pointFormatSet(@"本案均价：{point.y}&nbsp万元/㎡")
    .valueDecimalsSet(@2) // 精确到小数点后几位
    .backgroundColorSet(@"#00000055")
//    .borderColorSet(@"#00000022")
    .borderWidthSet(@0)
    .styleSet((id)AAStyle.new
              .colorSet(@"#ffffff")
              .fontSizeSet(@"12px"));
    
    [self.cvChart aa_drawChartWithOptions:aaOptions];
}

@end
