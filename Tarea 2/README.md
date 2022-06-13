# Tara 2 Teoría Macroeconómica 1

## Datos del alumno

| Nombre | Mail UC |
| :-: | :-: |
| {Francisco Fuentes} | {francisco.fuentes@uc.cl} |
| {Josefa Hernández} | {jthernandez1@uc.cl} |

## Consideraciones generales :thinking:

* El desarrollo de  nuestro tarea en ocasiones se escapa de las peticiones del enunciado con el proposito de investigar el alcance de  nuestro programa. Es más en muchas ocasiones realicé ciertas funciones o algoritmos antes de que me los pidieran puesto que facilitan el proceso de construcción de  nuestro código. 
Espero que disculpen nuestra osadía, pero creo firmemente que mejoran nuestra exprincia de aprendizaje. 
* En nuestra tarea la gente si vive hasta los 70 años, solo cambiamos el salario para que no terminaran ganando negativo al final de su vida.
* La función Fisher solo genera la cantidad de capital demandada por la firma. Además, se asume que la firma escoge producir todo lo que puede bajo indiferencia ya que al tener retornos contsantes a escala esta tiene un beneficio nulo. Si asumieramos que ante indiferencia la firma no produce entonces la tarea pierde sentido.

## Ejecución :computer:
* Como fue solicitado, cada pregunta tiene un programa distinto, a decir verdad, planeaba hacerlo de esa manera desde el principio, pero entendemos porque lo están pidiendo. Cada pregunta parte con los comandos ```clear``` y ```clc```
para ser lo más ordenado posible.
* Otra considración es que recomendamos revisar nuestra tarea es que cada código de cada pregunta se corra sección por sección, ya que al correr el código entero de una pregunta los gráficos se mesclan unos con otros y forman objetos sin sentido. Cada sección de nuestro código esta destacada y caracterizada con el clásico %%, así que solo falta apretar "ctrl + enter" para correr de manera comoda cada letra de cada pregunta partiendo por los parametros claramente.

## Funciones más usadas :books:
* ```V``` **General Function**: La función que resuelve el problema de Bellman, como no queríamos citar ni mencionar a nadie, cosntruimos nuestra propia versión de esta función que podemos asegurar funciona de la misma manera que la expuesta en ayudantías (es casi lo mismo en cuanto al loop se refiere, cambian muchas otras funciones auxiliares que usa para alimentarse).
* ```BS``` **General Function**: función basada en el algoritmo de bisección.
* ```corrp``` **General Function**: esta función calcula la correlación entre dos vectores, luego nos dimos cuenta que matlab ya tiene una de serie, pero la usamos de todas formas.
* ```fisher``` **General Function**: Calcula cantidad de capital demandado por la firma a cada tasa de interes.
* ```Laboral_suply``` **General Function**: Como su nombre lo indica calcula oferta laboral de los individuos, sin embargo lo hace asumiendo que la tasa de crecimiento de la población es nula o que cada grupo etario tiene "1/T" integrantes en cada periodo de tiempo.
* ```mt``` **General Function**: Función que busca calcular un vector con el tamaño de cada grupo etario dado un g y una esperanza de vida.
* ```util``` **General Function**: Bueno, a pesar de que me gistaría decir que todas las funciones en nuestra tarea son propias, esta es la excepción, esta copiada de lo desarrollado por Pablo en las ayudantías. 
* ```Vl``` **General Function**: Vl es esencia lo mismo que V pero incluye el analisis del osio. 


