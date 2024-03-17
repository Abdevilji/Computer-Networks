set ns [new Simulator] 
 
set mytrace [open l7p0.tr w] 
$ns trace-all $mytrace 
 
set mynAM [open l7p0.nam w] 
$ns namtrace-all $mynAM 
 
proc finish {} { 
    global ns mynAM mytrace 
    $ns flush-trace 
    close $mynAM 
    close $mytrace 
    exec nam l7p0.nam & 
    exit 0 
} 
 
$ns color 1 Teal 
$ns color 2 Magenta 
$ns color 3 Gold 
 
set n0 [$ns node] 
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node] 
set n4 [$ns node] 
set n5 [$ns node] 
set n6 [$ns node] 
set n7 [$ns node] 
 
$ns duplex-link $n3 $n2 1Mb 10ms DropTail 
$ns duplex-link-op $n3 $n2 orient left-up 
 
$ns duplex-link $n3 $n1 1Mb 10ms DropTail 
$ns duplex-link-op $n3 $n1 orient left 
 
$ns duplex-link $n3 $n0 1Mb 10ms DropTail 
$ns duplex-link-op $n3 $n0 orient left-down 
 
$ns duplex-link $n3 $n4 1Mb 10ms DropTail 
$ns duplex-link-op $n3 $n4 orient right 
 
$ns duplex-link $n4 $n5 1Mb 10ms DropTail 
$ns duplex-link-op $n4 $n5 orient right-up 
 
$ns duplex-link $n4 $n6 1Mb 10ms DropTail 
$ns duplex-link-op $n4 $n6 orient right 
 
$ns duplex-link $n4 $n7 1Mb 10ms DropTail 
$ns duplex-link-op $n4 $n7 orient right-down 
 
set udp0 [new Agent/UDP] 
$ns attach-agent $n0 $udp0 
set null5 [new Agent/Null] 
$ns attach-agent $n5 $null5 
$ns connect $udp0 $null5 
$udp0 set fid_ 1 
 
set cbr0 [new Application/Traffic/CBR] 
$cbr0 attach-agent $udp0 
$cbr0 set type_ CBR 
$cbr0 set packet_size_ 500 
$cbr0 set rate_ 800kb 
$cbr0 set random_ false 
 
set udp1 [new Agent/UDP] 
$ns attach-agent $n1 $udp1 
set null6 [new Agent/Null] 
$ns attach-agent $n6 $null6 
$ns connect $udp1 $null6 
$udp1 set fid_ 2 
 
set cbr1 [new Application/Traffic/CBR] 
$cbr1 attach-agent $udp1 
$cbr1 set type_ CBR 
$cbr1 set packet_size_ 500 
$cbr1 set rate_ 800kb 
$cbr1 set random_ false 
 
set udp2 [new Agent/UDP] 
$ns attach-agent $n2 $udp2 
set null7 [new Agent/Null] 
$ns attach-agent $n7 $null7 
$ns connect $udp2 $null7 
$udp2 set fid_ 3 
 
set cbr2 [new Application/Traffic/CBR] 
$cbr2 attach-agent $udp2 
$cbr2 set type_ CBR 
$cbr2 set packet_size_ 500 
$cbr2 set rate_ 800kb 
$cbr2 set random_ false 
 
$ns at 1.0 "$cbr0 start" 
$ns at 1.5 "$cbr1 start" 
$ns at 1.8 "$cbr2 start" 
 
$ns at 4.0 "$cbr0 stop" 
$ns at 4.2 "$cbr1 stop" 
$ns at 4.5 "$cbr2 stop" 
$ns at 5.0 "finish" 
$ns run 
