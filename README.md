# MPT-MWI-BLiF

Zhengyu Zhang, Shishun Tian, Jianjun Xiang, Wenbin Zou, Luce Morin, and Lu Zhang.

The code of our proposed MPT-MWI-BLiF metric in "Blind Light Field Image Quality Assessment using Multiplane Texture and Multilevel Wavelet Information", which has been accepted by IEEE Transactions on Broadcasting. <!-- Please refer to our [paper](https://...) for details. -->

### Run demo
To run the demo code, please download "./demo/EPICNN_dishes.bmp" on [Baidu drive](https://pan.baidu.com/s/1rpOhzPzczGBp76uAFjRI8Q) (code: GZHU), put it into "./demo/..." and run:
```
  $ run_demo.m
```

### Generate features   
We also provide a script to generate MPT-MWI-BLiF features for all five databases mentioned in our paper, please run:
```
  $ get_MPT_MWI_BLiF_features_from_database.m
```

### Report performance 
To report quality assessment performance using our provided features, please run:
```
  $ Report_Result_Win5.m
  $ Report_Result_NBU.m
  $ Report_Result_SMART.m
  $ Report_Result_VALID10bit.m
  $ Report_Result_SHU.m
```

### Citation
If you find this work helpful, please consider citing:
```
@article{MPT-MWI-BLiF,
  title        = {Blind Light Field Image Quality Assessment using Multiplane Texture and Multilevel Wavelet Information},
  author       = {Zhang, Zhengyu and Tian, Shishun and Xiang, Jianjun and Zou, Wenbin and Morin, Luce and Zhang, Lu},
  journal      = {IEEE Transactions on Broadcasting},
  year         = {2025},
}
```

<!--   doi          = {10.1109/TCSVT.2024.3486336}   -->


## Contact
For some reasons, here we only provide the code of MPT-MWI-BLiF metric with obfuscated pcode files. 

If you want to get the full code, feel free to contact [zhengyuzhang@gzhu.edu.cn](zhengyuzhang@gzhu.edu.cn) and we will send you the full code soon.
