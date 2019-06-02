module partoserial(
    input [7:0]data_stripe,
    input valid_stripe,
    input reset_L,
    input clk_8f,
    input clk_f,
    output reg out);
    
    reg  [7:0]      buffer,buffer2;             // registro que contiene el dato correcto a transformar a serial
    reg  [2:0]      cnt_bits;           // contador de bits enviados
    reg             sync,first,start;   // bits de sincronizacion para enviar datos  

    always @(*) begin
        if(~reset_L) begin
            buffer = 'hBC;
        end else begin
            buffer = 'hBC;
            if (valid_stripe==1)
                buffer = data_stripe;
            else begin
                buffer = 'hBC;
            end
        end
    end

    always @(posedge clk_f) begin
        if(~reset_L) begin
            start <= 0;
        end else begin
            if (~start) begin
                start<=1;
            end
            buffer2<=buffer;
        end
    end

    always @(posedge clk_8f) begin
        if(~reset_L) begin
            out <= 0;
            cnt_bits<=0;
            first <= 0;
            sync <= 0;
            start<=0;
        end else begin
            if (start) begin
                cnt_bits<=cnt_bits+1;
            end
            if (cnt_bits==0 && first==1)begin
                sync <= 1;
            end
            if (sync) begin
                out <= buffer2[7-cnt_bits];
            end
            else begin
                if (cnt_bits==7)begin
                    first<=1;
                end
            end
        end
    end
endmodule // partoserial