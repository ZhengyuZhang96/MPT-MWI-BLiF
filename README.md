# MPT-MWI-BLiF

The demo of our proposed MPT-MWI-BLiF metric for light field image quality assessment. The corresponding paper has been submitted to TIP. 

**The full code will be provided after the paper is accepted.**

### Run demo
To run the demo code, please download "EPICNN_dishes.bmp" on [Baidu drive](https://pan.baidu.com/s/1aD9ns9rDzSbTAmKLqhhE8w) (code: INSA), put it into "./demo/..." and run:
```
  $ run_demo.m
```

### Generate features   
Please set the path to the database in "./Databases/get_info_from_database.m" and the database name in "get_MPT_MWI_BLiF_features_from_database.m" and run:
```
  $ get_MPT_MWI_BLiF_features_from_database.m
```

### Report performance 
Please run:
```
  $ Report_Result_Win5.m
  $ Report_Result_NBU.m
  $ Report_Result_SMART.m
  $ Report_Result_VALID10bit.m
  $ Report_Result_SHU.m
```

## Contact
Welcome to raise issues or email to [zhengyu.zhang@insa-rennes.fr](zhengyu.zhang@insa-rennes.fr) for any question.

