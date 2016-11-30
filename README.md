# OWWaterFlowView
Make a display in the waterflow way. (By imitating UIScrollView)
# How to use
## Create a OWWaterFlowView
    OWWaterFlowView *waterFlowView = [[OWWaterFlowView alloc] init];
    waterFlowView.delegate = self;
    waterFlowView.dataSource = self;
    waterFlowView.frame = CGRectMake(0, 20.0, self.view.frame.size.width, self.view.frame.size.height - 20.0);
    [self.view addSubview:waterFlowView];
## OWWaterFlowViewDelegate && OWWaterFlowViewDataSource
    - (CGFloat)numberOfColumsOnWaterflowView:(OWWaterFlowView *)waterflowView {
    }

    - (CGFloat)numberOfCellsOnWaterflowView:(OWWaterFlowView *)waterflowView {
    }

    - (OWWaterFlowViewCell *)waterflowView:(OWWaterFlowView *)waterflowView cellAtIndex:(NSUInteger)index{
    }

    - (CGFloat)waterflowView:(OWWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index {
    }

    - (CGFloat)waterflowView:(OWWaterFlowView *)waterflowView marginForType:(OWWaterFlowMarginType)type {
    }

    - (void)waterflowView:(OWWaterFlowView *)waterflowView didSelectedCellAtIndex:(NSUInteger)index {
    }
