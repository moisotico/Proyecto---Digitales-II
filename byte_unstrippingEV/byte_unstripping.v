
module byte_unstripping(
                        output reg[7:0] data_demux_cond,     //salida a data demux, cambia con clk_2f
                        output reg      valid_demux_cond,
                        input           clk_2f,
                        input           reset_L,
                        input[7:0]      data_stripe_0,      //entradas data stripe cambian 
                        input[7:0]      data_stripe_1,      //tomando como referencia clk_f
                        input           valid_stripe_0,
                        input           valid_stripe_1);

//Banderas y senales internas
    
    reg selector; 
    reg lectura;
//bloques always
    always @(*)begin
    data_demux_cond='b0;
    valid_demux_cond='b0;
        if(!reset_L)begin
            data_demux_cond='b0;
            valid_demux_cond='b0;
        end

        else begin
            if(lectura==1)begin
                if(selector==0)begin
                    data_demux_cond=data_stripe_0;
                    valid_demux_cond=valid_stripe_0;
                end
                else begin
                    data_demux_cond=data_stripe_1;
                    valid_demux_cond=valid_stripe_1;
                end
            end
        end
    end

    always @(posedge clk_2f)begin
        if (!reset_L) begin
            selector<='b0;
            lectura<='b0;
        end 
        else begin
            if(valid_stripe_0==1)begin
                lectura<='b1;
            end
            else begin
                lectura<='b0;
            end

            if(lectura==1)begin
                selector<=~selector;
            end
            else begin
                selector<='b0;
            end
        end
    end
endmodule
