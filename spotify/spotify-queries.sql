-- ---------------------------------------------------------------------------
-- Realizar los siguientes informes: 
-- ---------------------------------------------------------------------------
-- Mostrar el nombre de usuario y contar la cantidad de playlist que tiene.
SELECT 
    u.nombreusuario, COUNT(*) playlist
FROM
    usuario u
        INNER JOIN
    playlist p ON u.idUsuario = p.idusuario
GROUP BY u.nombreusuario; 

-- Generar un reporte, donde se muestre el método de pago , la cantidad de 
-- operaciones que se realizaron con cada uno y el importe total.
SELECT 
    TipoFormaPago, COUNT(idPagos), SUM(Importe)
FROM
    datospagoxusuario dp
        INNER JOIN
    tipoformapago tp ON dp.idTipoFormaPago = tp.idTipoFormaPago
        INNER JOIN
    pagos p ON dp.idDatosPagoxUsuario = p.IdDatosPagoxUsuario
GROUP BY TipoFormaPago;

-- Listar las canciones que tienen los artistas cuyo nombre contiene la 
-- letra “r” y el pertenecen al código de género 20. 
SELECT 
    c.titulo, gc.IdGenero, ar.Nombre
FROM
    cancion c
        INNER JOIN
    album a ON c.IdAlbum = a.idAlbum
        INNER JOIN
    artista ar ON a.idArtista = ar.idArtista
    LEFT JOIN 
    generoxcancion gc ON c.idCancion = gc.idCancion
WHERE ar.Nombre LIKE "%r%" AND gc.IdGenero = 20;

-- Listar todos los usuarios que que pagaron con efectivo y la fecha de 
-- pago sea del 2020.
SELECT 
    u.nyap nombre, EXTRACT(YEAR FROM p.fechaPago) fecha_pago, tp.TipoFormaPago
FROM
    usuario u
        INNER JOIN
    datospagoxusuario dpu ON u.idUsuario = dpu.idusuario
        INNER JOIN
    pagos p ON dpu.idDatosPagoxUsuario = p.IdDatosPagoxUsuario
        INNER JOIN
    tipoformapago tp ON dpu.idTipoFormaPago = tp.idTipoFormaPago
WHERE
    tp.TipoFormaPago = 'Efectivo' AND EXTRACT(YEAR FROM p.fechaPago) = '2020';
	
-- Generar un reporte de todas las canciones, cuyo álbum no posee imagen 
-- de portada.
SELECT 
    c.titulo, al.imagenportada
FROM
    cancion c
        INNER JOIN
    album al ON c.IdAlbum = al.idAlbum
WHERE
    al.imagenportada IS NULL;

-- Genera un reporte por género e informar la cantidad de canciones que 
-- posee. Si una canción tiene más de un género, debe ser incluida en 
-- la cuenta de cada uno de esos géneros.
SELECT 
    g.Genero, COUNT(*)
FROM
    cancion c
        INNER JOIN
    generoxcancion gxc ON c.idCancion = gxc.IdCancion
        INNER JOIN
    genero g ON gxc.IdGenero = g.idGenero
GROUP BY g.Genero;

-- Listar todos las playlist que no están en estado activo y a que 
-- usuario pertenecen , ordenado por la fecha de eliminación.
SELECT 
    pl.titulo,
    u.nyap,
    pl.Fechaeliminada
FROM
    playlist pl
        INNER JOIN
    usuario u ON pl.idusuario = u.idUsuario
WHERE pl.idestado = 2
ORDER BY pl.Fechaeliminada;

-- Generar un reporte que muestre por tipo de usuario, la cantidad de
-- usuarios que posee.
SELECT 
    tu.TipoUsuario, COUNT(*) cantidad
FROM
    usuario u
        INNER JOIN
    tipousuario tu ON u.IdTipoUsuario = tu.idTipoUsuario
GROUP BY tu.TipoUsuario;

-- Listar la suma total obtenida por cada tipo de suscripción, en el
-- periodo del 01-01-2020 al 31-12-2020.
SELECT 
    tu.TipoUsuario, SUM(p.Importe) total
FROM
    suscripcion s
        INNER JOIN
    pagos p ON s.idpagos = p.idPagos
		INNER JOIN
	tipousuario tu ON s.IdTipoUsuario = tu.idTipoUsuario
WHERE s.FechaInicio BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY tu.TipoUsuario;

-- Listar el álbum y la discográfica que posea la canción con más 
-- reproducciones.
SELECT 
    al.titulo Album,
    d.nombre Discografia,
    c.titulo Cancion,
    c.cantreproduccion Reproducciones
FROM
    cancion c
        LEFT JOIN
    album al ON al.idAlbum = c.IdAlbum
        INNER JOIN
    discografica d ON d.idDiscografica = al.iddiscografica
ORDER BY c.cantreproduccion DESC
LIMIT 1;

-- Listar todos los usuarios que no hayan generado una playlist.
SELECT 
    *
FROM
    usuario u
        LEFT JOIN
    playlist pl ON pl.idusuario = u.idUsuario
WHERE pl.idestado IS NULL;

-- Listar todas las canciones hayan o no recibido likes (cuántos) y 
-- aclarar si han sido reproducidas o no. Listar las 15 primeras 
-- ordenadas como si fueran un Ranking.
SELECT 
    c.titulo,
    COALESCE(SUM(c.cantlikes), 0) Likes,
    CASE
        WHEN c.cantreproduccion <= 0 THEN 'No Reproducida'
        ELSE 'Reproducida'
    END AS Estado
FROM
    cancion c
GROUP BY c.idCancion
ORDER BY Likes DESC
LIMIT 15;

-- Generar un reporte con el nombre del artista y el nombre de la 
-- canción que no pertenecen a ninguna lista. 
SELECT 
    ar.Nombre, c.titulo, plxc.IdPlaylist
FROM
    cancion c
        LEFT JOIN
    playlistxcancion plxc ON plxc.Idcancion = c.idCancion
		LEFT JOIN
	album al ON al.idAlbum = c.IdAlbum
		LEFT JOIN 
	artista ar ON ar.idArtista = al.idArtista
WHERE plxc.IdPlaylist IS NULL;

-- Listar todas las canciones, el nombre del artista, la razón social
-- de la discográfica y  la cantidad de veces que fue reproducida. 
    SELECT 
    c.titulo Cancion,
    ar.Nombre Artista,
    d.nombre Discografica,
    c.cantreproduccion Reproducciones
FROM
    cancion c
        LEFT JOIN
    album al ON al.idAlbum = c.IdAlbum
        LEFT JOIN
    artista ar ON ar.idArtista = al.idArtista
        LEFT JOIN
    discografica d ON d.idDiscografica = al.iddiscografica;

-- Listar todas las discográficas, que pertenezcan a Inglaterra y la
-- cantidad de álbumes que hayan editado. 
SELECT 
    d.nombre Discografica,
    p.Pais Pais,
    COUNT(al.idAlbum) Albumes
FROM
    discografica d
        LEFT JOIN
    pais p ON p.idPais = d.idPais
        LEFT JOIN
    album al ON al.idAlbum = d.idPais
GROUP BY Discografica, p.Pais
HAVING p.Pais = "Inglaterra";

-- Listar a todos los artistas que no poseen ningún álbum. 
SELECT 
    ar.nombre, al.titulo
FROM
    artista ar
        LEFT JOIN
    album al ON al.idArtista = ar.idArtista
WHERE al.idAlbum IS NULL;

-- Listar todos los álbumes que tengan alguna canción que posea más 
-- de un género.
SELECT 
    al.titulo Album, c.titulo Cancion, COUNT(g.Genero) N_Generos
FROM
    album al
        INNER JOIN
    cancion c ON c.IdAlbum = al.idAlbum
        INNER JOIN
    generoxcancion gxc ON gxc.IdCancion = c.idCancion
        INNER JOIN
    genero g ON g.idGenero = gxc.IdGenero
GROUP BY Album, Cancion
HAVING N_Generos > 1;

-- Generar un reporte por usuario , listando las suscripciones que tiene 
-- o tuvo, el importe que abonó y  los datos de las formas de pago con
-- que lo realizó.
SELECT 
    u.nyap Usuario, 
    s.idSuscripcion "ID Suscripcion",
    SUM(p.Importe) Importe,
    tfp.TipoFormaPago
FROM
    usuario u
        LEFT JOIN
    suscripcion s ON s.idusuario = u.idUsuario
        LEFT JOIN
    pagos p ON p.idPagos = s.idpagos
        LEFT JOIN
    datospagoxusuario dpu ON dpu.idusuario = u.idUsuario
        LEFT JOIN
    tipoformapago tfp ON tfp.idTipoFormaPago = dpu.idTipoFormaPago
GROUP BY u.nyap, s.idSuscripcion, tfp.TipoFormaPago;


