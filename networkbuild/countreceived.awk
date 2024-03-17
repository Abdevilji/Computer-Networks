BEGIN   { 
    packet_size = 0; 
    udp5 = 0; 
    udp7 = 0; 
    udp6 = 0; 
}{ 
    packet_type_identifier = $1 
    destination_node = $4 
    packet_size = $6 
 
    if (packet_type_identifier == "r") { 
        if (destination_node=="5") { 
            udp5++; 
        } 
        else if (destination_node=="7") { 
            udp7++; 
        } 
        else if (destination_node=="6") { 
            udp6++; 
        } 
    } 
} 
END { 
    printf("No. of packets received at node5: 
%d\nThroughput at node5: %dbps\n\n",udp5, 
(udp5*packet_size/5)); 
    printf("No. of packets received at node6: 
%d\nThroughput at node6: %dbps\n\n",udp6, 
(udp6*packet_size/5)); 
    printf("No. of packets received at node7: 
%d\nThroughput at node7: %dbps\n",udp7, 
(udp7*packet_size/5)); 
} 