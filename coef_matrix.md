## Importing data & Descriptive Statistics

เอกสารนี้ เราจะเรียนรู้ในเรื่องของการเขียน Coefficient Matrix
และการคำนวณ Contrast นะคะ :)

โดยในขั้นแรก เราสามารถเรียกไฟล์ที่พร้อมใช้ออกมาในการคำนวณ contrast
ซึ่งในเอกสารนี้เราจะใช้ไฟล์ของ Eysenck (1974) ในการทดลอง Level of
Processing

หากเรามี **Working Directory** แล้วเราสามารถเรียกไฟล์
`.csv`โดยการพิมพ์ชื่อไฟล์ อย่าลืมใส่เครื่องหมาย quotation `"ชื่อไฟล์"`

    dat <- read.csv("Assignment04", header = TRUE, sep = ",", stringsAsFactors = TRUE)

เมื่อเรียกไฟล์ออกมาแล้ว เราสามารถเรียกคำสั่งจาก package **`psych`**
เพื่ออ่านค่าสถิติเชิงพรรณาของแต่ละกลุ่มโดยใช้คำสั่ง **`describeBy()`**
จากนั้นใส่ตัวแปรที่ต้องการ โดยใช้
`describeBy(ตัวแปรที่ต้องการค่าสถิติ ~ ตัวแปรจัดกลุ่ม, data = ชื่อไฟล์)`

    library(psych)
    describeBy(value ~ condition, data = dat)

    ## 
    ##  Descriptive statistics by group 
    ## condition: Adjective
    ##       vars  n mean   sd median trimmed  mad min max range  skew kurtosis   se
    ## value    1 10   11 2.49     11   11.25 2.97   6  14     8 -0.66    -0.84 0.79
    ## ------------------------------------------------------------ 
    ## condition: Counting
    ##       vars  n mean   sd median trimmed  mad min max range skew kurtosis   se
    ## value    1 10    7 1.83      7       7 1.48   4  10     6    0    -1.22 0.58
    ## ------------------------------------------------------------ 
    ## condition: Imagery
    ##       vars  n mean  sd median trimmed  mad min max range skew kurtosis   se
    ## value    1 10 13.4 4.5   11.5   12.75 1.48   9  23    14 0.99    -0.53 1.42
    ## ------------------------------------------------------------ 
    ## condition: Intention
    ##       vars  n mean   sd median trimmed  mad min max range skew kurtosis   se
    ## value    1 10   12 3.74     11      12 2.97   5  19    14 0.05    -0.47 1.18
    ## ------------------------------------------------------------ 
    ## condition: Rhyming
    ##       vars  n mean   sd median trimmed  mad min max range skew kurtosis   se
    ## value    1 10  6.9 2.13    6.5    6.88 0.74   3  11     8 0.18     -0.4 0.67

จากนั้น สร้าง `aov` object สำหรับการวิเคราะห์ครั้งนี้ ด้วยคำสั่ง `aov()`
และ `summary()` ในการแสดงผล

    level.aov <- aov(value ~ condition, data = dat)
    summary(level.aov)

    ##             Df Sum Sq Mean Sq F value   Pr(>F)    
    ## condition    4  351.5   87.88   9.085 1.82e-05 ***
    ## Residuals   45  435.3    9.67                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## Contrasts

ในการคำนวณ Contrast (หรือ จะใช้กับ Post-hoc ก็ได้) เราจะใช้คำสั่งจาก
package `emmeans`

    library(emmeans)

หลังจากเรียก Library `emmeans` ออกมาแล้ว ในขั้นแรก
เราจะระบุจำนวนคู่ที่เราจะเปรียบเทียบโดยแต่ละคู่จะถูกนำไปเขียนใน
Coefficient Matrix

สมมติว่าเราจะเปรียบเทียบ 2 คู่ คือ

1.  Rhyming เปรีบเทียบกับ Adjective
2.  Adjective, Counting, Imagery เปรียบเทียบกับ Rhyming

เราสามารถเขียนสูตรอย่างง่ายก่อนที่จะนำค่า Coefficient ไปใส่ในตารางโดย

-   **Rhyming - Adjective**

    เราสามารถใส่เลข Coefficient สำหรับเงื่อนไข Rhyming เป็นเลข 1
    และหลังเครื่องหมายลบ (-) คือเงื่อนไข Adjective เป็นเลข -1

-   **(Adjective + Counting + Imagery)/3 - Rhyming**

    เนื่องจากเงื่อนไขด้านหน้ามีทั้งหมด 3 เงื่อนไข
    เราสามารถเขียนได้โดยนำเงื่อนไขหารด้วย 3 จะได้ตัวเลข 1/3, 1/3, 1/3
    และเงื่อนไขหลังเครื่องหมายลบ (-) คือเงื่อนไข Rhyming เป็นเลข -1

ในตาราง Coefficient ให้ใส่ค่า `0` ลงไปในเงื่อนไขที่ไม่ได้นำมาเปรียบเทียบ

ก่อนนำตัวเลข Coefficient ไปใส่ในตาราง
เราสามารถเรียกดูลำดับของเงื่อนไขได้โดยใช้คำสั่ง

    levels(dat$condition) #จาก package psych

    ## [1] "Adjective" "Counting"  "Imagery"   "Intention" "Rhyming"

\*\*ลำดับนี้มีความสำคัญมากกับการสร้างตาราง Coefficient

จากนั้นนำเลขที่คำนวณไว้มาใส่ใน `data.frame()`

    contrast_m <- data.frame("Rhym.vs.Adj"                   = c(-1,    0,   0, 0,  1), 
                             "Adj.Coun.Imag.vs.Rhyming"      = c(1/3, 1/3, 1/3, 0, -1), 
                             row.names = levels(dat$condition))  
    contrast_m

    ##           Rhym.vs.Adj Adj.Coun.Imag.vs.Rhyming
    ## Adjective          -1                0.3333333
    ## Counting            0                0.3333333
    ## Imagery             0                0.3333333
    ## Intention           0                0.0000000
    ## Rhyming             1               -1.0000000

สังเกตว่าคำสั่ง **`row.names = levels(dat$condition)`**
จะเป็นการช่วยระบุชื่อเงื่อนไขในบรรทัดด้านหน้า
หากไม่มีคำสั่งนี้ก็ยังสามารถใช้ Coefficient Matrix นี้ได้

ต่อมาเราจะสร้าง `emmGrid` object โดยการใช้คำสั่ง `emmeans`
และใส่ไว้ในชื่อ `level.emm`

    level.emm <- emmeans(level.aov, ~ condition) #(aov object ที่เราสร้างไว้, ~ เงื่อนไข)
    summary(level.emm)

    ##  condition emmean    SE df lower.CL upper.CL
    ##  Adjective   11.0 0.984 45     9.02    12.98
    ##  Counting     7.0 0.984 45     5.02     8.98
    ##  Imagery     13.4 0.984 45    11.42    15.38
    ##  Intention   12.0 0.984 45    10.02    13.98
    ##  Rhyming      6.9 0.984 45     4.92     8.88
    ## 
    ## Confidence level used: 0.95

จากนั้นเราสามารถคำนวณ Contrasts ได้โดยการใช้คำสั่ง `contrast()` จาก
package `emmeans`

โดยคำสั่ง `contrast()` จะประกอบไปด้วย

`object` ในตัวอย่างนี้เราใส่ `level.emm` ที่เป็น object จาก `emmeans`

`method` = ตาราง coefficient matrix ที่เราเขียนขึ้นมา,

`adjust =`วิธีการปรับค่า *p*-value จะมีหลายวิธีด้วยกัน
(`"tukey", "scheffe", "sidak", "mvt", "none"`) ในตัวอย่างเราจะเลือกใช้
`bonferroni`

`infer = (TRUE, FALSE)` คือเรียกคำสั่งสถิติอื่น ๆ เช่น ค่า *t* และ *Cls*

    contrast_results <- contrast(level.emm, method = contrast_m, adjust = "bonferroni", infer = TRUE)

    contrast_results

    ##  contrast                 estimate   SE df lower.CL upper.CL t.ratio p.value
    ##  Rhym.vs.Adj                 -4.10 1.39 45   -7.325   -0.875  -2.948  0.0101
    ##  Adj.Coun.Imag.vs.Rhyming     3.57 1.14 45    0.933    6.200   3.141  0.0060
    ## 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: bonferroni method for 2 estimates 
    ## P value adjustment: bonferroni method for 2 tests

ตารางผลที่แสดงโดยใช้การปรับค่า *p*-value ด้วยวิธี Bonferroni
ซึ่งผลของการคำนวณ contrasts นี้ แสดงให้เห็นว่า
คู่ที่เรานำมาเปรียบเทียบกันทั้งสองคู่มีความแตกต่างกันอย่างมีนัยสำคัญ

*Note*: ลำดับของ Coefficient Matrix มีความสำคัญอย่างมากในการสร้าง Matrix
ถ้าเราพลาดใส่ผิดลำดับไป แต่จำนวนแถวและคอลัมน์ถูกต้อง R อาจจะรันค่า
contrast ออกมาให้เราเห็นได้
แต่ผลที่ออกมาจะไม่ตรงกับสิ่งที่เราอยากเปรียบเทียบนะคะ

`Happy Coding ค่ะ,`Sirinapa
