module partoserial(
    input [7:0]data_stripe,
    input valid_stripe,
    input reset_L,
    input clk_8f,
    output reg out);

reg [7:0]data2send;
reg [3:0]contador;
reg [7:0]data_temp;
reg flag;

always @(*)begin
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
        contador<=0;
        flag<=0;
        data_temp<=0;
    end
    else begin
        data_temp<=data2send;//    
        if (valid_stripe==1)begin
            out<=data2send[7-contador];
            contador<=contador+1;
        end

        else begin
            if(flag==1)begin
            out<=data2send[7-contador];
            contador<=contador+1;    
            end
        end
        
        if(contador==7)begin
            flag<=1;
            contador<='b0;
        end
    end
end

endmodule
