module partoserial(
    input [7:0]data_in,
    input valid_in,
    input reset,
    input clk_8f,
    output reg data_out);

reg [7:0]data2send;
reg [3:0]contador;

always @(*)begin
//data_out=data2send[7-contador];
    if(reset==0)begin
        data2send='hBC;
    end
    else begin
       if (valid_in==1)
            data2send=data_in;
        else
            data2send='hBC; 
    end
 
end


always @(posedge clk_8f)begin
    if(reset==0)begin
        data_out<='b0;
        data2send<=data_in;
        contador<=0;
    end
    else begin    
        data_out<=data2send[7-contador];
        contador<=contador+1;
        if(contador==7)begin
            contador<='b0;
        end
    end
end

endmodule