Basic R for Cats
================
07/05/2023

# การใช้ R ขั้นพื้นฐานสำหรับการวิเคราะห์ทางสถิติ

ในการวิเคราะห์สถิติขั้นพื้นฐาน มีขั้นตอนที่สำคัญที่เราจะค่อย ๆ
ทำไปที่ละขั้น

หากเราทำความรู้จัก Code พื้นฐานสำคัญของ R จะทำให้เราเข้าใจภาษา R
ง่ายยิ่งขึ้น

ใน Demo นี้ เราจะทำความรู้จักสมการหรือภาษาของ R และ คำสั่ง (function)
พื้นฐานกัน

## พื้นฐานสุด ๆ

สมมติว่าเราต้องการให้ R ทำงานเปรียบเสมือนเครื่องคิดเลข
เราสามารถสั่งคำสั่งได้โดยการใช้ เครื่องหมาย `+, -, *, /` (บวก ลบ คูณ
และหาร ตามลำดับ)

``` r
3 + 6
```

    ## [1] 9

``` r
3 - 6
```

    ## [1] -3

``` r
3 * 6
```

    ## [1] 18

``` r
3 / 6
```

    ## [1] 0.5

ผลที่ R แสดงขึ้นมาคือผลที่เราต้องการหาคำตอบค่า

## รู้จักชนิดของวัตถุใน R

วัตถุ หรือ `object` ใน R มีหลายประเภท โดยพื้นฐานแล้ว เราจะใช้ `vector`
`array` `matrix` `dataframe`
โดยแต่ละชนิดอาจะมีวิธีการเรียกใช้แตกต่างกันไปบ้าง

``` r
vector1 <- c(1, 2, 3, 4, 5, 6)

vector2 <- c(0, 1, 2, 3, 4, 5)

vector3 <- c("a", "b", "c", "d", "e")

vector4 <- c(1.3, 1.2, 1.4, 1.5, 1.1)

array <- rbind(vector1, vector2, vector3)

matrix <- matrix(1:6, 6, 6)
matrix
```

    ##      [,1] [,2] [,3] [,4] [,5] [,6]
    ## [1,]    1    1    1    1    1    1
    ## [2,]    2    2    2    2    2    2
    ## [3,]    3    3    3    3    3    3
    ## [4,]    4    4    4    4    4    4
    ## [5,]    5    5    5    5    5    5
    ## [6,]    6    6    6    6    6    6

``` r
dataframe <- data.frame(matrix)
dataframe
```

    ##   X1 X2 X3 X4 X5 X6
    ## 1  1  1  1  1  1  1
    ## 2  2  2  2  2  2  2
    ## 3  3  3  3  3  3  3
    ## 4  4  4  4  4  4  4
    ## 5  5  5  5  5  5  5
    ## 6  6  6  6  6  6  6

จะเห็นได้ว่า `vector` คือเลขเรียงลำดับในบรรทักเดียวไปเรื่อย ๆ ในขณะที่
`Array` จะเป็น `vector` ที่มีหลายมิติ `Matrix` คือเลขที่มีทั้งแถว (row)
และสดมภ์ (column๗ เช่นเดียวกับ `dataframe` แต่ `dataframe`
จะบ่งบอกลักษณะได้หลายประการมากกว่า โดยจะมี `structure` คือ ชื่อตัวแปร
ลักษณะของตัวแปร และจำนวนของ `observation` (แถว) นี่เอง

ที่นี้เราลองมาใช้การคำนวณใน object ที่เราสร้างมากัน

``` r
vector1 + vector2
```

    ## [1]  1  3  5  7  9 11

``` r
vector1 * vector2
```

    ## [1]  0  2  6 12 20 30

สังเกตว่า vector1 กับ vector2 เมื่อ บวก และ คูณ กันจะได้ผลลัพธ์ตาม
output ด้านบนนี้

แต่!!!! ถ้าสมมติว่าเราเอา vector1 บวก และ คูณ vector3 ละ?

ผลจะแสดง `Error` ออกมาตามนี้เลย เนื่องจาก R จัดแบ่งข้อมูล `vector`
ที่เราใส่ลงไป 4 แบบด้วยกันคือ `charactor` หรือ `numeric` การเกิด `error`
นี้แปลว่า R จะไม่เอา `charactor` ไปคำนวณกับ numeric นี่เอง

และถ้าเราเอา `Matrix` คำนวณกับ `Vector` ผลที่ได้คือ

จะเห็นได้ว่า ข้อมูลใน `vector` นำเข้าไปคำนวณในทุกๆ แถวของ `matrix` เลย
แต่!! ผลลัพธ์ที่ 3 ก็ออกมา `error` เช่นกัน

ลักษณะการคำนวณเช่นนี้ `dataframe` จะไม่แตกต่างจาก `matrix` เท่าไหร่นัก
เดี๋ยวเราไปรู้จักชนิดของข้อมูลการดีกว่า

## ชนิดของข้อมูลที่เราคีย์ใน R

ข้อมูลที่เราได้จาก database หรือการเก็บมาเองจะมีลำดับของมาตรส่วน
หรือที่เรียกว่า Level of Measurements

![levels](https://raw.githubusercontent.com/amaiesc/study_r/master/docs/levels.png)

<img src="https://raw.githubusercontent.com/amaiesc/study_r/master/docs/levels.png" alt="levels">

ใน R เราจะรู้จัก `level` เหล่านี้ได้ในอีกรูปแบบต่างออกไปคือ
`Qualitative = Factor` ซึ่งส่วนใหญ่นักวิจัยหรือนักวิเคราะห์จะ `key`
ข้อมูลเหล่านี้เป็นตัวอักษร หรือ `charactor` และ `Quantitative = Numeric`
ซึ่งเป็นเป็นตัวเลขที่มีทศนิยมหรือไม่มีก็ได้

``` r
typeof(vector1)
```

    ## [1] "double"

``` r
typeof(vector3)
```

    ## [1] "character"

``` r
typeof(vector4)
```

    ## [1] "double"

``` r
class(vector1)
```

    ## [1] "numeric"

``` r
class(vector3)
```

    ## [1] "character"

``` r
class(vector4)
```

    ## [1] "numeric"

จะเห็นได้ว่า เมื่อใช้คำสั่ง `typeof()` และ
`class()`ข้อมูลที่เป็นตัวเลขจะแสดงผลเป็น `double (เลขที่ไม่มีจุดทศนิยม)`
และ `numeric` ในขณะที่ ข้อมูลที่เป็นตัวอักษรจะแสดงผลออกมาเป็น
`character`

เพราะฉะนั้น การ key ข้อมูลใน R จะมี 2 ลักษณะคือ
เมื่อไหร่ก็ตามที่เราคีย์เป็นตัวเลข R จะจัดให้เป็น numeric
และถ้าเราคีย์เป็นตัวอักษร R โดยการใส่เครื่องหมายคำพูด (quotation)
`"____"` จะจัดให้เป็น character หากต้องการเปลี่ยนลักษณะของข้อมูล
สามารถทำได้หลาย (มากๆ) วิธีด้วยกัน เราชอบใช้ `as.________` ที่สุด
(ง่ายดี)

## การเปลี่ยนชนิดข้อมูลใน R

`Demo` นี้เราจะใช้ `dataset` ชื่อว่า coronavirus ที่มาจาก Package
ชื่อว่า coronavirus

เนื่องจากว่า R มีนักพัฒนาใจดีทั่วโลกร่วมกันเขียน package ออกมาหลากหลาย
(ดูได้ใน Cran.R) การเรียก package ออกมาเราจะต้องทำการติดตั้ง package
นั้นเสียก่อน โดยใช้ คำสั่ง `install.packages("_____")` ต้องมีเครื่องหมาย
Quatation ด้วยนะ และเรียก package นั้นออกมาด้วยคำสั่ง `library()`

เนื่องจากว่า เรามีตัวแปรที่เป็น**กลุ่ม** (เช่น เพศ ลำดับในองค์กร
พื้นที่) และ**ข้อมูลต่อเนื่อง** (เช่น มาตรวัด น้ำหนัก อายุ ส่วนสูง)
เราจึงต้องจัดชนิดของข้อมูลใน R ให้เหมาะสมด้วยการเขียนคำสั่ง เช่น

``` r
#install.packages("coronavirus")
library(coronavirus)
head(coronavirus)
```

    ##         date province country     lat      long      type cases   uid iso2 iso3
    ## 1 2020-01-22  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN
    ## 2 2020-01-23  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN
    ## 3 2020-01-24  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN
    ## 4 2020-01-25  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN
    ## 5 2020-01-26  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN
    ## 6 2020-01-27  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN
    ##   code3    combined_key population continent_name continent_code
    ## 1   124 Alberta, Canada    4413146  North America             NA
    ## 2   124 Alberta, Canada    4413146  North America             NA
    ## 3   124 Alberta, Canada    4413146  North America             NA
    ## 4   124 Alberta, Canada    4413146  North America             NA
    ## 5   124 Alberta, Canada    4413146  North America             NA
    ## 6   124 Alberta, Canada    4413146  North America             NA

``` r
typeof(coronavirus)
```

    ## [1] "list"

``` r
class(coronavirus)
```

    ## [1] "data.frame"

`dataset` นี้มีลักษณะเป็น `list` โดยมีข้อมูลเป็น `data.frame` ใน
`dataset` นี้ มีตัวแปรแบบกลุ่มที่เห็นได้ชัดคือ `country` และ `province`
ในขณะที่ตัวแปรแบบต่อเนื่องคือ จำนวน `case` `population`
(ที่เหลือเดี๋ยวสนุกแล้วกลับมาเล่นได้นะ)

เราจะเรียกใช้เพียง country province case population เท่านั้น
วิธีการด้านล่างจะเรียกว่าวิธีการ `subset` ซึ่งจะมีการพูดถึงในส่วนถัดไป

``` r
Data <- coronavirus[c("date", "province", "country", "cases", "population")]
head(Data, 3)
```

    ##         date province country cases population
    ## 1 2020-01-22  Alberta  Canada     0    4413146
    ## 2 2020-01-23  Alberta  Canada     0    4413146
    ## 3 2020-01-24  Alberta  Canada     0    4413146

การที่เราจะดูลักษณะ (structure) ของข้อมูลในแต่ละ column
เราสามารถเรียกคำสั่ง `str()` ออกมาให้เราดูโดยรวมได้

``` r
str(Data)
```

    ## 'data.frame':    518682 obs. of  5 variables:
    ##  $ date      : Date, format: "2020-01-22" "2020-01-23" ...
    ##  $ province  : chr  "Alberta" "Alberta" "Alberta" "Alberta" ...
    ##  $ country   : chr  "Canada" "Canada" "Canada" "Canada" ...
    ##  $ cases     : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ population: num  4413146 4413146 4413146 4413146 4413146 ...

จะเห็นได้ว่า ข้อมูลที่เรา `subset` มาแล้วมีจำนวน `observation = 518682`
และมีตัวแปร `5` ตัว คือ date `(Date)`, province `(chr)`, country
`(chr)`, cases `(int)`, population `(num)`

ถ้าเราอยากเปลี่ยนชนิดของตัวแปร เช่น เปลี่ยน province ให้เป็น factor
เราสามารถทำได้โดยการ เรียกชื่อ `file` และ ใช้ `$` (เรียกว่า dolla sign)
และชื่อ `column` ที่มีตัวแปรนั้นอยู่ เช่น
`as.factor(data$columnx)`เมื่อแปลงเป็น `factor` เรียบร้อยแล้ว
เราสามารถเรียกดูชนิดได้โดยใช้คำสั่ง `is.factor()`

``` r
Data$province <- as.factor(Data$province)
is.factor(Data$province)
```

    ## [1] TRUE

ถ้าเราต้องการเปลี่ยนเป็นชนิดอื่น ๆ ก็ใช้คำสั่ง `as.____()` R จะมี
`dropdown` ลงมาให้ว่ามีตัวเลือกอะไรให้บ้าง เช่น `as.numeric()`

## การ Subset ข้อมูลใน dataset

ไม่ว่า `dataset` จะมีลักษณะ `array`, `matrix`, หรือ `dataframe`
เราสามารถ `subset` หรือพูดง่าย ๆ คือการตัดเฉพาะข้อมูลที่เราจะใช้ออกมาได้
การ subset จะมีการเขียนคำสั่งแตกต่างไปบ้างขึ้นอยู่กับลักษณะ `dataset`
แต่สิ่งที่สำคัญที่สุดคือการเรียนรู้การระบุพิกัดของข้อมูล
หรือที่เราเรียกว่า `indexing`

การระบุพิกัดของข้อมูล (indexing)

ในการฝึกนี้เราจะใช้ matrix ที่เราสร้างไว้ในตอนแรกสุด

``` r
matrix
```

    ##      [,1] [,2] [,3] [,4] [,5] [,6]
    ## [1,]    1    1    1    1    1    1
    ## [2,]    2    2    2    2    2    2
    ## [3,]    3    3    3    3    3    3
    ## [4,]    4    4    4    4    4    4
    ## [5,]    5    5    5    5    5    5
    ## [6,]    6    6    6    6    6    6

การเรียง `index` ของ `R` จะเป็นการเรียงแบบ \[เลขแถว, เลขคอลลัมภ์\]
นั่นหมายความว่า ถ้าจะเรียกข้อมูลแถวที่ `3` บรรทัดที่ `4` ออกมา
เราจะเขียนคำสั่งว่า ชื่อ `file[3,4]`
แต่หากว่าต้องการข้อมูลทั้งแถวหรือทั้งคอลลัมภ์
เราสามารถเรียกได้โดยการไม่ใส่ข้อมูลใด ๆ ลงใน `[ , ]` เช่น

``` r
matrix[3,4]
```

    ## [1] 3

``` r
matrix[ ,4]
```

    ## [1] 1 2 3 4 5 6

``` r
matrix[3, ]
```

    ## [1] 3 3 3 3 3 3

คำสั่งนี้ยังนำไปใช้กับ `dataframe` หรือ `table` ได้เลย
แต่เนื่องจากความเป็น `dataframe` `R` จะบอกชื่อคอลลัมภ์กำกับมาด้วย

``` r
dataframe[3, 4]
```

    ## [1] 3

``` r
dataframe[ ,4]
```

    ## [1] 1 2 3 4 5 6

``` r
dataframe[3, ]
```

    ##   X1 X2 X3 X4 X5 X6
    ## 3  3  3  3  3  3  3

การเลือกพิกัดอย่างเฉพาะเจาะจง

นอกจากการเลือกพิกัดตามคำสั่งด้านบนแล้ว หากข้อมูลมีความหลากหลายมาก ๆ
เราสามารถเลือกตัวแปรที่ต้องการ แถวที่ต้องการโดยใช้คำสั่ง `c()`
(มาจากคำว่า combine) กำกับ และ `:` สำหรับการเรียกข้อมูลที่ต่อกัน

เช่น หากต้องการเรียกแถวที่ `1` ถึง `200` และ เรียกทุก ๆ คอลลัมภ์
เราสามารถใช้ `[1:200, ]` กับ `dataset` ได้เลย
แต่ถ้าหากว่าเราต้องการข้อมูลที่แถว `1:10, 15, 16, 19, และ 200` ในทุก ๆ
คอลลัมภ์ เราสามารถเขียน
`[c(1:10, 15, 16, 19, 200), ]`จะพบว่าจำนวนแถวจะตรงกับแถวที่เราต้องการ

``` r
Data[1:200, ]
```

    ##           date province country cases population
    ## 1   2020-01-22  Alberta  Canada     0    4413146
    ## 2   2020-01-23  Alberta  Canada     0    4413146
    ## 3   2020-01-24  Alberta  Canada     0    4413146
    ## 4   2020-01-25  Alberta  Canada     0    4413146
    ## 5   2020-01-26  Alberta  Canada     0    4413146
    ## 6   2020-01-27  Alberta  Canada     0    4413146
    ## 7   2020-01-28  Alberta  Canada     0    4413146
    ## 8   2020-01-29  Alberta  Canada     0    4413146
    ## 9   2020-01-30  Alberta  Canada     0    4413146
    ## 10  2020-01-31  Alberta  Canada     0    4413146
    ## 11  2020-02-01  Alberta  Canada     0    4413146
    ## 12  2020-02-02  Alberta  Canada     0    4413146
    ## 13  2020-02-03  Alberta  Canada     0    4413146
    ## 14  2020-02-04  Alberta  Canada     0    4413146
    ## 15  2020-02-05  Alberta  Canada     0    4413146
    ## 16  2020-02-06  Alberta  Canada     0    4413146
    ## 17  2020-02-07  Alberta  Canada     0    4413146
    ## 18  2020-02-08  Alberta  Canada     0    4413146
    ## 19  2020-02-09  Alberta  Canada     0    4413146
    ## 20  2020-02-10  Alberta  Canada     0    4413146
    ## 21  2020-02-11  Alberta  Canada     0    4413146
    ## 22  2020-02-12  Alberta  Canada     0    4413146
    ## 23  2020-02-13  Alberta  Canada     0    4413146
    ## 24  2020-02-14  Alberta  Canada     0    4413146
    ## 25  2020-02-15  Alberta  Canada     0    4413146
    ## 26  2020-02-16  Alberta  Canada     0    4413146
    ## 27  2020-02-17  Alberta  Canada     0    4413146
    ## 28  2020-02-18  Alberta  Canada     0    4413146
    ## 29  2020-02-19  Alberta  Canada     0    4413146
    ## 30  2020-02-20  Alberta  Canada     0    4413146
    ## 31  2020-02-21  Alberta  Canada     0    4413146
    ## 32  2020-02-22  Alberta  Canada     0    4413146
    ## 33  2020-02-23  Alberta  Canada     0    4413146
    ## 34  2020-02-24  Alberta  Canada     0    4413146
    ## 35  2020-02-25  Alberta  Canada     0    4413146
    ## 36  2020-02-26  Alberta  Canada     0    4413146
    ## 37  2020-02-27  Alberta  Canada     0    4413146
    ## 38  2020-02-28  Alberta  Canada     0    4413146
    ## 39  2020-02-29  Alberta  Canada     0    4413146
    ## 40  2020-03-01  Alberta  Canada     0    4413146
    ## 41  2020-03-02  Alberta  Canada     0    4413146
    ## 42  2020-03-03  Alberta  Canada     0    4413146
    ## 43  2020-03-04  Alberta  Canada     0    4413146
    ## 44  2020-03-05  Alberta  Canada     0    4413146
    ## 45  2020-03-06  Alberta  Canada     1    4413146
    ## 46  2020-03-07  Alberta  Canada     1    4413146
    ## 47  2020-03-08  Alberta  Canada     2    4413146
    ## 48  2020-03-09  Alberta  Canada     3    4413146
    ## 49  2020-03-10  Alberta  Canada     0    4413146
    ## 50  2020-03-11  Alberta  Canada    12    4413146
    ## 51  2020-03-12  Alberta  Canada     0    4413146
    ## 52  2020-03-13  Alberta  Canada    10    4413146
    ## 53  2020-03-14  Alberta  Canada     0    4413146
    ## 54  2020-03-15  Alberta  Canada    10    4413146
    ## 55  2020-03-16  Alberta  Canada    17    4413146
    ## 56  2020-03-17  Alberta  Canada    18    4413146
    ## 57  2020-03-18  Alberta  Canada    23    4413146
    ## 58  2020-03-19  Alberta  Canada    22    4413146
    ## 59  2020-03-20  Alberta  Canada    27    4413146
    ## 60  2020-03-21  Alberta  Canada    49    4413146
    ## 61  2020-03-22  Alberta  Canada    64    4413146
    ## 62  2020-03-23  Alberta  Canada    42    4413146
    ## 63  2020-03-24  Alberta  Canada    58    4413146
    ## 64  2020-03-25  Alberta  Canada    -1    4413146
    ## 65  2020-03-26  Alberta  Canada   128    4413146
    ## 66  2020-03-27  Alberta  Canada    56    4413146
    ## 67  2020-03-28  Alberta  Canada     0    4413146
    ## 68  2020-03-29  Alberta  Canada    79    4413146
    ## 69  2020-03-30  Alberta  Canada    40    4413146
    ## 70  2020-03-31  Alberta  Canada    29    4413146
    ## 71  2020-04-01  Alberta  Canada    64    4413146
    ## 72  2020-04-02  Alberta  Canada   215    4413146
    ## 73  2020-04-03  Alberta  Canada     0    4413146
    ## 74  2020-04-04  Alberta  Canada   106    4413146
    ## 75  2020-04-05  Alberta  Canada   106    4413146
    ## 76  2020-04-06  Alberta  Canada    69    4413146
    ## 77  2020-04-07  Alberta  Canada   123    4413146
    ## 78  2020-04-08  Alberta  Canada     0    4413146
    ## 79  2020-04-09  Alberta  Canada    50    4413146
    ## 80  2020-04-10  Alberta  Canada    28    4413146
    ## 81  2020-04-11  Alberta  Canada   116    4413146
    ## 82  2020-04-12  Alberta  Canada     0    4413146
    ## 83  2020-04-13  Alberta  Canada   165    4413146
    ## 84  2020-04-14  Alberta  Canada   138    4413146
    ## 85  2020-04-15  Alberta  Canada     0    4413146
    ## 86  2020-04-16  Alberta  Canada   126    4413146
    ## 87  2020-04-17  Alberta  Canada   401    4413146
    ## 88  2020-04-18  Alberta  Canada   165    4413146
    ## 89  2020-04-19  Alberta  Canada   241    4413146
    ## 90  2020-04-20  Alberta  Canada   105    4413146
    ## 91  2020-04-21  Alberta  Canada   187    4413146
    ## 92  2020-04-22  Alberta  Canada   306    4413146
    ## 93  2020-04-23  Alberta  Canada   319    4413146
    ## 94  2020-04-24  Alberta  Canada   297    4413146
    ## 95  2020-04-25  Alberta  Canada   216    4413146
    ## 96  2020-04-26  Alberta  Canada   247    4413146
    ## 97  2020-04-27  Alberta  Canada   216    4413146
    ## 98  2020-04-28  Alberta  Canada   154    4413146
    ## 99  2020-04-29  Alberta  Canada   315    4413146
    ## 100 2020-04-30  Alberta  Canada   190    4413146
    ## 101 2020-05-01  Alberta  Canada   218    4413146
    ## 102 2020-05-02  Alberta  Canada    97    4413146
    ## 103 2020-05-03  Alberta  Canada    96    4413146
    ## 104 2020-05-04  Alberta  Canada    70    4413146
    ## 105 2020-05-05  Alberta  Canada    57    4413146
    ## 106 2020-05-06  Alberta  Canada    70    4413146
    ## 107 2020-05-07  Alberta  Canada    54    4413146
    ## 108 2020-05-08  Alberta  Canada    81    4413146
    ## 109 2020-05-09  Alberta  Canada    59    4413146
    ## 110 2020-05-10  Alberta  Canada    96    4413146
    ## 111 2020-05-11  Alberta  Canada    47    4413146
    ## 112 2020-05-12  Alberta  Canada    45    4413146
    ## 113 2020-05-13  Alberta  Canada    62    4413146
    ## 114 2020-05-14  Alberta  Canada    50    4413146
    ## 115 2020-05-15  Alberta  Canada    58    4413146
    ## 116 2020-05-16  Alberta  Canada    72    4413146
    ## 117 2020-05-17  Alberta  Canada    57    4413146
    ## 118 2020-05-18  Alberta  Canada    39    4413146
    ## 119 2020-05-19  Alberta  Canada    33    4413146
    ## 120 2020-05-20  Alberta  Canada    19    4413146
    ## 121 2020-05-21  Alberta  Canada    33    4413146
    ## 122 2020-05-22  Alberta  Canada    32    4413146
    ## 123 2020-05-23  Alberta  Canada    18    4413146
    ## 124 2020-05-24  Alberta  Canada    42    4413146
    ## 125 2020-05-25  Alberta  Canada    19    4413146
    ## 126 2020-05-26  Alberta  Canada    22    4413146
    ## 127 2020-05-27  Alberta  Canada    25    4413146
    ## 128 2020-05-28  Alberta  Canada    29    4413146
    ## 129 2020-05-29  Alberta  Canada    24    4413146
    ## 130 2020-05-30  Alberta  Canada    13    4413146
    ## 131 2020-05-31  Alberta  Canada    18    4413146
    ## 132 2020-06-01  Alberta  Canada    34    4413146
    ## 133 2020-06-02  Alberta  Canada    13    4413146
    ## 134 2020-06-03  Alberta  Canada    19    4413146
    ## 135 2020-06-04  Alberta  Canada    15    4413146
    ## 136 2020-06-05  Alberta  Canada     7    4413146
    ## 137 2020-06-06  Alberta  Canada    40    4413146
    ## 138 2020-06-07  Alberta  Canada     0    4413146
    ## 139 2020-06-08  Alberta  Canada    64    4413146
    ## 140 2020-06-09  Alberta  Canada    27    4413146
    ## 141 2020-06-10  Alberta  Canada    47    4413146
    ## 142 2020-06-11  Alberta  Canada    40    4413146
    ## 143 2020-06-12  Alberta  Canada    30    4413146
    ## 144 2020-06-13  Alberta  Canada    37    4413146
    ## 145 2020-06-14  Alberta  Canada    50    4413146
    ## 146 2020-06-15  Alberta  Canada    20    4413146
    ## 147 2020-06-16  Alberta  Canada    29    4413146
    ## 148 2020-06-17  Alberta  Canada    48    4413146
    ## 149 2020-06-18  Alberta  Canada    49    4413146
    ## 150 2020-06-19  Alberta  Canada    46    4413146
    ## 151 2020-06-20  Alberta  Canada    48    4413146
    ## 152 2020-06-21  Alberta  Canada    31    4413146
    ## 153 2020-06-22  Alberta  Canada    32    4413146
    ## 154 2020-06-23  Alberta  Canada    45    4413146
    ## 155 2020-06-24  Alberta  Canada    44    4413146
    ## 156 2020-06-25  Alberta  Canada    26    4413146
    ## 157 2020-06-26  Alberta  Canada    37    4413146
    ## 158 2020-06-27  Alberta  Canada    69    4413146
    ## 159 2020-06-28  Alberta  Canada    39    4413146
    ## 160 2020-06-29  Alberta  Canada    71    4413146
    ## 161 2020-06-30  Alberta  Canada    41    4413146
    ## 162 2020-07-01  Alberta  Canada     0    4413146
    ## 163 2020-07-02  Alberta  Canada    94    4413146
    ## 164 2020-07-03  Alberta  Canada    57    4413146
    ## 165 2020-07-04  Alberta  Canada     0    4413146
    ## 166 2020-07-05  Alberta  Canada     0    4413146
    ## 167 2020-07-06  Alberta  Canada   130    4413146
    ## 168 2020-07-07  Alberta  Canada    47    4413146
    ## 169 2020-07-08  Alberta  Canada    46    4413146
    ## 170 2020-07-09  Alberta  Canada    37    4413146
    ## 171 2020-07-10  Alberta  Canada    77    4413146
    ## 172 2020-07-11  Alberta  Canada     0    4413146
    ## 173 2020-07-12  Alberta  Canada     0    4413146
    ## 174 2020-07-13  Alberta  Canada   230    4413146
    ## 175 2020-07-14  Alberta  Canada    86    4413146
    ## 176 2020-07-15  Alberta  Canada    82    4413146
    ## 177 2020-07-16  Alberta  Canada   120    4413146
    ## 178 2020-07-17  Alberta  Canada   105    4413146
    ## 179 2020-07-18  Alberta  Canada     0    4413146
    ## 180 2020-07-19  Alberta  Canada     0    4413146
    ## 181 2020-07-20  Alberta  Canada   368    4413146
    ## 182 2020-07-21  Alberta  Canada   141    4413146
    ## 183 2020-07-22  Alberta  Canada     0    4413146
    ## 184 2020-07-23  Alberta  Canada   247    4413146
    ## 185 2020-07-24  Alberta  Canada   111    4413146
    ## 186 2020-07-25  Alberta  Canada     0    4413146
    ## 187 2020-07-26  Alberta  Canada     0    4413146
    ## 188 2020-07-27  Alberta  Canada   304    4413146
    ## 189 2020-07-28  Alberta  Canada    80    4413146
    ## 190 2020-07-29  Alberta  Canada   133    4413146
    ## 191 2020-07-30  Alberta  Canada   113    4413146
    ## 192 2020-07-31  Alberta  Canada   127    4413146
    ## 193 2020-08-01  Alberta  Canada     0    4413146
    ## 194 2020-08-02  Alberta  Canada     0    4413146
    ## 195 2020-08-03  Alberta  Canada     0    4413146
    ## 196 2020-08-04  Alberta  Canada   303    4413146
    ## 197 2020-08-05  Alberta  Canada    94    4413146
    ## 198 2020-08-06  Alberta  Canada    56    4413146
    ## 199 2020-08-07  Alberta  Canada   134    4413146
    ## 200 2020-08-08  Alberta  Canada     0    4413146

``` r
Data[c(1:10, 15, 16, 19, 200), ]
```

    ##           date province country cases population
    ## 1   2020-01-22  Alberta  Canada     0    4413146
    ## 2   2020-01-23  Alberta  Canada     0    4413146
    ## 3   2020-01-24  Alberta  Canada     0    4413146
    ## 4   2020-01-25  Alberta  Canada     0    4413146
    ## 5   2020-01-26  Alberta  Canada     0    4413146
    ## 6   2020-01-27  Alberta  Canada     0    4413146
    ## 7   2020-01-28  Alberta  Canada     0    4413146
    ## 8   2020-01-29  Alberta  Canada     0    4413146
    ## 9   2020-01-30  Alberta  Canada     0    4413146
    ## 10  2020-01-31  Alberta  Canada     0    4413146
    ## 15  2020-02-05  Alberta  Canada     0    4413146
    ## 16  2020-02-06  Alberta  Canada     0    4413146
    ## 19  2020-02-09  Alberta  Canada     0    4413146
    ## 200 2020-08-08  Alberta  Canada     0    4413146

ในการเลือกคอลลัมภ์หรือตัวแปรนั้น
จะใช้การเรียกพิกัดแบบเดียวกันกับวิธีด้านบนก็ได้
แต่หากมีชื่อคอลลัมภ์อยู่แล้ว อาจจะสะดวกมากกว่าที่จะเลือกเป็นชื่อโดยใช้
`"_____"` แทนการเขียนตัวเลข

``` r
Data[1:10, c("date", "country", "cases")]
```

    ##          date country cases
    ## 1  2020-01-22  Canada     0
    ## 2  2020-01-23  Canada     0
    ## 3  2020-01-24  Canada     0
    ## 4  2020-01-25  Canada     0
    ## 5  2020-01-26  Canada     0
    ## 6  2020-01-27  Canada     0
    ## 7  2020-01-28  Canada     0
    ## 8  2020-01-29  Canada     0
    ## 9  2020-01-30  Canada     0
    ## 10 2020-01-31  Canada     0

### การ subset โดยใช้พิกัดและค่าของข้อมูลที่เฉพาะเจาะจง

บางครั้ง เราไม่เพียงต้องการแถวและคอลลัมภ์
แต่เรายังต้องการค่าที่เฉพาะเจาะลงไปใน dataset เช่น ต้องการให้ country
มีเพียง Canada เราสามารถเรียกพิกัดและข้อมูลนั้น ๆ ได้ โดยใช้การ subset
หรือจะเรียกว่าการหั่น (indicing) การกรอง (filtering) ก็ได้เหมือนกัน โดย

a.) การเขียน logic
`ชื่อไฟล์[ชื่อไฟล์$ชื่อคอลลัมภ์ที่ต้องการ == ค่าข้อมูลที่ต้องการ, ]`

b.) การใช้คำสั่ง `subset()` ของ `Base R`

``` r
# method a.
Covid <- Data[Data$country == "Canada", ]
head(Covid)
```

    ##         date province country cases population
    ## 1 2020-01-22  Alberta  Canada     0    4413146
    ## 2 2020-01-23  Alberta  Canada     0    4413146
    ## 3 2020-01-24  Alberta  Canada     0    4413146
    ## 4 2020-01-25  Alberta  Canada     0    4413146
    ## 5 2020-01-26  Alberta  Canada     0    4413146
    ## 6 2020-01-27  Alberta  Canada     0    4413146

``` r
tail(Covid)
```

    ##              date province country cases population
    ## 417086 2021-10-08     <NA>  Canada     0   37855702
    ## 417087 2021-10-09     <NA>  Canada     0   37855702
    ## 417088 2021-10-10     <NA>  Canada     0   37855702
    ## 417089 2021-10-11     <NA>  Canada     0   37855702
    ## 417090 2021-10-12     <NA>  Canada     0   37855702
    ## 417091 2021-10-13     <NA>  Canada     0   37855702

``` r
summary(Covid)
```

    ##       date                        province       country         
    ##  Min.   :2020-01-22   Alberta         : 1262   Length:20823      
    ##  1st Qu.:2020-06-27   British Columbia: 1262   Class :character  
    ##  Median :2020-12-02   Diamond Princess: 1262   Mode  :character  
    ##  Mean   :2020-12-02   Grand Princess  : 1262                     
    ##  3rd Qu.:2021-05-09   Manitoba        : 1262                     
    ##  Max.   :2021-10-13   (Other)         :13882                     
    ##                       NA's            :  631                     
    ##      cases            population      
    ##  Min.   :-1405971   Min.   :   38780  
    ##  1st Qu.:       0   1st Qu.:  158158  
    ##  Median :       0   Median :  977457  
    ##  Mean   :      82   Mean   : 4209062  
    ##  3rd Qu.:       5   3rd Qu.: 5110917  
    ##  Max.   :   23848   Max.   :37855702  
    ##                     NA's   :3786

``` r
# method b.
Covid_canada <- subset(Covid, country == "Canada")
head(Covid_canada)
```

    ##         date province country cases population
    ## 1 2020-01-22  Alberta  Canada     0    4413146
    ## 2 2020-01-23  Alberta  Canada     0    4413146
    ## 3 2020-01-24  Alberta  Canada     0    4413146
    ## 4 2020-01-25  Alberta  Canada     0    4413146
    ## 5 2020-01-26  Alberta  Canada     0    4413146
    ## 6 2020-01-27  Alberta  Canada     0    4413146

``` r
tail(Covid_canada)
```

    ##              date province country cases population
    ## 417086 2021-10-08     <NA>  Canada     0   37855702
    ## 417087 2021-10-09     <NA>  Canada     0   37855702
    ## 417088 2021-10-10     <NA>  Canada     0   37855702
    ## 417089 2021-10-11     <NA>  Canada     0   37855702
    ## 417090 2021-10-12     <NA>  Canada     0   37855702
    ## 417091 2021-10-13     <NA>  Canada     0   37855702

``` r
summary(Covid_canada)
```

    ##       date                        province       country         
    ##  Min.   :2020-01-22   Alberta         : 1262   Length:20823      
    ##  1st Qu.:2020-06-27   British Columbia: 1262   Class :character  
    ##  Median :2020-12-02   Diamond Princess: 1262   Mode  :character  
    ##  Mean   :2020-12-02   Grand Princess  : 1262                     
    ##  3rd Qu.:2021-05-09   Manitoba        : 1262                     
    ##  Max.   :2021-10-13   (Other)         :13882                     
    ##                       NA's            :  631                     
    ##      cases            population      
    ##  Min.   :-1405971   Min.   :   38780  
    ##  1st Qu.:       0   1st Qu.:  158158  
    ##  Median :       0   Median :  977457  
    ##  Mean   :      82   Mean   : 4209062  
    ##  3rd Qu.:       5   3rd Qu.: 5110917  
    ##  Max.   :   23848   Max.   :37855702  
    ##                     NA's   :3786

``` r
identical(Covid, Covid_canada)
```

    ## [1] TRUE

การเรียกข้อมูลที่มีขนาดใหญ่ออกมาดู เราอาจใช้คำสั่ง `head()` หรือ
`tail()`แทนการ `print()`หรือเรียกชื่อไฟล์ออกมาทั้งไฟล์ก็ได้นะคะ
หรืออาจใช้คำสั่ง `summary()`เพื่อดูสถิติเชิงพรรณาคร่าว ๆ

Noted คำสั่ง `identical()`
ทดสอบว่าวัตถุสองชนิดมีลักษณะเหมือนกันทุกประการไหม

นอกจากนี้แล้ว
เรายังสามารถเขียนเงื่อนไขการคัดกรองข้อมูลแบบรวบยอดได้โดยการนำสัญลักษณ์
`|` (or; หรือ) และ `&` (and; และ) ไปเขียนใน `function` อย่างไรก็ตาม
ความเข้าใจในการคัดกรองตรรกะเป็นเรื่องสำคัญ ซึ่งเราจะได้เรียนรู้ต่อไปค่าา

การใช้สัญลักษณ์ตรรกะ (และ/หรือ) ใน R

โดยทั่วไปแล้ว การที่เราคัดกรองข้อมูลจะมีความเข้าใจพื้นฐาน
โดยสามารถคิดตามจากภาพด้านล่างนี้

![cond](https://raw.githubusercontent.com/amaiesc/study_r/master/docs/logical_condition.png)

<img src="https://raw.githubusercontent.com/amaiesc/study_r/master/docs/logical_condition.png" alt="cond">

**สมมติ**ว่ามี data 2 ชุด เราต้องการเลือก ชุดข้อมูลบางชุดใน A และ
ชุดข้อมูลบางชุดใน B ถ้าเราต้องการทั้งหมด เราจะใช้ **หรือ** สัญลักษณ์ `|`
ในสมการ

แต่หากว่าเราต้องการ data ชุดข้อมูลบางชุดใน A
แต่ชุดข้อมูลนี้ต้องปรากฎพร้อมกันใน B ด้วย เราจะใช้ **และ**
สัญลักษณ์`&`ในสมการ

เช่น เราต้องการ country คือ Canada และ Thailand และทั้ง Canada และ
Thailand จะต้องมีผู้ติดเชื้อเกิน 20 ราย

``` r
Covid_th_can <- Data[Data$country == "Canada" | Data$country == "Thailand", ]
head(Covid_th_can)
```

    ##         date province country cases population
    ## 1 2020-01-22  Alberta  Canada     0    4413146
    ## 2 2020-01-23  Alberta  Canada     0    4413146
    ## 3 2020-01-24  Alberta  Canada     0    4413146
    ## 4 2020-01-25  Alberta  Canada     0    4413146
    ## 5 2020-01-26  Alberta  Canada     0    4413146
    ## 6 2020-01-27  Alberta  Canada     0    4413146

``` r
Covid_th_can_20 <- Covid_th_can[Covid_th_can$cases >= 20, ]
head(Covid_th_can_20)
```

    ##          date province country cases population
    ## 57 2020-03-18  Alberta  Canada    23    4413146
    ## 58 2020-03-19  Alberta  Canada    22    4413146
    ## 59 2020-03-20  Alberta  Canada    27    4413146
    ## 60 2020-03-21  Alberta  Canada    49    4413146
    ## 61 2020-03-22  Alberta  Canada    64    4413146
    ## 62 2020-03-23  Alberta  Canada    42    4413146

Note : หากผู้ใช้ชำนาญแล้วแนะนำให้เขียนอยู่ในบรรทัดเดียวกันเลยค่า

ทั้งนี้ หากเราอยากนับจำนวนวันที่เคสติดเชื้อมากกว่า 20 รายใน `Canada` และ
`Thailand` เราสามารถใช้คำสั่ง `table()` โดยระบุตัวแปรกลุ่มที่เราต้องการ

``` r
table(Covid_th_can_20$country)
```

    ## 
    ##   Canada Thailand 
    ##     3856      602

และถ้าหากเราต้องการค่าเฉลี่ยเคสที่ติดโควิดใน `Canada` และ `Thailand`
ในช่วงเวลาใน dataset เราสามารถหาได้โดยการใช้คำสั่งพื้นฐานของ R คือ
`mean()`

``` r
mean(Covid_th_can_20$cases)
```

    ## [1] 1095.29

``` r
sd(Covid_th_can_20$cases)
```

    ## [1] 2591.22

``` r
median(Covid_th_can_20$cases)
```

    ## [1] 250

``` r
sqrt(mean(Covid_th_can_20$cases))
```

    ## [1] 33.09516

**ข้อควรระวัง**คือ การหาค่าเฉลี่ยดังกล่าวคือการหาค่าเฉลี่ยรวมของ
`Canada` และ `Thailand` ค่า หากทบทวนการ subset ด้านบน เราสามารถแยก
`data` ของ `Canada` และ `Thailand` ออกจากกันได้ และหาค่าเฉลี่ย
แต่เดี๋ยวเราจะได้เริ่มใช้ `packages`
ที่ให้ข้อมูลเชิงซับซ้อนได้มากขึ้นในบทต่อไป :)

`Happy Coding —-)`
