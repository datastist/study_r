<<<<<<< HEAD
=======
---
title: "Visualization (ggplot2) with R"
author: "Sirinapa"
date: "Nov 22, 2021"
---

>>>>>>> 49c3f4e18fe072df78516fcb02af9bad4d131e60
การสร้างภาพข้อมูลหรือ Data Visualization
ช่วยให้เราเข้าใจชุดข้อมูลที่มีความซับซ้อนได้ง่ายขึ้นและทำให้เราตัดสินใจในการจัดการกับข้อมูลเร็วขึ้น
ซึ่ง Data Visualization สามารถทำได้ทั้งก่อนและหลังการวิเคราะห์เชิงสถิติ

การสร้างภาพข้อมูลใน `R` สามารถทำได้จากหลากหลาย package ซึ่งใน tutorial
นี้เราจะใช้ package `ggplot2` ซึ่งเป็น package
ที่ช่วยให้เราสามารถสร้างกราฟิคได้หลากหลาย และสามารถปรับแต่งรูปแบบต่าง ๆ
ได้ในแบบที่ต้องการ

``` r
#load packages
library(ggplot2)
library(psych)
library(Rmisc)
```

## Mtcars data

ใน tutorial นี้เราจะใช้ข้อมูลที่มีอยู่แล้วใน package `ggplot2` ชื่อว่า
`mtcars` ในการสร้างกราฟฟิค  
หลังจาก import `mtcars` ลงมาแล้ว เราสามารถเซ็ตค่าตัวแปรได้ตามนี้

``` r
data("mtcars")

mtcars$vs <- factor(mtcars$vs, labels = c("V", "S"))
mtcars$am <- factor(mtcars$am, labels = c("automatic", "manual"))
mtcars$cyl  <- as.factor(mtcars$cyl)
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)

psych::describe(mtcars)
```

    ##       vars  n   mean     sd median trimmed    mad   min    max  range  skew
    ## mpg      1 32  20.09   6.03  19.20   19.70   5.41 10.40  33.90  23.50  0.61
    ## cyl*     2 32   2.09   0.89   2.00    2.12   1.48  1.00   3.00   2.00 -0.17
    ## disp     3 32 230.72 123.94 196.30  222.52 140.48 71.10 472.00 400.90  0.38
    ## hp       4 32 146.69  68.56 123.00  141.19  77.10 52.00 335.00 283.00  0.73
    ## drat     5 32   3.60   0.53   3.70    3.58   0.70  2.76   4.93   2.17  0.27
    ## wt       6 32   3.22   0.98   3.33    3.15   0.77  1.51   5.42   3.91  0.42
    ## qsec     7 32  17.85   1.79  17.71   17.83   1.42 14.50  22.90   8.40  0.37
    ## vs*      8 32   1.44   0.50   1.00    1.42   0.00  1.00   2.00   1.00  0.24
    ## am*      9 32   1.41   0.50   1.00    1.38   0.00  1.00   2.00   1.00  0.36
    ## gear*   10 32   1.69   0.74   2.00    1.62   1.48  1.00   3.00   2.00  0.53
    ## carb*   11 32   2.72   1.37   2.00    2.65   1.48  1.00   6.00   5.00  0.35
    ##       kurtosis    se
    ## mpg      -0.37  1.07
    ## cyl*     -1.76  0.16
    ## disp     -1.21 21.91
    ## hp       -0.14 12.12
    ## drat     -0.71  0.09
    ## wt       -0.02  0.17
    ## qsec      0.34  0.32
    ## vs*      -2.00  0.09
    ## am*      -1.92  0.09
    ## gear*    -1.07  0.13
    ## carb*    -0.95  0.24

โดยข้อมูลประกอบไปด้วย  
`mpg` - จำนวนแกลลอนของน้ำต่อ 1 ไมล์  
`cyl` - จำนวนกระบอกสูบ  
`disp` - ความจุของเครื่องยนต์ (ลูกบาศก์นิ้ว)  
`hp` - แรงม้า  
`drat` - สัดส่วนของเพลากลางของรถ  
`wt` - น้ำหนัก  
`qsec` - ความเร่ง  
`vs` - รูปร่างของเครื่องยนต์ ‘V’ หรือ ‘S’  
`am` - ระบบเกียร์อัตโนมัติ (auto) หรือ เกียร์กระปุก (manual)  
`gear` - จำนวนเกียร์  
`carb` - จำนวนตัวเผาไหม้เครื่องยนต์

## Ggplot2 Package

Ggplot2 เป็น package ในรูปแบบของ Grammar of Graphic ที่ความยืดหยุ่น
ซึ่งในการเขียนคำสั่งของ `ggplot2` นั้น
จะมีลักษณะเป็นการเรียงคำสั่งในแต่ละขั้น  
โดยปกติแล้ว คำสั่งที่ใช้งานพื้นฐานจะประกอบไปด้วย

-   `data` - การเรียกข้อมูลที่ใช้งาน

-   `aesthetic mappings` - การเลือกตัวแปรที่จะปรากฎอยู่ในกราฟ

-   `geometric objects` - การเลือกวิธีการสร้างกราฟฟิค

-   `Customizing` เช่น การใส่ชื่อ เลือกธีม หรือลงสีให้กราฟ

นอกจากนี้ยังมีคำสั่งอื่น ๆ ที่มีความซับซ้อนมากขึ้น
หากเราเริ่มคุ้นเคยกับคำสั่งพื้นฐานแล้ว
เราสามารถศึกษาเพิ่มเติมให้กราฟฟิคมีความสวยงามและตรงตามความต้องการของเรามากขึ้นได้

## การสร้างกราฟ

ก่อนที่เราจะสร้างกราฟ
เราควรสังเกตตัวแปรที่เราต้องการนำมาสร้างว่าเป็นตัวแปรลักษณะใด
โดยสามารถใช้คำสั่ง `str()`

``` r
str(mtcars)
```

    ## 'data.frame':    32 obs. of  11 variables:
    ##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
    ##  $ cyl : Factor w/ 3 levels "4","6","8": 2 2 1 2 3 2 3 1 1 2 ...
    ##  $ disp: num  160 160 108 258 360 ...
    ##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
    ##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
    ##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
    ##  $ qsec: num  16.5 17 18.6 19.4 17 ...
    ##  $ vs  : Factor w/ 2 levels "V","S": 1 1 2 2 1 2 1 2 2 2 ...
    ##  $ am  : Factor w/ 2 levels "automatic","manual": 2 2 2 1 1 1 1 1 1 1 ...
    ##  $ gear: Factor w/ 3 levels "3","4","5": 2 2 2 1 1 1 1 2 2 2 ...
    ##  $ carb: Factor w/ 6 levels "1","2","3","4",..: 4 4 1 1 2 1 4 2 2 4 ...

หลักการในการสร้างกราฟฟิคคือ การสังเกตจำนวนตัวแปรและลักษณะของตัวแปรในแกน
x และ y โดยลักษณะของตัวแปรนี้จะเป็นการคัดรูปแบบกราฟของเรา  
ใน tutorial นี้เราจะเรียนรู้สร้าง boxplot, bar graph และ line graph ค่ะ

### การสร้าง boxplot

ในการสร้าง boxplot (หรือกราฟลักษณะอื่น ๆ)
เราจะเริ่มกันที่การสร้างคำสั่งพื้นฐาน คือ `data` และ
`aesthetic mappings`  
โดยคำสั่งทั่วไปคือ
`ggplot(data = ชื่อไฟล์, aes(x = ตัวแปรแกน x, y = ตัวแปรแกน y)`

คำสั่ง `aes()` สามารถเซ็ตค่าอื่น ๆ ได้ เช่น

-   ตำแหน่งของตัวแปร (`x =` และ `y =` )

-   สี: โดย `color=` เป็นสีเส้นขอบ และ `fill=` เป็นสีด้านใน

-   `shape =` รูปร่างของจุดข้อมูล และ `size =`ขนาดของจุดข้อมูล

``` r
ggplot(data = mtcars, aes(x = am, y = mpg))
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-4-1.png)

ถ้าเรา `run` คำสั่งข้างต้น เราจะพบว่า กราฟฟิคมีเพียง `background` (หรือ
`coordinate system`) และชื่อตัวแปรของเราเท่านั้น
ดังนั้นเราจึงจำเป็นต้องเขียนคำสั่งว่าเราต้องการให้กราฟออกมาเป็นรูปแบบใด
(สามารถเข้าไปดูรูปแบบทั้งหมดได้ที่
`help.search("geom_", package = "ggplot2")`

สำหรับการสร้าง boxplot เราจะใช้คำสั่ง `geom_boxplot()` เพื่อเซ็ตค่า
`geometric objects`

``` r
ggplot(data = mtcars, aes(x = am, y = mpg)) +
  geom_boxplot()
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-5-1.png)

จะเห็นว่ากราฟ boxplot ที่สร้างขึ้นมามีเพียงตัวแปร x และ y
หากเราต้องการจัดกลุ่มตัวแปร เราสามารถใช้คำสั่ง `fill = ตัวแปรจัดกลุ่ม`
ใน `aesthetic mapping` เพื่อให้มีการจัดกลุ่มของตัวแปรในกราฟ

``` r
ggplot(data = mtcars, aes(x = am, y = mpg, fill = vs)) +
  geom_boxplot()
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-6-1.png)

หากเราต้องการให้กราฟมีสีสันและชื่อแกนตามที่เราต้องการ
เราสามารถเขียนคำสั่งต่อจาก คำสั่ง geometric ได้

ตัวอย่างคำสั่งอื่น ๆ ในการปรับแต่งกราฟ

-   **เพิ่มลักษณะกราฟฟิค:**

    -   หากเราอยากให้ `ggplot2` สร้างจุดข้อมูลในกราฟของเรา
        เราสามารถสั่งคำสั่ง `geom_jitter()` หลังจาก geometric objects
        หลักของเราได้

-   **ตกแต่งกราฟ:**

    -   ใช้คำสั่ง `alpha = ค่าโปรงใส` เพื่อเพิ่มความโปร่งใสของกราฟ

    -   ใช้คำสั่ง `width = ค่าความกว้างของกราฟ`
        ในการกำหนดความกว้างของกราฟ

-   **เพิ่มชื่อ:**

    -   **แกน x และ y**: ใช้คำสั่ง `xlab = "ชื่อแกน x"` และ
        `ylab = "ชื่อแกน y"`

    -   **ชื่อหัวกราฟ:** ใช้คำสั่ง `ggtitle("ชื่อหัวกราฟ")`

-   **เลือกใช้ theme:**

    -   **ธีมของกราฟ:** ใช้คำสั่ง `theme_` ในการเลือกใช้ theme โดย
        คำสั่ง `theme_classic` จะใกล้เคียงกับ APA

    -   **สีของกราฟ:**

        -   เลือกจาก palette ที่มีชุดคำสั่งสี

            -   สีเส้นขอบ:
                `scale_color_brewer(palette = "ชื่อ palette ที่ต้องการ")`

            -   สีช่องในกล่องหรือคอลัมน์:
                `scale_fill_brewer(palette = "ชื่อ palette ที่ต้องการ")`

        -   เลือกสีเอง

            -   สีเส้นขอบ:
                `scale_color_manual(values=c("สีที่1", "สีที่2", "สีที่3"))`

            -   สีช่องในกลุ่มหรือคอลัมน์:
                `scale_fill_manual(values=c("สีที่1", "สีที่2", "สีที่3"))`

*Note*: หากเลือกสีเอง
จำนวนสีต้องเท่ากับจำนวนกลุ่มตัวแปรที่ต้องการจะให้มีสี

``` r
ggplot(data = mtcars, aes(x = am, y = mpg, fill = vs)) +
  geom_boxplot(alpha = 0.7, width = 0.6) +
  geom_jitter(alpha = 0.2, size = 2) +
  xlab("Types of Gear transmissions") +
  ylab("Miles per Gallon") +
  ggtitle("Motor Trend Car Road Tests") +
  theme_classic() +
  scale_color_brewer(palette="Accent") +
  scale_fill_brewer(palette="Accent")
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-7-1.png)

จะเห็นได้ว่าสีของกล่องข้อมูลเปลี่ยนไปตามที่เราตั้งค่าไว้
และมีการแสดงของจุดข้อมูลที่มาจากชุดคำสั่ง `geom_jitter()`
โดยมีความโปร่งใสของจุดข้อมูลให้เห็นในกราฟ

### การสร้าง Bar Graph

การสร้าง Bar Graph เหมาะสมกับตัวแปรต้นที่มีลักษณะเป็นกลุ่ม (discrete
variable) ดังนั้นโครงสร้างของชุดคำสั่งจะคล้ายคลึงกับการสร้าง boxplot

เราสามารถสร้าง bar graph ได้ 2 วิธีคือ

-   `geom_bar()` จะมีคำสั่งพื้นฐานโดยมีความสูงของกราฟจากสัดส่วนของ n
    ในข้อมูล

-   `geom_col()`
    จะมีคำสั่งพื้นฐานโดยมีความสูงของกราฟเป็นค่าของข้อมูลนั้น ๆ
    คำสั่งนี้จะเหมาะสมกับข้อมูลที่ผ่านการหาค่าสถิติเชิงพรรณามาแล้ว
    (เช่นค่า *n*, *mean*, *sd*, *se*)
    และนำไปใช้งานได้สะดวกกว่าเมื่อต้องการสร้าง `error_bar`

ดังนั้น หากต้องการสร้าง bar graph อย่างง่าย เราสามารถใช้คำสั่ง
`geom_bar()` ได้ โดยเพิ่มคำสั่ง `stat = "summary"` เมื่อต้องการค่าเฉลี่ย
(mean) หรือ `stat = "identity"` เมื่อต้องการค่าผลรวม (sum)

นอกจากนี้แล้ว การสร้าง bar graph ยังสามารถเลือกการวางตัวของกราฟได้
โดยใช้คำสั่ง `position =`โดยค่าพื้นฐานของ `geom_bar()` คือ
`position = "stack"` โดยจะเป็นการต่อกันของข้อมูลในแต่ละกลุ่ม
ถ้าต้องการให้กราฟอยู่แยกกัน เราจะใช้คำสั่ง `position = "dodge"` หรือ
`position = position_dodge(ค่าความห่าง)`

``` r
# x axis is am
#  stack
stack <- ggplot(data = mtcars, aes(x = am, y = mpg, fill = vs)) +
         geom_bar(stat = "summary") +
         ggtitle("stack") +
         theme_classic()
#  dodge
dodge <- ggplot(data = mtcars, aes(x = am, y = mpg, fill = vs)) +
         geom_bar(stat = "summary", position = position_dodge(0.9)) +
         ggtitle("dodge") +
         theme_classic()
#x axis is vs
#  stack
stack2 <- ggplot(data = mtcars, aes(x = vs, y = mpg, fill = am)) +
         geom_bar(stat = "summary") +
         ggtitle("stack") +
         theme_classic()
#  dodge
dodge2 <- ggplot(data = mtcars, aes(x = vs, y = mpg, fill = am)) +
         geom_bar(stat = "summary", position = position_dodge(0.9)) +
         ggtitle("dodge") +
         theme_classic()

describeBy(mpg ~ am * vs, data = mtcars)
```

    ## 
    ##  Descriptive statistics by group 
    ## am: automatic
    ## vs: V
    ##    vars  n  mean   sd median trimmed mad  min  max range  skew kurtosis  se
    ## X1    1 12 15.05 2.77   15.2    15.1 2.3 10.4 19.2   8.8 -0.28    -0.96 0.8
    ## ------------------------------------------------------------ 
    ## am: manual
    ## vs: V
    ##    vars n  mean   sd median trimmed  mad min max range skew kurtosis   se
    ## X1    1 6 19.75 4.01  20.35   19.75 3.85  15  26    11 0.21    -1.53 1.64
    ## ------------------------------------------------------------ 
    ## am: automatic
    ## vs: S
    ##    vars n  mean   sd median trimmed  mad  min  max range skew kurtosis   se
    ## X1    1 7 20.74 2.47   21.4   20.74 3.26 17.8 24.4   6.6  0.1    -1.75 0.93
    ## ------------------------------------------------------------ 
    ## am: manual
    ## vs: S
    ##    vars n  mean   sd median trimmed mad  min  max range  skew kurtosis  se
    ## X1    1 7 28.37 4.76   30.4   28.37 4.6 21.4 33.9  12.5 -0.35    -1.73 1.8

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-9-1.png)

### การสร้างกราฟที่มี Error Bar

ในการสร้างกราฟแบบ bar graph และ line graph
เราสามารถที่จะแสดงผลความคลาดเคลื่อนข้อมูลโดยเพิ่มคำสั่ง
`geom_errorbar()` โดยเราสามารถหาค่า *sd*, *se*, หรือ *ci*
จากข้อมูลที่เรามีก่อนการสร้าง Error Bar โดยใช้คำสั่ง `summarySE()` จาก
package `Rmisc`โดยใช้คำสั่ง

`summarySE(ชื่อไฟล์, measurevar = "ชื่อตัวแปรที่ต้องการหาค่ามาตรฐาน", groupvars = c("ชื่อกลุ่ม 1", "ชื่อกลุ่ม 2"))`

``` r
library(Rmisc)

sum <- summarySE(mtcars, measurevar="mpg", groupvars=c("am","vs"))
sum
```

    ##          am vs  N      mpg       sd        se       ci
    ## 1 automatic  V 12 15.05000 2.774396 0.8008991 1.762767
    ## 2 automatic  S  7 20.74286 2.471071 0.9339769 2.285359
    ## 3    manual  V  6 19.75000 4.008865 1.6366124 4.207046
    ## 4    manual  S  7 28.37143 4.757701 1.7982418 4.400139

เมื่อได้ค่าความคลาดเคลื่อนออกมาแล้ว เราจะสร้างกราฟจาก object ที่มาจาก
`summarySE()` นี้

โดยในการสร้าง line graph เราจะใช้คำสั่ง `geom_point()` และ `geom_line()`
โดย `geom_point()` จะเป็นการกำหนดให้กราฟมีจุดที่เป็นค่า mean และ
`geom_line()`จะเป็นการใส่เส้นกราฟ
ซึ่งเราสามารถเซ็ตให้กราฟมีการแยกกลุ่มตามที่เรากำหนดโดยใส่
`aes(group = ตัวแปรจัดกลุ่ม)`

จากนั้น เพิ่มคำสั่ง `geom_errorbar()` ในการสร้าง error bar โดยใช้คำสั่ง
`aes(ymin = ชื่อตัวแปรค่า mean - ci, ymax = ชื่อตัวแปรค่า mean + ci)`
(*Note*: เราสามารถใช้ค่า *sd* หรือ *se* ในการสร้าง error bar
ได้โดยการเปลี่ยน `ci` เป็น `sd` หรือ `se`)

หากกราฟที่ปรากฎออกมามีค่าแกน x และ y ที่ไม่สมดุล เราสามารถใช้คำสั่ง
`xlim()` หรือ `ylim()` เพื่อปรับแก้สเกลให้เหมาะสมได้

``` r
#only plot
line.plot <- ggplot(sum, aes(x = am, y = mpg, color = vs)) +
             geom_point(position = position_dodge(.2)) +
             geom_line(aes(group = vs), position = position_dodge(.2)) +
             ylim(5, 35) +
             ggtitle("Line Plot without Error Bar") +
             theme_classic() +
             scale_color_brewer(palette="Accent")

#with error

line.error <- ggplot(sum, aes(x = am, y = mpg, color = vs)) +
             geom_point(position = position_dodge(.2)) +
             geom_line(aes(group = vs), position = position_dodge(.2)) +
             geom_errorbar(aes(ymin=mpg-ci, ymax=mpg+ci), width=.2, 
                           position=position_dodge(.2)) +
             ylim(5, 35) +
             ggtitle("Line Plot with Error Bar") +
             theme_classic() +
             scale_color_brewer(palette="Accent")
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-12-1.png)

นอกจากนี้ การสร้าง error bar ด้วยคำสั่ง `geom_errorbar()`
ยังสามารถนำไปประยุกต์กับ bar graph ได้เช่นกัน แต่ในกรณีรการสร้าง bar
graph จากข้อมูลที่หาค่าสถิติจากคำสั่ง `summarySE()` มาแล้วนั้น
สังเกตว่าจะมีค่า mean เฉลี่ยแต่ละกลุ่ม (และค่าความคลาดเคลื่อนอื่น ๆ)
เท่านั้น ดังนั้นในกรณีนี้เราจะใช้คำสั่ง `geom_col()` ในการสร้าง bar
graph

``` r
bar.error <- ggplot(sum, aes(x = am, y = mpg, color = vs)) + 
             geom_col(aes(fill = vs), alpha = .5, position = position_dodge(.9)) +
             geom_errorbar(aes(ymin=mpg-ci, ymax=mpg+ci), width = .3, 
                           position = position_dodge(.9)) + 
             theme_classic() +
             scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) +
             scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

bar.error
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-13-1.png)

### การสร้างกราฟรูปแบบอื่น ๆ

นอกจาก boxplot, Bar Graph และ Line Graph แล้ว package `Ggplot2`
ยังช่วยเราในการสร้างกราฟอื่น ๆ ได้ เช่น
กราฟที่มีตัวแปรเป็นตัวแปรต่อเนื่อง (continuous variable)
เราสามารถใช้คำสั่ง `geom_point()` ในการสร้างจุดข้อมูล และ
`geom_smooth()` ในการหาเส้นตรงที่เหมาะสมระหว่างข้อมูลทั้งสองตัวแปร
โดยเพิ่มคำสั่ง `geom_smooth(method = lm)`

``` r
con.point <- ggplot(mtcars, aes(x = hp, y = mpg, color = hp)) + 
             geom_point(aes(color = hp)) +
             geom_smooth(method = lm, color = "darkblue") +
             theme_classic()

con.point
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-14-1.png)

เรายังสามารถสร้างข้อมูลเชิงเส้นโดยการใช้คำสั่ง `geom_line()` และ
`geom_jitter()` ในการสร้างกราฟเส้น

``` r
con.line <- ggplot(mtcars, aes(x = hp, y = mpg, group = vs)) + 
             geom_line(color = "blue3", position = position_dodge(.9)) +
             geom_jitter(alpha = 0.1, size = 0.5) +
             theme_classic()

con.line
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-15-1.png)

### การปรับแต่งสีในกราฟ

เราสามารถเลือกปรับแต่งกราฟได้โดยการใช้คำสั่ง `theme_`
และการใส่สีของกราฟ  
ทั้ง `R` และ `Ggplot2` มีระบบสีที่ช่วยให้เราเลือกสี 2 วิธี คือ 1.
เราสามารถใส่ชื่อสีที่เราต้องการได้โดยเรียกดูชื่อสีในคำสั่ง `colors()`
ซึ่งเป็นคำสั่งจาก Base R หรือ 2. คำสั่ง `display.brewer.all()`จาก
package `RColorBrewer`

``` r
colors()
```

    ##   [1] "white"                "aliceblue"            "antiquewhite"        
    ##   [4] "antiquewhite1"        "antiquewhite2"        "antiquewhite3"       
    ##   [7] "antiquewhite4"        "aquamarine"           "aquamarine1"         
    ##  [10] "aquamarine2"          "aquamarine3"          "aquamarine4"         
    ##  [13] "azure"                "azure1"               "azure2"              
    ##  [16] "azure3"               "azure4"               "beige"               
    ##  [19] "bisque"               "bisque1"              "bisque2"             
    ##  [22] "bisque3"              "bisque4"              "black"               
    ##  [25] "blanchedalmond"       "blue"                 "blue1"               
    ##  [28] "blue2"                "blue3"                "blue4"               
    ##  [31] "blueviolet"           "brown"                "brown1"              
    ##  [34] "brown2"               "brown3"               "brown4"              
    ##  [37] "burlywood"            "burlywood1"           "burlywood2"          
    ##  [40] "burlywood3"           "burlywood4"           "cadetblue"           
    ##  [43] "cadetblue1"           "cadetblue2"           "cadetblue3"          
    ##  [46] "cadetblue4"           "chartreuse"           "chartreuse1"         
    ##  [49] "chartreuse2"          "chartreuse3"          "chartreuse4"         
    ##  [52] "chocolate"            "chocolate1"           "chocolate2"          
    ##  [55] "chocolate3"           "chocolate4"           "coral"               
    ##  [58] "coral1"               "coral2"               "coral3"              
    ##  [61] "coral4"               "cornflowerblue"       "cornsilk"            
    ##  [64] "cornsilk1"            "cornsilk2"            "cornsilk3"           
    ##  [67] "cornsilk4"            "cyan"                 "cyan1"               
    ##  [70] "cyan2"                "cyan3"                "cyan4"               
    ##  [73] "darkblue"             "darkcyan"             "darkgoldenrod"       
    ##  [76] "darkgoldenrod1"       "darkgoldenrod2"       "darkgoldenrod3"      
    ##  [79] "darkgoldenrod4"       "darkgray"             "darkgreen"           
    ##  [82] "darkgrey"             "darkkhaki"            "darkmagenta"         
    ##  [85] "darkolivegreen"       "darkolivegreen1"      "darkolivegreen2"     
    ##  [88] "darkolivegreen3"      "darkolivegreen4"      "darkorange"          
    ##  [91] "darkorange1"          "darkorange2"          "darkorange3"         
    ##  [94] "darkorange4"          "darkorchid"           "darkorchid1"         
    ##  [97] "darkorchid2"          "darkorchid3"          "darkorchid4"         
    ## [100] "darkred"              "darksalmon"           "darkseagreen"        
    ## [103] "darkseagreen1"        "darkseagreen2"        "darkseagreen3"       
    ## [106] "darkseagreen4"        "darkslateblue"        "darkslategray"       
    ## [109] "darkslategray1"       "darkslategray2"       "darkslategray3"      
    ## [112] "darkslategray4"       "darkslategrey"        "darkturquoise"       
    ## [115] "darkviolet"           "deeppink"             "deeppink1"           
    ## [118] "deeppink2"            "deeppink3"            "deeppink4"           
    ## [121] "deepskyblue"          "deepskyblue1"         "deepskyblue2"        
    ## [124] "deepskyblue3"         "deepskyblue4"         "dimgray"             
    ## [127] "dimgrey"              "dodgerblue"           "dodgerblue1"         
    ## [130] "dodgerblue2"          "dodgerblue3"          "dodgerblue4"         
    ## [133] "firebrick"            "firebrick1"           "firebrick2"          
    ## [136] "firebrick3"           "firebrick4"           "floralwhite"         
    ## [139] "forestgreen"          "gainsboro"            "ghostwhite"          
    ## [142] "gold"                 "gold1"                "gold2"               
    ## [145] "gold3"                "gold4"                "goldenrod"           
    ## [148] "goldenrod1"           "goldenrod2"           "goldenrod3"          
    ## [151] "goldenrod4"           "gray"                 "gray0"               
    ## [154] "gray1"                "gray2"                "gray3"               
    ## [157] "gray4"                "gray5"                "gray6"               
    ## [160] "gray7"                "gray8"                "gray9"               
    ## [163] "gray10"               "gray11"               "gray12"              
    ## [166] "gray13"               "gray14"               "gray15"              
    ## [169] "gray16"               "gray17"               "gray18"              
    ## [172] "gray19"               "gray20"               "gray21"              
    ## [175] "gray22"               "gray23"               "gray24"              
    ## [178] "gray25"               "gray26"               "gray27"              
    ## [181] "gray28"               "gray29"               "gray30"              
    ## [184] "gray31"               "gray32"               "gray33"              
    ## [187] "gray34"               "gray35"               "gray36"              
    ## [190] "gray37"               "gray38"               "gray39"              
    ## [193] "gray40"               "gray41"               "gray42"              
    ## [196] "gray43"               "gray44"               "gray45"              
    ## [199] "gray46"               "gray47"               "gray48"              
    ## [202] "gray49"               "gray50"               "gray51"              
    ## [205] "gray52"               "gray53"               "gray54"              
    ## [208] "gray55"               "gray56"               "gray57"              
    ## [211] "gray58"               "gray59"               "gray60"              
    ## [214] "gray61"               "gray62"               "gray63"              
    ## [217] "gray64"               "gray65"               "gray66"              
    ## [220] "gray67"               "gray68"               "gray69"              
    ## [223] "gray70"               "gray71"               "gray72"              
    ## [226] "gray73"               "gray74"               "gray75"              
    ## [229] "gray76"               "gray77"               "gray78"              
    ## [232] "gray79"               "gray80"               "gray81"              
    ## [235] "gray82"               "gray83"               "gray84"              
    ## [238] "gray85"               "gray86"               "gray87"              
    ## [241] "gray88"               "gray89"               "gray90"              
    ## [244] "gray91"               "gray92"               "gray93"              
    ## [247] "gray94"               "gray95"               "gray96"              
    ## [250] "gray97"               "gray98"               "gray99"              
    ## [253] "gray100"              "green"                "green1"              
    ## [256] "green2"               "green3"               "green4"              
    ## [259] "greenyellow"          "grey"                 "grey0"               
    ## [262] "grey1"                "grey2"                "grey3"               
    ## [265] "grey4"                "grey5"                "grey6"               
    ## [268] "grey7"                "grey8"                "grey9"               
    ## [271] "grey10"               "grey11"               "grey12"              
    ## [274] "grey13"               "grey14"               "grey15"              
    ## [277] "grey16"               "grey17"               "grey18"              
    ## [280] "grey19"               "grey20"               "grey21"              
    ## [283] "grey22"               "grey23"               "grey24"              
    ## [286] "grey25"               "grey26"               "grey27"              
    ## [289] "grey28"               "grey29"               "grey30"              
    ## [292] "grey31"               "grey32"               "grey33"              
    ## [295] "grey34"               "grey35"               "grey36"              
    ## [298] "grey37"               "grey38"               "grey39"              
    ## [301] "grey40"               "grey41"               "grey42"              
    ## [304] "grey43"               "grey44"               "grey45"              
    ## [307] "grey46"               "grey47"               "grey48"              
    ## [310] "grey49"               "grey50"               "grey51"              
    ## [313] "grey52"               "grey53"               "grey54"              
    ## [316] "grey55"               "grey56"               "grey57"              
    ## [319] "grey58"               "grey59"               "grey60"              
    ## [322] "grey61"               "grey62"               "grey63"              
    ## [325] "grey64"               "grey65"               "grey66"              
    ## [328] "grey67"               "grey68"               "grey69"              
    ## [331] "grey70"               "grey71"               "grey72"              
    ## [334] "grey73"               "grey74"               "grey75"              
    ## [337] "grey76"               "grey77"               "grey78"              
    ## [340] "grey79"               "grey80"               "grey81"              
    ## [343] "grey82"               "grey83"               "grey84"              
    ## [346] "grey85"               "grey86"               "grey87"              
    ## [349] "grey88"               "grey89"               "grey90"              
    ## [352] "grey91"               "grey92"               "grey93"              
    ## [355] "grey94"               "grey95"               "grey96"              
    ## [358] "grey97"               "grey98"               "grey99"              
    ## [361] "grey100"              "honeydew"             "honeydew1"           
    ## [364] "honeydew2"            "honeydew3"            "honeydew4"           
    ## [367] "hotpink"              "hotpink1"             "hotpink2"            
    ## [370] "hotpink3"             "hotpink4"             "indianred"           
    ## [373] "indianred1"           "indianred2"           "indianred3"          
    ## [376] "indianred4"           "ivory"                "ivory1"              
    ## [379] "ivory2"               "ivory3"               "ivory4"              
    ## [382] "khaki"                "khaki1"               "khaki2"              
    ## [385] "khaki3"               "khaki4"               "lavender"            
    ## [388] "lavenderblush"        "lavenderblush1"       "lavenderblush2"      
    ## [391] "lavenderblush3"       "lavenderblush4"       "lawngreen"           
    ## [394] "lemonchiffon"         "lemonchiffon1"        "lemonchiffon2"       
    ## [397] "lemonchiffon3"        "lemonchiffon4"        "lightblue"           
    ## [400] "lightblue1"           "lightblue2"           "lightblue3"          
    ## [403] "lightblue4"           "lightcoral"           "lightcyan"           
    ## [406] "lightcyan1"           "lightcyan2"           "lightcyan3"          
    ## [409] "lightcyan4"           "lightgoldenrod"       "lightgoldenrod1"     
    ## [412] "lightgoldenrod2"      "lightgoldenrod3"      "lightgoldenrod4"     
    ## [415] "lightgoldenrodyellow" "lightgray"            "lightgreen"          
    ## [418] "lightgrey"            "lightpink"            "lightpink1"          
    ## [421] "lightpink2"           "lightpink3"           "lightpink4"          
    ## [424] "lightsalmon"          "lightsalmon1"         "lightsalmon2"        
    ## [427] "lightsalmon3"         "lightsalmon4"         "lightseagreen"       
    ## [430] "lightskyblue"         "lightskyblue1"        "lightskyblue2"       
    ## [433] "lightskyblue3"        "lightskyblue4"        "lightslateblue"      
    ## [436] "lightslategray"       "lightslategrey"       "lightsteelblue"      
    ## [439] "lightsteelblue1"      "lightsteelblue2"      "lightsteelblue3"     
    ## [442] "lightsteelblue4"      "lightyellow"          "lightyellow1"        
    ## [445] "lightyellow2"         "lightyellow3"         "lightyellow4"        
    ## [448] "limegreen"            "linen"                "magenta"             
    ## [451] "magenta1"             "magenta2"             "magenta3"            
    ## [454] "magenta4"             "maroon"               "maroon1"             
    ## [457] "maroon2"              "maroon3"              "maroon4"             
    ## [460] "mediumaquamarine"     "mediumblue"           "mediumorchid"        
    ## [463] "mediumorchid1"        "mediumorchid2"        "mediumorchid3"       
    ## [466] "mediumorchid4"        "mediumpurple"         "mediumpurple1"       
    ## [469] "mediumpurple2"        "mediumpurple3"        "mediumpurple4"       
    ## [472] "mediumseagreen"       "mediumslateblue"      "mediumspringgreen"   
    ## [475] "mediumturquoise"      "mediumvioletred"      "midnightblue"        
    ## [478] "mintcream"            "mistyrose"            "mistyrose1"          
    ## [481] "mistyrose2"           "mistyrose3"           "mistyrose4"          
    ## [484] "moccasin"             "navajowhite"          "navajowhite1"        
    ## [487] "navajowhite2"         "navajowhite3"         "navajowhite4"        
    ## [490] "navy"                 "navyblue"             "oldlace"             
    ## [493] "olivedrab"            "olivedrab1"           "olivedrab2"          
    ## [496] "olivedrab3"           "olivedrab4"           "orange"              
    ## [499] "orange1"              "orange2"              "orange3"             
    ## [502] "orange4"              "orangered"            "orangered1"          
    ## [505] "orangered2"           "orangered3"           "orangered4"          
    ## [508] "orchid"               "orchid1"              "orchid2"             
    ## [511] "orchid3"              "orchid4"              "palegoldenrod"       
    ## [514] "palegreen"            "palegreen1"           "palegreen2"          
    ## [517] "palegreen3"           "palegreen4"           "paleturquoise"       
    ## [520] "paleturquoise1"       "paleturquoise2"       "paleturquoise3"      
    ## [523] "paleturquoise4"       "palevioletred"        "palevioletred1"      
    ## [526] "palevioletred2"       "palevioletred3"       "palevioletred4"      
    ## [529] "papayawhip"           "peachpuff"            "peachpuff1"          
    ## [532] "peachpuff2"           "peachpuff3"           "peachpuff4"          
    ## [535] "peru"                 "pink"                 "pink1"               
    ## [538] "pink2"                "pink3"                "pink4"               
    ## [541] "plum"                 "plum1"                "plum2"               
    ## [544] "plum3"                "plum4"                "powderblue"          
    ## [547] "purple"               "purple1"              "purple2"             
    ## [550] "purple3"              "purple4"              "red"                 
    ## [553] "red1"                 "red2"                 "red3"                
    ## [556] "red4"                 "rosybrown"            "rosybrown1"          
    ## [559] "rosybrown2"           "rosybrown3"           "rosybrown4"          
    ## [562] "royalblue"            "royalblue1"           "royalblue2"          
    ## [565] "royalblue3"           "royalblue4"           "saddlebrown"         
    ## [568] "salmon"               "salmon1"              "salmon2"             
    ## [571] "salmon3"              "salmon4"              "sandybrown"          
    ## [574] "seagreen"             "seagreen1"            "seagreen2"           
    ## [577] "seagreen3"            "seagreen4"            "seashell"            
    ## [580] "seashell1"            "seashell2"            "seashell3"           
    ## [583] "seashell4"            "sienna"               "sienna1"             
    ## [586] "sienna2"              "sienna3"              "sienna4"             
    ## [589] "skyblue"              "skyblue1"             "skyblue2"            
    ## [592] "skyblue3"             "skyblue4"             "slateblue"           
    ## [595] "slateblue1"           "slateblue2"           "slateblue3"          
    ## [598] "slateblue4"           "slategray"            "slategray1"          
    ## [601] "slategray2"           "slategray3"           "slategray4"          
    ## [604] "slategrey"            "snow"                 "snow1"               
    ## [607] "snow2"                "snow3"                "snow4"               
    ## [610] "springgreen"          "springgreen1"         "springgreen2"        
    ## [613] "springgreen3"         "springgreen4"         "steelblue"           
    ## [616] "steelblue1"           "steelblue2"           "steelblue3"          
    ## [619] "steelblue4"           "tan"                  "tan1"                
    ## [622] "tan2"                 "tan3"                 "tan4"                
    ## [625] "thistle"              "thistle1"             "thistle2"            
    ## [628] "thistle3"             "thistle4"             "tomato"              
    ## [631] "tomato1"              "tomato2"              "tomato3"             
    ## [634] "tomato4"              "turquoise"            "turquoise1"          
    ## [637] "turquoise2"           "turquoise3"           "turquoise4"          
    ## [640] "violet"               "violetred"            "violetred1"          
    ## [643] "violetred2"           "violetred3"           "violetred4"          
    ## [646] "wheat"                "wheat1"               "wheat2"              
    ## [649] "wheat3"               "wheat4"               "whitesmoke"          
    ## [652] "yellow"               "yellow1"              "yellow2"             
    ## [655] "yellow3"              "yellow4"              "yellowgreen"

``` r
RColorBrewer::display.brewer.all()
```

![](ggplot_knit_files/figure-markdown_github/unnamed-chunk-16-1.png)
<<<<<<< HEAD
\*this tutorial was in associated with Psychology Faculty, Chulalongkorn
=======

*this tutorial was in associated with Psychology Faculty, Chulalongkorn
>>>>>>> 49c3f4e18fe072df78516fcb02af9bad4d131e60
University in Experimental Design And Analysis course.
