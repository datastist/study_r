# Import dataset

ปกติแล้ว ชุดข้อมูลที่ได้มา เราจะเก็บไว้ใน excel (พื้นฐาน) แต่การใช้ R จะใช้ไฟล์ที่มีนาสกุลว่า .csv ซะส่วนใหญ่ ดังนั้น เราจะมา import .csv ลง environment ของเรากันค่ะ

    #ชื่อไฟล์ที่จะใช้ใน r <- read.csv("ชื่อไฟล์ใน folder.csv")