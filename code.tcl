set ns [new Simulator] 
$ns color 1 Red 
set myNAM [open lol.nam w] 
$ns namtrace-all $myNAM 
set mytrace [open lol.tr w] 
$ns trace-all $mytrace 
proc finish {} { 
global ns myNAM mytrace 
$ns flush-trace 
close $myNAM 
close $mytrace 
exec nam lol.nam & 
exit 0 
} 
set n0 [$ns node] 
set n1 [$ns node] 
$ns at 0.0 "$n0 label Sender " 
$ns at 0.0 "$n1 label Receiver " 
$ns duplex-link $n0 $n1 1Mb 20ms DropTail 
$ns duplex-link-op $n0 $n1 orient right 
set tcp [new Agent/TCP] 
$ns attach-agent $n0 $tcp 
$tcp set fid_ 1 
$tcp set window_ 1 
$tcp set maxcwnd_ 1 
set sink [new Agent/TCPSink] 
$ns attach-agent $n1 $sink 
$ns connect $tcp $sink 
set ftp [new Application/FTP] 
$ftp attach-agent $tcp 
$ns at 0.5 "$ftp start" 
$ns at 4.5 "$ftp stop" 
$ns at 5.0 "finish" 
$ns run