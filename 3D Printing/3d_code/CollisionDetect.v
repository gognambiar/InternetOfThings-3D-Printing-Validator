`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:07:45 03/06/2017 
// Design Name: 
// Module Name:    collisiondetect 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CollisionDetect(
input clk, reset, in_val,
input [7:0] x1, y1, z1, x2, y2, z2,
output reg out_val,
output reg [7:0] lineID);

reg [7:0] memar1[50:0][0:6];
reg [7:0] a1,b1,a2,b2,c1,d1,c2,d2;
integer o1,o2,o3,o4,m1,m2,m3,m4;
integer s1,s2,s3,s4,ct;
integer i,j,flag,flag1;
integer flag3,flag4,flag5,m,l,w,nflg1,nflg2;
integer p10,p20,v10,v20,p30,cr10,cr20,flg0;
integer p11,p21,v11,v21,p31,cr11,cr21,flg1;
integer p12,p22,v12,v22,p32,cr12,cr22,flg2;
reg [31:0] a11,b11;
reg [32:0] p1;

initial begin
	out_val = 0;
	flag = 0;
	ct = 0;
end

always @(posedge clk) begin
	out_val = 0;
	flag = 0;
	if(in_val == 1) begin
		memar1[ct][0] = x1;
		memar1[ct][1] = y1;
		memar1[ct][2] = z1;
		memar1[ct][3] = x2;
		memar1[ct][4] = y2;
		memar1[ct][5] = z2;
		memar1[ct][6] = 0;
		ct = ct + 1;
		lineID = ct;
		flag = 0;
		flag1 = 0;
		out_val = 0;				
		for(i = 0; i<51;i=i+1) begin
			if((i<(ct-1))&&(flag != 1)) begin
				if(memar1[i][6] != 1) begin
					flag1 = 0;
					for(j = 0;j<51;j=j+1) begin
						if((j<3)&&(flag1 != 1)) begin
							if(j == 0) begin
								a1 = x1;
								b1 = y1;
								a2 = x2;
								b2 = y2;
								c1 = memar1[i][0];
								d1 = memar1[i][1];
								c2 = memar1[i][3];
								d2 = memar1[i][4];
								end
							else if(j == 1) begin
								a1 = y1;
								b1 = z1;
								a2 = y2;
								b2 = z2;
								c1 = memar1[i][1];
								d1 = memar1[i][2];
								c2 = memar1[i][4];
								d2 = memar1[i][5];
								end
							else begin
								a1 = x1;
								b1 = z1;
								a2 = x2;
								b2 = z2;
								c1 = memar1[i][0];
								d1 = memar1[i][2];
								c2 = memar1[i][3];
								d2 = memar1[i][5];
								end
								
							o1 = (b2 - b1)*(c1-a2) - (a2-a1)*(d1 - b2);
							if (o1 != 0)
								o1 = (o1>0)? 1:2;
							o2 = (b2 - b1)*(c2-a2) - (a2-a1)*(d2 - b2);
							if (o2 != 0)
								o2 = (o2>0)? 1:2;
						
							o3 = (d2 - d1)*(a1-c2) - (c2-c1)*(b1 - d2);
							if (o3 != 0)
								o3 = (o3>0)? 1:2;
						
							o4 = (d2 - d1)*(a2-c2) - (c2-c1)*(b2 - d2);
							if (o4 != 0)
								o4 = (o4>0)? 1:2;
					
							m1 = (a1 > a2)? a1:a2;
							m2 = (a1 > a2)? a2:a1;
							m3 = (b1 > b2)? b1:b2;
							m4 = (b1 > b2)? b2:b1;
						
							if(c1 <= m1 && c1 >= m2 && d1 <= m3 && d1 >= m4)
								s1 = 1;
							else
								s1 = 0;
						
							if(c2 <= m1 && c2 >= m2 && d2 <= m3 && d2 >= m4)
								s2 = 1;
							else
								s2 = 0;
						
							m1 = (c1 > c2)? c1:c2;
							m2 = (c1 > c2)? c2:c1;
							m3 = (d1 > d2)? d1:d2;
							m4 = (d1 > d2)? d2:d1;
						
							if(a1 <= m1 && a1 >= m2 && b1 <= m3 && b1 >= m4)
								s3 = 1;
							else
								s3 = 0;
						
							if(a2 <= m1 && a2 >= m2 && b2 <= m3 && b2 >= m4)
								s4 = 1;
							else
								s4 = 0;
							
							if((o1 != o2) && (o3 != o4))
								flag = 1;
						
							else if(o1 == 0 && s1 == 1)
								flag = 1;
						
							else if(o2 == 0 && s2 == 1)
								flag = 1;
					
							else if(o3 == 0 && s3 == 1)
								flag = 1;
							
							else if(o4 == 0 && s4 == 1)
								flag = 1;
						
							else begin
								flag = 0;
								flag1 = 1;
							end
						end//if for 2
						else
							j = 51;
					end//2 for
					
					if(flag1 != 1 && flag == 1) begin
						//Handling of exceptions - 
						flag3 = 0;
						p10 = x1;
						p11 = y1;
						p12 = z1;
						v10 = x2-x1;
						v11 = y2-y1;
						v12 = z2-z1;
						p20 = memar1[i][0];
						p21 = memar1[i][1];
						p22 = memar1[i][2];
						v20 = memar1[i][3]-memar1[i][0];
						v21 = memar1[i][4]-memar1[i][1];
						v22 = memar1[i][5]-memar1[i][2];
						
						p30 = p20 - p10;
						p31 = p21 - p11;
						p32 = p22 - p12;

						cr10 = v11*v22 - v12*v21;
						cr11 = v12*v20 - v10*v22;
						cr12 = v10*v21 - v11*v20;
						cr20 = p31*v22 - p32*v21;
						cr21 = p32*v20 - p30*v22;
						cr22 = p30*v21 - p31*v20;

						if(cr10 == 0 && cr20 == 0)
								flg0 = 1001;
							else if(cr10 == 0 || cr20 == 0)
								flg0 = 1002;
							else begin
								nflg1 = 0;
								nflg2 = 0;
								if(cr10 < 0 && cr20 < 0) begin
						        	a11 = 0 - cr10;
						        	b11 = 0 - cr20;
						        end
						        else if(cr10 < 0) begin
						        	a11 = 0 - cr10;
						        	b11 = cr20;
						        	nflg1 = 1;
						        end
						        else if(cr20 < 0) begin
						        	a11 = cr10;
						        	b11 = 0 - cr20;
						        	nflg2 = 1;
						        end
						        else begin
						        	a11 = cr10;
						        	b11 = cr20;
						        end
						        p1= 0;
						        for(w=0;w <31;w=w+1)    begin //start the for loop
						            p1 = {p1[30:0],a11[31]};
						            a11[31:1] = a11[30:0];
						            p1 = p1-b11;
						            if(p1[31] == 1)    begin
						                a11[0] = 0;
						                p1 = p1 + b11;   
						            end
						            else
						                a11[0] = 1;
						        end
						        
						        if(nflg1 < 0 || nflg2 < 0)
						    		flg0 = 0 - a11;
						    	else
						    		flg0 = a11;    		
						    end

						if(cr11 == 0 && cr21 == 0)
								flg1 = 1001;
							else if(cr11 == 0 || cr21 == 0)
								flg1 = 1002;
							else begin
								nflg1 = 0;
								nflg2 = 0;
								if(cr11 < 0 && cr21 < 0) begin
						        	a11 = 0 - cr11;
						        	b11 = 0 - cr21;
						        end
						        else if(cr11 < 0) begin
						        	a11 = 0 - cr11;
						        	b11 = cr21;
						        	nflg1 = 1;
						        end
						        else if(cr21 < 0) begin
						        	a11 = cr11;
						        	b11 = 0 - cr21;
						        	nflg2 = 1;
						        end
						        else begin
						        	a11 = cr11;
						        	b11 = cr21;
						        end
						        p1= 0;
						        for(w=0;w<31;w=w+1)    begin //start the for loop
						            p1 = {p1[30:0],a11[31]};
						            a11[31:1] = a11[30:0];
						            p1 = p1-b11;
						            if(p1[31] == 1)    begin
						                a11[0] = 0;
						                p1 = p1 + b11;   
						            end
						            else
						                a11[0] = 1;
						        end
						        
						        if(nflg1 < 0 || nflg2 < 0)
						    		flg1 = 0 - a11;
						    	else
						    		flg1 = a11;	
						    end

						if(cr12 == 0 && cr22 == 0)
								flg2 = 1001;
							else if(cr12 == 0 || cr22 == 0)
								flg2 = 1002;
							else begin
								nflg1 = 0;
								nflg2 = 0;
								if(cr12 < 0 && cr22 < 0) begin
						        	a11 = 0 - cr12;
						        	b11 = 0 - cr22;
						        end
						        else if(cr12 < 0) begin
						        	a11 = 0 - cr12;
						        	b11 = cr22;
						        	nflg1 = 1;
						        end
						        else if(cr22 < 0) begin
						        	a11 = cr12;
						        	b11 = 0 - cr22;
						        	nflg2 = 1;
						        end
						        else begin
						        	a11 = cr12;
						        	b11 = cr22;
						        end
						        p1= 0;
						        for(w=0;w<31;w=w+1)    begin //start the for loop
						            p1 = {p1[30:0],a11[31]};
						            a11[31:1] = a11[30:0];
						            p1 = p1-b11;
						            if(p1[31] == 1)    begin
						                a11[0] = 0;
						                p1 = p1 + b11;   
						            end
						            else
						                a11[0] = 1;
						        end
						        
						        if(nflg1 < 0 || nflg2 < 0)
						    		flg2 = 0 - a11;
						    	else
						    		flg2 = a11;    		
							end

						if(flg0 == flg1 || flg0 == 1001 || flg1 == 1001)
							flag3 = 1;
						if(flg1 == flg2 || flg1 == 1001 || flg2 == 1001)
							flag4 = 1;
						if(flg2 == flg0 || flg2 == 1001 || flg0 == 1001)
							flag5 = 1;
						else begin
							flag3 = 0;
							flag4 = 0;
							flag5 = 0;
						end
							
						if(flag3 == 1 && flag4 == 1 && flag5 == 1) begin
							out_val = 1;
							memar1[ct-1][6] = 1;
							flag = 1;
						end

						else begin
							out_val = 0;
							memar1[ct-1][6] = 0;
							flag = 0;
						end
						//end of exception handling
						/*out_val = 1;
						memar1[ct-1][6] = 1;*/
					end
					else begin
						out_val = 0;
						memar1[ct-1][6] = 0;
					end
				end//memar1
			end//if for 1
			else
				i = 51;
		end//1 for
	end//if in_val
end

endmodule
