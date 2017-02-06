BEGIN {
	itvl = 0.5
	t = itvl;
	through = 0;
	f1 = "throughput.tr"
}
{
	action = $1;
	time = $2;
	from = $3;
	to = $4;
	#type = $5;
	pktsize = $6;
	flow_id = $8;
	src = $9;
	dst = $10;
	seq_no = $11;
	packet_id = $12;
	if (from == "3" && to == "4" && action="+"){
		if(time < t){
			through++;
		}else {
			through = through/itvl;
			printf("%f %f\n", t, through);
			t = t + itvl;
			through = 0;
		}
	}
}
END {

}