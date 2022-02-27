# P3-CIU-2021-2022

Autor: Víctor Sánchez Rodríguez

Se realiza una simulación de un sistema planetario simple (sin tener demasiado en cuenta la gravedad). Como toque personal se ha añadido la posibilidad de acelerar o detener la rotación de uno de los planetas, o de todos a la vez. Cada planeta tiene una distancia del sol aleatoria en los tres ejes (dentro de unos rangos) y una posibilidad también aleatoria de poseer luna. Estas condiciones iniciales se pueden recalcular en cualquier momento.

Para que el texto se mantenga constante en cualquier momento, se realizan operaciones inversas de transformación en el momento de dibujar el texto (no se puede usar popMatrix() porque se necesita mantener el frame de referencia para futuras transformaciones) aunque estas operaciones inversas sí se hacen dentro de un pushMatrix()-popMatrix().

Para realizar el trabajo se han usado únicamente las propias herramientas y documentación del propio Processing aportadas en el guión, incluso para la captura del gif animado (la cual no se ve reflejada en el código entregado).
Se han usado imágenes de Google para los activos multimedia (las imágenes del sol, planetas y lunas).

![animacion](https://user-images.githubusercontent.com/73181748/155898110-1345613d-5f1d-4d43-9c3b-8f968dbc2d17.gif)
