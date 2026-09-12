def calculate_total(expenses):
    total = 0

    for expense in expenses:
        total += expense["amount"]

    return total


def calculate_average(expenses):
    total = calculate_total(expenses)

    return total / len(expenses)


def find_highest(expenses):
    highest = expenses[0]

    for expense in expenses:
        if expense["amount"] > highest["amount"]:
            highest = expense

    return highest


def find_lowest(expenses):
    lowest = expenses[0]

    for expense in expenses:
        if expense["amount"] < lowest["amount"]:
            lowest = expense

    return lowest


def category_summary(expenses):

    categories = {}

    for expense in expenses:

        category = expense["category"]
        amount = expense["amount"]

        if category not in categories:
            categories[category] = 0

        categories[category] += amount

    return categories


expenses = [
    {
        "date": "2026-01-05",
        "category": "Food",
        "amount": 5000
    },
    {
        "date": "2026-01-10",
        "category": "Travel",
        "amount": 3000
    },
    {
        "date": "2026-01-15",
        "category": "Rent",
        "amount": 15000
    },
    {
        "date": "2026-01-20",
        "category": "Food",
        "amount": 2000
    }
]


total = calculate_total(expenses)
average = calculate_average(expenses)
highest = find_highest(expenses)
lowest = find_lowest(expenses)
categories = category_summary(expenses)


print("Total expenses:", total)
print("Average expense:", average)
print("Highest expense:", highest)
print("Lowest expense:", lowest)

print("\nCategory Summary:")

for category, amount in categories.items():
    print(category, ":", amount)