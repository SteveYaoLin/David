module led_ctrl_fsm_Mealy2_two_segment
(
    //basic item
    input       clk         ,
    input       rst_n       ,
    //led_ctrl interface
    input       key_touch   ,
    output  reg led

);
////////////////////////////////////////////////////////////
//1.wire
////////////////////////////////////////////////////////////
//2.reg
reg     [7:0]   state      = 8'd0;

////////////////////////////////////////////////////////////
//3.module instantiation
////////////////////////////////////////////////////////////
//4.always procedual
//1st to describe the transtion of state using sequential logic circuit
//------------------state---------------------
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
        begin
            state <= 8'd0;
        end
    else
        begin
            case(state)
                //------------------
                8'd0    :   begin
                                if(key_touch == 1'b1)
                                    begin
                                        state <= 8'd1;
                                    end
                                else
                                    begin
                                        state <= 8'd0;
                                    end
                            end
                //------------------
                8'd1    :   begin
                                if(key_touch == 1'b1)
                                    begin
                                        state <= 8'd2;
                                    end
                                else
                                    begin
                                        state <= 8'd1;
                                    end
                            end
                //------------------
                8'd2    :   begin
                                if(key_touch == 1'b1)
                                    begin
                                        state <= 8'd3;
                                    end
                                else
                                    begin
                                        state <= 8'd2;
                                    end
                            end
                //------------------
                8'd3    :   begin
                                if(key_touch == 1'b1)
                                    begin
                                        state <= 8'd4;
                                    end
                                else
                                    begin
                                        state <= 8'd3;
                                    end
                            end
                //------------------
                8'd4    :   begin
                                if(key_touch == 1'b1)
                                    begin
                                        state <= 8'd0;
                                    end
                                else
                                    begin
                                        state <= 8'd4;
                                    end
                            end
                //------------------
                default :   begin
                                state <= 8'd0;
                            end
                //------------------
                            
            endcase
        end
end
//2nd:to describe the output
//------------------led-----------------
always @(posedge clk or negedge rst_n)
begin
    if(rst_n == 1'b0)
        begin
            led <= 1'b0;
        end
    else
        begin
            case(state)
                8'd4    :   begin
                                if(key_touch == 1'b1)
                                    begin
                                        led <= (~led);
                                    end
                                else
                                    begin
                                        led <= led;
                                    end
                            end
                //------------------
                8'd0,8'd1,8'd2,8'd3 :   begin
                                            led <= led;
                                        end
                //------------------
                default :   begin
                                led <= 1'b0;
                            end
                //------------------
            endcase
        end
end
////////////////////////////////////////////////////////////
//5.assign 
////////////////////////////////////////////////////////////
endmodule