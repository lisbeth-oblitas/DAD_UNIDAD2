package pe.edu.upeu.milkminder.controllers;


import jakarta.servlet.http.HttpServletRequest;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.net.URI;
import org.springframework.web.bind.annotation.RequestMapping;
import pe.edu.upeu.milkminder.configuration.UserAuthenticationProvider;
import pe.edu.upeu.milkminder.dtos.CredencialesDto;
import pe.edu.upeu.milkminder.dtos.UsuarioCrearDto;
import pe.edu.upeu.milkminder.dtos.UsuarioDto;
import pe.edu.upeu.milkminder.services.UsuarioService;

@RequiredArgsConstructor
@RestController
@RequestMapping("/finca")
public class AuthController {

    private final UsuarioService userService;
    private final UserAuthenticationProvider userAuthenticationProvider;

    @PostMapping("/login")
    public ResponseEntity<UsuarioDto> login(@RequestBody @Valid CredencialesDto credentialsDto, HttpServletRequest request) {
        UsuarioDto userDto = userService.login(credentialsDto);
        userDto.setToken(userAuthenticationProvider.createToken(userDto));
        request.getSession().setAttribute("USER_SESSION", userDto.getCorreo());        
        return ResponseEntity.ok(userDto);
    }

    @PostMapping("/register")
    public ResponseEntity<UsuarioDto> register(@RequestBody @Valid UsuarioCrearDto user) {
        System.out.println("Passss...."+ user.token());
        UsuarioDto createdUser = userService.register(user);
        createdUser.setToken(userAuthenticationProvider.createToken(createdUser));
        return ResponseEntity.created(URI.create("/users/" + createdUser.getId())).body(createdUser);
    }

}
