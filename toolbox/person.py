class Person:

    def __init__(self, first=None, last=None):
        self.firstname = first
        self.lastname = last
        self.age = 0
        self.eye_color = None
        self.nationality = None

    def fullname(self):
        return "%s %s" % (self.firstname, self.lastname)

    def happy_birthday(self):
        return "Happy birthday " + self.firstname
        self.age += 1

    def is_major(self):
        return self.age > 18
