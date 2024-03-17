set ns [new Simulator] 
#Tell the simulator to use dynamic rou ng 
$ns rtproto DV 
$ns macType Mac/Sat/Unslo edAloha 
#Open the nam trace file 
set nf [open aloha.nam w] 
 
 
$ns namtrace-all $nf 
#Open the output files 
set tr [open aloha.tr w] 
$ns trace-all $tr 
#Define a finish procedure 
proc finish {} { 
global ns tr nf 
$ns flush-trace 
#Close the trace file 
close $tr 
close $nf 
exec nam aloha.nam & 
exit 0 
} 
# Create fournodes 
set n0 [$ns node] 
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node] 
# Create duplex links between nodes with bandwidth and 
distance 
$ns duplex-link $n0 $n1 10Mb 10ms DropTail 
 
 
$ns duplex-link $n1 $n2 10Mb 10ms DropTail 
$ns duplex-link $n2 $n3 10Mb 10ms DropTail 
$ns duplex-link $n3 $n0 10Mb 10ms DropTail 
$ns duplex-link-op $n0 $n1 orient right 
$ns duplex-link-op $n1 $n2 orient down 
$ns duplex-link-op $n2 $n3 orient le 
$ns duplex-link-op $n3 $n0 orient up 
set tcp0 [new Agent/TCP] 
$ns a ach-agent $n0 $tcp0 
set p [new Applica on/FTP] 
$ p a ach-agent $tcp0 
set sink [new Agent/TCPSink] 
$ns a ach-agent $n2 $sink 
$ns connect $tcp0 $sink 
#Schedule events for the p agent and the network 
dynamics 
$ns at 0.5 "$ p start" 
$ns rtmodel-at 1.0 down $n0 $n1 
$ns rtmodel-at 3.0 up $n0 $n1 
$ns at 4.5 "$ p stop" 
#Call the finish procedure a er 5 seconds of simula on me 
$ns at 5.0 "finish" 
 
 
#Run the simula on 
$ns run