				/*******************************RULE BASE:*****************************/

/*NOTE:
                   1) In Rule Base multiple options are present from which client can choose only one.
                  *2) Client needs to pass the unused predicates parameters as "null" 'explicitly'.
                   3) The Syntax for a particular option is given in the corresponding comment.
                   4) Protocol names, whenever required, are to be given completely in lowercase, like tcp,udp,icmp.
		 **5) There is a sequence of validation,
			Firstly adapter is checked
			Then ethernet
			Then ipv4
			Then protocol
		If anyone of the first three fails according to rule base (fails only when packet doesn't satisfy one or more arguments given in rule base),
		packet is rejected and first unmatch encountered is cited as the reason for rejection.
		If protocol's argument, packet is dropped silently with no ouptput.
		Otherwise, packet is accepted.
		   6) Please Consult Database before launching engine.
END OF NOTE*/
         
PREDICATES:

===================================FOR ADAPTER==========================================================
setAdapterClauseList(X) :- 	Used to Specify Adapters List, Eg: "A,B,J,H" i.e comma(,) seperated list.
				If you wish to pass only a single adpater simply pass "<Name>". Eg:- "A"

setAdapterClauseRange(X) :- 	Used to Specify a Range (use - as separator), Eg:- "A-P". 
				For L-H range L must be less than or equal to H

setAdapterClauseAny(X) :- 	Used to Specify 'any', Eg: "any".

===================================FOR ETHERNET==========================================================
setEthClauseProto(X) :- 	Used to set the protocols (packets corresponding to these protocols will be blocked). 
				Only one Number System(Decimal) is being used in this program, hence adhere to that.
				Syntax:-  For a list pass a comma-separated string. Eg:- "0,5,255" OR "5"

setEthClauseVid(X) :-   	Used to set the VID values as a list.
				Syntax:-  "1,2,3" OR "7"

setEthClauseVidRange(X) :- 	Used to set VID as a range.
			 	Syntax:- "25-40" 
				Note: L-H range must be such that L<=H

setEthClauseCom1(X) :- 		Used to set a combination of Protocols and VID values.
				Syntax:- "25-40,95" where 25-40 is VID range and 95 is Protocol number in Decimal

==================================FOR IPV4===============================================================
			
setIpv4ClauseSrc(X) :- 		Used to Specify Source address. Eg: 172.24.16.31

setIpv4ClauseDst(X) :- 		Used to Specify Destination Address. Eg: 172.24.16.87

setIpv4ClauseProto(X) :- 	Used to Specify Protocol Type, Eg: tcp.
				Note:- Please pass the protocols as "lowercase" only

setIpv4ClauseCom1(X) :- 	Used to Specify Combination as "Src adr, Dest adr" Eg: "172.24.16.31, 172.24.16.45".

setIpv4ClauseCom2(X) :- 	Used to Specify Combination as "Src adr, Dest adr, Protocol_type". 
				Eg: "172.24.16.31, 172.24.16.45, tcp"


==================================FOR TCP==================================================================
	NOTE: 	Port numbers must be between 0 and 65535 (both inclusive)
setTcpSrc(X) :- 		Used to Specify Source Port Number. Eg: "34"
setTcpDest(X) :- 		Used to Specify Destination Port Number.  Eg: "87"
setTcpCom(X) :- 		Used to Specify Combination:- Eg: "1234, 4536" where 1234 is Src_Port and 4536 is Dst_Port.

==================================FOR UDP===================================================================
	NOTE: 	Port numbers must be between 0 and 65535 (both inclusive)
setUdpSrc(X) :- 		Used to Specify Souce Port Number. Eg: "56"
setUdpDest(X) :- 		Used to Specify Destination Port Number. Eg: "67"
setUdpCom(X) :- 		Used to Specify Combination:- Eg: "1234, 4536" where 1234 is Src_Port and 4536 is Dst_Port.

==================================FOR ICMP==================================================================
	Note: 	ICMP Type must be decimal number between 0 and 255 (both inclusive) acc to IANA
		ICMP Code must be decimal number between 0 and 254 (both inclusive) acc to IANA

setIcmpType(X) :- 		Used to Specify ICMP type. Eg:"123"
setIcmpCode(X) :- 		Used to Specify ICMP Code. Eg:"354"
setIcmpCom(X) :- 		Used to Specify Combination:- Eg: "243,123" where abc is ICMP_Type and 123 is ICMP_Code.


=================================================INPUT=====================================================
INPUT:
1)	Launch Engine using printResult command. (?- printResult.)
2)	Enter the packet details exatly in the same format as given below.

OUTPUT:
1)	Accepted!! -> If all the parameters of the packet match the rule base
2)	Rejected if Adpater and/or Ethernet and/or IPV4 rules for packet don't match the rule base
3)	(No output (Like: true.)) This means your packet was silently dropped because the protocol (TCP/UDP/ICMP) arguments for the packet didn't match the rule base

INPUT_SYNTAX:
1) Must be passed in double quotes
2) Compulsory to pass all parameters as stated below

"<Adapter_Type>#<Ethernet_VID>,<Ethernet_Protocol>#<IP_Src_Address>,<IP_Dest_Address>,<IP_Protocol_Type>#<X>,<Y>".
 where
 <X>=<Tcp_Scr> and <Y>=<Tcp_Dest> when <IP_Protocol_Type>=tcp
 <X>=<Udp_Scr> and <Y>=<Udp_Dest> when <IP_Protocol_Type>=udp
 <X>=<Icmp_Type> and <Y>=<Icmp_Code> when <IP_Protocol_Type>=icmp
 
Note: It is expected the user will enter a valid IP Protocol Type, otherwise packet is dropped or rejected by the program


