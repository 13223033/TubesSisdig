library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity CORDIC is
    generic (data_length : natural := 16);
    port (
        max10_clock           : in std_logic;
        divider_done    : in std_logic;
        purge           : in std_logic;
        in_z            : in std_logic_vector(data_length-1 downto 0);
        out_theta       : out std_logic_vector(data_length-1 downto 0);
        out_cordic_done : out std_logic
    );
end entity CORDIC;

architecture CORDIC_arch of CORDIC is
    component MUX is
        generic (data_length: natural := 16);
        port (
        in_mux_A        : in std_logic_vector(data_length-1 downto 0);
        in_mux_B        : in std_logic_vector(data_length-1 downto 0);
        selector        : in std_logic;
        out_mux         : out std_logic_vector(data_length-1 downto 0)
        );
    end component MUX;

    component REG is
        generic (data_length: natural := 16);
        port (
            clock       : in std_logic;
            enable      : in std_logic;
            -- clear       : in std_logic;
            data_in     : in std_logic_vector(data_length-1 downto 0);
            data_out    : out std_logic_vector(data_length-1 downto 0)
        );
    end component REG;

    component Subtractor is
        generic (data_length: natural := 16);
        port (
            in_A, in_B  : in std_logic_vector((data_length-1) downto 0);
            output      : out std_logic_vector(data_length-1 downto 0)
        );
    end component Subtractor;
        
    component Adder is
        generic (data_length: natural := 16);
        port (
            in_A, in_B  : in std_logic_vector((data_length-1) downto 0);
            output      : out std_logic_vector(data_length-1 downto 0)
        );
    end component Adder;

    component Right_shifter is
        generic (data_length: natural := 16);
        port (
            in_data     : in std_logic_vector(data_length-1 downto 0);
            shift       : in std_logic_vector(3 downto 0);
            out_data    : out std_logic_vector(data_length-1 downto 0)
        );
    end component Right_shifter;

    component Counter_CORDIC is
        generic (data_length: natural := 4);
        port (
            clock           : in std_logic;
            enable_ctr      : in std_logic;
            reset_ctr       : in std_logic;
            count           : out std_logic_vector(3 downto 0)
        );
    end component Counter_CORDIC;

    component Comparator is
        generic (data_length : natural := 16);
        port (
            in_a, in_b : in std_logic_vector((data_length-1) downto 0);
            output : out std_logic_vector(1 downto 0)
        );
    end component Comparator;

    component FSM_Cordic is
        port (
        clock, divider_done, purge : in std_logic;
        comp_iter, comp_dir : in std_logic_vector(1 downto 0);
        enable, reset, sel_iter, sel_dir, cordic_done : out std_logic
    );
    end component FSM_Cordic;

    component Arctan_LUT is
        generic (data_length: natural := 16);
        port (
            index     : in std_logic_vector(3 downto 0);
            arctan_out    : out std_logic_vector(data_length-1 downto 0)
        );
    end component Arctan_LUT;

    --signal output_theta : std_logic_vector(data_length-1 downto 0);
    signal cordic_done : std_logic;

    constant x_0 : std_logic_vector(data_length-1 downto 0) := "0010011011011101";
    constant y_0 : std_logic_vector(data_length-1 downto 0) := "0000000000000000";
    constant theta_0 : std_logic_vector(data_length-1 downto 0) := "0000000000000000";
    constant max_iter : std_logic_vector(3 downto 0) := "1111";

    signal out_mux_4, out_mux_5, out_mux_6: std_logic_vector(data_length-1 downto 0) := "0000000000000000";
    signal in_mux_4A, in_mux_4B, in_mux_5A, in_mux_5B, in_mux_6A, in_mux_6B: std_logic_vector(data_length-1 downto 0);
    
    signal in_reg_x, in_reg_y, in_reg_theta: std_logic_vector(data_length-1 downto 0);

    signal out_reg_x, out_reg_y, out_reg_theta: std_logic_vector(data_length-1 downto 0);

    signal out_shift_x, out_shift_y: std_logic_vector(data_length-1 downto 0);

    signal out_counter: std_logic_vector(3 downto 0) := "0000";

    signal out_LUT: std_logic_vector(data_length-1 downto 0);

    signal enable, reset: std_logic;
    signal sel_iter, sel_dir: std_logic := '0';

    signal clock: std_logic;

    signal comp_iter_out: std_logic_vector(1 downto 0);

    signal comp_dir_out: std_logic_vector(1 downto 0);

    signal seldirinverted:std_logic;

begin
	seldirinverted <= NOT(sel_dir);
    clock <= max10_clock;

    -- instantiasi MUX layer 1
    mux_1 : MUX generic map(data_length) port map(out_mux_4, x_0, sel_iter, in_reg_x);
    mux_2 : MUX generic map(data_length) port map(out_mux_5, y_0, sel_iter, in_reg_y);
    mux_3 : MUX generic map(data_length) port map(out_mux_6, theta_0, sel_iter, in_reg_theta);

    -- instantiasi MUX layer 2
    mux_4 : MUX generic map(data_length) port map(in_mux_4A, in_mux_4B, (seldirinverted), out_mux_4);
    mux_5 : MUX generic map(data_length) port map(in_mux_5A, in_mux_5B, sel_dir, out_mux_5);
    mux_6 : MUX generic map(data_length) port map(in_mux_6A, in_mux_6B, sel_dir, out_mux_6);

    -- instantiasi register
    reg_x : REG generic map(data_length) port map(clock, enable, in_reg_x, out_reg_x);
    reg_y : REG generic map(data_length) port map(clock, enable, in_reg_y, out_reg_y);
    reg_theta : REG generic map(data_length) port map(clock, enable, in_reg_theta, out_reg_theta);

    -- instantiasi shifter
    shifter_x : Right_shifter generic map(data_length) port map(out_reg_x, out_counter, out_shift_x);
    shifter_y : Right_shifter generic map(data_length) port map(out_reg_y, out_counter, out_shift_y);

    -- instantiasi subtractor dan adder
    subtractor_x : Subtractor generic map(data_length) port map(out_reg_x, out_shift_y, in_mux_4A);
    adder_x : Adder generic map(data_length) port map(out_reg_x, out_shift_y, in_mux_4B);

    subtractor_y : Subtractor generic map(data_length) port map(out_reg_y, out_shift_x, in_mux_5A);
    adder_y : Adder generic map(data_length) port map(out_reg_y, out_shift_x, in_mux_5B);

    subtractor_theta : Subtractor generic map(data_length) port map(out_reg_theta, out_LUT, in_mux_6A);
    adder_theta : Adder generic map(data_length) port map(out_reg_theta, out_LUT, in_mux_6B);

    -- instantiasi counter
    counter : Counter_CORDIC generic map(data_length) port map(clock, enable, reset, out_counter);

    -- instantiasi comparator
    comp_iter : Comparator generic map(4) port map(out_counter, max_iter, comp_iter_out);
    comp_dir  : Comparator generic map(data_length) port map(out_mux_5, in_z, comp_dir_out);

    -- instantiasi FSM
    CONTROL_UNIT    : FSM_Cordic port map(clock, divider_done, purge, comp_iter_out, comp_dir_out, enable, reset, sel_iter, sel_dir, cordic_done);

    -- instantiasi LUT
    Arctan_LUT_inst : Arctan_LUT generic map(data_length) port map(out_counter, out_LUT);

    out_theta <= out_reg_theta;
    out_cordic_done <= cordic_done;
end architecture CORDIC_arch;