library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity Right_shifter is
    generic (data_length: natural := 16);
    port (
        in_data     : in std_logic_vector(data_length-1 downto 0);
        shift       : in std_logic_vector(3 downto 0);
        out_data    : out std_logic_vector(data_length-1 downto 0)
    );
end entity Right_shifter;
    
architecture Right_shifter_arch of Right_shifter is
    signal shifted : std_logic_vector (data_length-1 downto 0);
    signal zeros : std_logic_vector (data_length-1 downto 0):="0000000000000000";
    signal ones  : std_logic_vector (data_length-1 downto 0):="1111111111111111";

begin
    process (in_data, shift)
        variable shift_amount : integer;
    begin
        shift_amount := to_integer(unsigned(shift));
        if shift_amount < data_length then
            if NOT(shift_amount=0) then
                if in_data(data_length-1)='0' then
                    shifted(data_length-1-1-shift_amount downto 0) <= in_data(data_length-1-1 downto shift_amount);
                    shifted(data_length-1-1 downto data_length-shift_amount) <=zeros(data_length-1-1 downto data_length-shift_amount);
                    shifted(data_length-1) <=in_data(data_length-1);
                else
                    shifted(data_length-1-1-shift_amount downto 0) <= in_data(data_length-1-1 downto shift_amount);
                    shifted(data_length-1-1 downto data_length-shift_amount) <=ones(data_length-1-1 downto data_length-shift_amount);
                    shifted(data_length-1) <=in_data(data_length-1);
                end if;
            else
                shifted<=in_data;
            end if;
        else
            shifted <= zeros;
        end if;
    end process;
out_data<=shifted;
end architecture Right_shifter_arch;
-- architecture Right_shifter_arch of Right_shifter is
-- begin
--     process (in_data, shift)
--     begin
--         if shift < unsigned(data_length) then
--             out_data <= in_data(data_length-1 downto shift) & std_logic_vector(to_unsigned(0, shift));
--         else
--             out_data <= (others => '0');
--         end if;
--     end process;
-- end architecture Right_shifter_arch;