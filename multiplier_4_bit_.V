module and_gate(a,b,ans);
//just a and gate;
input a,b;
output ans;
     and A1(ans,a,b);
endmodule 
////////////////////////////////////////////////////////////////////////////
module half_adder(a,b,sum,carry);
input a,b;
output sum,carry;
     and H1(carry,a,b);
     xor H2(sum,a,b);
endmodule
////////////////////////////////////////////////////////////////////////////
module full_adder(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
wire [2:0] ha_connect;
      xor F1(ha_connect[0],a,b);
      xor F2(sum,cin,ha_connect[0]);
      and F3(ha_connect[1],a,b);
      and F4(ha_connect[2],ha_connect[1],cin);
      or  F5(cout,ha_connect[1],ha_connect[2]);
endmodule
///////////////////////////  MULTIPLIER PART ///////////////////
module array_multiplier(input1,input2,multiplied_product);
//declaring input ports
input [3:0] input1;
input [3:0] input2;
//declaring output ports
output [7:0] multiplied_product;
///declaring th data flow modelling
/// multiplied_product[0] == input1[0].input2[0]
and_gate AM1(input1[0],input2[0],multiplied_product[0]);
/// multiplied product[1] == input1[1].input2[0] + input2[1].input1[0]
wire [1:0] connector0;
wire carry0;
and_gate AM2i1(input1[0],input2[1],connector0[0]);
and_gate AM2i2(input1[1],input2[0],connector0[1]);
half_adder AM2(connector0[0],connector0[1],multiplied_product[1],carry0);
/// multiplied product[2] == input1[2].input2[0] + input1[1].input2[1] + input1[0].input2[2];carry0 is used
wire [2:0] connector1;
wire [1:0] carry1;
wire sum0;
and_gate AM3i1(input1[2],input2[0],connector1[0]);
and_gate AM3i2(input1[1],input2[1],connector1[1]);
and_gate AM3i3(input1[0],input2[2],connector1[2]);

full_adder AM3i4(connector1[0],connector1[1],carry0,sum0,carry1[0]);
half_adder AM3(sum0,connector1[2],multiplied_product[2],carry1[1]);
/// multiplied product[3] == input1[3].input2[0] + input1[2].input2[1] + input1[1].input2[2] + input1[0].input2[3]; carry1 2 bits used
wire [3:0] connector2;
wire [2:0] carry2;
wire [1:0] sum1;

and_gate AM4i1(input1[3],input2[0],connector2[0]);
and_gate AM4i2(input1[2],input2[1],connector2[1]);
and_gate AM4i3(input1[1],input2[2],connector2[2]);
and_gate AM4i4(input1[0],input2[3],connector2[3]);

full_adder AM4i5(connector2[0],connector2[1],carry1[0],sum1[0],carry2[0]);
full_adder AM4i6(connector2[2],connector2[3],carry1[1],sum1[1],carry2[1]);
half_adder AM4i7(sum1[0],sum1[1],multiplied_product[3],carry2[2]);
/// multiplied product[4] == input1[3].input2[1] + input1[2].input2[2] + input1[2].input2[3] ;carry1 2 bits used
wire [2:0] connector3;
wire [2:0] carry3;
wire [1:0]sum2;

and_gate AM7i1(input1[3],input2[2],connector3[0]);
and_gate AM7i2(input1[2],input2[2],connector3[1]);
and_gate AM7i3(input1[2],input2[3],connector3[2]);

full_adder AM7i4(connector3[0],connector3[1],carry2[0],sum2[0],carry3[0]);
full_adder AM7i5(connector3[2],sum2[0],carry2[1],sum2[1],carry3[1]);
half_adder AM7i6(sum2[1],carry2[2],multiplied_product[4],carry3[2]);
/// multiplied product[5] == input1[3].input2[2] + input1[2].input2[3] ;carry1 2 bits used
wire [1:0] connector4;
wire [1:0] carry4;
wire sum3;

and_gate AM5i1(input1[3],input2[2],connector4[0]);
and_gate AM5i2(input1[2],input2[2],connector4[1]);

full_adder AM5i3(connector4[0],connector4[1],carry3[0],sum3,carry4[0]);
full_adder AM5i4(sum3,carry3[1],carry3[2],multiplied_product[5],carry4[1]);
/// multiplied product[6] == input1[3].input2[3] ;carry1 2 bits used
wire connector5;

and_gate AM6i1(input1[3],input2[3],connector5);

full_adder AM6i2(connector5,carry4[0],carry4[1],multiplied_product[6],multiplied_product[7]);

endmodule
////////////////////////////////////////////////////////////////



