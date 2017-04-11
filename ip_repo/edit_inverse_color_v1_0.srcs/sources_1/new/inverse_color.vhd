----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2017 02:16:11 PM
-- Design Name: 
-- Module Name: inverse_color - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inverse_color is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR(7 downto 0);
           output : out STD_LOGIC_VECTOR(7 downto 0));
end inverse_color;

architecture Behavioral of inverse_color is

begin

process(clk)
    variable max_val : std_logic_vector(7 downto 0) := (others=>'1');
begin   
    if clk='1' and clk'event then
        output <= std_logic_vector(signed(max_val) - signed(input));
    end if;
end process;
end Behavioral;
