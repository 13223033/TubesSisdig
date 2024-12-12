library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

entity Arctan is
    generic (LUT_size : integer := 16);
    port (
        clk         : in std_logic;
        index       : in integer range 0 to LUT_size-1;
        arctan_out  : out real
    );
end entity Arctan;

architecture Arctan_arch of Arctan is
    type real_array is array (0 to LUT_size-1) of real;
    constant arctan_table: real_array := (
        0 => atan(2.0**(-0)),
        1 => atan(2.0**(-1)),
        2 => atan(2.0**(-2)),
        3 => atan(2.0**(-3)),
        4 => atan(2.0**(-4)),
        5 => atan(2.0**(-5)),
        6 => atan(2.0**(-6)),
        7 => atan(2.0**(-7)),
        8 => atan(2.0**(-8)),
        9 => atan(2.0**(-9)),
        10 => atan(2.0**(-10)),
        11 => atan(2.0**(-11)),
        12 => atan(2.0**(-12)),
        13 => atan(2.0**(-13)),
        14 => atan(2.0**(-14)),
        15 => atan(2.0**(-15))
    );
begin
    process (clk)
    begin
        if rising_edge(clk) then
            arctan_out <= arctan_table(index);
        end if;
    end process;
end architecture Arctan_arch;