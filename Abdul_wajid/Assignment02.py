#1 A company decided to give bonus of 5% to employee if his/her year of service is more than 5 years. Ask user for their salary and year of service and print the net bonus amount.
salary=float(input("Enter Your salary:"))
years=float(input("Enter Your year of service:"))
if years > 5 :
    Bonus = salary * 5/100
    print("Your net bonus is:", Bonus)
else:
     print("No bonus:")


#2 Write a program to check whether a person is eligible for voting or not. (accept age from user) if age is greater than 17 eligible otherwise not eligible

age=float (input("Enter Your age"))
if age > 17 :
     print("Your are eligible for voting:")
else:
     print("Your aare not elogible for voting:")


#3 Write a program to check whether a number entered by user is even or odd.
Num= int(input("Enter A number."))
if Num %2==0:
     print(f"{Num} Number is even")
else:
     print(f"{Num} Number is Odd")


# 4 Write a program to check whether a number is divisible by 7 or not. Show Answer
Num= int(input("Enter A number."))
if Num % 7==0:
     print(f"{Num} Number is divisible by 7")
else:
     print(f"{Num} Number is not divisible by 7")



# 5 Write a program to display "Hello" if a number entered by user is a multiple of five , otherwise print "Bye".

Numum = int(input("Enter a number: "))
if Num % 5 == 0:
    print("Hello")
else:
    print("Bye")


# 6 Write a program to display the last digit of a number.

num = int(input("Enter a number: "))
last_digit = num % 10
print(f"The last digit of {num} is {last_digit}.")


# 7 Take values of length and breadth of a rectangle from user and print if it is square or rectangle.

length = float(input("Enter the length: "))
breadth = float(input("Enter the breadth: "))
if length == breadth:
    print("It is a Square.")
else:
    print("It is a Rectangle.")



# 8 Take two int values from user and print greatest among them.

num1 = int(input("Enter the first number: "))
num2 = int(input("Enter the second number: "))
if num1 > num2:
    print(f"{num1} is the greatest.")
elif num2 > num1:
    print(f"{num2} is the greatest.")
else:
    print("Both numbers are equal.")


# 9 A shop will give discount of 10% if the cost of purchased quantity is more than 1000. Ask user for quantity Suppose, one unit will cost 100. Judge and print total cost for user.

quantity = int(input("Enter the quantity of items purchased: "))
unit_cost = 100
total_cost = quantity * unit_cost
if total_cost > 1000:
    discount = total_cost * 0.10
    total_cost = total_cost - discount
    print(f"Discount applied: {discount}")
    print(f"Total cost after 10% discount: {total_cost}")
else:
    print(f"No discount applied.")
    print(f"Total cost: {total_cost}")



# 10 

marks = float(input("Enter the marks: "))
if marks < 25:
    grade = "F"
elif marks >= 25 and marks < 45:
    grade = "E"
elif marks >= 45 and marks < 50:
    grade = "D"
elif marks >= 50 and marks < 60:
    grade = "C"
elif marks >= 60 and marks < 80:
    grade = "B"
elif marks >= 80:
    grade = "A"
else:
    grade = "Invalid"
print(f"Your grade is: {grade}")



# 11

classes_held = int(input("Enter the number of classes held: "))
classes_attended = int(input("Enter the number of classes attended: "))


attendance_percentage = (classes_attended / classes_held) * 100

print(f"Attendance Percentage: {attendance_percentage:.2f}%")

if attendance_percentage >= 75:
    print("The student is allowed to sit in the exam.")
else:
    print("The student is NOT allowed to sit in the exam.")



# 12 

classes_held = int(input("Enter the number of classes held: "))
classes_attended = int(input("Enter the number of classes attended: "))
medical_cause = input("Do you have a medical cause? (Y/N): ").strip().upper()

attendance_percentage = (classes_attended / classes_held) * 100

# Print the attendance percentage
print(f"Attendance Percentage: {attendance_percentage:.2f}%")

if attendance_percentage >= 75:
    print("The student is allowed to sit in the exam.")
elif medical_cause == 'Y':
    print("The student is allowed to sit in the exam due to medical cause.")
else:
    print("The student is NOT allowed to sit in the exam.")


# 13 

year = int(input("Enter a year: "))

if year % 4 == 0:
    if year % 100 == 0:
        if year % 400 == 0:
            print(f"{year} is a Leap Year.")
        else:
            print(f"{year} is NOT a Leap Year.")
    else:
        print(f"{year} is a Leap Year.")
else:
    print(f"{year} is NOT a Leap Year.")



# 14 

age = int(input("Enter your age: "))
gender = input("Enter your gender (M/F): ").strip().upper()
marital_status = input("Enter your marital status (Y/N): ").strip().upper()

if gender == 'F':
    print("Place of Service: Urban areas only.")
elif gender == 'M':
    if 20 <= age <= 40:
        print("Place of Service: Anywhere.")
    elif 40 < age <= 60:
        print("Place of Service: Urban areas only.")
    else:
        print("ERROR")
else:
    print("ERROR")



# 15 


units = int(input("Enter the number of units consumed: "))

if units <= 100:
    bill = 0
elif units <= 300:
    bill = (units - 100) * 5
else:
    bill = (200 * 5) + ((units - 300) * 10)

print(f"Total Electricity Bill: Rs. {bill}")


# 16 

age1 = int(input("Enter the age of person 1: "))
age2 = int(input("Enter the age of person 2: "))
age3 = int(input("Enter the age of person 3: "))

if age1 >= age2 and age1 >= age3:
    oldest = age1
elif age2 >= age1 and age2 >= age3:
    oldest = age2
else:
    oldest = age3

if age1 <= age2 and age1 <= age3:
    youngest = age1
elif age2 <= age1 and age2 <= age3:
    youngest = age2
else:
    youngest = age3

print(f"The oldest person is {oldest} years old.")
print(f"The youngest person is {youngest} years old.")