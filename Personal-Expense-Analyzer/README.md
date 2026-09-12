# Finance Calculator

income = 1000
expense = 300
remaining = income - expense
print(remaining)


#SI and CI Calculator:

Enter_Principal = int(input("Enter the principal: "))
Enter_annual_interest = float(input("Enter the annual interest rate: "))
Enter_Year = int(input("Enter Year: "))

simple_interest = Enter_Principal*Enter_annual_interest*Enter_Year/100
Total_amount = simple_interest + Enter_Principal
print(simple_interest)
print(Total_amount)

principal = int(input("Enter Principal: "))
rate = float(input("Enter the annual interest rate: "))
time = int(input("Enter the time: "))

compound_amount = principal * (1 + rate / 100) ** time
compound_interest = compound_amount - principal

print(compound_interest)
print(compound_amount)

#Expense calculator

expense= int(input("Enter Expense: "))
expense2 = int(input("Enter Expense2: "))
expense3 = int(input("Enter Expense3: "))

Total = expense + expense2 + expense3
print(input(f'your total expenses is {Total}'))

