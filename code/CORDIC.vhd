library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity CORDIC is
    generic (data_length : natural := 16);
    port (
        clock           : in std_logic;
        in_z            : in std_logic_vector(data_length-1 downto 0);
        out_theta       : out std_logic_vector(data_length-1 downto 0)
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
            clear       : in std_logic;
            data_in     : in std_logic_vector(data_length-1 downto 0);
            data_out    : out std_logic_vector(data_length-1 downto 0)
        );
    end component REG;

    component Subtractor is
        generic (data_length: natural := 16);
        port (
            in_A, in_B  : in std_logic_vector((data_length-1) downto 0);
            output      : out std_logic_vector(data_length downto 0)
        );
    end component Subtractor;
        
    component Adder is
        generic (data_length: natural := 16);
        port (
            in_A, in_B  : in std_logic_vector((data_length-1) downto 0);
            output      : out std_logic_vector(data_length downto 0)
        );
    end component Adder;

    component Right_shifter is
        generic (data_length: natural := 16);
        port (
            in_data     : in std_logic_vector(data_length-1 downto 0);
            shift       : in natural range 0 to (data_length-1);
            out_data    : out std_logic_vector(data_length-1 downto 0)
        );
    end component Right_shifter;

    component Counter_CORDIC is
        generic (data_length: natural := 4);
        port (
            clock           : in std_logic;
            enable_ctr      : in std_logic;
            reset_ctr       : in std_logic;
            count           : out std_logic_vector(data_length-1 downto 0)
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
        clock, divider_done : in std_logic;
        comp_iter, comp_dir : in std_logic_vector(1 downto 0);
        enable, reset, sel_iter, sel_dir, cordic_done : out std_logic
    );
    end component FSM_Cordic;
begin
end architecture CORDIC_arch;