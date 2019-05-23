module partoserial(
    input [7:0]data_stripe,
    input valid_stripe,
    input reset_L,
    input clk_8f,
    output reg out);

reg [7:0]data2send;
reg [3:0]contador;

always @(*)begin
//out=data2send[7-contador];
    if(reset_L==0)begin
        data2send='hBC;
    end
    else begin
       if (valid_stripe==1)
            data2send=data_stripe;
        else
            data2send='hBC; 
    end
 
end


always @(posedge clk_8f)begin
    if(reset_L==0)begin
        out<='b0;
        //data2send<=data_stripe;
        contador<=0;
    end
    else begin    
        out<=data2send[7-contador];
        contador<=contador+1;
        if(contador==7)begin
            contador<='b0;
        end
    end
end

endmodule
