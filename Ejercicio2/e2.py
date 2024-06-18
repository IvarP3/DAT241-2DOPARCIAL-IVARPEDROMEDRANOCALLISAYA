from google.colab import drive
import os
import scipy.sparse as sp
import cv2
import numpy as np
from matplotlib import pyplot as plt

drive.mount("/content/drive")
os.chdir("/content/drive/MyDrive/data")

img1 = cv2.imread("1a.jpg")
img2 = cv2.imread("2a.jpg")

m_sparse1 = sp.coo_matrix(img1[:, :, 1])
m_sparse2 = sp.coo_matrix(img2[:, :, 1])

combined_sparse_matrix = sp.hstack([m_sparse1, m_sparse2])

print("Matriz dispersa combinada (datos, fila, columna):")
print("Datos:", combined_sparse_matrix.data)
print("Filas:", combined_sparse_matrix.row)
print("Columnas:", combined_sparse_matrix.col)

print("\nVer imagenes Orginales:")
plt.subplot(1, 2, 1)  
plt.title("Imagen 1")  
plt.imshow(cv2.cvtColor(img1, cv2.COLOR_BGR2RGB))  

plt.subplot(1, 2, 2)  
plt.title("Imagen 2")  
plt.imshow(cv2.cvtColor(img2, cv2.COLOR_BGR2RGB)) 

plt.show()