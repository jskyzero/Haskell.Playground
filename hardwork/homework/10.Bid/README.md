```
文件bids_201711.txt 是广州市某月车牌竞价信息，包含若干行，每行形如“1234198004118085   29570”，表示一位竞价人的身份证号和出价。
假设本月有10个车牌竞拍。你的任务是统计相关信息，包括最高成交价、最低成交价、平均成交价、按照出价从高到低列车前十位出价人身份证号和出价，并存入另一个文件bidResults.txt中。例如，统计结果可能如文件bidResults1.txt  所示。
要求：
1. 提交你的代码文件；
2. 提交统计结果文件，或者将结果粘贴在提交窗口。
提示：需要排序函数，请hoogle :: [a] -> [a]，或者自定义排序。
```