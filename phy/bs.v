module bs(
    input [7:0]data_mux,
    input valid_mux,
    input reset_L,
    input clk_2f,
    output reg [7:0]data_stripe_0,
    output reg valid_stripe_0,
    output reg [7:0]data_stripe_1,
    output reg valid_stripe_1);

reg selector;
reg [7:0] l0,reg0;
reg [7:0] l1,reg1;
reg     flag,valid_0,valid_1,valid_reg_0,valid_reg_1,last;

always @(*)begin
    l0=0;
    l1=0;
    valid_0=0;
    valid_1=0;
    if(reset_L==0)begin
        l0='b0;
        l1='b0;
        valid_0=0;
        valid_1=0;
    end

    else begin
        if (selector==0) begin
            l1=data_mux;
            l0=reg0;
            valid_0=valid_mux;
            valid_1=valid_mux;
        end else begin
            l1=l1;
            l0=data_mux;
            valid_0=valid_mux;
            if (flag) begin
                valid_1=valid_mux;
            end
        end
    end
end

always @(posedge clk_2f)begin
    if(reset_L==0)begin
        selector<='b0;
        reg0<='b0;
        reg1<='b0;
        flag<=0;
        data_stripe_0 <= 0;
        data_stripe_1 <= 0;
        valid_stripe_0 <=0;
        valid_stripe_1 <=0;
    end
    
    else begin
        if (valid_mux==1)begin
            flag<=1;
            selector<=~selector;
            if (selector)begin
                reg0<=data_mux;
                valid_reg_0<=valid_0;            
                last=0;
            end
            else begin
                reg1<=data_mux;
                valid_reg_1<=valid_1;
                last=1;
            end
        end else begin
            flag<=0;
            selector<=1;
            if (~last && flag)begin
                valid_reg_0<=1;     
                valid_reg_1<=valid_1;
            end else if (last && flag)begin
                valid_reg_1<=1;      
                valid_reg_0<=valid_0;
            end else begin
                valid_reg_0<=valid_0;
                valid_reg_1<=valid_1;
            end
        end
        data_stripe_0 <= reg0;
        data_stripe_1 <= reg1;
        valid_stripe_0 <= valid_reg_0;
        valid_stripe_1 <= valid_reg_1;
    end
end

endmodule
