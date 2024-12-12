library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity Adder is
    generic (data_length: natural);
    port (
        in_A, in_B  : in std_logic_vector((data_length-1) downto 0);
        output      : out std_logic_vector(data_length downto 0)
    );
end entity Adder;

architecture Adder_arch of Adder is
    component FullAdder is
        port (
            A, B, Cin   : in std_logic;
            Cout, Sum   : out std_logic
        );
    end component FullAdder;

    signal carry: std_logic_vector(data_length downto 0);
begin
    carry(0) <= '0';
    GEN_ADDER: for i in 0 to data_length-1 generate
        ADDER: FullAdder port map (
            A => in_A(i),
            B => in_B(i),
            Cin => carry(i),
            Cout => carry(i+1),
            Sum => output(i)
        );
    end generate GEN_ADDER;
end architecture Adder_arch;