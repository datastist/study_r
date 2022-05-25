# Family-Wise Error Rate


<img src="https://github.com/amaiesc/study_r/blob/master/pics/cat_meditate.png?raw=true" alt="cat" style="width:150;height:150px;">  
: อะไรอีกเน้ออ


**Family-Wise Error** คือการที่เราทดสอบทางสถิติหลาย ๆ คู่ แต่ดันใช้ค่า **แอลฟ่า (alpha;** **α) = 0.05 ในทุกคู่

> แล้วมันผิดอย่างไรอ่ะ

เราต้องย้อนกลับไปในช่วงที่นักคณิตศาตร์พยายามหาจุดตัดที่จะปฎิเสธหรือยอมรับสมมติฐานว่าง (null hypothesis)

<img src="https://github.com/amaiesc/study_r/blob/master/pics/P-2.png?raw=true" alt="cat" style="width:250;height:250px;">

> **นักคณิตศาสตร์ A :** พวกเรา ฉันว่าให้การ error มันเกิดขึ้น 5 ใน 100
> ครั้งมันก็โอเคนะ
>
> **นักคณิตศาสตร์ B :** หมายความว่า ถ้ามันเกิดขึ้นน้อยกว่า 5 ครั้ง ใน
> 100 ครั้ง ให้พวกเราปฎิเสธสมมติฐานว่างสินะ
>
> **นักคณิตศาสตร์ C** : ใช่ ๆ ฉันว่าเราต้องมีมาตรฐานนี้แหละ จะได้ชัดเจน
> 

ทุกคนเลยพร้อมใจให้ค่า **แอลฟ่า (alpha;** **α) ที่ยอมรับได้คือ 0.05** นักวิเคราะห์สถิติ หรือ นักวิจัยอาจให้แอลฟ่าต่ำกว่า 0.05 ได้
ในกรณีที่วิเคราะห์ออกมาแล้วโอกาสที่จะเกิด error ต่ำกว่า (เช่น 0.01, 0.001) ถือว่าเป็นจุดตัดสินใจที่จะทำอย่างไรกับสมมติฐานว่างนั่นเอง แต่ก็มี parameter ที่สามารถแสดงถึงช่วงกว้างของ (standard) error ของข้อมูลคือ Confident Interval (see: CI)


### ทีนี้แล้วการตกลงนี้มันเกี่ยวอะไรกับ Family-Wise Error Rate?

คือการใช้สถิติโดยเฉพาะกลุ่มการเปรียบเทียบค่าเฉลี่ย เช่น t-test เป็นการเปรียบเทียบกลุ่มแบบจับคู่ เวลาที่เราบอกว่า **α ที่เรายอมรับได้คือ 0.05** คือสำหรับ 1 คู่ ทีนี้พอมีการทดสอบหลายคู่ จึงมีการต้องปรับค่า α
นี้ เพราะว่า

.

.

.

แมวชวนคิดเล่น ๆ ดู

> ถ้าเรายอมให้โอกาส error เกิดขึ้น 0.05 ใน 1 คู่ แล้วถ้าเราทดสอบ 4 คู่
> ค่า error นี้จะเท่ากับเท่าไหร่?

<img src="https://github.com/amaiesc/study_r/blob/master/pics/cat_meditate.png?raw=true" alt="cat" style="width:150;height:150px;">  
: ก็ 0.05 น่ะสิ

*ผิด!!!!!*

มันแปลว่าเรายอมให้มันเกิด error มากกว่า 0.05 ไหน ๆ ลูกแมวก็เรียนเขียน R code แล้ว เราใช้ R เป็นเครื่องคิดสมการเลยแล้วกัน

     **FWE ≤ 1 – (1 – α)^c**

``` r
FWE_4_pairs <- 1 - (1 - .05)^4
FWE_4_pairs
```


    ## [1] 0.1854938

``` r
FWE_10_pairs <- 1 - (1 - .05)^10
FWE_10_pairs
```


    ## [1] 0.4012631


ค่าของการทดสอบ ที่ 4 คู่ และ 10 คู่ เฟ้อมากขึ้นสุด ๆ แปลอีกอย่างว่า มันจะเกิด false positive มากขึ้นนี่เอง เพราะ FWER = Probability (false positive >= 1) ดังนั้นเราจึงควรปรับค่าแอลฟ่าในการทดสอบหลาย ๆ คู่ หรือเรียกว่าเป็น `family test`

**วิธีที่นิยมใช้ในการปรับแอลฟ่า**

-   **วิธีแบบ Tukey** : คุณ Tukey (1953) เป็นนักคณิตศาสตร์ที่มองเห็นจุด
    error นี้ แต่วิธีการของเขาสามารถใช้ได้เพียงกับการเปรียบเทียบรายคู่
    (ทุกคู่) (see; one-way ANOVA analysis)
-   **วิธีแบบ Bonferroni** : อันนี้เข้าใจง่าย ก็คือการนำ
    α/จำนวนคู่ที่ทดสอบ
-   **วิธีแบบ Šidák :** อาจจะงงหน่อย แมวก็งง แต่จะใช้สูตร α = 1 - (1 -
    α)^1/m
    ***Note*** มีวิธีอื่น ๆ อีกหลายชนิด ในโปรแกรม spss จะมีให้กดออกมา
    แต่ใน R เราอาจจะต้องเลือกที่จะทดสอบ


### ปัญหาที่เกิดขึ้นถ้าไม่ปรับ **alpha; α**

ทบทวนว่า การที่เราไม่ปรับ **α จะทำให้เกิด FWE ขึ้น** ดังนั้นจะทำให้เกิดการตัดสินใจแบบ false positive หรือ เกิด Type I error มากขึ้นนี่เอง ดังนั้น ถ้าลูกแมวจะทดสอบพร้อมกันหลายๆ คู่ ลูกแมวจงเลือกใช้การปรับ α เพื่อลดอคติที่จะเกิดขึ้นในงานของเราค่ะ

### P-hacking or P-harking

<img src="https://github.com/amaiesc/study_r/blob/master/pics/P.png?raw=true" alt="cat" style="width:150;height:150px;">


ถ้าจะอธิบายให้เกี่ยวข้องกับบทความนี้ p-hacking คือการที่ผู้วิจัยรายงานผลการเปรียบเทียบรายคู่แบบ family โดยไม่ปรับ α *ทั้งตั้งใจและไม่ตั้งใจ* ทำให้โอกาสการเกิด false positive มากขึ้น ผลก็คือทำให้งานวิจัยนั้น ๆ พบผลที่จริงๆ ไม่มีผล (see: Type I & Type II error) ทำให้ผู้อ่านและสังคมนักวิจัยงงกับผลที่ได้อ่านมา (ทุกวันนี้แมวก็ยังงงอยู่~)


#### ดังนั้น ลูกแมวปรับ **α กันเถิด เพราะการวิเคราะห์ผลและรายงานผล เราควรจะทำอยู่บน practice ที่ดีน้า**