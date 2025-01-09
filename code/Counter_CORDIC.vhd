library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity Counter_CORDIC is
    generic (data_length: natural := 4);
    port (
        clock           : in std_logic;
        enable_ctr      : in std_logic;
        reset_ctr       : in std_logic;
        count           : out std_logic_vector(data_length-1 downto 0)
    );
end entity Counter_CORDIC;

architecture Counter_CORDIC_arch of Counter_CORDIC is
    signal temp_count: unsigned (3 downto 0) := "0000";
begin
    process (clock)
	begin
		-- jika clock mengalami perubahan dan bernilai 1
		if rising_edge(clock) then
			-- jika nilai reset adalah 1, maka hasil penghitungan menjadi 0.
			if (reset_ctr = '1') then
				temp_count <= (others => "0000");
			else
			-- jika nilai reset adalah 0, maka...
				-- jika nilai enable adalah 1, maka hasil penghitungan sementara ditambah 1.
				if(enable_ctr = '1') then
					temp_count <= temp_count + 1;
				end if;
			end if;
		end if;
	end process;
	-- hasil penghitungan sementara dimasukkan ke luaran hasil penghitungan. 
	count <= std_logic_vector(temp_count);
end Counter_CORDIC_arch;