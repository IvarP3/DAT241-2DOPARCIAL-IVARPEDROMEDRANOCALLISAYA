from scipy.sparse import random as sparse_random

A = sparse_random(2000, 2000, density=0.02, format='csr')
B = sparse_random(2000, 2000, density=0.02, format='csr')

# Multiplicar las matrices dispersas utilizando el operador @
C = A @ B

# Imprimir la matriz resultante
print("Matriz resultante de la multiplicación de matrices dispersas:")
print(C)
