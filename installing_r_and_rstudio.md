# Installing R

สำหรับคนที่ไม่มีพื้นฐานการเขียน code มาก่อน อันดับแรกเราจะต้องลงโปรแกรม R ในเครื่องของเราก่อน (เห็นไหม บอกแล้วเบสิคมาก)

     [http://cran.r-project.org/](http://cran.r-project.org/)
     แล้วไปที่ Mirror เพื่อเลือก CRAN จากประเทศไทย
     
     #Thailand
     #http://mirrors.psu.ac.th/pub/cran/	    Prince of Songkla University, Hatyai

จากนั้นก็ทำตามขั้นตอนการลงโปรแกรม

# installing R-studio

R studio คือ Environment สำหรับ R program โดยเฉพาะ ซึ่งจะเน้นการเขียน R language แต่ (2022) เราสามารถเขียนภาษาอื่นเช่น python หรือ css ใน R ได้้ด้วยค่า

    #[http://www.rstudio.org/download/desktop](http://www.rstudio.org/download/desktop) #สำหรับ Desktop version

จากนั้นเราก็ทำตามขั้นตอนการลงโปรแกรมอีกครั้ง

# การใช้ R studio

เราสามารถใช้ R studio โดยไปที่ Application ชื่อ Rstudio เมื่อเปิดโปรแกรมออกมาแล้วจะมีหน้าต่างหลายส่วน

![r]()

ซึ่งแต่ละส่วนจะมีความแตกต่างกันในการใช้งาน


    # ส่วน Script
    Script คือการเขียน code โดยการเขียนเป็นไฟล์ที่สามารถเก็บเอาไว้ใช้ภายหลังได้ นามสกุลของไฟล์จะเป็น `.r` 
    ในครั้งแรกที่เราเปิด Rstudio ขึ้นมา script อาจจะยังไม่ขึ้น เราสามารถเรียก Script ขึ้นมาได้โดยไปที่
    ## file --> New file --> R script
    
    #ส่วนของ console
    console คือหน้าต่างที่บอก output ที่เราเขียนจาก script เมื่อเรากด Run ที่ R script output จะออกมาค่ะ
    *Note* console ก็สามารถใช้เขียน commands สั้นๆ เพื่อให้ผลออกมาทันทีได้ด้วย
    
    #ส่วน Environment
    ในส่วน Emvironment โดยพื้นฐานเราจะใช้เพียง Global Environment ทีี่จะแสดงวัตถุที่เราสร้างใน R
    
    #ส่วน Tools (ขึ้นต้นด้วย file) จะเป็นส่วนที่เราเชื่อมต่อกับ folder ในคอมพิวเตอร์ของเรา
    ถ้าเรา plot graph ในส่วนนี้อัติโนมัติ
    และเราสามารถเรียกคำสั่ง help ได้จากส่วนนี้เหมือนกัน
    

เดี๋ยวเรามาต่อกันด้วยวิธีการสร้าง Working Directory ค่า~


--------
Happy Coding
sirinapa


    
