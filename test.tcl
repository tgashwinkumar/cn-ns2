
set ns [new Simulator]
 
$ns color 1 Blue
$ns color 2 Red
 

set nf [open out.nam w]
$ns namtrace-all $nf
 

proc finish {} {
    global ns nf
    $ns flush-trace
     

    close $nf
     

    exec nam out.nam &
    exit 0
}
 
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]


$ns duplex-link $n0 $n1 2Mb 10ms DropTail
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n0 $n3 2Mb 10ms DropTail
$ns duplex-link $n0 $n4 2Mb 10ms DropTail
$ns duplex-link $n0 $n5 2Mb 10ms DropTail

 
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
 
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp $sink1

set sink2 [new Agent/TCPSink]
$ns attach-agent $n1 $sink2
$ns connect $tcp $sink2

set sink3 [new Agent/TCPSink]
$ns attach-agent $n1 $sink3
$ns connect $tcp $sink3

set sink4 [new Agent/TCPSink]
$ns attach-agent $n1 $sink4
$ns connect $tcp $sink4

set sink5 [new Agent/TCPSink]
$ns attach-agent $n1 $sink5
$ns connect $tcp $sink5

$tcp set fid_ 1

$ns at 0.1 "$ftp start"
$ns at 4.0 "$ftp stop"
$ns at 5.0 "finish"
 
 
$ns run