# IAPsNet

The code running in the environment of MATLAB R2017b (The Math Works Inc., USA). The GPU of the PC is a NVIDIA GeForce GTX 1080.
net_IAPsNet.mat is A CNN model for IAPs identification.
segment_block.m is used to segment big images into blocks with 112X112 pixels size.
test_IAPs_Apply.m is used to identify and mark the blocks.
test_net.m is used to test the CNN model.
together.m is used to merge the identified blocks into a big image.
trainImages.mat, valImages.mat, train_AlexNet.m, train_IAPsNet.m, train_LeNet.m, and train_VGG_11.m are used for CNN models training.
