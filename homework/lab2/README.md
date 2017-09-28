```
请完成lab2.pdf中第二部分问题，即求平方根。
1. 程序脚本命名规则： Newton_Raphson.hs，模块命名( 即程序脚本第一行)：
module Newton_Raphson where
-- 下面是你的代码
2. 必须在截止日期前提交
3. 请勿抄袭，系统会查重
4. 确保老师和其他同学能运行你脚本中的程序
5. 请用附件提交。你可以多次重新提交附件，但是，需要先删除旧的附件，然后再提交。
作业文件：NewtonRaphson.pdf 
注意，sqrtSeq的结果是迭代序列，因此是一个无穷列表。
Haskell很容易表示无穷列表，如
[1..] :: [Int]
ones ::[Int]
ones = 1 : ones
infinite :: [Int]
infinite = 1 : [1+x | x <- infinite]
如果在ghci下计算这些式子，将得到不间断的显示，请用Ctrl + C中断。你也可以用函数take显示有限的部分。

```