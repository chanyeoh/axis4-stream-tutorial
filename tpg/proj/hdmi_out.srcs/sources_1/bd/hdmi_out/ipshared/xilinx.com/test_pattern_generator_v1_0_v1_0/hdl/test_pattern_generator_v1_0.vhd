library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_pattern_generator_v1_0 is
	generic (
		-- Users to add parameters here
        WIDTH : integer := 640;
        HEIGHT : integer := 480;
        
        -- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Ports of Axi Master Bus Interface M00_AXIS
		aclk	: in std_logic;
        aclken	: in std_logic;
		aresetn	: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tuser	: out std_logic;
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic
	);
end test_pattern_generator_v1_0;

architecture arch_imp of test_pattern_generator_v1_0 is
    type VISION_STATE is (IDLE, VALID, INVALID);
    signal state :  VISION_STATE := IDLE;
    
    signal tdata : std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0) := (7 => '0', 15 => '0', 23 => '0', others => '1');
    signal tvalid : std_logic := '0';
    signal tuser : std_logic := '1';
    signal tlast : std_logic := '0';
begin
	-- Add user logic here
	m00_axis_tdata <= tdata;
	m00_axis_tvalid <= tvalid;
	m00_axis_tuser <= tuser;
	m00_axis_tlast <= tlast;
	
	process(aclk)
    	variable height_count :integer := 0;
        variable width_count :integer := 0;
    begin
       if aresetn='1' and aclken='1' then
             if aclk='1' and aclk'event then
                case state is
                    when IDLE =>
                        state <= VALID;
                    when VALID =>
                        if m00_axis_tready='1' then
                            tvalid <='1';
                            if height_count=0 and width_count=0 then
                                tuser <= '1';
                            else
                                tuser <= '0';
                            end if;
                            
                            -- Depending on the width count create different 
                            -- output colors
                            if width_count=WIDTH-1 then
                                width_count := 0;
                                if height_count=HEIGHT-1 then
                                    height_count:=0;
                                    tdata <= (7 => '0', 15 => '0', 23 => '0', others => '1');
                                else
                                    if height_count=HEIGHT/2 then
                                        tdata <= (others => '1');
                                    end if;
                                    height_count := height_count + 1;
                                end if;
                                tlast <= '1';
                            else
                                width_count := width_count + 1;
                                tlast <= '0';
                            end if;
                        end if;
                    when INVALID =>
                        state <= IDLE;
                end case;
             end if;
        end if;
    end process;

end arch_imp;