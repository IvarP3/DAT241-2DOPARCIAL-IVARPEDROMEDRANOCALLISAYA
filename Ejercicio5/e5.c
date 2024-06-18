#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

void inicializar_matriz(int *matriz, int tamano) {
    #pragma omp parallel for collapse(2) // Usa OpenMP para paralelizar este bucle anidado
    for (int i = 0; i < tamano; i++) {
        for (int j = 0; j < tamano; j++) {
            matriz[i * tamano + j] = rand() % 10 + 1; // Inicializar con valores aleatorios del 1 al 10
        }
    }
}

void multiplicar_bloque(int inicio_fila, int fin_fila, int *A, int *B, float *C, int tamano) {
    #pragma omp parallel for collapse(2) // Usa OpenMP para paralelizar este bucle anidado
    for (int i = inicio_fila; i < fin_fila; i++) {
        for (int j = 0; j < tamano; j++) {
            for (int k = 0; k < tamano; k++) {
                C[i * tamano + j] += A[i * tamano + k] * B[k * tamano + j];
            }
        }
    }
}

int main() {
    int tamano = 1000;
    int *A, *B;
    float *C;

    A = (int *)malloc(tamano * tamano * sizeof(int));
    B = (int *)malloc(tamano * tamano * sizeof(int));
    C = (float *)calloc(tamano * tamano, sizeof(float));

    // Inicializar matrices A y B
    srand(1234); // Semilla para reproducibilidad
    inicializar_matriz(A, tamano);
    inicializar_matriz(B, tamano);

    int tamanio_bloque = 100;
    int num_bloques = tamano / tamanio_bloque;

    #pragma omp parallel for num_threads(4)
    for (int i = 0; i < num_bloques; i++) {
        int inicio_fila = i * tamanio_bloque;
        int fin_fila = (i + 1) * tamanio_bloque;
        multiplicar_bloque(inicio_fila, fin_fila, A, B, C, tamano);
    }

    // Imprimir solo los primeros y últimos datos de la matriz resultante
    printf("Matriz resultante de la multiplicación de matrices dispersas:\n");
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            printf("  (%d, %d)\t%.16f\n", i, j, C[i * tamano + j]);
        }
    }

    printf("  :\n");

    for (int i = tamano - 10; i < tamano; i++) {
        for (int j = tamano - 10; j < tamano; j++) {
            printf("  (%d, %d)\t%.16f\n", i, j, C[i * tamano + j]);
        }
    }

    free(A);
    free(B);
    free(C);

    return 0;
}
