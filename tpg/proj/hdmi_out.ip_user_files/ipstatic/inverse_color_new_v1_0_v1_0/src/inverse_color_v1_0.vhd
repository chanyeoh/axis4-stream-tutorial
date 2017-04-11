library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inverse_color_v1_0 is
	generic (
		-- Users to add parameters here
        WIDTH : integer := 640;
        HEIGHT : integer := 480;
		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		aclk	: in std_logic;
        aclken  : in std_logic;
        aresetn    : in std_logic;
            
        -- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic;
		s00_axis_tuser : in std_logic;

		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic;
        m00_axis_tuser : out std_logic
	);
end inverse_color_v1_0;

architecture arch_imp of inverse_color_v1_0 is

    component inverse_color is
        Port ( clk : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR(7 downto 0);
               output : out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    type CORE_STATE is (IDLE, RUNNING);
    type OPERATION_STATE is (DATA, SOF, EOL);
    
    signal state_core :  CORE_STATE := IDLE;
    
    signal tvalid : std_logic := '0';
    signal tuser : std_logic := '1'; -- First frame is valid
    signal tlast : std_logic := '0';
    signal tready : std_logic := '0';
    signal tdata : std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0) := (others => '0');
    signal tdata_result : std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0) := (others => '0');
begin
	-- Set The Master Output
	m00_axis_tdata <= tdata;
	m00_axis_tvalid <= tvalid;
	m00_axis_tuser <= tuser;
	m00_axis_tlast <= tlast;
	s00_axis_tready <= tready;
	
	-- Read Input and process
	process(aclk)
	variable height_count :integer := 0;
	variable width_count :integer := 0;
	
    variable state_operation : OPERATION_STATE := SOF;    
    begin
	    if aresetn='1' and aclken='1' then
                if aclk='1' and aclk'event then
                   case state_core is
                        when IDLE =>
                            tready <= '1';
                            state_core <= RUNNING;
                        when RUNNING =>
                            -- Detects if Frame is Restarted
                            if height_count=0 and width_count=0 then
                                state_operation := SOF;
                            end if;
                            
                            -- Checks if the Width is the end
                            if width_count=WIDTH-1 then
                                -- Reset Width and Update Height
                                width_count := 0;
                                if height_count=HEIGHT-1 then
                                    height_count:=0;
                                else
                                    height_count := height_count + 1;
                                end if;
                                state_operation := EOL;
                            else
                                width_count := width_count + 1;
                                tlast <= '0';
                            end if;
                            
                            if m00_axis_tready='1' and s00_axis_tvalid = '1' then
                                case state_operation is
                                    when DATA =>
                                        tvalid <= '1';
                                        tuser <= '0';
                                        tlast <= '0';
                                    when SOF =>
                                        tvalid <= '1';
                                        tuser <= '1';
                                        tlast <= '0';
                                        
                                        state_operation := DATA;
                                    when EOL =>
                                        tvalid <= '1';
                                        tuser <= '0';
                                        tlast <= '1';
                                        
                                        state_operation := DATA;
                                end case;
                                tdata_result <= s00_axis_tdata;
                            end if;
                   end case;
                end if;
        end if;  
	end process;
    
    -- Operate Here
    G1: inverse_color port map(aclk, tdata_result(7 downto 0), tdata(7 downto 0));
    G2: inverse_color port map(aclk, tdata_result(15 downto 8), tdata(15 downto 8));
    G3: inverse_color port map(aclk, tdata_result(23 downto 16), tdata(23 downto 16));
end arch_imp;