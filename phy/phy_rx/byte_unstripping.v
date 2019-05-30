
module byte_unstripping(
                        output reg[7:0] data_unstripped,     //salida a data demux, cambia con clk_2f
                        output reg      valid_unstripped,
                        input           clk_2f,
                        input           reset_L,
                        input[7:0]      data_par_0,      //entradas data stripe cambian 
                        input[7:0]      data_par_1,      //tomando como referencia clk_f
                        input           valid_par_0,
                        input           valid_par_1);

//Banderas y senales internas
    
    reg selector; 
    reg lectura;
//bloques always
    always @(*)begin
    data_unstripped='b0;
    valid_unstripped='b0;
        if(!reset_L)begin
            data_unstripped='b0;
            valid_unstripped='b0;
        end

        else begin
            if(lectura==1)begin
                if(selector==0)begin
                    data_unstripped=data_par_0;
                    valid_unstripped=valid_par_0;
                end
                else begin
                    data_unstripped=data_par_1;
                    valid_unstripped=valid_par_1;
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
            if(valid_par_0==1)begin
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
