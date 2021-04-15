----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2020 11:47:32 AM
-- Design Name: 
-- Module Name: if - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity if is
    Port ( clk : in STD_LOGIC;
           adrBranch : in STD_LOGIC_VECTOR (15 downto 0);
           adrJump : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           PCsrc : in STD_LOGIC;
           Instr : out STD_LOGIC_VECTOR (15 downto 0);
           adrUrm : out STD_LOGIC_VECTOR (15 downto 0));
end if;

architecture Behavioral of if is

begin


end Behavioral;
