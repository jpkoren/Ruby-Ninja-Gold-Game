require 'sinatra'
enable :sessions

get '/' do
	if session[:activities] == nil
		session[:activities] = []
		session[:gold] = 0
	end

	@gold = session[:gold]
	@activities = session[:activities].reverse
	@@time = Time.new
	erb :index
end

post '/farm' do
	@rand = rand(10..20)
	@activities = "<span class='green'>Earned #{@rand} gold from the farm!"
	updateGold
end

post '/cave' do
	@rand = rand(5..10)
	@activities = "<span class='green'>Earned #{@rand} gold from the cave!"
	updateGold
end

post '/house' do
	@rand = rand(2..5)
	@activities = "<span class='green'>Earned #{@rand} gold from the house!"
	updateGold
end

post '/casino' do
	@rand = rand(-50..50)
	if @rand >= 0
		@activities = "<span class ='green'>Earned #{@rand} gold from the casino!"
	else
		@activities = "<span class ='red'>Lost #{-@rand} gold from the casino!"
	end
	updateGold
end

def updateGold
	@timestamp = @@time.strftime('%m/%d/%Y %l:%M %p')
	@activities += "(#{@timestamp})"
	session[:gold] += @rand
	session[:activities].push(@activities)
	redirect '/'
end

get '/reset' do
	session[:activities] = nil
	session[:gold] = nil
	redirect '/'
end
