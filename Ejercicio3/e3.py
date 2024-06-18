import cv2
from matplotlib import pyplot as plt
from google.colab import drive
import os

drive.mount("/content/drive")
os.chdir("/content/drive/MyDrive/data")

imagen1 = cv2.imread("1a.jpg")
imagen2 = cv2.imread("2a.jpg")

adicion = cv2.addWeighted(imagen1, 0.8, imagen2, 0.1, 0)

subtraccion = cv2.subtract(imagen1, imagen2)

plt.figure(figsize=(10, 5))

# Mostrar la imagen resultante de la adición
plt.subplot(1, 2, 1)
plt.title("Adición de Imágenes")
plt.imshow(cv2.cvtColor(adicion, cv2.COLOR_BGR2RGB))

# Mostrar la imagen resultante de la sustracción
plt.subplot(1, 2, 2)
plt.title("Sustracción de Imágenes")
plt.imshow(cv2.cvtColor(subtraccion, cv2.COLOR_BGR2RGB))

# Mostrar la figura
plt.show()
