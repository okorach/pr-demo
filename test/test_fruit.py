
from fruits.fruit import Fruit

def test_peelable():
    orange = Fruit(family="Agrums", peelable=True)
    assert orange.peel() 

def test_not_pealable():
    mystery_fruit = Fruit(family="Martian fruits", peelable=False)
    try:
        mystery_fruit.peel()
    except Exception as e:
        assert True
    else:
        assert False