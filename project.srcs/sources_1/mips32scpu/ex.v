`timescale 1ns / 1ps
`include "defines.v"

module ex(
	input wire rst,
	
	//�͵�ִ�н׶ε���Ϣ
	input wire[`AluOpBus]         aluop_i,
	input wire[`AluSelBus]        alusel_i,
	input wire[`RegBus]           reg1_i,
	input wire[`RegBus]           reg2_i,
	input wire[`RegAddrBus]       wd_i,
	input wire                    wreg_i,

/*
	//HI��LO�Ĵ�����ֵ
	input wire[`RegBus]           hi_i,
	input wire[`RegBus]           lo_i,

	//��д�׶ε�ָ���Ƿ�ҪдHI��LO�����ڼ��HI��LO���������
	input wire[`RegBus]           wb_hi_i,
	input wire[`RegBus]           wb_lo_i,
	input wire                    wb_whilo_i,
	
	//�ô�׶ε�ָ���Ƿ�ҪдHI��LO�����ڼ��HI��LO���������
	input wire[`RegBus]           mem_hi_i,
	input wire[`RegBus]           mem_lo_i,
	input wire                    mem_whilo_i,
*/	
	output reg[`RegAddrBus]       wd_o,
	output reg                    wreg_o,
	output reg[`RegBus]           wdata_o

/*
	output reg[`RegBus]           hi_o,
	output reg[`RegBus]           lo_o,
	output reg                    whilo_o	
*/	
);

	reg[`RegBus] logicout;
	
	always @ (*) begin
        if(rst == `RstEnable) begin
            logicout <= `ZeroWord;
        end else begin
            case(aluop_i)
                `EXE_OR_OP:begin
                    logicout <= reg1_i | reg2_i;
                end
                default:begin
                    logicout <= `ZeroWord;
                end
            endcase
        end
	end
	
	always @ (*) begin
        wd_o <= wd_i;
        wreg_o <= wreg_i;
        case(alusel_i)
            `EXE_RES_LOGIC:begin
                wdata_o <= logicout;
            end
            default:begin
                wdata_o <= `ZeroWord;
            end
        endcase
	end
endmodule