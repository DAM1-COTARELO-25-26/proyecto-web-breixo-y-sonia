# 📍 Consultas XPath Documentadas

## Introducción a XPath

**XPath** (XML Path Language) es un lenguaje para navegar y seleccionar elementos en documentos XML.

### Tipos de Rutas:
- **Ruta Absoluta:** Comienza desde la raíz (`/raiz/elemento`)
- **Ruta Relativa:** Comienza desde el contexto actual (`elemento/subelemento`)
- **Wildcard (`//`):** Selecciona cualquier nivel de profundidad

---

## ✅ 10 Consultas XPath Variadas

### **TIPO 1: RUTAS ABSOLUTAS**

#### Consulta 1.1: Obtener todos los destinos (ruta absoluta completa)
```xpath
/destinos/destino
```
#### Consulta 1.2: Obtener todos los nombres de destinos (ruta relativa con wildcard)
```xpath
//destino/nombre
```

#### Consulta 2.1: Obtener destinos con precio mayor a 800
```xpath
//destino[precio_base > 800]
```

#### Consulta 2.2: Obtener destinos eco-friendly (vegetariano = true)
```xpath
//destino[@vegetariano='true']
```

#### Consulta 3.1: Contar el total de destinos
```xpath
count(//destino)
```

#### Consulta 3.2: Suma de todos los precios
```xpath
sum(//destino/precio_base)
```

#### Consulta 3.3: Obtener destinos con nombres que contienen "á" (usando contains())
```xpath
//destino[contains(nombre, 'á')]
```

#### Consulta 4.1: Obtener el país padre de un destino específico
```xpath
//destino[nombre='Bali']/pais
```

#### Consulta 4.2: Obtener el hermano anterior (previous-sibling)
```xpath
//destino[@id='3']/preceding-sibling::destino[1]
```

#### Consulta 5.1: Destinos de montaña con puntuación >= 9
```xpath
//destino[@tipo='montaña' and puntuacion >= 9]
```

#### Consulta 5.2: Destinos con precio entre 700 y 1000 ordenados por nombre
```xpath
//destino[precio_base >= 700 and precio_base <= 1000]/nombre
```
