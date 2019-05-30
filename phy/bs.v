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
reg validflop;
reg [7:0] l0;
reg [7:0] l1;
reg flag;


always @(*)begin

    
    if(reset_L==0)begin
        data_stripe_0='b0;
        valid_stripe_0='b0;
        data_stripe_1='b0;
        valid_stripe_1='b0;
        flag='b0;
    end

    else begin
        if (valid_mux==0) begin //datos no validos
            if (selector==0) begin
                data_stripe_0=data_mux;
                data_stripe_1=l1;
                valid_stripe_0=valid_mux;
                valid_stripe_1=validflop;
            end 
            else begin
                data_stripe_1=data_mux;
                data_stripe_0=l0;
                valid_stripe_1=valid_mux;
                valid_stripe_0=validflop;
            end
        end 

        else begin
            flag='b0;
            if (selector==0) begin
                data_stripe_0=data_mux;
                data_stripe_1=l1;
                valid_stripe_0=valid_mux;
                valid_stripe_1=validflop;
            end 
            else begin
                data_stripe_1=data_mux;
                data_stripe_0=l0;
                valid_stripe_1=valid_mux;
                valid_stripe_0=validflop;
            end
        end
    end
end

// always @(posedge valid_mux)begin
//     selector='b0;
// end

always @(posedge clk_2f)begin
    if(reset_L==0)begin
        selector<='b0;
        validflop<='b0;
        l0<='b0;
        l1<='b0;
    end
    
    else begin
        validflop<=valid_mux;
        l0<=data_stripe_0;
        l1<=data_stripe_1;
        selector<=~selector;
    end
end


endmodule
