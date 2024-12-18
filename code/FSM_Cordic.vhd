library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity FSM_Cordic is
    port (
        clock, divider_done : in std_logic;
        comp_iter, comp_dir : in std_logic_vector(1 downto 0);
        enable, reset, sel_iter, sel_dir, cordic_done : out std_logic
    );
end entity FSM_Cordic;

architecture FSM_Cordic_arch of FSM_Cordic is
    type states is (idle, iteration, finish);
    signal current_state, next_state : states;
begin
    change_state: process(clock, divider_done)
    begin 
        if (divider_done = '1') then
            current_state <= idle;
        elsif (rising_edge(clock)) then
            current_state <= next_state;
        end if;
    end process change_state;

    control_fsm: process(current_state, comp_iter)
    begin
        case current_state is
            when idle =>
                next_state <= iteration;

                enable <= '1';
                reset <= '1';
                sel_iter <= '1';
                sel_dir <= '1';
                cordic_done <= '0';
            when iteration =>
                if (comp_iter = "11") then
                    next_state <= finish;

                    enable <= '1';
                    reset <= '0';
                    sel_iter <= '0';
                    cordic_done <= '0';
                elsif (comp_iter = "10") then
                    next_state <= iteration;

                    enable <= '1';
                    reset <= '0';
                    sel_iter <= '0';
                    cordic_done <= '0';
                    if (comp_dir = "10") then
                        sel_dir <= '0';
                    else
                        sel_dir <= '1';
                    end if;
                else
                    next_state <= idle;
                end if;
            when finish =>
                next_state <= idle;

                enable <= '0';
                reset <= '1';
                sel_iter <= '0';
                cordic_done <= '1';
        end case;
    end process control_fsm;
end architecture FSM_Cordic_arch;
