-- Declaramos la variable para almacenar el número de movimiento
DECLARE @mov_num_valido VARCHAR(30);

-- Declaramos el cursor para obtener los números de movimiento válidos
DECLARE cur_movimientos CURSOR FOR
SELECT mov_num
FROM movimientos_validos;

-- Abrimos el cursor
OPEN cur_movimientos;

-- Obtenemos el primer número de movimiento válido
FETCH NEXT FROM cur_movimientos INTO @mov_num_valido;

-- Bucle para procesar los números de movimiento válidos
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Actualizamos la tabla mov_ban
    UPDATE mov_ban
    SET dep_con = 1
    WHERE mov_num = @mov_num_valido;

    -- Imprimimos un mensaje para indicar que se actualizó un movimiento
    PRINT 'Movimiento ' + @mov_num_valido + ' actualizado.';

    -- Obtenemos el siguiente número de movimiento válido
    FETCH NEXT FROM cur_movimientos INTO @mov_num_valido;
END;

-- Cerramos el cursor
CLOSE cur_movimientos;

-- Desasignamos el cursor
DEALLOCATE cur_movimientos;

PRINT 'Proceso de actualización de mov_ban completado.';