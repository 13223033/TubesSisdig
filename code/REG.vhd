library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity REG is
    generic (data_length: natural);
    port (
        clock       : in std_logic;
        enable      : in std_logic;
        clear       : in std_logic;
        data_in     : in std_logic_vector(data_length-1 downto 0);
        data_out    : out std_logic_vector(data_length-1 downto 0)
    );
end entity REG;

architecture REG_arch of REG is
    signal temp_data: std_logic_vector(data_length-1 downto 0);
begin
    process(clock)
    begin
        if clear = '1' then
            temp_data <= (others => '0');
        elsif rising_edge(clock) then
            if (enable = '1') then
                temp_data <= data_in;
            else
                temp_data <= temp_data;
            end if;
        end if;
    end process;
    data_out <= temp_data;
end architecture REG_arch;