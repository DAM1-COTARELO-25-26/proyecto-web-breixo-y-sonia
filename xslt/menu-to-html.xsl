<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html lang="es">
    <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Destinos Turísticos - Catálogo Completo</title>
      <link rel="stylesheet" href="css/style.css"/>
      <style>
        body { font-family: 'Arial', sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 8px; margin-bottom: 30px; }
        .stats { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; }
        .stat-item { padding: 15px; background: #f0f0f0; border-radius: 5px; text-align: center; }
        .stat-number { font-size: 28px; font-weight: bold; color: #667eea; }
        .destino-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin-top: 20px; }
        .destino-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); transition: transform 0.3s; }
        .destino-card:hover { transform: translateY(-5px); box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .destino-header { padding: 15px; background-color: #f9f9f9; border-bottom: 2px solid #ddd; }
        .destino-body { padding: 15px; }
        .tipo-badge { display: inline-block; padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; margin-bottom: 10px; }
        .tipo-playa { background: #e3f2fd; color: #1976d2; }
        .tipo-montaña { background: #f3e5f5; color: #7b1fa2; }
        .tipo-ciudad { background: #fff3e0; color: #e65100; }
        .tipo-desierto { background: #fff8e1; color: #f57f17; }
        .premium { border-left: 4px solid #ff9800; background: #fff9c4; }
        .rating { color: #ffc107; font-weight: bold; }
        .precio { font-size: 18px; color: #2e7d32; font-weight: bold; margin: 10px 0; }
        .vegetariano { color: #4caf50; font-weight: bold; }
        footer { background: #333; color: white; padding: 20px; text-align: center; margin-top: 30px; border-radius: 8px; }
      </style>
    </head>
    <body>
      <div class="container">
        <!-- ENCABEZADO -->
        <header>
          <h1>🌍 Catálogo de Destinos Turísticos</h1>
          <p>Descubre los mejores destinos alrededor del mundo</p>
        </header>

        <!-- 
          Aquí usamos funciones XSLT para calcular:
          - count(): cantidad total de destinos
          - sum(): suma de precios
          - avg(): promedio de precios
        -->
        <section class="stats">
          <div class="stat-item">
            <div class="stat-number">
              <xsl:value-of select="count(//destino)"/>
            </div>
            <p>Destinos Disponibles</p>
          </div>
          <div class="stat-item">
            <div class="stat-number">
              $<xsl:value-of select="sum(//destino/precio_base)"/>
            </div>
            <p>Inversión Total (USD)</p>
          </div>
          <div class="stat-item">
            <div class="stat-number">
              $<xsl:value-of select="round(sum(//destino/precio_base) div count(//destino))"/>
            </div>
            <p>Precio Promedio (USD)</p>
          </div>
          <div class="stat-item">
            <div class="stat-number">
              <xsl:value-of select="count(//destino[vegetariano='true'])"/>
            </div>
            <p>Destinos Eco-Friendly</p>
          </div>
        </section>

        <section class="destino-grid">
          <!-- 
            PLANTILLA PRINCIPAL: Se aplica a cada elemento <destino>
            Se ordena por: 1) tipo de destino, 2) precio (menor a mayor)
          -->
          <xsl:apply-templates select="//destino">
            <xsl:sort select="@tipo"/>
            <xsl:sort select="precio_base" data-type="number"/>
          </xsl:apply-templates>
        </section>

        <!-- RESUMEN FINAL -->
        <footer>
          <p>✈️ Generado automáticamente desde XML con XSLT | Última actualización: <xsl:value-of select="//destino[1]/nombre"/></p>
        </footer>
      </div>
    </body>
  </html>
</xsl:template>

<!-- 
  Esta plantilla se ejecuta para CADA elemento <destino>
  Crea una tarjeta HTML con toda la información
-->
<xsl:template match="destino">
  <article class="destino-card">
    <xsl:attribute name="data-id">
      <xsl:value-of select="@id"/>
    </xsl:attribute>
    
    <div class="destino-header">
      <!-- Badge de tipo de destino con clase CSS dinámica -->
      <span>
        <xsl:attribute name="class">
          tipo-badge tipo-<xsl:value-of select="@tipo"/>
        </xsl:attribute>
        <xsl:value-of select="@tipo"/>
      </span>
      
      <!-- Numeración automática: "Destino #1", "Destino #2", etc. -->
      <p style="margin: 5px 0; color: #666; font-size: 12px;">
        Destino #<xsl:value-of select="position()"/>
      </p>
    </div>

    <div class="destino-body">
      <h3 style="margin: 0 0 10px 0;">
        <xsl:value-of select="nombre"/>
      </h3>

      <p style="color: #666; font-size: 14px; margin: 10px 0;">
        <xsl:value-of select="descripcion"/>
      </p>

      <div style="margin: 15px 0;">
        <p style="margin: 5px 0;">
          <strong>País:</strong> 
          <xsl:value-of select="pais"/>
        </p>
        <p style="margin: 5px 0;">
          <strong>Clima:</strong> 
          <xsl:value-of select="clima"/>
        </p>
      </div>

      <!-- 
        Si el precio es > 1000, añadimos la clase "premium" para resaltar
        Esto es un ejemplo de "Formato condicional"
      -->
      <div>
        <xsl:attribute name="style">
          padding: 10px;
          border-radius: 5px;
          <xsl:if test="precio_base > 1000">
            background-color: #fff9c4;
            border-left: 4px solid #ff9800;
          </xsl:if>
        </xsl:attribute>
        <div class="precio">
          USD $ <xsl:value-of select="precio_base"/>
        </div>
        <xsl:if test="precio_base > 1000">
          <span style="background: #ff9800; color: white; padding: 3px 8px; border-radius: 3px; font-size: 12px;">
            ⭐ PREMIUM
          </span>
        </xsl:if>
      </div>

      <!-- PUNTUACIÓN CON ESTRELLAS -->
      <div style="margin-top: 15px;">
        <p style="margin: 0 0 5px 0;">
          <strong>Puntuación:</strong>
          <span class="rating">
            <xsl:value-of select="puntuacion"/>/10
            <!-- Mostrar estrellas según la puntuación -->
            <xsl:choose>
              <xsl:when test="puntuacion >= 9">⭐⭐⭐⭐⭐</xsl:when>
              <xsl:when test="puntuacion >= 8">⭐⭐⭐⭐</xsl:when>
              <xsl:when test="puntuacion >= 7">⭐⭐⭐</xsl:when>
              <xsl:when test="puntuacion >= 6">⭐⭐</xsl:when>
              <xsl:otherwise>⭐</xsl:otherwise>
            </xsl:choose>
          </span>
        </p>
      </div>

      <!-- 
        Condicional: Si vegetariano='true', mostrar el badge
        Esto usa <xsl:if> para mostrar solo si cumple la condición
      -->
      <xsl:if test="vegetariano='true'">
        <div style="margin-top: 10px; padding: 8px; background: #e8f5e9; border-radius: 5px;">
          <span class="vegetariano">🌱 Destino Eco-Friendly</span>
        </div>
      </xsl:if>
    </div>
  </article>
</xsl:template>

</xsl:stylesheet>
