class Category:
    def __init__(self, name):
        self.name = name
        self.ledger = []

    def deposit(self, amount, description=""):
        self.ledger.append({"amount": amount, "description": description})

    def withdraw(self, amount, description=""):
        if self.check_funds(amount):
            self.ledger.append({"amount": -amount, "description": description})
            return True
        return False

    def get_balance(self):
        return sum(item["amount"] for item in self.ledger)

    def transfer(self, amount, category):
        if self.check_funds(amount):
            self.withdraw(amount, f"Transfer to {category.name}")
            category.deposit(amount, f"Transfer from {self.name}")
            return True
        return False

    def check_funds(self, amount):
        return amount <= self.get_balance()

    def __str__(self):
        title = self.name.center(30, "*") + "\n"
        items = ""
        for entry in self.ledger:
            description = entry["description"][:23]
            amount = "{:.2f}".format(entry["amount"])[:7]
            items += description.ljust(23) + amount.rjust(7) + "\n"
        output = title + items + "Total: " + "{:.2f}".format(self.get_balance())
        return output


def create_spend_chart(categories):
    spent_amounts = []
    for category in categories:
        spent = sum(-item["amount"] for item in category.ledger if item["amount"] < 0)
        spent_amounts.append(spent)

    total_spent = sum(spent_amounts)
    percentages = [(spent / total_spent) * 100 for spent in spent_amounts]

    chart = "Percentage spent by category\n"

    for i in range(100, -1, -10):
        chart += str(i).rjust(3) + "| "
        for percentage in percentages:
            if percentage >= i:
                chart += "o  "
            else:
                chart += "   "
        chart += "\n"

    chart += "    " + "-" * (len(categories) * 3 + 1) + "\n"

    max_name_length = max(len(category.name) for category in categories)
    for i in range(max_name_length):
        chart += "     "
        for category in categories:
            if i < len(category.name):
                chart += category.name[i] + "  "
            else:
                chart += "   "
        if i != max_name_length - 1:
            chart += "\n"

    return chart
