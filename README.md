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
- `format_rut_with_dv(rut, validar=true)` formatea el rut recibido como argumento. El rut debe incluir el dígito verificador.
- `format_rut_without_dv(rut)` formatea el rut recibido como argumento. El rut **NO** debe incluir el dígito verificador.

## Ejemplos

```ruby
# Validación
Rutcl::Rut.valid?("16365637k") #rut válido 16.365.637-k
#=> true
Rutcl::Rut.valid?("163656370") #rut inválido 16.365.637-0
#=> false

# Cómputo de dígito verificador
Rutcl::Rut.dv(1) #rut 1-9
#=> 9
Rutcl::Rut.dv(16365637) #rut 16.365.637-k
#=> "k"

# Formateo para RUTs que incluyen dígito verificador
Rutcl::Rut.format_rut_with_dv("16365637k")
#=> "16.365.637-k"
Rutcl::Rut.format_rut_with_dv("14569484-1")
#=> "14.569.484-1"
Rutcl::Rut.format_rut_with_dv("14569484-0")
ArgumentError: "El rut 14569484-0 es inválido"
Rutcl::Rut.format_rut_with_dv("14569484-0", false)
#=> "14.569.484-0"

# Formateo para RUTs que **NO** incluyen dígito verificador
Rutcl::Rut.format_rut_without_dv("16365637")
#=> "16.365.637-k"
Rutcl::Rut.format_rut_without_dv("14569484")
#=> "14.569.484-1"
```

## Changelog

### Versión 1.1.0 (2013-11-04)
- El método `pretty` es eliminado. En su lugar se crean dos métodos, `format_rut_without_dv(rut)` y `format_rut_with_dv(rut, validate=true)`.
