package pe.edu.upeu.milkminder.mappers;


import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pe.edu.upeu.milkminder.dtos.UsuarioCrearDto;
import pe.edu.upeu.milkminder.dtos.UsuarioDto;
import pe.edu.upeu.milkminder.models.Usuario;



@Mapper(componentModel = "spring")
public interface UsuarioMapper {

    UsuarioDto toUserDto(Usuario user);

    @Mapping(target = "password", ignore = true)
    Usuario usuarioCrearDtoToUser(UsuarioCrearDto usuarioCrearDto);

}
