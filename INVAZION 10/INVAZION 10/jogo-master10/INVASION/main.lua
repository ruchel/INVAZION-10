require("Paraquedas") ------- Chamada do Arquivo Paraquedas ------
-----------------------variaveis----------------------------------
local lose = false
local nextLevel = 10
local points = 0
local Paraquedas = nil
local music  = nil
local music2 = nil
local music3 = nil
local music4 = nil
local music5 = nil
local EndGame = nil
local gameover = nil
local fundo  = nil
local fundo2 = nil
local fundo3 = nil
local fundo4 = nil
local fundo5 = nil
local TelaFinal = nil
local actveStartMenu = true
local Parabens = false
local fonteGimmeDanger = "fonts/Gimme Danger.ttf"
local vida = 5

local x = nil
local y = nil
local imgNuvem = nil
local x1 = nil
local y1 = nil
local imgNuvem2 = nil
local x2 = nil
local y2 = nil
local imgNuvem3 = nil
local x3 = nil
local y3 = nil
local imgNuvem4 = nil
-----------------------variaveis----------------------------------

function love.load()

-----------------------------nuvens-------------------------------
	imgNuvem = love.graphics.newImage( "imgs/nuvem.png" )
	x=20
	y=10

	imgNuvem2 = love.graphics.newImage( "imgs/nuvem2.png" )
	x1=350
	y1=90

	imgNuvem3 = love.graphics.newImage( "imgs/nuvem3.png" )
	x2=700
	y2=60

	imgNuvem4 = love.graphics.newImage( "imgs/nuvem4.png" )
	x3=950
	y3=20

-----------------------------nuvens-------------------------------


-------------------------vida------------------------------------
vidas = love.graphics.newImage( "imgs/vida.png" )

-------------------------vida-------------------------------------



-------------------mira ou ponteiro do mouse----------------------
imgs = love.graphics.newImage( "imgs/Mira.png" )
love.mouse.setVisible( false )
-------------------mira ou ponteiro do mouse----------------------


love.window.setTitle("INVASION")--invasão
math.randomseed(os.time())
Paraquedas = newParaquedas(3, 30)
Paraquedas:initAllParaquedas()



----------------------imagem de fundo 1----------------------------
fundo = love.graphics.newImage( "imgs/Background01.png" )

	planoDeFundo = {x = 0, y = 0,}
----------------------imagem de fundo 1----------------------------



----------------------imagem de fundo 2----------------------------
fundo2 = love.graphics.newImage( "imgs/Background02.png" )

	planoDeFundo2 = {x = 0, y = 0,}
----------------------imagem de fundo 2-----------------------------


----------------------imagem de fundo 3-----------------------------
fundo3 = love.graphics.newImage( "imgs/Background03.png" )

	planoDeFundo3 = {x = 0, y = 0,}
----------------------imagem de fundo 3-----------------------------


----------------------imagem de fundo 4-----------------------------
fundo4 = love.graphics.newImage( "imgs/Background04.png" )

	planoDeFundo4 = {x = 0, y = 0,}
----------------------imagem de fundo 4 ----------------------------


----------------------imagem de fundo 5-----------------------------
fundo5 = love.graphics.newImage( "imgs/Background05.png" )

	planoDeFundo5 ={x = 0, y = 0,}
----------------------imagem de fundo 5-----------------------------


-----------------------tela inicial---------------------------------
abretela = false
TelaInicial = love.graphics.newImage( "imgs/Menu.png" )
-----------------------tela inicial---------------------------------

-----------------------tela final-----------------------------------
TelaFinal = love.graphics.newImage( "imgs/TelaFinal.png" )
	planoDeFundo6 = {x = 0, y = 0,}
-----------------------tela Final-----------------------------------

-----------------------audios do jogo-------------------------------
music = love.audio.newSource("sound/blast_off.mp3", "stream")
music:setLooping(true)
love.audio.play(music)

music2 = love.audio.newSource("sound/blast_off2.mp3", "stream")
music3 = love.audio.newSource("sound/blast_off3.mp3", "stream")
music4 = love.audio.newSource("sound/blast_off4.mp3", "stream")
music5 = love.audio.newSource("sound/blast_off5.mp3", "stream")
gameover = love.audio.newSource("sound/gameover.mp3", "stream")
EndGame = love.audio.newSource("sound/EndGame.mp3", "stream")
-----------------------audios do jogo------------------------------

------------------------------gameover-----------------------------
fimdejogo = love.graphics.newImage( "imgs/gameover.png")

------------------------------gameover-----------------------------

-------------------------------pause------------------------------
pausar = false
-------------------------------pause------------------------------

end


function love.update()

  lose = Paraquedas:updateParaquedas()
  if pausar == false then
	NUVEM()
  end
end



---------------------------botão de play---------------------------
PLAY = love.graphics.newImage( "imgs/play.png")
---------------------------botão de play---------------------------



---------------------função de pontuação---------------------------
function love.mousepressed(x, y, button, istouch)
  points = points + Paraquedas:checkClickParaquedas(x, y)

  if (points >= nextLevel) then
    Paraquedas:IncNumParaquedas()
    nextLevel = nextLevel + 10
  end

  if (lose == true) then --lose = perder
		Paraquedas:reinit()
		lose = false
		nextLevel = 10
		vida = vida - 1   -----VIDA
		if vida == 0 then
			points = 0
			love.audio.stop()
			love.audio.play(gameover)
		end

		if vida == -1 then
		   love.audio.stop()
		   love.audio.play(music)
		   vida = 5
		end
	end

  if button == 1 and x >= 600 and x < 600 + PLAY:getWidth() and button == 1 and y >= 280 and y < 280 + PLAY:getHeight() then
	actveStartMenu = false  ----------- inicia o Jogo
  end

  if (points >= 20 and points < 40) then -----troca de música-------
	love.audio.stop(music)
	love.audio.play(music2)
	music2:setLooping(true)
  end

  if (points >= 40 and points < 60) then -----troca de música-------
	love.audio.stop(music2)
	love.audio.play(music3)
	music3:setLooping(true)
  end

  if (points >= 60 and points < 80) then -----troca de música-------
	love.audio.stop(music3)
	love.audio.play(music4)
	music4:setLooping(true)
  end

  if (points >= 80 and points < 100) then -----troca de música------
	love.audio.stop(music4)
	love.audio.play(music5)
	music5:setLooping(true)
  end

  if (points >= 100) then ---------------música final---------------
	love.audio.stop(music5)
	love.audio.play(EndGame)
	EndGame:setLooping(true)
	Parabens = true
  end


end

---------------------função de pontuação----------------------------


------------------------------pause--------------------------------
function love.keyreleased( key )
	if key == "p" then
		pausar = not pausar
	end
end
-------------------------------pause------------------------------

------------------------------ volta ao Menu----------------------
function love.keyreleased( key )
	if Parabens == true then
		if key == "m" then
			actveStartMenu = true
		end
	end
end
------------------------------ volta ao Menu----------------------

-------------------------------NUVENS-----------------------------
function NUVEM()
	x = (x+0.5)
  x1 = (x1+0.5)
  x2 = (x2+0.5)
  x3 = (x3+0.5)
  if x3>1366 then
  	x3=0
   elseif x2>1366 then
  	x2=0
   elseif x1>1366 then
  	x1=0
   elseif x>1366 then
  	x=0
  end
end
-------------------------------NUVENS-----------------------------


function love.draw()
	love.graphics.draw( TelaInicial, planoDeFundo.x, planoDeFundo.y )  -----TELA INICIAL
	love.graphics.draw( PLAY, 600, 280 ) -----------------------------------BOTÃO PLAY
	love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )--------MIRA

	if 	Parabens==true then
		love.graphics.draw( TelaFinal, planoDeFundo6.x, planoDeFundo6.y )
	else

		if ( actveStartMenu == true) then
			else
			 love.graphics.draw( fundo, planoDeFundo.x, planoDeFundo.y ) ----- Cenário inicial -----
			 love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )


			if (points >= 20 and points < 40) then ------ troca de cenário ------
				love.graphics.draw( fundo2, planoDeFundo2.x, planoDeFundo2.y )
				love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )
			end

			if (points >= 40 and points < 60) then ------ troca de cenário ------
				love.graphics.draw( fundo3, planoDeFundo3.x, planoDeFundo3.y )
				love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )
			end

			if (points >= 60 and points < 80) then ------ troca de cenário ------
				love.graphics.draw( fundo4, planoDeFundo4.x, planoDeFundo4.y )
				love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )
			end

			if (points >= 80 and points < 100) then ------ troca de cenário ------
				love.graphics.draw( fundo5, planoDeFundo5.x, planoDeFundo5.y )
				love.graphics.draw( imgs, love.mouse.getX(), love.mouse.getY() )
			end



			 love.graphics.draw( imgNuvem, x, y, 0)
			 love.graphics.draw( imgNuvem2, x1, y1, 0)
			 love.graphics.draw( imgNuvem3, x2, y2, 0)
			 love.graphics.draw( imgNuvem4, x3, y3, 0)


			if (lose == false) then
				Paraquedas:drawParaquedas()
			end

			if (vida == 0) then
				love.graphics.draw( fimdejogo , 350, 300 )
			end


			  love.graphics.draw( vidas, 700, 650 ) -------vida coração-----------

			  love.graphics.setColor(255, 0, 0, 255)--------COR DO NOME VIDAS------
			  love.graphics.setFont(love.graphics.newFont(fonteGimmeDanger, 16))
			  love.graphics.print("VIDAS   " .. vida, 570, 650)
			  love.graphics.setColor(0, 0, 0, 0)



			  love.graphics.setColor(0, 0, 0, 255)--------COR DO NOME PONTOS------
			  love.graphics.setFont(love.graphics.newFont(fonteGimmeDanger, 20))
			  love.graphics.print("PONTOS  " .. points, 20, 20)
		end	  love.graphics.setColor(255, 255, 255, 255)
	end

end

