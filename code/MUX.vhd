library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity MUX is
    generic (data_length: natural := 16);
    port (
        in_mux_A        : in std_logic_vector(data_length-1 downto 0);
        in_mux_B        : in std_logic_vector(data_length-1 downto 0);
        selector        : in std_logic;
        out_mux         : out std_logic_vector(data_length-1 downto 0)
    );
end entity MUX;

architecture MUX_arch of MUX is
begin
    process (in_mux_A, in_mux_B, selector)
    begin
        if (selector = '1') then
            out_mux <= in_mux_B;
        else
            out_mux <= in_mux_A;
        end if;
    end process;
end architecture MUX_arch;