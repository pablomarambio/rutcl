# Rut

Valida y formatea RUTs chilenos.

## Instalación

Incluye esta línea en tu Gemfile

```ruby
    gem 'rut'
```

Y luego ejecuta `bundle` en la carpeta de tu proyecto.

## Uso

La gema habilita la clase Rut, la que cuenta con tres métodos:

- `valid?(rut)` retorna `true` si el rut es válido.
- `dv(rut)` retorna el dígito verificador del rut. El argumento debe ser un rut **sin dígito verificador**.
- `pretty(rut, validar=true)` formatea el rut recibido como argumento.

## Ejemplos

```ruby
# Validación
Rut.valid?("16365637k") #rut válido 16.365.637-k
#=> true
Rut.valid?("163656370") #rut inválido 16.365.637-0
#=> false

# Cómputo de dígito verificador
Rut.dv(1) #rut 1-9
#=> 9
Rut.dv(16365637) #rut 16.365.637-k
#=> "k"

# Formateo
Rut.pretty("16365637k")
#=> "16.365.637-k"
Rut.pretty("14569484-1")
#=> "14.569.484-1"
Rut.pretty("14569484-0")
ArgumentError: "El rut 14569484-0 es inválido"
Rut.pretty("14569484-0", false)
#=> "14.569.484-0"
```
