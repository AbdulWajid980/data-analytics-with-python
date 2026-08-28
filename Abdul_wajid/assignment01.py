#Task 01

print("Name:\t Abdul wajid\nFather's Name:\t Abdul Haleem \nDate of Birth: 30-12-1991")

#Task 02
name="Abdul_wajid"
father_name= "Abdul_Haleem"
date_of_birth= "25-2-1990"
age="35"
City="Quetta"
Qualification="MS_in_electrical_engg"
job="lab_engr"
province="Balochistan" 
print("\n---Small bio---")
print("Name:",name)
print("Father's NAME:",father_name)
print("DOB:",date_of_birth)
print("AGE:",age)
print("CITY:",City)
print("Last Qualification:",Qualification)
print("JOB:",job)
print("PROVINCE:",province)

#Task 03
a=100
b=20
print("\n---Operators---")
print ("a+b=",(a+b))
print("a-b=",(a-b))
print("a*b=",(a*b))
print("a/b=",(a/b))
print("a//b=",(a//b))
print("a % b=",(a%b))
print("a**b=",(a**b))
print("a>b=",(a>b))
print("a<b=",(a<b))
print("a>=b=",(a>=b))
print("a<=b=",(a<=b))

print("\n---Percentage Calculation---")
#Task 04
English_marks= 75
Mathematics_marks=80
Islamiat_marks= 90
Total_marks=300
Total_Obtained_marks=English_marks+Mathematics_marks+Islamiat_marks
Percentage=(Total_Obtained_marks / Total_marks)*100
print("English Marks:", (English_marks))
print("Mathematics Marks:",(Mathematics_marks))
print("Islamiat Marks:",(Islamiat_marks))
print("Total Obtained Marks:",(Total_Obtained_marks))
print("Total Marks:", (Total_marks))
print("Percentage:",(Percentage))

#task05
print("\n---Swapinhg of numbers---")
a=10
b=20
print("Before Swaping:")
print("a=",(a) , ("b="),(b))
a,b=b,a
print("After Swaping:")
print("a=",(a) , ("b="),(b))


#task 06
print("\n---Calculation of area and circumference---")
r = 7
pi = 3.14159
print("Area:", pi * r * r)
print("Circumference:", 2 * pi * r)


#Task 07
print("\n---Discount percentage---")
p = 1000
d = 20
print(f"Final Price: Rs{p - (p*d/100)}")
print(f"Discount: Rs{p*d/100}")