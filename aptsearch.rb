require 'rubygems'
require 'mechanize'

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'


open('apartments.txt','w') { |f|


startpage = 1
lastpage = 10

curpage = startpage

naked_url_prefix = "http://www.nakedapartments.com/renter/listings/search?broker_id=&bid=2&nids=169%2C170%2C36%2C30%2C37%2C31%2C38%2C32%2C33%2C34%2C39%2C43%2C127%2C27%2C94%2C28%2C134%2C88%2C40%2C35%2C44%2C47&aids=3&baths=1&min_rent=&max_rent=1850&amids=0&pets=&move_date=07%2F01%2F2013&page="



	# puts url_to_get

for curpage in startpage..lastpage

		# page = agent.get('http://www.webtnder.com/db/drink/'+i.to_s())

		page = agent.get(naked_url_prefix+curpage.to_s)

		#page = agent.get('http://google.com')


		listings_array =  page.search('//h3/a')


	#	aptpage = agent.get(listings_array[0].attribute("href").to_s)

		listings_array.each do |thislisting|
			#print thislisting
			
			aptpage = agent.get(thislisting.attribute("href").to_s)

			
			myfields = aptpage.search("/html/body[@id='listingDetail']/div[@id='wrapper']/div[@id='listingContent']/div[@id='rightCol']/div[@id='overview']/table[@id='listingOverview']/tr")
			whatdate = "X"
			isForJuly = false
			myfields.each do |thisfield|
				if thisfield.children[0].content.to_s == "Available:"
					whatdate = thisfield.children[2].content.to_s
					print whatdate + "\n"
					if whatdate.count("Jul") == 3
						#print "true"
						isForJuly = true
					else
						#print "false"
						isForJuly = false
					end

				end
			end

			# print(whatdate)
			if isForJuly
				print thislisting.attribute("href").to_s + "\n"
				f << thislisting.attribute("href").to_s << "\n"
			end


		end



		#ingredients_array = []
		#ingredients_nodes = page.search("/html/body/table[1]/tr/td[1]/ul/li")

		#instructions_node = page.search("/html/body/table[1]/tr/td[1]/p")


		#ingredients_nodes.each do |thisnode|
		#	ingredients_array.push(thisnode.content.gsub("\n",''))
		#end

		
end


}

#puts title_str
#puts info_array

#puts ingredients_array