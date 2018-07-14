/*
			More Junto

	(x) Como usário, desejo me cadastrar no sistema
	(x) Como usuário cadastrado, desejo efetuar login no sistema
	(x) Como usuário cadastrado, após efeturar login, gostaria de visualizar meu perfil
	(x) Como usuário logado, gostaria de ver os anúncios
	(x) Como usuario logado, gostaria de criar meu proprio anuncio
	(x) Como usuario logado, gostaria de ver meus anuncio em uma aba separada
	(x) Como usuario logado, gostaria de poder apagar meu perfil
	(x) Como usuario logado, gostaria de poder mudar minha senha
	(x) Como usuario logado, gostaria de deslogar do sistemas

*/
module moreJunto
------------------------------------------------
-------------ASSINATURAS----------------
------------------------------------------------
abstract sig Usuario{}

sig UsuarioNaoCadastrado{

	cadastrar : one Cadastro
}

sig UsuarioCadastrado extends Usuario{

	logar : lone Login
}

sig UsuarioLogado in UsuarioCadastrado{
	
	perfil : one Perfil,
	abaAnuncio : one Anuncios,
	cadastrarAnuncio : one CadastrarAnuncio,
	meusAnuncios : one MeusAnuncios,
	configuracao : one Configuracoes
}

sig Configuracoes{
	
	excluirPerfil : one ApagarPerfil,
	trocarSenha : one MudarSenha,
	deslogar : one Deslogar
}

sig ApagarPerfil{}

sig MudarSenha{}

sig Deslogar{}

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

----------------------------------------------
------------------FATOS-------------------
----------------------------------------------
fact mult{
	
	--Apenas usuarios nao cadastrados podem efetuar cadastro
	all c : Cadastro | some c.~cadastrar

	--Apenas usuarios cadastrados podem efeturar login
	all l : Login | some l.~logar
	
	--Tpda pagina perfil pertence a um usuario
	all p: Perfil | one  p.~perfil

	--Toda aba anuncios pertence a um usuario
	all a: Anuncios | one a.~abaAnuncio
	
	--Toda  aba de cadastrar anuncios pertence a um usuario cadastrado
	all c_a : CadastrarAnuncio| one c_a.~cadastrarAnuncio

	--Todo usuario tem acesso ao seus anuncios
	all m : MeusAnuncios | one m.~meusAnuncios

	--Cada anuncio criado por um usuario deve pertencer apenas a uma aba Meus Anuncios
	all a_c : AnuncioCriadoPeloUsuario | one a_c.~anuncios

	--Todo anuncio deve estar ligado a uma aba anuncios
	all a : Anuncio | some a.~anuncio

	--Toda pagina de configuracao de conta epode ser acessado por apenas um usuario logado dono da conta
	all c : Configuracoes | one c.~configuracao
	
	--Toda opcao de apagar perfil esta ligada a uma aba configuracoes respectivo a seu usuario
	all a : ApagarPerfil | one a.~excluirPerfil

	--Toda opcao de mudar senha esta ligada a uma aba configuracao respectivo a seu usuario
	all m : MudarSenha | one m.~trocarSenha

	--Toda opcao de deslogar esta ligada a uma aba configuracao respectivo a seu usuario
	all d : Deslogar | one d.~deslogar
}

fact {

	--Todo usuario cadastrado tem sua propria pagina de perfil diferente das demais
	all u1, u2 : UsuarioCadastrado | u1 != u2 implies u1.perfil != u2.perfil

	--Todo usuario cadastrado tem sua propria aba de anuncios diferente das demais
	all u1, u2 : UsuarioCadastrado | u1 != u2 implies u1.abaAnuncio != u2.abaAnuncio

	--Todo usuario cadastrado tem sua propria aba de criar anuncios diferente das demais
	all u1,u2 : UsuarioCadastrado | u1 != u2 implies u1.cadastrarAnuncio != u2.cadastrarAnuncio
	
	--Todo usuario cadastrado tem sua propria aba de meus anuncios diferente das demais
	all u1,u2 : UsuarioCadastrado | u1 != u2 implies u1.meusAnuncios != u2.meusAnuncios
}

fact{
	
	--Todo anuncio craido por um usuario pertence a alguma aba anuncios tal que esta aba não seja a do usuario que criou o anuncio
	all u: UsuarioLogado , m: MeusAnuncios, aba: Anuncios | (abaMeusAnuncios[u] = m) and (abaAnuncioDoUsuario[u] = aba) implies aba.anuncio = aba.anuncio - m.anuncios
}

fact usuarioLogadoNaoPodeLogarDeNovo{
	
	all u: UsuarioLogado | #u.logar = 0 
}
--------------------------------------------
------------PREDICADOS--------------
--------------------------------------------

pred anunciosContemAnuncioCriado[anuncio : AnuncioCriadoPeloUsuario, abaAnuncio : Anuncios]{

	 (anuncio in todosOsAnuncios[abaAnuncio])
} 

--------------------------------------------
----------------FUNCOES---------------
-------------------------------------------
fun todosOsAnuncios[abaAnuncio : Anuncios] : set Anuncio{

	abaAnuncio.anuncio
}

fun abaMeusAnuncios[usuario : UsuarioLogado] : one MeusAnuncios{

	usuario.meusAnuncios 
}

fun abaAnuncioDoUsuario[usuario: UsuarioLogado] : one Anuncios{

	usuario.abaAnuncio
}

pred show[]{}
run show for 5

