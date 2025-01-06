library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

-- VHDL comparator 16B (khusus 16B signed)
entity comparator16B is
    Port (
        a       : in  STD_LOGIC_VECTOR(15 downto 0);
        b       : in  STD_LOGIC_VECTOR(15 downto 0);
        greater : out STD_LOGIC
    );
end entity;

architecture Behavioral of comparator16B is
begin
    process(a, b)
    begin
        if (a(15) = '0' and b(15) = '1') then
            -- a positif and b is negatif
            greater <= '1';
        elsif (a(15) = '1' and b(15) = '0') then
            -- a negatif and b positif
            greater <= '0';
        elsif (a(15) = b(15)) then
            -- kasus keduanya positif atau negatif 
            if a(15) = '0' then
                -- kedua positif (biasa)
                if unsigned(a(14 downto 0)) > unsigned(b(14 downto 0)) then
                    greater <= '1';
                else
                    greater <= '0';
                end if;
            else
                -- kedua negatif (berkebalikan)
                if unsigned(a(14 downto 0)) < unsigned(b(14 downto 0)) then
                    greater <= '1';
                else
                    greater <= '0';
                end if;
            end if;
        else
            -- perandaian bila gaada yang memenuhi 
            greater <= '0';
        end if;
    end process;
end Behavioral;
