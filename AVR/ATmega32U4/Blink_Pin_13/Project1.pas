program Project1;

const
  BP5 = 5; // Pin 13 des Arduino
  PC7 = 7;
  sl = 19000;

  procedure mysleep(t: int32);
  var
    i: Int32;
  begin
    for i := 0 to t do begin
      asm
               Nop;
      end;
    end;
  end;

begin
  DDRB := DDRB or (1 shl BP5);
  DDRC := DDRC or (1 shl PC7);
  DDRD := $FF;
  repeat
    PORTC := PORTC or (1 shl PC7);
    PORTD:=$FF;
    mysleep(sl);

    PORTC := PORTC and not (1 shl PC7);
    PORTD:=0;
    mysleep(sl);
  until 1 = 4;
end.
