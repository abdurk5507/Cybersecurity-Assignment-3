# Creating New Simulator
set ns [new Simulator]

# Setting up the traces
set f [open out.tr w]
set nf [open out.nam w]
$ns namtrace-all $nf
$ns trace-all $f
proc finish {} { 
	global ns nf f
	$ns flush-trace
	puts "Simulation completed."
	close $nf
	close $f
	exit 0
}


#Create Nodes
#Bots
set bot01 [$ns node]
      puts "bot01: [$bot01 id]"

set bot02 [$ns node]
      puts "bot02: [$bot02 id]"

set bot03 [$ns node]
      puts "bot03: [$bot03 id]"

set bot04 [$ns node]
      puts "bot04: [$bot04 id]"

set bot05 [$ns node]
      puts "bot05: [$bot05 id]"

set bot06 [$ns node]
      puts "bot06: [$bot06 id]"

set bot07 [$ns node]
      puts "bot07: [$bot07 id]"

#Routers
set router01 [$ns node]
      puts "router01: [$router01 id]"

set router02 [$ns node]
	puts "router02: [$router02 id]"

set router03 [$ns node]
	puts "router03: [$router03 id]"	

set router04 [$ns node]
	puts "router04: [$router04 id]"	

set router05 [$ns node]
	puts "router05: [$router05 id]"	

set router06 [$ns node]
	puts "router06: [$router06 id]"	

set router07 [$ns node]
	puts "router07: [$router07 id]"	

#Users
set user01 [$ns node]
      puts "user01: [$user01 id]"

set user02 [$ns node]
	puts "user02: [$user02 id]"

set user03 [$ns node]
	puts "user03: [$user03 id]"

set user04 [$ns node]
	puts "user04: [$user04 id]"


#Server
set WebServer [$ns node]
      puts "WebServer: [$WebServer id]"


#Router Shapes
$router01 shape hexagon
$router02 shape hexagon
$router03 shape hexagon
$router04 shape hexagon
$router05 shape hexagon
$router06 shape hexagon
$router07 shape hexagon

#Bot color and label
$bot01 color red
$bot01 label "Bot1"

$bot02 color red
$bot02 label "Bot2"

$bot03 color red
$bot03 label "Bot3"

$bot04 color red
$bot04 label "Bot4"

$bot05 color red
$bot05 label "Bot5"

$bot06 color red
$bot06 label "Bot6"

$bot07 color red
$bot07 label "Bot7"

#User Color and Label
$user01 color green
$user01 label "User1"

$user02 color green
$user02 label "User2"

$user03 color green
$user03 label "User3"

$user04 color green
$user04 label "User4"

#Server color and label
$WebServer color blue
$WebServer label "Web Server"


#
#Setup Connections
#

#Bot to router
$ns duplex-link $bot01 $router01 4Mb 5ms RED
$ns duplex-link $bot02 $router02 4Mb 5ms RED
$ns duplex-link $bot03 $router03 4Mb 5ms RED
$ns duplex-link $bot04 $router04 4Mb 5ms RED
$ns duplex-link $bot05 $router05 4Mb 5ms RED
$ns duplex-link $bot06 $router06 4Mb 5ms RED
$ns duplex-link $bot07 $router07 4Mb 5ms RED

#User to router
$ns duplex-link $user01 $router01 4Mb 5ms RED
$ns duplex-link $user02 $router02 4Mb 5ms RED
$ns duplex-link $user03 $router06 4Mb 5ms RED
$ns duplex-link $user04 $router05 4Mb 5ms RED

#Router to router
$ns duplex-link $router01 $router03 4Mb 5ms RED
$ns duplex-link $router02 $router03 4Mb 5ms RED
$ns duplex-link $router03 $router04 4Mb 5ms RED
$ns duplex-link $router04 $router05 4Mb 5ms RED
$ns duplex-link $router04 $router06 4Mb 5ms RED
$ns duplex-link $router05 $router07 4Mb 5ms RED
$ns duplex-link $router06 $router07 4Mb 5ms RED

#Router to server
$ns duplex-link $router07 $WebServer 4Mb 5ms RED
$ns duplex-link-op $router07 $WebServer color purple
$ns duplex-link-op $router07 $WebServer label "Target Link 1"


#
#Set up Transport Level Connections
#
set null_WebServer [new Agent/Null]
$ns attach-agent $WebServer $null_WebServer

set udp_bot01 [new Agent/UDP]
$ns attach-agent $bot01 $udp_bot01

set udp_bot02 [new Agent/UDP]
$ns attach-agent $bot02 $udp_bot02

set udp_bot03 [new Agent/UDP]
$ns attach-agent $bot03 $udp_bot03

set udp_bot04 [new Agent/UDP]
$ns attach-agent $bot04 $udp_bot04

set udp_bot05 [new Agent/UDP]
$ns attach-agent $bot05 $udp_bot05

set udp_bot06 [new Agent/UDP]
$ns attach-agent $bot06 $udp_bot06

set udp_bot07 [new Agent/UDP]
$ns attach-agent $bot07 $udp_bot07

set udp_user01 [new Agent/UDP]
$ns attach-agent $user01 $udp_user01

set udp_user02 [new Agent/UDP]
$ns attach-agent $user02 $udp_user02

set udp_user03 [new Agent/UDP]
$ns attach-agent $user03 $udp_user03

set udp_user04 [new Agent/UDP]
$ns attach-agent $user04 $udp_user04


#
#Setup traffic sources
#
set cbr_bot01 [new Application/Traffic/CBR]
$cbr_bot01 set rate_ 1Mb
$cbr_bot01 attach-agent $udp_bot01

set cbr_bot02 [new Application/Traffic/CBR]
$cbr_bot02 set rate_ 1Mb
$cbr_bot02 attach-agent $udp_bot02

set cbr_bot03 [new Application/Traffic/CBR]
$cbr_bot03 set rate_ 1Mb
$cbr_bot03 attach-agent $udp_bot03

set cbr_bot04 [new Application/Traffic/CBR]
$cbr_bot04 set rate_ 1Mb
$cbr_bot04 attach-agent $udp_bot04

set cbr_bot05 [new Application/Traffic/CBR]
$cbr_bot05 set rate_ 1Mb
$cbr_bot05 attach-agent $udp_bot05

set cbr_bot06 [new Application/Traffic/CBR]
$cbr_bot06 set rate_ 1Mb
$cbr_bot06 attach-agent $udp_bot06

set cbr_bot07 [new Application/Traffic/CBR]
$cbr_bot07 set rate_ 1Mb
$cbr_bot07 attach-agent $udp_bot07

set cbr_user01 [new Application/Traffic/CBR]
$cbr_user01 set rate_ 100Kb
$cbr_user01 attach-agent $udp_user01

set cbr_user02 [new Application/Traffic/CBR]
$cbr_user02 set rate_ 100Kb 
$cbr_user02 attach-agent $udp_user02

set cbr_user03 [new Application/Traffic/CBR]
$cbr_user03 set rate_ 100Kb
$cbr_user03 attach-agent $udp_user03

set cbr_user04 [new Application/Traffic/CBR]
$cbr_user04 set rate_ 100Kb 
$cbr_user04 attach-agent $udp_user04



#connect traffic sources to traffic destination (for CBR components, the destination is defined as a NULL component)
$ns connect $udp_bot01 $null_WebServer
$ns connect $udp_bot02 $null_WebServer
$ns connect $udp_bot03 $null_WebServer
$ns connect $udp_bot04 $null_WebServer
$ns connect $udp_bot05 $null_WebServer
$ns connect $udp_bot06 $null_WebServer
$ns connect $udp_bot07 $null_WebServer

$ns connect $udp_user01 $null_WebServer
$ns connect $udp_user02 $null_WebServer
$ns connect $udp_user03 $null_WebServer
$ns connect $udp_user04 $null_WebServer

#define colors for traffic types (bot vs. user)
$ns color 1 green
$ns color 2 red

#sets udp_bot01 and udp_bot02 traffic color to red
$udp_bot01 set fid_ 2
$udp_bot02 set fid_ 2
$udp_bot03 set fid_ 2
$udp_bot04 set fid_ 2
$udp_bot05 set fid_ 2
$udp_bot06 set fid_ 2
$udp_bot07 set fid_ 2

# set udp_user01 (user) traffic color to green
$udp_user01 set fid_ 1 
$udp_user02 set fid_ 1
$udp_user03 set fid_ 1
$udp_user04 set fid_ 1

#
#Start up the sources
#

$ns set-animation-rate 3ms

$ns at 0 "$cbr_bot01 start" 
#start cbr_bot01 at time 0
$ns at 0 "$cbr_bot02 start"
$ns at 0 "$cbr_bot03 start"
$ns at 0 "$cbr_bot04 start"
$ns at 0 "$cbr_bot05 start"
$ns at 0 "$cbr_bot06 start"
$ns at 0 "$cbr_bot07 start"

$ns at 1 "$cbr_user01 start"
$ns at 1 "$cbr_user02 start"
$ns at 1 "$cbr_user03 start"
$ns at 1 "$cbr_user04 start"

$ns at 10.0 "finish"
#end simulation after 10 seconds

$ns run