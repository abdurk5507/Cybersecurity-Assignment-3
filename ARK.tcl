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

#Routers
set router01 [$ns node]
      puts "router01: [$router01 id]"

set router02 [$ns node]
	puts "router02: [$router02 id]"

set router03 [$ns node]
	puts "router03: [$router03 id]"	

set router04 [$ns node]
	puts "router04: [$router04 id]"	

#Users
set user01 [$ns node]
      puts "user01: [$user01 id]"

set user02 [$ns node]
	puts "user02: [$user02 id]"

#Server
set WebServer [$ns node]
      puts "WebServer: [$WebServer id]"


#Router Shapes
$router01 shape hexagon
$router02 shape hexagon
$router03 shape hexagon
$router04 shape hexagon

#Bot color and label
$bot01 color red
$bot01 label "Bot1"

$bot02 color red
$bot02 label "Bot2"

#User Color and Label
$user01 color green
$user01 label "User1"

$user02 color green
$user02 label "User2"

#Server color and label
$WebServer color blue
$WebServer label "Web Server"


#
#Setup Connections
#

$ns duplex-link $bot01 $router01 950kb 5ms RED
$ns duplex-link $bot02 $router01 950kb 5ms RED

$ns duplex-link $user01 $router01 950kb 5ms RED
$ns duplex-link $user02 $router02 950kb 5ms RED

$ns duplex-link $router01 $router03 950kb 5ms RED
$ns duplex-link $router02 $router03 950kb 5ms RED
$ns duplex-link $router03 $router04 950kb 5ms RED

$ns duplex-link $router01 $WebServer 950kb 5ms RED
$ns duplex-link-op $router01 $WebServer color purple
$ns duplex-link-op $router01 $WebServer label "Target Link 1"


#
#Set up Transport Level Connections
#
set null_WebServer [new Agent/Null]
$ns attach-agent $WebServer $null_WebServer

set udp_bot01 [new Agent/UDP]
$ns attach-agent $bot01 $udp_bot01

set udp_bot02 [new Agent/UDP]
$ns attach-agent $bot02 $udp_bot02

set udp_user01 [new Agent/UDP]
$ns attach-agent $user01 $udp_user01

set udp_user02 [new Agent/UDP]
$ns attach-agent $user02 $udp_user02


#
#Setup traffic sources
#
set cbr_bot01 [new Application/Traffic/CBR]
$cbr_bot01 set rate_ 500Kb
$cbr_bot01 attach-agent $udp_bot01


set cbr_bot02 [new Application/Traffic/CBR]
$cbr_bot02 set rate_ 500Kb
$cbr_bot02 attach-agent $udp_bot02

set cbr_user01 [new Application/Traffic/CBR]
$cbr_user01 set rate_ 100Kb
$cbr_user01 attach-agent $udp_user01

set cbr_user02 [new Application/Traffic/CBR]
$cbr_user02 set rate_ 100Kb 
$cbr_user02 attach-agent $udp_user02


#connect traffic sources to traffic destination (for CBR components, the destination is defined as a NULL component)
$ns connect $udp_bot01 $null_WebServer
$ns connect $udp_bot02 $null_WebServer
$ns connect $udp_user01 $null_WebServer
$ns connect $udp_user02 $null_WebServer

#define colors for traffic types (bot vs. user)
$ns color 1 green
$ns color 2 red

#sets udp_bot01 and udp_bot02 traffic color to red
$udp_bot01 set fid_ 2
$udp_bot02 set fid_ 2

# set udp_user01 (user) traffic color to green
$udp_user01 set fid_ 1 
$udp_user02 set fid_ 1

#
#Start up the sources
#

$ns set-animation-rate 3ms

$ns at 0 "$cbr_bot01 start" 
#start cbr_bot01 at time 0
$ns at 0 "$cbr_bot02 start"
$ns at 1 "$cbr_user01 start"
$ns at 1 "$cbr_user02 start"

$ns at 10.0 "finish"
#end simulation after 10 seconds

$ns run