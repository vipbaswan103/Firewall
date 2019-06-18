 /*****************************************RULE BASE*******************************************/

         /*
         NOTE:
                 1) In Rule Base multiple options are present from which client can choose only one.
                 *2) Client needs to pass the unused predicate argument as "null" explicitly.
                 3) The Syntax for a particular option is given in the corresponding comment.
                 4) Protocol names, whenever required, are to be given completely in lowercase.
                 5) Adapter names are to be given in UpperCase only.
                 6) Please consult this Database file before launching engine.
         END OF NOTE
         */

/*Adapter Rules*/
setAdapterClauseList(X):-X="A,B,C,D".   /*Specify Adapters List, Eg: "A,B,J,H" i.e. comma(,) separated list*/
                                        /*For a single Adapter, just pass that letter, Eg:- "A"*/
setAdapterClauseRange(X):-X="null".     /*Specify a Range (use - as separator), Eg:- "A-P"*/
setAdapterClauseAny(X):-X="null".       /*Specify 'any', Eg: "any"*/


getAdapterListList(L):-setAdapterClauseList(X),split_string(X,","," ",L).
getAdapterRangeList(L):-setAdapterClauseRange(X),split_string(X,"-"," ",L).

/*Ethernet rules*/
setEthClauseProto(X):-X="null".           /*Specify Protocols */
setEthClauseVidRange(X):-X="null".        /*Specify Vid as Lis, Eg:-"1,2,3"  OR   Eg:- "1"*/
setEthClauseVidList(X):-X="null".         /*Specify Vid as a Range, Eg:- "25-40" */
setEthClauseCom1(X):-X="25-40,255".       /*Both VID_Range and protocol allowed (Format: Vid_Range,Protocol_name)
                                            If you want to pass only one value for VID, simple pass like 10-10 means 10 is passed
                                            Eg:- "10-20,10,255" here 10-20 is VIDRange and 10,255 are allowed Protocols(can be one or                                            multiple).
                                            Only Decimal is Allowed
                                           */

getEthListProto(L):-setEthClauseProto(X),split_string(X,","," ",L).
getEthListVidRange(L):-setEthClauseVidRange(X),split_string(X,","," ",L).
getEthListCom1(L):-setEthClauseCom1(X),split_string(X,"-,"," ",L).
getEthListVidList(L):-setEthClauseVidList(X), split_string(X,"-"," ",L).

/*IPv4 Rules*/
setIpv4ClauseSrc(X):-X="null".      /*Specify Source address*/
setIpv4ClauseDst(X):-X="null".      /*Specify Destination Address*/
setIpv4ClauseProto(X):-X="null".    /*Specify Protocol Type, Eg: tcp*/
setIpv4ClauseCom1(X):-X="null".     /*Specify Combination as "Src adr, Dest adr" Eg: "172.24.16.31, 172.24.16.45"*/
setIpv4ClauseCom2(X):-X="172.24.16.31,172.24.16.35,udp".    /*Specify Combination as "Src adr, Dest adr, Protocol_type" */

getIpv4ListCom1(L):-setIpv4ClauseCom1(X),split_string(X,","," ",L).
getIpv4ListCom2(L):-setIpv4ClauseCom2(X),split_string(X,","," ",L).

/*TCP Rules*/
setTcpSrc(X):-X="null".            /*Specify Source Port Number*/
setTcpDest(X):-X="null".            /*Specify Destination Port Number*/
setTcpCom(X):-X="null".            /*Specify Combination:- Eg: "1234, 4536" where 1234 is Src_Port and 4536 is Dst_Port*/
getTcpListCom(L):-setTcpCom(X),split_string(X,","," ",L).

/*UDP Rules*/
setUdpSrc(X):-X="null".             /*Specify Souce Port Number*/
setUdpDest(X):-X="null".            /*Specify Destination Port Number*/
setUdpCom(X):-X="13,133".           /*Specify Combination:- Eg: "1234, 4536" where 1234 is Src_Port and 4536 is Dst_Port*/
getUdpListCom(L):-setUdpCom(X),split_string(X,","," ",L).

/*ICMP Rules*/
setIcmpType(X):-X="null".            /*Specify ICMP type*/
setIcmpCode(X):-X="null".           /*Specify ICMP Code*/
setIcmpCom(X):-X="null".            /*Specify Combination:- Eg: "154,123" where 154 is ICMP_Type and 123 is ICMP_Code*/
getIcmpListCom(L):-setIcmpCom(X), split_string(X,","," ",L).













