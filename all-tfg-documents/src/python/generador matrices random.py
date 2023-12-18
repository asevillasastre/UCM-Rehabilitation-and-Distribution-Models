"""
generar ejemplos aleatorios de estudio para el tfg
"""

import random

def genera(dimension):
    result = "  "
    for i in range(dimension):
        result += str(i) + " "
    for j in range(dimension):
        result += "\n" + str(j) + " "
        for k in range(dimension):
            r = random.random()
            e = "0"
            if r > 0.85:
                e = "1" 
            if k<=j :
                e = "0"
            result += e + " "
    return result

print(genera(10));
