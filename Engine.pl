   /***********************************************ENGINE************************************************/
/*Input*/
/*Input is purely handled by the engine*/

main(X):-print("Enter the packet: "),nl,read(X).


tokenizeFirst(L):-main(X),split_string(X,"#"," ",L).


/* will check which client wants to implement*/
decisionAdap(F):-setAdapterClauseList(X),setAdapterClauseRange(Y),setAdapterClauseAny(Z),
                                                            (X\="null" -> F=1;
                                                             Y\="null" -> F=2;
                                                             Z\="null" -> F=3;
                                                             F=0).

/*check adpater's validity*/
checkAdapValidity(L,Op):-nth1(1,L,Inp),decisionAdap(F),
                                                 (F=:=0 -> (Op=true);
                                                  F=:=1 -> (getAdapterListList(B), member(Inp,B) -> Op=true;
                                                                                                    Op=false);
                                                  F=:=2 ->(getAdapterRangeList(C), nth1(1,C,Lower),nth1(2,C,Upper),
                                                           ((Lower=<Inp, Inp=<Upper) -> Op=true;
                                                                           Op=false));
                                                  F=:=3 -> Op=true;
                                                  Op=false).

/* will check which client wants to implement*/
decisionEth(F):-setEthClauseProto(X),setEthClauseVidList(Y),setEthClauseVidRange(Z),setEthClauseCom1(W),( X\="null" -> F=1;
                                                                              Y\="null" -> F=2;
                                                                              Z\="null" -> F=3;
                                                                              W\="null" -> F=4;
                                                                              F=0
                                                                            ).
/*check ethernet's validity*/
checkEthValidity(L,Op):-decisionEth(F), (F=:=0 -> Op=true;
                                 F=:=1 -> getEthListProto(B), ((nth1(2,L,X),member(X,B)) -> Op=true; Op=false);
                                 F=:=2 -> getEthListVidList(C), nth1(1,L,P), ((member(P,C) -> Op=true;
                                                                              Op=false));
                                 F=:=3 -> getEthListVidRange(C), nth1(1,L,P), nth1(1,C,Lower), nth1(2,C,Upper),
                                                     (   (Lower=<P, P=<Upper) -> Op=true;
                                                          Op=false);
                                 F=:=4 -> getEthListCom1(D), nth1(2,L,P), nth1(1,L,V), nth1(1,D,Lo), nth1(2,D,Up),
                                                    atom_number(Lo,Low),atom_number(Up,U),atom_number(V,Vi),
                                                     ( (member(P,D),Low=<Vi, Vi=<U)-> Op=true;
                                                                      Op=false);
                                 Op=false
                                        ).

/* will check which client wants to implement*/
decisionIPV4(F):-setIpv4ClauseSrc(X),setIpv4ClauseDst(Y),setIpv4ClauseProto(A),setIpv4ClauseCom1(B),
                 setIpv4ClauseCom2(C),(X\="null" -> F=1;
                                       Y\="null" -> F=2;
                                       A\="null" -> F=3;
                                       B\="null" -> F=4;
                                       C\="null" -> F=5;
                                       F=0).

/*check ipv4's validity*/
checkIPV4Validity(L,Op):-decisionIPV4(F),(F=:=0 -> Op=false;
                                          F=:=1 -> setIpv4ClauseSrc(X), (nth1(1,L,X)-> Op=true; Op=false);
                                          F=:=2 -> setIpv4ClauseDst(Y), (nth1(2,L,Y)-> Op=true; Op=false);
                                          F=:=3 -> setIpv4ClauseProto(A), (nth1(3,L,A)-> Op=true;Op=false);
                                          F=:=4 -> getIpv4ListCom1(B), nth1(1,B,H),nth1(2,B,T),
                                                   ((nth1(1,L,H),nth1(2,L,T)) -> Op=true; Op=false);
                                          F=:=5 -> getIpv4ListCom2(C), nth1(1,C,H1), nth1(2,C,H2), nth1(3,C,H3),
                                          ((nth1(1,L,H1),nth1(2,L,H2),nth1(3,L,H3))-> Op=true; Op=false);
                                          Op=false).


/* will check which client wants to implement*/
decisionTcp(F):-setTcpSrc(X), setTcpDest(Y), setTcpCom(Z), (X\="null" -> F=1;
                                                           Y\="null" -> F=2;
                                                           Z\="null" -> F=3;
                                                           F=0).
/*check tcp's validity*/
checkTcpValidity(L,Op):-decisionTcp(F), (F=:=0 -> Op=true;
                                         F=:=1 -> nth1(1,L,X), setTcpSrc(Y), (X=Y -> Op=true;
                                                                             Op=false);

                                         F=:=2 -> nth1(2,L,X), setTcpDest(Y), (X=Y -> Op=true;
                                                                             Op=false);

                                         F=:=3 -> nth1(1,L,X),nth1(2,L,Y),getTcpListCom(Z),nth1(1,Z,M),nth1(2,Z,N),
                                                  ((X=M, Y=N)-> Op=true; Op=false);
                                         Op=false).

/* will check which client wants to implement*/
decisionUdp(F):-setUdpSrc(X), setUdpDest(Y), setUdpCom(Z), (X\="null" -> F=1;
                                                           Y\="null" -> F=2;
                                                           Z\="null" -> F=3;
                                                           F=0).

/*check udp's validity*/
checkUdpValidity(L,Op):-decisionUdp(F), (F=:=0 -> Op=true;
                                         F=:=1 -> nth1(1,L,X), setUdpSrc(Y), (X=Y -> Op=true;
                                                                             Op=false);

                                         F=:=2 -> nth1(2,L,X), setUdpDest(Y), (X=Y -> Op=true;
                                                                             Op=false);

                                         F=:=3 -> nth1(1,L,X),nth1(2,L,Y),getUdpListCom(Z),nth1(1,Z,M),nth1(2,Z,N),
                                                  ((X=M, Y=N)-> Op=true; Op=false);
                                         Op=false).

/* will check which client wants to implement*/
decisionIcmp(F):-setIcmpType(X), setIcmpCode(Y), setIcmpCom(Z), (X\="null" -> F=1;
                                                           Y\="null" -> F=2;
                                                           Z\="null" -> F=3;
                                                           F=0).

/*check icmp's validity*/
checkIcmpValidity(L,Op):-decisionIcmp(F), (F=:=0 -> Op=true;
                                         F=:=1 -> nth1(1,L,X), setIcmpType(Y), (X=Y -> Op=true;
                                                                             Op=false);

                                         F=:=2 -> nth1(2,L,X), setIcmpCode(Y), (X=Y -> Op=true;
                                                                             Op=false);

                                         F=:=3 -> nth1(1,L,X),nth1(2,L,Y),getIcmpListCom(Z),nth1(1,Z,M),nth1(2,Z,N),
                                                  ((X=M, Y=N)-> Op=true; Op=false);
                                          Op=false).


/*check protocol's validity on the basis of what is passed in the package*/
checkProtoValidity(L,L1,Op):- nth1(3,L,X), (X="icmp" -> (checkIcmpValidity(L1,Op1), Op=Op1);
                                        X="udp" -> (checkUdpValidity(L1,Op1), Op=Op1);
                                        X="tcp" -> (checkTcpValidity(L1,Op1), Op=Op1);
                                        Op=false
                                        ).
printResult:-tokenizeFirst(L),
                              nth1(1,L,X), split_string(X,","," ",L1),
                              nth1(2,L,Y), split_string(Y,","," ",L2),
                              nth1(3,L,Z), split_string(Z,","," ",L3),
                              nth1(4,L,W),split_string(W,","," ",L4),
                              checkAdapValidity(L1,Op1), checkEthValidity(L2,Op2), checkIPV4Validity(L3,Op3),
                              checkProtoValidity(L3,L4,Op7),
                              (Op1=false -> print("Rejecting... (Reason: Adapter Unmatch)");
                               Op2=false -> print("Rejecting... (Reason: Ethernet Unmatch)");
                               Op3=false -> print("Rejecting... (Reason: IPV4 Unmatch)");
                               Op7=false -> _=true;
                               print("Accepted!!")
                               ).

