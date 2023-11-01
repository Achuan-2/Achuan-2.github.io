---
title: Matlab 调用 cellpose 模块进行细胞分割
date: '2023-10-31 21:57:07'
updated: '2023-11-01 14:56:29'
categories:
  - Notes
  - '10'
  - 技术博客
comments: true
toc: true
---



## 编写调用cellpose的Python自定义模块

```python
import numpy as np
import cv2
from cellpose import models, dynamics
from cellpose.transforms import normalize99, resize_image


def cal_diam(std_image, ops):
    """
    """
    device, gpu = models.assign_device(
        use_torch=True, gpu=ops['gpu'], device=ops['device'])
    pretrained_size = models.size_model_path('cyto', True)
    cp = models.CellposeModel(device=device, gpu=gpu,
                              model_type='cyto',
                              diam_mean=30,
                              net_avg=ops['net_avg'])  # model for diameter calculation
    sz = models.SizeModel(device=device, pretrained_size=pretrained_size,
                          cp_model=cp)
    sz.model_type = ops['model_type']
    diameter, _ = sz.eval(std_image, channels=ops['channels'], channel_axis=None, invert=ops['invert'],
                          batch_size=ops['batch_size'],
                          augment=ops['augment'], tile=True, normalize=ops['normalize'])
    return diameter


def seg(std_image, ops):
    # Parameter settings
    device, gpu = models.assign_device(
        use_torch=True, gpu=ops['gpu'], device=ops['device'])

    model = models.Cellpose(gpu=gpu, device=device, model_type=ops['model_type'],
                            net_avg=ops['net_avg'])  # model for cellpose segmentation

    out = model.eval(std_image, channels=ops['channels'], diameter=ops['diameter'],
                     do_3D=ops['do_3D'], net_avg=ops['net_avg'],
                     augment=ops['augment'],
                     resample=ops['resample'],
                     flow_threshold=ops['flow_threshold'],
                     cellprob_threshold=ops['cellprob_threshold'],
                     stitch_threshold=ops['stitch_threshold'],
                     min_size=ops['min_size'],
                     invert=ops['invert'],
                     batch_size=ops['batch_size'],
                     interp=ops['interp'],
                     normalize=ops['normalize'],
                     channel_axis=ops['channel_axis'],
                     z_axis=ops['z_axis'],
                     anisotropy=ops['anisotropy'],
                     model_loaded=True)
    mask, flows = out[:2]
    return mask, flows


def seg_default_ops():
    """ default options to run pipeline """
    chan1 = 1
    chan2 = 0
    diameter = 21.5
    return {
        'gpu': True,  # whether or not to use GPU, will check if GPU available
        # which gpu device to use, use an integer for torch, or mps for M1, (default: '0')
        'device': '0',
        'model_type': 'cyto2',
        'channels': [chan1, chan2],
        'diameter': diameter,
        'do_3D': False,
        'net_avg': True,
        'augment': False,
        'resample': True,
        'flow_threshold': 0.1,
        'cellprob_threshold': 0,
        'stitch_threshold': 0,
        # minimum number of pixels per mask, can turn off with -1, (default: 15)
        'min_size': 15,
        'invert': False,  # invert grayscale channel
        'batch_size': 8,
        'interp': False,  # interpolate when running dynamics (default: False)
        'normalize': True,
        # axis of image which corresponds to image channels (default: None)
        'channel_axis': None,
        'z_axis': None,
        'anisotropy': 1.0,  # anisotropy of volume in 3D (default: 1.0)
        'model_loaded': True
    }

def test():
    print("hello")
def dynamic_compute(masks, flows, ops):
    transform_flow = [[], [], []]
    transform_flow[0] = flows[0].copy()  # RGB flow
    transform_flow[1] = (np.clip(normalize99(flows[2].copy()),
                                 0, 1) * 255).astype(np.uint8)  # dist/prob
    masks = masks[np.newaxis, ...]
    transform_flow[0] = resize_image(transform_flow[0], masks.shape[-2], masks.shape[-1],
                                     interpolation=cv2.INTER_NEAREST)
    transform_flow[1] = resize_image(
        transform_flow[1], masks.shape[-2], masks.shape[-1])
    transform_flow[2] = np.zeros(masks.shape[1:], dtype=np.uint8)
    transform_flow = [transform_flow[n][np.newaxis, ...]
                      for n in range(len(transform_flow))]
    transform_flow.append(flows[3].squeeze())  # p
    transform_flow.append(np.concatenate(
        (flows[1], flows[2][np.newaxis, ...]), axis=0))  # dP, dist/prob

    flow_threshold = ops['flow_threshold']
    cellprob_threshold = ops['cellprob_threshold']
    maski = dynamics.compute_masks(transform_flow[4][:-1],
                                   transform_flow[4][-1],
                                   p=transform_flow[3].copy(),
                                   cellprob_threshold=cellprob_threshold,
                                   flow_threshold=flow_threshold,
                                   resize=masks.shape[-2:])[0]

    return maski

```

## 调用cellpose模块的Matlab代码

```matlab
% 添加自定义python模块，让matlab能够找到
if count(py.sys.path,'+components') == 0
    insert(py.sys.path,int32(0),'+components/+segmentation');
end
clear classes
mod = py.importlib.import_module('segmodule');
py.importlib.reload(mod);

% 运行cellpose代码，预估神经元大小
ops = py.segmodule.seg_default_ops();
im = imread('cellpose_test.tif');
im_for_python = mat2nparray(im); % matlab和python数据不一致，需要额外处理
diameter = py.segmodule.cal_diam(im_for_python,ops);
ops{'diameter'} =diameter;

% cellpose 进行细胞分割
results= py.segmodule.seg(im_for_python,ops);
masks = results{1};
flows  =  results{2};

% 显示分割结果
figure
matlab_mask=uint8(masks);
imshow(matlab_mask,[]);

% test mask to rgb random color mask
colored_mask = mask_to_rgb(matlab_mask);
imshow(colored_mask,[])


% test mask overlay to image
colored_mask = mask_to_rgb(matlab_mask);
binary_mask = matlab_mask>0;


figure
imshow(im,[])
hold on 
alpha = 0.3;
h = imshow(colored_mask,[])
h.AlphaData=binary_mask*alpha;


% test mask to outline


figure
outline = mask_to_outline(matlab_mask);
imshow(outline,[])


% 用images.roi.Freehand
% figure
% imshow(im)
% rois = images.roi.Freehand.empty();
% for i = 1:numel(boundaries)
%     boundary = fliplr(boundaries{i});
%     roi = images.roi.Freehand(gca, 'Position', boundary,'MarkerSize',1,'LineWidth',1);
%     rois(i) = roi;
% end



% 可以更改阈值，改变识别的roi
ops{'flow_threshold'} = 1
masksi = py.segmodule.dynamic_compute(masks, flows, ops)

figure
matlab_mask=uint8(masksi)
imshow(matlab_mask,[])

RGB = mask_to_rgb_test(matlab_mask);
imshow(RGB)
```

## 涉及的函数

```matlab
function result = mat2nparray(matarray)
    %mat2nparray Convert a Matlab array into an nparray
    %   Convert an n-dimensional Matlab array into an equivalent nparray  
    data_size=size(matarray);
    if length(data_size)==1
        % 1-D vectors are trivial
        result=py.numpy.array(matarray);
    elseif length(data_size)==2
        % A transpose operation is required either in Matlab, or in Python due
        % to the difference between row major and column major ordering
        transpose=matarray';
        % Pass the array to Python as a vector, and then reshape to the correct
        % size
        result=py.numpy.reshape(transpose(:)', int32(data_size));
    else
        % For an n-dimensional array, transpose the first two dimensions to
        % sort the storage ordering issue
        transpose=permute(matarray,length(data_size):-1:1);
        % Pass it to python, and then reshape to the python style of matrix
        % sizing
        result=py.numpy.reshape(transpose(:)', int32(fliplr(size(transpose))));
    end
end


function color_mask = mask_to_rgb(mask)
    color_mask = zeros([size(mask), 3], 'single');
    for n = 1:max(mask(:))

        mask_indices = (mask == n);
        color_mask(mask_indices) = rand; % hue
        color_mask(:,:,2) = color_mask(:,:,2) .* ~mask_indices +  rand*mask_indices; 
        color_mask(:,:,3) = color_mask(:,:,3) .* ~mask_indices +  rand*mask_indices;
    end
    color_mask = uint8(color_mask*255);
end

% function color_mask = mask_to_rgb(mask)
%     % 先用hsv色彩，再转化为rgb
%     color_mask = zeros([size(mask), 3], 'single');
% 
%     color_mask(:,:,3) = 1;
% 
%     for n = 1:max(mask(:))
%         mask_indices = mask == n;
% 
%         color_mask(mask_indices) = rand; % hue
%         color_mask(:,:,2) = color_mask(:,:,2) .* ~mask_indices +  (rand()*0.5+0.5)*mask_indices; 
%         color_mask(:,:,3) = color_mask(:,:,3) .* ~mask_indices +  (rand()*0.5+0.5)*mask_indices; 
%     end
%     color_mask = uint8(hsv2rgb(color_mask) * 255);
% 
% end


function outline = mask_to_outline(mask)
    % 考虑到有些roi会重叠，所以不应该直接把mask变为二值化mask
    % 最好还是一个个转化？
    outline = zeros(size(mask));
    n_roi = max(max(mask));
    for i = 1:n_roi
        mask_i = mask==i;
        [boundaries,~] = bwboundaries(mask_i);
        boundary = boundaries{1};
        linearIndices = sub2ind(size(outline), boundary(:, 1), boundary(:, 2));
        outline(linearIndices) = 1;
    end
  
    outline  =uint8(outline);
end
```
