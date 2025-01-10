library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity Arctan_LUT is
    generic (
        data_length : natural := 16);
    port (
        index       : in std_logic_vector(3 downto 0);
        arctan_out  : out std_logic_vector(data_length-1 downto 0)
    );
end entity Arctan_LUT;

architecture Arctan_LUT_arch of Arctan_LUT is
begin
    LUT_ARCTAN: process(index)
    begin
        case index is
        when "0000" => arctan_out <= "0011001001000011";
        when "0001" => arctan_out <= "0001110110101100";
        when "0010" => arctan_out <= "0000111110101101";
        when "0011" => arctan_out <= "0000011111110101";
        when "0100" => arctan_out <= "0000001111111110";
        when "0101" => arctan_out <= "0000000111111111";
        when "0110" => arctan_out <= "0000000011111111";
        when "0111" => arctan_out <= "0000000010000000";
        when "1000" => arctan_out <= "0000000001000000";
        when "1001" => arctan_out <= "0000000000100000";
        when "1010" => arctan_out <= "0000000000010000";
        when "1011" => arctan_out <= "0000000000001000";
        when "1100" => arctan_out <= "0000000000000100";
        when "1101" => arctan_out <= "0000000000000010";
        when "1110" => arctan_out <= "0000000000000001";
        when "1111" => arctan_out <= "0000000000000000";
	    when others => arctan_out <= "0000000000000000";
        end case;
    end process LUT_ARCTAN;
end architecture Arctan_LUT_arch;