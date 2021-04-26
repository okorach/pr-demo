class Fruit:

    def __init__(self, peelable=None, family=None):
        self.peelable = peelable
        self.family = family
        self.color = None
        self.password = None

    def peel(self):
        if self.peelable:
            return True
        raise Exception("Fruit is not pealable")

    def lock(self):
        self.password = "donttouch"
