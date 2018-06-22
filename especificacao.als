/*
			More Junto

	(x) Como usário, desejo me cadastrar no sistema
	(x) Como usuário cadastrado, desejo efetuar login no sistema
	(x) Como usuário cadastrado, após efeturar login, gostaria de visualizar meu perfil
	(x) Como usuário logado, gostaria de ver os anúncios
	( ) Como usuario logado, gostaria de criar meu proprio anuncio
	( ) Como usuario logado, gostaria de ver meus anuncio em uma aba separada

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
	criarAnuncio : one CadastrarAnuncio,
	meusAnuncios : one MeusAnuncios
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

sig AnuncioCriadoPeloUsuario extends Anuncio{}

sig AnuncioMoradoPeloUsuario extends Anuncio{}

sig CadastrarAnuncio{}

sig MeusAnuncios{

	anuncios : set AnuncioCriadoPeloUsuario
}

sig Localizacao{}

sig Preco{}

sig Favoritar{}

sig Avaliar{}

sig Consultar{}

sig Filtro{} 

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

	//Cada usuario tem sua aba de cadastrar anuncios
	all c_a : CadastrarAnuncio| one c_a.~criarAnuncio

	//Cada usuario tem acesso ao seus anuncios
	all m : MeusAnuncios | one m.~meusAnuncios
}

pred show[]{}
run show for 5

