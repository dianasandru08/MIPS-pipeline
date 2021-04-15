----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2020 09:16:20 AM
-- Design Name: 
-- Module Name: ram - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram is
    Port ( intrare : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           regWr : in STD_LOGIC;
           iesire : out STD_LOGIC_VECTOR (15 downto 0));
end ram;

architecture Behavioral of ram is
signal rd, wd: std_logic_vector(15 downto 0);
type mem_type is array(0 to 15) of std_logic_vector(15 downto 0);
signal memory : mem_type := ("0000000011100111", "0000000011111111",
                         "0000000000000000", "0000000001111111", 
                         "0000000000111111", "0000000011100000", 
                          "0000000011111110", "0000000000000001",
                          "0000000000000001", "0000000000000101",
                          "0000000000000011", "0000000000001000",
                          "0000000000001001", "0000000000010000",
                          others => "0000000000000000" );

begin

process(clk, regWr)
begin
if regWr ='1' then 
    
    memory(conv_integer(intrare)) <= wd;
    wd<=rd (13 downto 0) & "00";
    iesire<=wd;
    
    else
    if clk'event and clk ='1' then 
    rd <= memory(conv_integer(intrare));
    iesire<= rd (13 downto 0) & "00";
    end if;
end if;

end process;
 
    
    
end Behavioral;
