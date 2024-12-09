library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity FullAdder is
    port (
        A, B, Cin   : in std_logic;
        Cout, Sum   : out std_logic
    );
end entity FullAdder;

architecture FullAdder_arch of FullAdder is
begin
    Sum <= A XOR B XOR Cin;
    Cout <= (A NAND B) NAND ((A XOR B) NAND Cin);
end architecture FullAdder_arch;