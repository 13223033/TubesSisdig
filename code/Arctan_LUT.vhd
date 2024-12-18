library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

entity Arctan_LUT is
    generic (
        LUT_size : integer := 16;
        data_length : integer := 16);
    port (
        clk         : in std_logic;
        index       : in integer range 0 to LUT_size-1;
        arctan_out  : out real
    );
end entity Arctan_LUT;

architecture Arctan_LUT_arch of Arctan_LUT is
    type real_array is array (0 to LUT_size-1) of real;
    constant arctan_table: real_array := (
        0 => std_logic_vector(to_signed(integer(atan(2.0**(-0)) * 2**(data_length-1)), data_length)),
        1 => std_logic_vector(to_signed(integer(atan(2.0**(-1)) * 2**(data_length-1)), data_length)),
        2 => std_logic_vector(to_signed(integer(atan(2.0**(-2)) * 2**(data_length-1)), data_length)),
        3 => std_logic_vector(to_signed(integer(atan(2.0**(-3)) * 2**(data_length-1)), data_length)),
        4 => std_logic_vector(to_signed(integer(atan(2.0**(-4)) * 2**(data_length-1)), data_length)),
        5 => std_logic_vector(to_signed(integer(atan(2.0**(-5)) * 2**(data_length-1)), data_length)),
        6 => std_logic_vector(to_signed(integer(atan(2.0**(-6)) * 2**(data_length-1)), data_length)),
        7 => std_logic_vector(to_signed(integer(atan(2.0**(-7)) * 2**(data_length-1)), data_length)),
        8 => std_logic_vector(to_signed(integer(atan(2.0**(-8)) * 2**(data_length-1)), data_length)),
        9 => std_logic_vector(to_signed(integer(atan(2.0**(-9)) * 2**(data_length-1)), data_length)),
        10 => std_logic_vector(to_signed(integer(atan(2.0**(-10)) * 2**(data_length-1)), data_length)),
        11 => std_logic_vector(to_signed(integer(atan(2.0**(-11)) * 2**(data_length-1)), data_length)),
        12 => std_logic_vector(to_signed(integer(atan(2.0**(-12)) * 2**(data_length-1)), data_length)),
        13 => std_logic_vector(to_signed(integer(atan(2.0**(-13)) * 2**(data_length-1)), data_length)),
        14 => std_logic_vector(to_signed(integer(atan(2.0**(-14)) * 2**(data_length-1)), data_length)),
        15 => std_logic_vector(to_signed(integer(atan(2.0**(-15)) * 2**(data_length-1)), data_length))
    );
begin
    process (clk)
    begin
        if rising_edge(clk) then
            arctan_out <= arctan_table(index);
        end if;
    end process;
end architecture Arctan_LUT_arch;