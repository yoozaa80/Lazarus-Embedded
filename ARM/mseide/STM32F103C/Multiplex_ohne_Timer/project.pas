program GPIO_Write;
  
procedure Delay;
var
  i: uint32;
begin
  for i := 0 to 1500 do asm nop end;
end;

type
  TMaske = array[0..7] of Byte;
  
const
  maxZiffern = 10;
  Ziffern: array[0..maxZiffern - 1] of TMaske = ((
    %11100000,
    %10100000,
    %10100000,
    %10100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %01000000,
    %11000000,
    %01000000,
    %01000000,
    %01000000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %00100000,
    %11100000,
    %10000000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %00100000,
    %11100000,
    %00100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %10100000,
    %10100000,
    %11100000,
    %00100000,
    %00100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10000000,
    %11100000,
    %00100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10000000,
    %11100000,
    %10100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %00100000,
    %00100000,
    %00100000,
    %00100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10100000,
    %11100000,
    %10100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000), (
    %11100000,
    %10100000,
    %11100000,
    %00100000,
    %11100000,
    %00000000,
    %00000000,
    %00000000));
    
var
  p,
  Zaehler,
  Zahl: integer;
  
procedure TIM2_global_interrupt; public Name 'TIM2_global_interrupt'; interrupt;
begin
  PortC.ODR := $FFFF;
end; 

begin
  Timer2.SR := 0;
  //Timer2.PSC := 0;
  
//  Timer2.CR1 := Timer2.CR1 or TIM_CR1_CEN;
  
//  while Timer2.SR and TIM_SR_UIF do begin
//  end;;
  


  // Ports einschalten
  RCC.APB2ENR := RCC.APB2ENR or (%111 shl 2);

  // Ports auf Ausgabe schalten
  PortA.CRL := $33333333;
  PortA.CRH := $33333333;

  PortB.CRL := $33333333;
  PortB.CRH := $33333333;

  PortC.CRL := $33333333;
  PortC.CRH := $33333333;    
  
  Zahl := 2;
  
  while true do begin  
    Inc(Zaehler); 
    if Zaehler >= 600 then Zaehler := 0;

    if Zaehler = 0 then begin 
      PortC.ODR := not PortC.ODR;    
      Inc(Zahl); 
      if Zahl >= 10 then Zahl := 0;
    end;
  
    Inc(p);
    if p >= 8 then p := 0;
    PortA.ODR := 1 shl p;
    
    PortB.ODR := (Ziffern[Zahl, p] or ((Ziffern[(Zahl + 2) mod 10, p]) shr 5)) shl 8;
//    PortB.ODR := $FF shl 8;

  Delay;

  end;
end.
