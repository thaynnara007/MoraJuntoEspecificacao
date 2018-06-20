/*
			More Junto

	( ) Como usário, desejo me cadastrar no sistema
	( ) Como usuário cadastrado, desejo efetuar login no sistema
	( ) Como usuário cadastrado, após efeturar login, gostaria de visualizar meu perfil
	( ) Como usuário logado, gostaria de ver os anúncios

*/

module moreJunto

abstract sig Usuario{}

sig UsuarioNaoCadastrado{

	cadastrar : one Cadastro
}

sig UsuarioCadastrado extends Usuario{

	logar : one Login
}

sig UsuarioLogado extends Usuario{
	
	perfil : one Perfil
}

one sig Cadastro{}

one sig Login{}

sig Perfil{}

sig Anuncios{
	
	anuncio : set Anuncio
}

abstract sig Anuncio{}

sig AnuncioApartamento extends Anuncio{}

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
run show for 8

