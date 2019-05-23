module bs(
    input [7:0]data_in,
    input valid_in,
    input reset,
    input clk_2f,
    output reg [7:0]lane_0_cond,
    output reg valid_0_cond,
    output reg [7:0]lane_1_cond,
    output reg valid_1_cond);

reg selector;
reg validflop;
reg [7:0] l0;
reg [7:0] l1;
reg flag;


always @(*)begin

    
    if(reset==0)begin
        lane_0_cond='b0;
        valid_0_cond='b0;
        lane_1_cond='b0;
        valid_1_cond='b0;
        flag='b0;
    end

    else begin
        if (valid_in==0) begin //datos no validos
            if (selector==0) begin
                lane_0_cond=data_in;
                lane_1_cond=l1;
                valid_0_cond=valid_in;
                valid_1_cond=validflop;
            end 
            else begin
                lane_1_cond=data_in;
                lane_0_cond=l0;
                valid_1_cond=valid_in;
                valid_0_cond=validflop;
            end
        end 

        else begin
            flag='b0;
            if (selector==0) begin
                lane_0_cond=data_in;
                lane_1_cond=l1;
                valid_0_cond=valid_in;
                valid_1_cond=validflop;
            end 
            else begin
                lane_1_cond=data_in;
                lane_0_cond=l0;
                valid_1_cond=valid_in;
                valid_0_cond=validflop;
            end
        end
    end
end

// always @(posedge valid_in)begin
//     selector='b0;
// end

always @(posedge clk_2f)begin
    if(reset==0)begin
        selector<='b0;
        validflop<='b0;
        l0<='b0;
        l1<='b0;
    end
    
    else begin
        validflop<=valid_in;
        l0<=lane_0_cond;
        l1<=lane_1_cond;
        selector<=~selector;
    end
end


endmodule
