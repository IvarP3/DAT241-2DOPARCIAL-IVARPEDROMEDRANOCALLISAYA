import numpy as np
from scipy.sparse import random as dispersa_aleatoria
from scipy.sparse import csr_matrix, vstack
from multiprocessing import Pool

def multiplicacion_dispersa_paralela(bloque):
    return A[bloque[0]:bloque[1]] @ B

forma = (2000, 2000)

A = dispersa_aleatoria(forma[0], forma[1], density=0.02, format='csr')
B = dispersa_aleatoria(forma[0], forma[1], density=0.02, format='csr')

# Dividiendo las filas en bloques para procesamiento paralelo
tamanio_bloque = 100
num_bloques = forma[0] // tamanio_bloque

# Generar una lista de tuplas por filas, donde los bloques representan filas
bloques = []
for i in range(num_bloques):
    fila_inicio = i * tamanio_bloque
    fila_fin = (i + 1) * tamanio_bloque
    bloques.append((fila_inicio, fila_fin))

# Creando un grupo de procesos para la multiplicación paralela
with Pool(processes=4) as pool:  # 4 procesos en paralelo
    bloques_resultado = pool.map(multiplicacion_dispersa_paralela, bloques)

# Combinar los bloques de resultado en una matriz dispersa final
resultado = vstack(bloques_resultado)

print("Matriz resultante de la multiplicación de matrices dispersas:")
print(resultado)
