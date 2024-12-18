library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity Right_shifter is
    generic (data_length: natural := 16);
    port (
        in_data     : in std_logic_vector(data_length-1 downto 0);
        shift       : in natural range 0 to (data_length-1);
        out_data    : out std_logic_vector(data_length-1 downto 0)
    );
end entity Right_shifter;
    
architecture Right_shifter_arch of Right_shifter is
begin
    process (in_data, shift)
    begin
        if shift < data_length then
            out_data <= in_data(data_length-1 downto shift) & std_logic_vector(to_unsigned(0, shift));
        else
            out_data <= (others => '0');
        end if;
    end process;
end architecture Right_shifter_arch;