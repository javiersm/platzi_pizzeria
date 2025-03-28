# platzi_pizzeria
Java Spring Boot Proyect


## POSTMAN
Javi he guardado las llamadas en Postman dentro de "platzi_pizza"


## USUARIOS PARA LOGUEARSE POR LA API POSTMAN
Deben estar en la bdd en users con la contraseña encriptada en bcrypt

### CREDENTIALS 
admin - admin
customer - customer

INSERT INTO `platzi_pizzeria`.`user` (`username`, `password`, `email`, `locked`) VALUES ('admin', '0', 'admin@admin.com', '0')
INSERT INTO `platzi_pizzeria`.`user` (`username`, `password`, `email`, `locked`, `disabled`) VALUES ('admin', '0', 'admin@admin.com', '0', '$2a$12$lk9VeC3tyaBSWrWDlsKdN.dBo940YPZWi2gr4d9TtuDBGKU8x2QNi')

### TABLA ROLES USUARIO
Cada usuario debe tener una fila en la tabla user_roles 
