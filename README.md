[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/0esC98hF)
# viaj.es

Sitio web de agencia de viajes enfocada en jubilados.

## Mapa del sitio

- **index.html** → Página principal con bienvenida y destinos destacados.  
- **destinos.html** → Tabla con destinos, precios y galería de imágenes.  
- **contacto.html** → Formulario de contacto y datos de la agencia.  

## Estructura de carpetas
```
/viajes/
├── index.html
├── destinos.html
├── contacto.html
├── /img/
│ ├── logo.png
│ ├── destino1.jpg
│ ├── destino2.jpg
│ └── destino3.jpg
└── README.md
```
## Estructura de Datos XML 
### Descripción 
Este proyecto utiliza XML para estructurar [descripción del tipo de datos]. 
### Archivos
- **`/datos/tablaDestinos.xml`**: Indica la descripción del contenido
- **`/datos/tablaDes.dtd`**: Validador DTD
- **`/datos/tablaDes.xsd`**: Schema XSD con restricciones avanzadas 
### Estructura principal 
Explica que estructura tiene tu árbol de XML por niveles, con sus respectivos 
atributos, etc. 
### Validación 
Ver documentación completa en [`/datos/validacion.md`](datos/validacion.md) 

## Paleta y tipografía
- Fondo blanco
- Tipografía estilo *Times New Roman* o similar, ligeramente más gruesa.
- Colores brillantes (verde lima, rojo, azul claro, turquesa) en menús y botones (se aplicarán en fase CSS).


---

## **5 ACTUALIZACIÓN DE README.md**

# Proyecto de Transformación XML a HTML - Entrega 4

## Descripción General
Este proyecto implementa la **transformación automática de datos XML a HTML5** mediante hojas de estilo XSLT, permitiendo visualizar un catálogo de destinos turísticos de manera interactiva.

---

## Estructura de Archivos
```
Entrega_4/ ├── README.md 
# Este archivo ├── index.html 
# Página principal del sitio ├── menu.html 
# Catálogo generado con XSLT ├── contacto.html 
# Página de contacto ├── destinos.html 
# Página de destinos │ ├── /datos/ │ ├── menu.xml 
# Datos XML de destinos (Entrega 3) │ └── consultas-xpath.md 
# Consultas XPath documentadas │ ├── /xslt/ │ └── menu-to-html.xsl 
# Hoja de transformación XSLT │ ├── /css/ │ └── style.css 
# Estilos CSS globales │ └── /imgs/ ├── menu-generado.png 
# Captura de resultado HTML └── xpath-testing.png 
# Captura de pruebas XPath
```

---

## FASE 4: Transformación y Consulta de Datos

### **Hoja de Transformación XSLT**

**Archivo:** `/xslt/menu-to-html.xsl`

#### Elementos XSLT Implementados (6+ obligatorios):
1. **`<xsl:template match="">`** - 2 plantillas:
   - Plantilla raíz (`match="/"`)
   - Plantilla para cada destino (`match="destino"`)

2. **`<xsl:apply-templates>`** - Aplica plantillas a cada destino
   ```xslt
   <xsl:apply-templates select="//destino">
   ```
3. <xsl:for-each> - Iteración sobre elementos (implícita en apply-templates)
4. <xsl:value-of> - Extrae valores de elementos:

```xslt
<xsl:value-of select="nombre"/>
<xsl:value-of select="precio_base"/>
```
5. <xsl:sort> - Ordenación por 2 criterios:

```xslt
<xsl:sort select="@tipo"/>           <!-- Por tipo -->
<xsl:sort select="precio_base" data-type="number"/>  <!-- Por precio -->
```
6. <xsl:choose> + <xsl:when> - Condicionales:

```xslt
<xsl:choose>
  <xsl:when test="puntuacion >= 9">⭐⭐⭐⭐⭐</xsl:when>
  <xsl:when test="puntuacion >= 8">⭐⭐⭐⭐</xsl:when>
  <!-- más condiciones -->
</xsl:choose>
```
7. <xsl:attribute> - Crea atributos dinámicos:

```xslt
<xsl:attribute name="class">
  tipo-badge tipo-<xsl:value-of select="@tipo"/>
</xsl:attribute>
```
8. XPath Expressions - En selectores:

```xslt
select="//destino"
select="//destino[precio_base > 800]"
```
