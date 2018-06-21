/*
			More Junto

	(x) Como usário, desejo me cadastrar no sistema
	(x) Como usuário cadastrado, desejo efetuar login no sistema
	(x) Como usuário cadastrado, após efeturar login, gostaria de visualizar meu perfil
	(x) Como usuário logado, gostaria de ver os anúncios
	( ) Como usuario logado, gostaria de criar meu proprio anuncio

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
	
	perfil : one Perfil,
	abaAnuncio : one Anuncios,
	criarAnuncio : one CadastrarAnuncio
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

sig CadastrarAnuncio{}

sig NotificadoPorEmail{}

sig Deslogar{} 

fact mult{
	
	//Apenas usuarios nao cadastrados podem fazer cadastro
	all c : Cadastro | some c.~cadastrar

	//Apenas usuarios cadastrados podem efeturar login
	all l : Login | some l.~logar
	
	//Toda pagina de perfil esta ligada à um usuario
	all p : Perfil | one p.~perfil 

	//Cada usuario tem sua aba anuncios
	all a : Anuncios | one a.~abaAnuncio
}

pred show[]{}
run show for 8

