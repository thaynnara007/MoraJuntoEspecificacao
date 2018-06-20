module moreJunto

sig Usuario{}

sig UsuarioCadastrado{}

sig Cadastro{}

sig Login{}

sig Perfil{}

sig Anuncios{}

abstract sig Anuncio{}

sig AnuncioPartamento extends Anuncio{}

sig AnuncioRepublica extends Anuncio{}

sig AnuncioCriadoPeloUusario extends Anuncio{}

sig AnuncioMoradoPeloUsuario extends Anuncio{}

sig Localizacao{}

sig Preco{}

sig Favoritar{}

sig Avaliar{}

sig Consultar{}

sig Filtro{} 

sig CadastrarAnuncios{}

sig NotificadoPorEmail{}

sig Deslogar{}

pred show[]{}
run show for 15

