library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Comparator is
    generic (data_length : natural := 16);
    port (
        in_a, in_b : in std_logic_vector((data_length-1) downto 0);
        output : out std_logic_vector(1 downto 0)
    );
end entity Comparator;

architecture Comparator_arch of Comparator is
begin
    compare: process(in_a, in_b)
        variable signed_a, signed_b : signed((data_length-1) downto 0);
    begin
        -- Convert std_logic_vector to signed
        signed_a := signed(in_a);
        signed_b := signed(in_b);

        -- Perform signed comparison
        if (signed_a > signed_b) then output <= "01";
        elsif (signed_a < signed_b) then output <= "10";
        elsif (signed_a = signed_b) then output <= "11";
        else output <= "00";
        end if;
    end process compare;
end architecture Comparator_arch;




-- library ieee;
--     use ieee.std_logic_1164.all;
--     use ieee.numeric_std.all;

-- entity Comparator is
--     generic (data_length : natural := 16);
--     port (
--         in_a, in_b : in std_logic_vector((data_length-1) downto 0);
--         output : out std_logic_vector(1 downto 0)
--     );
-- end entity Comparator;

-- architecture Comparator_arch of Comparator is
-- begin
--     compare: process(in_a, in_b)
--     begin
--         if (in_a > in_b) then output <= "01";
--         elsif (in_a < in_b) then output <= "10";
--         elsif (in_a = in_b) then output <= "11";
--         else output <= "00";
--         end if;
--     end process compare;
-- end architecture Comparator_arch;
