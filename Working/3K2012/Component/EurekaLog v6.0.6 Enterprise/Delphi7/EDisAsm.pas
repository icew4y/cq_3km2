{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Disassembler Unit - EDebug            }
{                                                }
{************************************************}

// ----------------------------------------------
// 12-October-2006   Modify by Fabio Dell'Aria. |
// ----------------------------------------------

// --------------------------------------
// Original FreeWare software from:     |
// Author: Python (python@softhome.net) |
// http://www.ggoossen.net/revendepro   |
// --------------------------------------

unit EDisAsm;

{$I Exceptions.inc}

interface

uses
  SysUtils, Windows;

type
  TRegister = (rEax, rEcx, rEdx, rEbx, rEsp, rEbp, rEsi, rEdi);

  TdaRef = record
    MultiplyReg1: Integer;
    ARegister1: TRegister;
    MultiplyReg2: Integer;
    ARegister2: TRegister;
    Immidiate: PChar;
  end;

  TJumpInstrProc = procedure(Param: Pointer; ValueAddress, JumpAddress: PChar; var Result: string);
  TCallInstrProc = procedure(Param: Pointer; ValueAddress, CallAddress: PChar; var Result: string);
  TAddressRefProc = procedure(Param: Pointer; ValueAddress, RefAddress: PChar; var Result: string);
  TRefProc = procedure(Param: Pointer; Ref: TdaRef; RefSize: Integer; var Result: string);
  TImmidiateDataProc = procedure(Param: Pointer; ValueAddress: PChar; OperandSize: Integer; Sigend: Boolean; var Result: string);

  TDisAsm = class(TObject)
  public
    OnJumpInstr: TJumpInstrProc;
    OnCallInstr: TCallInstrProc;
    OnAddressRef: TAddressRefProc;
    OnRef: TRefProc;
    OnImmidiateData: TImmidiateDataProc;
    Param: Pointer;
    function GetInstruction(Address: PChar; var Size: Integer): string;
  end;

implementation

const
  modrmReg = $38; // Reg part of the ModRM byte, ??XXX???
  modrmMod = $C0; // Mod part of the ModRM byte, XX??????
  modrmRM = $07; // RM part of the ModRM byte,  ?????XXX

  OneByteOpcodes: array[char] of string =
  // 0
  ('add     #Eb , #Gb ', 'add     #Ev , #Gv ', 'add     #Gb , #Eb ',
    'add     #Gv , #Ev ', 'add     al, #Hb ', 'add     @eax, #Hv ',
    'push    es', 'pop     es', 'or      #Eb , #Gb ', 'or      #Ev , #Gv ',
    'or      #Gb , #Eb ', 'or      #Gv , #Ev ', 'or      al, #Ib ',
    'or      @eax, #Iv ', 'push    cs', '@c2',
    // 1
    'adc     #Eb , #Gb ', 'adc     #Ev , #Gv ', 'adc     #Gb , #Eb ',
    'adc     #Gv , #Ev ', 'adc     al, #Ib ', 'adc     @eax, #Iv ',
    'push    ss', 'pop     ss', 'sbb     #Eb , #Gb ', 'sbb     #Ev , #Gv ',
    'sbb     #Gb , #Eb ', 'sbb     #Gv , #Ev ', 'sbb     al, #Ib ',
    'sbb     @eax, #Iv ', 'push    ds', 'pop     ds',
    // 2
    'and     #Eb , #Gb ', 'and     #Ev , #Gv ', 'and     #Gb , #Eb ',
    'and     #Gv , #Ev ', 'and     al, #Ib ', 'and     @eax, #Iv ',
    '@pe', 'daa', 'sub     #Eb , #Gb ', 'sub     #Ev , #Gv @m ',
    'sub     #Gb , #Eb ', 'sub     #Gv , #Ev @m ', 'sub     al, #Ib ',
    'sub     @eax, #Iv ', '@pc', 'das',
    // 3
    'xor     #Eb , #Gb ', 'xor     #Ev , #Gv ', 'xor     #Gb , #Eb ',
    'xor     #Gv , #Ev ', 'xor     al, #Ib ', 'xor     @eax, #Iv ',
    '@ps', 'aaa', 'cmp     #Eb , #Gb ', 'cmp     #Ev , #Gv ',
    'cmp     #Gb , #Eb ', 'cmp     #Gv , #Ev ', 'cmp     al, #Ib ',
    'cmp     @eax, #Iv ', '@pd', 'aas',
    // 4
    'inc     @eax', 'inc     @ecx', 'inc     @edx', 'inc     @ebx',
    'inc     @esp', 'inc     @ebp', 'inc     @esi', 'inc     @edi',
    'dec     @eax', 'dec     @ecx', 'dec     @edx', 'dec     @ebx',
    'dec     @esp', 'dec     @ebp', 'dec     @esi', 'dec     @edi',
    // 5
    'push    @eax', 'push    @ecx', 'push    @edx', 'push    @ebx',
    'push    @esp', 'push    @ebp', 'push    @esi', 'push    @edi',
    'pop     @eax', 'pop     @ecx', 'pop     @edx', 'pop     @ebx',
    'pop     @esp', 'pop     @ebp', 'pop     @esi', 'pop     @edi',
    // 6
    'pusha', 'popa', 'bound   #Gv , #Ma ', 'arpl    #Ew , #Gw ',
    '@pf', '@pg', '@so', '@sa',
    'push    #Iv ', 'imul    #Gv , #Ev , #Iv ', 'push    #Ib ',
    'imul    #Gv , #Ev , #Ib ', 'insb', 'ins@o4', 'outsb', 'outs@o4',
    // 7
    'jo      #Jbj', 'jno     #Jbj', 'jb      #Jbj', 'jnb     #Jbj',
    'jz      #Jbj', 'jnz     #Jbj', 'jbe     #Jbj', 'jnbe    #Jbj',
    'js      #Jbj', 'jns     #Jbj', 'jp      #Jbj', 'jnp     #Jbj',
    'jl      #Jbj', 'jnl     #Jbj', 'jle     #Jbj', 'jnle    #Jbj',
    // 8
    '@ga#Eb , #Ib ', '@ga#Ev , #Iv ', '@ga#Ev , #Ib ', '@ga#Ev , #Hb ',
    'test    #Eb , #Gb ', 'test    #Ev , #Gv ', 'xchg    #Eb , #Gb ',
    'xchg    #Ev , #Gv ', 'mov     #Eb , #Gb ', 'mov     #Ev , #Gv ',
    'mov     #Gb , #Eb ', 'mov     #Gv , #Ev ', 'mov     #Ew , #Sw ',
    'lea     #Gv , #M  ', 'mov     #Sw , #Ew ', 'pop     #Ev ',
    // 9
    'nop', 'xchg    eax, @ecx', 'xchg    eax, @edx', 'xchg    eax, @ebx',
    'xchg    eax, @esp', 'xchg    eax, @ebp', 'xchg    eax, @esi',
    'xchg    eax, @edi', 'c@o2@o4@e ', 'c@o4@o8', 'call    #Ap ', 'wait',
    'pushf   #Fv ', 'pop     #Fv ', 'sahf', 'lahf',
    // A
    'mov     al, #Ob ', 'mov     @eax, #Ov ', 'mov     #Ob , al',
    'mov     #Ov , @eax', 'movsb', 'movs@o4', 'cmpsb', 'cmps@o4',
    'test    al, #Ib ', 'test    @eax, #Iv ', 'stosb', 'stos@o4',
    'lodsb', 'lods@o4', 'scasb', 'scas@o4',
    // B
    'mov     al, #Ib ', 'mov     cl, #Ib ', 'mov     dl, #Ib ',
    'mov     bl, #Ib ', 'mov     ah, #Ib ', 'mov     ch, #Ib ',
    'mov     dh, #Ib ', 'mov     bh, #Ib ', 'mov     @eax, #Iv ',
    'mov     @ecx, #Iv ', 'mov     @edx, #Iv ', 'mov     @ebx, #Iv ',
    'mov     @esp, #Iv ', 'mov     @ebp, #Iv ', 'mov     @esi, #Iv ',
    'mov     @edi, #Iv ',
    // C
    '@gb#Eb , #Ib ', '@gb#Ev , #Ib ', 'ret     #Ib ', 'ret',
    '%c les     #Gv , #Mp ', 'lds     #Gv , #Mp ', 'mov     #Eb , #Ib ',
    'mov     #Ev , #Iv ', 'enter   #Lw , #Ib ', 'leave', 'ret     #Lw ', 'ret',
    'int     3', 'int     #Ib ', 'into', 'iret',
    // D
    '@gb#Eb , 1', '@gb#Ev , 1', '@gb#Eb , cl', '@gb#Ev , cl', 'aam', 'aad',
    '%c ', 'xlat', '@ca', '@cb', '@cc', '@cd', '@ce', '@cf', '@cg', '@ch',
    // E
    'loopn   #Jbj', 'loope   #Jbj', 'loop    #Jbj', 'jcxz    #Jbj',
    'in      al, #Ib ', 'in      @eax, #Ib ', 'out     #Ib , al',
    'out     #Ib , @eax', 'call    #Jvc', 'jmp     #Jvj', 'jmp     #Ap ',
    'jmp     #Jbj', 'in      al, dx', 'in      @eax, dx', 'out     dx, al',
    'out     dx, @eax',
    // F
    'lock', '%c ', 'repne', 'rep', 'hlt', 'cmc', '@gc#Eb @h1', '@gc#Ev @h2 ',
    'clc', 'stc', 'cli', 'sti', 'cld', 'std', '@gd@h3', '@ge@h4');

  // @c2
  TwoByteOpcodes: array[char] of string =
  // 0
  ('@gf', '%c ', 'lar     #Gv , #Ew ', 'lsl     #Gv , #Ew ',
    '%c ', '%c ', 'ctls', '%c ', 'invd', 'wbinvd', '%c ', 'ud2',
    '%c ', '%c ', '%c ', '%c ',
    // 1
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    // 2
    'mov     #Rd , #Cd ', 'mov     #Rd , #Dd ', 'mov     #Cd , #Rd ',
    'mov     #Dd , #Cd ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    // 3
    'wrmsr', 'rdtsc', 'rdmsr', 'rdpmc', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    // 4
    'cmovo   #Gv , #Ev ', 'cmovno  #Gv , #Ev ', 'cmovb   #Gv , #Ev ',
    'cmovnb  #Gv , #Ev ', 'cmove   #Gv , #Ev ', 'cmovne  #Gv , #Ev ',
    'cmovbe  #Gv , #Ev ', 'cmovnbe #Gv , #Ev ', 'cmovs   #Gv , #Ev ',
    'cmovns  #Gv , #Ev ', 'cmovp   #Gv , #Ev ', 'cmovnp  #Gv , #Ev ',
    'cmovl   #Gv , #Ev ', 'cmovnl  #Gv , #Ev ', 'cmovle  #Gv , #Ev ',
    'cmovnle #Gv , #Ev ',
    // 5
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    // 6
    '%c punpcklbw #Pq , #Qd ', '%c punpcklwd #Pq , #Qd ',
    '%c punpckldq #Pq , #Qd ', '%c packusdw #Pq , #Qd ',
    '%c pcmpgtb #Pq , #Qd ', '%c pcmpgtw #Pq , #Qd ',
    '%c pcmpgtd #Pq , #Qd ', '%c packsswb #Pq , #Qd ',
    '%c punpckhbw #Pq , #Qd ', '%c punpckhwd #Pq , #Qd ',
    '%c punpckhdq #Pq , #Qd ', '%c packssdw #Pq , #Qd ',
    '%c ', '%c ', 'movd    #Pd , #Ed ', 'movq    #Pq , #Qq ',
    // 7
    '%c ', '@gg', '@gh', '@gi', 'pcmpeqb #Pq , #Qd ', 'pcmpeqw #Pq , #Qd ',
    'pcmpeqd #Pq , #Qd ', 'emms', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    'movd    #Ed , #Pd ', 'movq    #Qq , #Pq ',
    // 8
    'jo      #Jvj', 'jno     #Jvj', 'jb      #Jvj', 'jnb     #Jvj',
    'jz      #Jvj', 'jnz     #Jvj', 'jbe     #Jvj', 'jnbe    #Jvj',
    'js      #Jvj', 'jns     #Jvj', 'jp      #Jvj', 'jnp     #Jvj',
    'jl      #Jvj', 'jnl     #Jvj', 'jle     #Jvj', 'jnle    #Jvj',
    // 9
    'seto    #Eb ', 'setno   #Eb ', 'setb    #Eb ', 'setnb   #Eb ',
    'setz    #Eb ', 'setnz   #Eb ', 'setbe   #Eb ', 'setnbe  #Eb ',
    'sets    #Eb ', 'setns   #Eb ', 'setp    #Eb ', 'setnp   #Eb ',
    'setl    #Eb ', 'setnl   #Eb ', 'setle   #Eb ', 'setnle  #Eb ',
    // A
    'push    fs', 'pop     fs', 'cpuid', 'bt      #Ev , #Gv %m ',
    'shld    #Ev , #Gv , #Ib ', 'shld    #Ev , #Gv , cl', '%c ', '%c ',
    'push    gs', 'pop     gs', 'rsm', 'bts     #Ev , #Gv ',
    'shrd    #Ev , #Gv , #Ib ', 'shrd    #Ev , #Gv , cl', '%c ',
    'imul    #Gv , #Ev ',
    // B
    'cmpxchg #Eb , #Gb ', 'cmpxchg #Ev , #Gv ', 'lss     #Mp ',
    'btr     #Ev , #Gv ', 'lfs     #Mp ', 'lgs     #Mp ',
    'movzx   #Gv , @m #Eb ', 'movzx   #Gv , @m #Ew ', '%c ', 'ud2',
    '@gb     #Ev , #Ib ', 'btc     #Ev , #Gv ', 'bsf     #Gv , #Ev ',
    'bsr     #Gv , #Ev ', 'movsx   #Gv ,@m  #Eb ', 'movsx   #Gv ,@m  #Ew ',
    // C
    'xadd   #Eb , #Gb ', 'xadd    #Ev , #Gv ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '@gj', 'bswap   @eax', 'bswap   @ecx',
    'bswap   @edx', 'bswap   @ebx', 'bswap   @esp', 'bswap   @ebp',
    'bswap   @esi', 'bswap   @edi',
    // D
    '%c ', 'psrlw   #Pq , #Qd ', 'psrld   #Pq , #Qd ', 'prslq   #Pq , #Qd ',
    '%c ', 'pmullw  #Pq , #Qd ', '%c ', '%c ',
    'pcubusb #Pq , #Qq ', 'pcubusw #Pq , #Qq ', '%c ', 'pand    #Pq , #Qq ',
    'paddusb #Pq , #Qq ', 'paddusw #Pq , #Qq ', '%c ', 'pandn   #Pq , #Qq ',
    // E
    '%c ', 'psraw   #Pq , #Qd ', 'psrad   #Pq , #Qd ', '%c ',
    '%c ', 'pmulhw  #Pq , #Qd ', '%c ', '%c ',
    'psubsb  #Pq , #Qq ', 'psubsw  #Pq , #Qq ', '%c ', 'por     #Pq , #Qq ',
    'paddsb  #Pq , #Qq ', 'paddsw  #Pq , #Qq ', '%c ', 'pxor    #Pq , #Qq ',
    // F
    '%c ', 'psllw   #Pq , #Qd ', 'pslld   #Pq , #Qd ', 'prllq   #Pq , #Qd ',
    '%c ', 'pmaddwd #Pq , #Qd ', '%c ', '%c ',
    'psubb   #Pq , #Qq ', 'psubw   #Pq , #Qq ', 'psubd   #Pq , #Qq ', '%c ',
    'paddb   #Pq , #Qq ', 'paddw   #Pq , #Qq ', 'paddd   #Pq , #Qq ', '%c ');

  // @g
  GroupsOpcodes: array['a'..'j', 0..7] of string =
  // 'a'
  (('add     ', 'or      ', 'adc     ', 'sbb     ',
    'and     ', 'sub     ', 'xor     ', 'cmp     '),
    // 'b'
    ('rol     ', 'ror     ', 'rcl     ', 'rcr     ',
    'shl     ', 'shr     ', '%c       ', 'sar     '),
    // 'c'
    ('test    ', '%c       ', 'not     ', 'neg     ',
    'mul     ', 'imul    ', 'div     ', 'idiv    '),
    // 'd'
    ('inc     ', 'dec     ', '%c       ', '%c       ',
    '%c       ', '%c       ', '%c       ', '%c       '),
    // 'e'
    ('inc     ', 'dec     ', 'call    ', 'call    ',
    'jmp     ', 'jmp     ', 'push    ', '%c       '),
    // 'f'
    ('sldt    #Ew ', 'str     #Ew ', 'lldt    #Ew ', 'ltr     #Ew ',
    'verr    #Ew ', 'verw    #Ew ', '%c       ', '%c       '),
    // 'g'
    ('%c ', '%c ', 'psrld   #Pq , #Ib ', '%c ',
    'psrad   #Pq , #Ib ', '%c ', 'pslld   #Pq , #Ib ', '%c '),
    // 'h'
    ('%c ', '%c ', 'psrlw   #Pq , #Ib ', '%c ',
    'psraw   #Pq , #Ib ', '%c ', 'psllw   #Pq , #Ib ', '%c '),
    // 'i'
    ('%c ', '%c ', 'psrlq   #Pq , #Ib ', '%c ',
    '%c ', '%c ', 'psllq   #Pq , #Ib ', '%c '),
    // 'j'
    ('%c ', 'cmpxchg8b #Mq ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c '));

  // @h
  GroupsOperands: array['1'..'4', 0..7] of string =
  // '1'  Group 3 with 8 bit operand
  ((', #Ib ', '', '', '', ', al', ', al', '', ''),
    // '2'  Group 3 with 16/32 bit operand
    (', #Iv ', '', '', '', '', '', '', ''),
    // '3'  Group 4
    ('#Eb ', '#Eb ', '', '', '', '', '', ''),
    // '4'  Group 5
    ('#Ev ', '#Ev ', '#Ev ', '#Ep ', '#Ev ', '#Ep ', '#Ev ', ''));

  // @c
  // $b8 .. $bf represent 0..7 for when modrm byte is within $00 to $bf
  FloatingPointOpcodes: array['a'..'h', $B8..$FF] of string =
  // 'a'
  (('fadd    #Ed ', 'fmul    #Ed ', 'fcom    #Ed ', 'fcomp   #Ed ',
    'fsub    #Ed ', 'fsubr   #Ed ', 'fdiv    #Ed ', 'fdivr   #Ed ',
    'fadd    st(0)', 'fadd    st(1)', 'fadd    st(2)', 'fadd    st(3)',
    'fadd    st(4)', 'fadd    st(5)', 'fadd    st(6)', 'fadd    st(7)',
    'fmul    st(0), st(0)', 'fmul    st(0), st(1)', 'fmul    st(0), st(2)',
    'fmul    st(0), st(3)', 'fmul    st(0), st(4)', 'fmul    st(0), st(5)',
    'fmul    st(0), st(6)', 'fmul    st(0), st(7)',
    'fcom    st(0)', 'fcom    st(1)', 'fcom    st(2)', 'fcom    st(3)',
    'fcom    st(4)', 'fcom    st(5)', 'fcom    st(6)', 'fcom    st(7)',
    'fcomp   st(0)', 'fcomp   st(1)', 'fcomp   st(2)', 'fcomp   st(3)',
    'fcomp   st(4)', 'fcomp   st(5)', 'fcomp   st(6)', 'fcomp   st(7)',
    'fsub    st(0), st(0)', 'fsub    st(0), st(1)', 'fsub    st(0), st(2)',
    'fsub    st(0), st(3)', 'fsub    st(0), st(4)', 'fsub    st(0), st(5)',
    'fsub    st(0), st(6)', 'fsub    st(0), st(7)', 'fsubr   st(0), st(0)',
    'fsubr   st(0), st(1)', 'fsubr   st(0), st(2)', 'fsubr   st(0), st(3)',
    'fsubr   st(0), st(4)', 'fsubr   st(0), st(5)', 'fsubr   st(0), st(6)',
    'fsubr   st(0), st(7)', 'fdiv    st(0), st(0)', 'fdiv    st(0), st(1)',
    'fdiv    st(0), st(2)', 'fdiv    st(0), st(3)', 'fdiv    st(0), st(4)',
    'fdiv    st(0), st(5)', 'fdiv    st(0), st(6)', 'fdiv    st(0), st(7)',
    'fdivr   st(0), st(0)', 'fdivr   st(0), st(1)', 'fdivr   st(0), st(2)',
    'fdivr   st(0), st(3)', 'fdivr   st(0), st(4)', 'fdivr   st(0), st(5)',
    'fdivr   st(0), st(6)', 'fdivr   st(0), st(7)'),
    // 'b'
    ('fld     #Ed ', '%c ', 'fst     #Ed ', 'fstp    #Ed ',
    'fldenv  #E  ', 'fldcw   #Ew ', 'fstenv  #E  ', 'fstcw   #Ew ',
    'fld     st(0)', 'fld     st(1)', 'fld     st(2)', 'fld     st(3)',
    'fld     st(4)', 'fld     st(5)', 'fld     st(6)', 'fld     st(7)',
    'fxch    st(0)', 'fxch    st(1)', 'fxch    st(2)', 'fxch    st(3)',
    'fxch    st(4)', 'fxch    st(5)', 'fxch    st(6)', 'fxch    st(7)',
    'fnop', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', 'fchs', 'fabs', '%c ', '%c ',
    'ftst', 'fxam', '%c ', '%c ', 'fld1', 'fldl2t', 'fldl2e', 'fldp1',
    'fldlg2', 'fldln2', 'fldz', '%c ', 'f2xm1', 'fyl2x', 'fptan', 'fpatan',
    'fxtract', 'fprem1', 'fdecstp', 'fincstp', 'fprem', 'fyl2xp1', 'fsqrt',
    'fsincos', 'frndint', 'fscale', 'fsing', 'fcos'),
    // 'c'
    ('fiadd   #Ed ', 'fimul   #Ed ', 'ficom   #Ed ', 'ficomp  #Ed ',
    'fisub   #Ed ', 'fisubr  #Ed ', 'fidiv   #Ed ', 'fidivr  #Ed ',
    'fcmovb  st(0), st(0)', 'fcmovb  st(0), st(1)', 'fcmovb  st(0), st(2)',
    'fcmovb  st(0), st(3)', 'fcmovb  st(0), st(4)', 'fcmovb  st(0), st(5)',
    'fcmovb  st(0), st(6)', 'fcmovb  st(0), st(7)', 'fcmove  st(0), st(0)',
    'fcmove  st(0), st(1)', 'fcmove  st(0), st(2)', 'fcmove  st(0), st(3)',
    'fcmove  st(0), st(4)', 'fcmove  st(0), st(5)', 'fcmove  st(0), st(6)',
    'fcmove  st(0), st(7)', 'fcmovbe st(0), st(0)', 'fcmovbe st(0), st(1)',
    'fcmovbe st(0), st(2)', 'fcmovbe st(0), st(3)', 'fcmovbe st(0), st(4)',
    'fcmovbe st(0), st(5)', 'fcmovbe st(0), st(6)', 'fcmovbe st(0), st(7)',
    'fcmovu  st(0), st(0)', 'fcmovu  st(0), st(1)', 'fcmovu  st(0), st(2)',
    'fcmovu  st(0), st(3)', 'fcmovu  st(0), st(4)', 'fcmovu  st(0), st(5)',
    'fcmovu  st(0), st(6)', 'fcmovu  st(0), st(7)', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', 'fucompp', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c '),
    // 'd'
    ('fild    #Ed ', '%c ', 'fist    #Ed ', 'fistp   #Ed ',
    '%c ', 'fld     #Et ', '%c ', 'fstp    #Et ',
    'fcmovnb st(0), st(0)', 'fcmovnb st(0), st(1)', 'fcmovnb st(0), st(2)',
    'fcmovnb st(0), st(3)', 'fcmovnb st(0), st(4)', 'fcmovnb st(0), st(5)',
    'fcmovnb st(0), st(6)', 'fcmovnb st(0), st(7)', 'fcmovne st(0), st(0)',
    'fcmovne st(0), st(1)', 'fcmovne st(0), st(2)', 'fcmovne st(0), st(3)',
    'fcmovne st(0), st(4)', 'fcmovne st(0), st(5)', 'fcmovne st(0), st(6)',
    'fcmovne st(0), st(7)', 'fcmovnbe st(0), st(0)', 'fcmovnbe st(0), st(1)',
    'fcmovnbe st(0), st(2)', 'fcmovnbe st(0), st(3)', 'fcmovnbe st(0), st(4)',
    'fcmovnbe st(0), st(5)', 'fcmovnbe st(0), st(6)', 'fcmovnbe st(0), st(7)',
    'fcmovnu st(0), st(0)', 'fcmovnu st(0), st(1)', 'fcmovnu st(0), st(2)',
    'fcmovnu st(0), st(3)', 'fcmovnu st(0), st(4)', 'fcmovnu st(0), st(5)',
    'fcmovnu st(0), st(6)', 'fcmovnu st(0), st(7)', '%c ', '%c ',
    'fclex', 'finit', '%c ', '%c ', '%c ', '%c ', 'fucomi  st(0), st(0)',
    'fucomi  st(0), st(1)', 'fucomi  st(0), st(2)', 'fucomi  st(0), st(3)',
    'fucomi  st(0), st(4)', 'fucomi  st(0), st(5)', 'fucomi  st(0), st(6)',
    'fucomi  st(0), st(7)', 'fcomi   st(0), st(0)', 'fcomi   st(0), st(1)',
    'fcomi   st(0), st(2)', 'fcomi   st(0), st(3)', 'fcomi   st(0), st(4)',
    'fcomi   st(0), st(5)', 'fcomi   st(0), st(6)', 'fcomi   st(0), st(7)',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c '),
    // 'e'
    ('fadd    #Eq ', 'fmul    #Eq ', 'fcom    #Eq ', 'fcomp   #Eq ',
    'fsub    #Eq ', 'fsubr   #Eq ', 'fdiv    #Eq ', 'fdivr   #Eq ',
    'fadd    st(0), st(0)', 'fadd    st(1), st(0)', 'fadd    st(2), st(0)',
    'fadd    st(3), st(0)', 'fadd    st(4), st(0)', 'fadd    st(5), st(0)',
    'fadd    st(6), st(0)', 'fadd    st(7), st(0)', 'fmul    st(0), st(0)',
    'fmul    st(1), st(0)', 'fmul    st(2), st(0)', 'fmul    st(3), st(0)',
    'fmul    st(4), st(0)', 'fmul    st(5), st(0)', 'fmul    st(6), st(0)',
    'fmul    st(7), st(0)', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    'fsubr   st(0), st(0)', 'fsubr   st(1), st(0)', 'fsubr   st(2), st(0)',
    'fsubr   st(3), st(0)', 'fsubr   st(4), st(0)', 'fsubr   st(5), st(0)',
    'fsubr   st(6), st(0)', 'fsubr   st(7), st(0)', 'fsub    st(0), st(0)',
    'fsub    st(1), st(0)', 'fsub    st(2), st(0)', 'fsub    st(3), st(0)',
    'fsub    st(4), st(0)', 'fsub    st(5), st(0)', 'fsub    st(6), st(0)',
    'fsub    st(7), st(0)', 'fdivr   st(0), st(0)', 'fdivr   st(1), st(0)',
    'fdivr   st(2), st(0)', 'fdivr   st(3), st(0)', 'fdivr   st(4), st(0)',
    'fdivr   st(5), st(0)', 'fdivr   st(6), st(0)', 'fdivr   st(7), st(0)',
    'fdiv    st(0), st(0)', 'fdiv    st(1), st(0)', 'fdiv    st(2), st(0)',
    'fdiv    st(3), st(0)', 'fdiv    st(4), st(0)', 'fdiv    st(5), st(0)',
    'fdiv    st(6), st(0)', 'fdiv    st(7), st(0)'),
    // 'f'
    ('fld     #Eq ', '%c ', 'fst     #Eq ', 'fstp    #Eq ',
    'frstor  #E  ', '%c ', 'fsave   #E  ', 'fstsw   #Ew ',
    'ffree   st(0)', 'ffree   st(1)', 'ffree   st(2)', 'ffree   st(3)',
    'ffree   st(4)', 'ffree   st(5)', 'ffree   st(6)', 'ffree   st(7)',
    '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ',
    'fst     st(0)', 'fst     st(1)', 'fst     st(2)', 'fst     st(3)',
    'fst     st(4)', 'fst     st(5)', 'fst     st(6)', 'fst     st(7)',
    'fstp    st(0)', 'fstp    st(1)', 'fstp    st(2)', 'fstp    st(3)',
    'fstp    st(4)', 'fstp    st(5)', 'fstp    st(6)', 'fstp    st(7)',
    'fucom   st(0), st(0)', 'fucom   st(1), st(0)', 'fucom   st(2), st(0)',
    'fucom   st(3), st(0)', 'fucom   st(4), st(0)', 'fucom   st(5), st(0)',
    'fucom   st(6), st(0)', 'fucom   st(7), st(0)', 'fucomp  st(0)',
    'fucomp  st(1)', 'fucomp  st(2)', 'fucomp  st(3)', 'fucomp  st(4)',
    'fucomp  st(5)', 'fucomp  st(6)', 'fucomp  st(7)', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c '),
    // 'g'
    ('fiadd   #Ew ', 'fimul   #Ew ', 'ficom   #Ew ', 'ficomp  #Ew ',
    'fisub   #Ew ', 'fisubr  #Ew ', 'fidiv   #Ew ', 'fidivr  #Ew ',
    'faddp   st(0), st(0)', 'faddp   st(1), st(0)', 'faddp   st(2), st(0)',
    'faddp   st(3), st(0)', 'faddp   st(4), st(0)', 'faddp   st(5), st(0)',
    'faddp   st(6), st(0)', 'faddp   st(7), st(0)', 'fmulp   st(0), st(0)',
    'fmulp   st(1), st(0)', 'fmulp   st(2), st(0)', 'fmulp   st(3), st(0)',
    'fmulp   st(4), st(0)', 'fmulp   st(5), st(0)', 'fmulp   st(6), st(0)',
    'fmulp   st(7), st(0)', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', 'fcompp', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    'fsubrp  st(0), st(0)', 'fsubrp  st(1), st(0)', 'fsubrp  st(2), st(0)',
    'fsubrp  st(3), st(0)', 'fsubrp  st(4), st(0)', 'fsubrp  st(5), st(0)',
    'fsubrp  st(6), st(0)', 'fsubrp  st(7), st(0)', 'fsubp   st(0), st(0)',
    'fsubp   st(1), st(0)', 'fsubp   st(2), st(0)', 'fsubp   st(3), st(0)',
    'fsubp   st(4), st(0)', 'fsubp   st(5), st(0)', 'fsubp   st(6), st(0)',
    'fsubp   st(7), st(0)', 'fdivrp  st(0), st(0)', 'fdivrp  st(1), st(0)',
    'fdivrp  st(2), st(0)', 'fdivrp  st(3), st(0)', 'fdivrp  st(4), st(0)',
    'fdivrp  st(5), st(0)', 'fdivrp  st(6), st(0)', 'fdivrp  st(7), st(0)',
    'fdivp   st(0), st(0)', 'fdivp   st(1), st(0)', 'fdivp   st(2), st(0)',
    'fdivp   st(3), st(0)', 'fdivp   st(4), st(0)', 'fdivp   st(5), st(0)',
    'fdivp   st(6), st(0)', 'fdivp   st(7), st(0)'),
    // 'h'
    ('fild    #Ew ', '%c ', 'fist    #Ew ', 'fistp   #Ew ', 'fbld    #E  ',
    'fild    #Eq ', 'fbstp   #Et ', 'fistp   #Eq ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ', 'fstsw   ax', '%c ', '%c ',
    '%c ', '%c ', '%c ', '%c ', '%c ',
    'fucomip st(0), st(0)', 'fucomip st(0), st(1)', 'fucomip st(0), st(2)',
    'fucomip st(0), st(3)', 'fucomip st(0), st(4)', 'fucomip st(0), st(5)',
    'fucomip st(0), st(6)', 'fucomip st(0), st(7)', 'fcomip  st(0), st(0)',
    'fcomip  st(0), st(1)', 'fcomip  st(0), st(2)', 'fcomip  st(0), st(3)',
    'fcomip  st(0), st(4)', 'fcomip  st(0), st(5)', 'fcomip  st(0), st(6)',
    'fcomip  st(0), st(7)', '%c ', '%c ', '%c ', '%c ', '%c ', '%c ',
    '%c ', '%c '));

// Convert an Integer to a string including a + or - and $ character.

function SignedIntToHex(Value: Integer; Digits: Integer): string;
begin
  if Value < 0 then
    Result := '-$' + IntToHex(-Integer(Value), Digits)
  else
    Result := '+$' + IntToHex(Integer(Value), Digits);
end;

// Reads the instruction at Address and return the Size and the assembler string
// representing the instruction.

function TDisAsm.GetInstruction(Address: PChar; var Size: Integer): string;

var
  Ref: TdaRef;

  { Reading is getting the value at Address + Size and then increment Size
    with the size of the read value }

  function ReadDWord: DWord;
  begin
    Result := PDWord(Address + Size)^;
    Inc(Size, 4);
  end;

  function ReadWord: Word;
  begin
    Result := PWord(Address + Size)^;
    Inc(Size, 2);
  end;

  function ReadByte: Byte;
  begin
    Result := PByte(Address + Size)^;
    Inc(Size, 1);
  end;

  function GetRefAddress: string;
  var
    RefAddress: PChar;
  begin
    RefAddress := PChar(ReadDWord);
    Ref.Immidiate := Ref.Immidiate + Integer(RefAddress);
    Result := '$' + IntToHex(DWord(RefAddress), 4);
    if Assigned(OnAddressRef) then
      OnAddressRef(Param, Address + Size - 4, RefAddress, Result);
    Result := '^' + Chr(Length(Result)) + Result;
  end;

  // Only read the ModRM byte the first time it is asked.
  // After that return the previous read ModRM byte
var
  XHasModRM: Boolean;
  XModRM: Byte;

  function ModRM: Byte;
  begin
    if not XHasModRM then
    begin
      XModRM := ReadByte;
      XHasModRM := True;
    end;
    Result := XModRM;
  end;

  // Only read the Sib byte the first time it is asked.
  // After that return the previous read Sib byte
var
  XHasSib: Boolean;
  XSib: Byte;

  function Sib: Byte;
  begin
    if not XHasSib then
    begin
      XSib := ReadByte;
      XHasSib := True;
    end;
    Result := XSib;
  end;

var
  DeffOperandSize: Integer; // Default = 4, but may be changed by operand prefix.
  AddressSize: Integer; // Default = 4, but may be changed by operand prefix.
  OperandSize: Integer; // Default = 0
  SegOverride: Boolean;
  SegName: string;
  MustHaveSize: Boolean;

  // Operand anlayser.
  function Operand(AddrMethod, OperandType, EnhOperandType: char): string;

    // Returns the name of the register specified by Reg using OperandType
    // to determen the size.
    function GetRegName(Reg: Byte): string;
    const
      ByteRegs1: array[0..3] of char = 'acdb';
      ByteRegs2: array[0..1] of char = 'lh';
      WordRegs1: array[0..7] of char = 'acdbsbsd';
      WordRegs2: array[0..4] of char = 'xxpi';
    begin
      if OperandSize = 1 then
        Result := ByteRegs1[Reg mod 4] + ByteRegs2[Reg div 4]
      else
      begin
        if OperandSize = 4 then
          Result := 'e'
        else
          Result := '';
        Result := Result + WordRegs1[Reg] + WordRegs2[Reg div 2];
      end;
    end;

    // Returns the description of the effective address in the ModRM byte.
    function GetEffectiveAddress(EAMustHaveSize: Boolean): string;
    var
      RM: Byte;
      AMod: Byte;

      function ReadSib: string;
      var
        SI: Byte;
        SS: Byte;
        Base: Byte;
      begin
        Base := Sib and $07; {?????XXX}
        SI := (Sib shr 3) and $07; {??XXX???}
        SS := (Sib shr 6) and $03; {XX??????}

        // Save register used by Base
        case Base of
          0: Result := '[eax';
          1: Result := '[ecx';
          2: Result := '[edx';
          3: Result := '[ebx';
          4: Result := '[esp';
          5: if AMod <> 0 then
              Result := '[ebp'
            else
              Result := '[' + GetRefAddress;
          6: Result := '[esi';
          7: Result := '[edi';
        end;
        if (Base <> 5) or (AMod = 0) then
        begin
          Ref.ARegister2 := TRegister(Base);
          Ref.MultiplyReg2 := 1;
        end;

        // result register Scaled Index
        case SI of
          0: Result := Result + '+eax';
          1: Result := Result + '+ecx';
          2: Result := Result + '+edx';
          3: Result := Result + '+ebx';
          5: Result := Result + '+ebp';
          6: Result := Result + '+esi';
          7: Result := Result + '+edi';
        end;
        if SI <> 4 then
          Ref.ARegister1 := TRegister(SI);

        // No SS when SI = 4
        if SI <> 4 then
          // Save modification made by SS
          case SS of
            0:
              begin
                Result := Result + '';
                Ref.MultiplyReg1 := 1;
              end;
            1:
              begin
                Result := Result + '*2';
                Ref.MultiplyReg1 := 2;
              end;
            2:
              begin
                Result := Result + '*4';
                Ref.MultiplyReg1 := 4;
              end;
            3:
              begin
                Result := Result + '*8';
                Ref.MultiplyReg1 := 8;
              end;
          end;
      end;

    var
      I: Integer;
    begin
      RM := ModRM and modrmRM;
      AMod := ModRm and modrmMod shr 6;

      // Effective address is a register;
      if AMod = 3 then
      begin
        Result := GetRegName(RM);
        Exit;
      end;

      Result := '%s' + Chr(OperandSize);

      // override seg name
      if SegOverride then
        Result := Result + SegName + ':';

      // Include the Size if it is other than 4
      if (OperandSize <> 4) and (OperandSize <> 0) then
        MustHaveSize := True;

      if AddressSize = 4 then
      begin
        // disp32.
        if (AMod = 0) and (RM = 5) then
        begin
          Result := Result + '[' + GetRefAddress + ']';
          if Assigned(OnRef) then
            OnRef(Param, Ref, OperandSize, Result);
          Exit;
        end;
      end
      else
      begin
        // disp16
        if (AMod = 0) and (RM = 6) then
        begin
          Result := Result + '[' + GetRefAddress + ']';
          if Assigned(OnRef) then
            OnRef(Param, Ref, OperandSize, Result);
          Exit;
        end;
      end;

      // Analyse RM Value.
      if AddressSize = 2 then
        case RM of
          0: Result := Result + '[bx+si';
          1: Result := Result + '[bx+di';
          2: Result := Result + '[bp+si';
          3: Result := Result + '[bp+di';
          4: Result := Result + '[si';
          5: Result := Result + '[di';
          6: Result := Result + '[bp';
          7: Result := Result + '[bx';
        end
      else
      begin
        case RM of
          0: Result := Result + '[eax';
          1: Result := Result + '[ecx';
          2: Result := Result + '[edx';
          3: Result := Result + '[ebx';
          4: Result := Result + ReadSIB;
          5: Result := Result + '[ebp';
          6: Result := Result + '[esi';
          7: Result := Result + '[edi';
        end;
        if RM <> 4 then
        begin
          Ref.ARegister1 := TRegister(RM);
          Ref.MultiplyReg1 := 1;
        end;
      end;

      // possible disp value dependent of Mod.
      case AMod of
        // no disp
        0: Result := Result + ']';
        // disp8
        1:
          begin
            I := ShortInt(ReadByte);
            Result := Result + SignedIntToHex(I, 2) + ']';
            Inc(Ref.Immidiate, I);
          end;
        // disp32 or disp16
        2: Result := Result + '+' + GetRefAddress + ']';
      end;

      // Call the OnRef proc.
      if Assigned(OnRef) then
        OnRef(Param, Ref, OperandSize, Result);
    end;

  var
    I: Integer;
  begin
    Result := '';
    // Save the operand size using the DeffOperandSize and SubType
    case OperandType of
      // two Word or two DWord, only used by BOUND
      'a': if DeffOperandSize = 2 then
          OperandSize := 4
        else
          OperandSize := 8;
      // Byte.
      'b': OperandSize := 1;
      // Byte or word
      'c': if DeffOperandSize = 2 then
          OperandSize := 1
        else
          OperandSize := 2;
      // DWord
      'd': OperandSize := 4;
      // 32 or 48 bit pointer
      'p': OperandSize := AddressSize + 2;
      // QWord
      'q': OperandSize := 8;
      // 6Byte
      's': OperandSize := 6;
      // Word or DWord
      'v': OperandSize := DeffOperandSize;
      // Word
      'w': OperandSize := 2;
      // Tera byte
      't': OperandSize := 10;
      // No size, also don't use must have size.
      ' ': MustHaveSize := False;
    end;

    case AddrMethod of
      // Direct Address.
      'A': if OperandType = 'p' then
        begin
          // Read address and return it.
          if SegOverride then
            Result := SegName + ':'
          else
            Result := '';
          if AddressSize = 4 then
            Result := Result + GetRefAddress
          else
            Result := Result + '$' + IntToHex(ReadWord, 2);
        end
        else
          // A direct address the isn't a pointer??
          Result := '???'; //raise EDisAsmError.Create('Invalid AddrMethod and OperandType combination');

      // Reg field in ModRm specifies Control register.
      'C': if OperandType = 'd' then
        begin
          // Read Reg part of the ModRM field.
          Result := Format('C%d', [(ModRM and modrmReg) div 8]);
          MustHaveSize := False;
        end
        else
          // Only support for the complete register.
          Result := '???'; //raise EDisAsmError.Create('Invalid AddrMethod and OperandType combination');

      // Reg field in ModRm specifies Debug register.
      'D': if OperandType = 'd' then
        begin
          // Read Reg part of the ModRM field.
          Result := Format('D%d', [(ModRM and modrmReg) div 8]);
          MustHaveSize := False;
        end
        else
          // Only support for the complete register.
          Result := '???'; //raise EDisAsmError.Create('Invalid AddrMethod and OperandType combination');

      // General purpose register or memory address specified in the ModRM byte.
      // There are no check for invalid operands.
      'E', 'M', 'R': Result := GetEffectiveAddress(False);

      // EFlags register
      'F': { Do nothing };

      // Reg field in ModRM specifies a general register
      'G':
        begin
          Result := GetRegName((ModRM and modrmReg) div 8);
          MustHaveSize := False;
        end;

      // Signed immidate data
      'H':
        begin
          case OperandSize of
            1: I := ShortInt(ReadByte);
            2: I := Smallint(ReadWord);
            4: I := Integer(ReadDWord);
          else I := 1; //raise EDisAsmError.Create('Invalid OperandSize');
          end;
          Result := SignedIntToHex(I, OperandSize * 2);
          if Assigned(OnImmidiateData) then
            OnImmidiateData(Param, Address + Size - OperandSize, OperandSize, True, Result);
          Result := '^' + chr(Length(Result)) + Result;
        end;
      // Imidiate data
      'I':
        begin
          Result := '';
          for I := OperandSize downto 1 do
            Result := IntToHex(ReadByte, 2) + Result;
          Result := '$' + Result;
          if Assigned(OnImmidiateData) then
            OnImmidiateData(Param, Address + Size - OperandSize,
              OperandSize, False, Result);
          Result := '^' + Chr(Length(Result)) + Result;
        end;

      // Relative jump Offset Byte
      'J':
        begin
          case OperandSize of
            1: I := ShortInt(ReadByte);
            2: I := Smallint(ReadWord);
            4: I := Integer(ReadDWord);
          else I := 1; //raise EDisAsmError.Create('Invalid OperandSize');
          end;
          // Convert the value to a string.
          Result := SignedIntToHex(I, OperandSize * 2);
          // if its a jump call the JumpInstr proc.
          if (EnhOperandType = 'j') and Assigned(OnJumpInstr) then
          begin
            OnJumpInstr(Param, Address + Size - OperandSize, Address + Size + I, Result);
            Result := '^' + Chr(Length(Result)) + Result;
          end;
          if (EnhOperandType = 'c') and Assigned(OnCallInstr) then
          begin
            OnCallInstr(Param, Address + Size - OperandSize, Address + Size + I, Result);
            Result := '^' + Chr(Length(Result)) + Result;
          end;
        end;

      // Relative Offset Word or DWord
      'O': if AddressSize = 2 then
          Result := '%s' + Chr(OperandSize) + '[$' + IntToHex(ReadWord, 4) + ']'
        else
        begin
          Result := '%s' + Chr(OperandSize) + '[' + GetRefAddress + ']';
          if Assigned(OnRef) then
            OnRef(Param, Ref, OperandSize, Result);
        end;

      // Reg field in ModRM specifies a MMX register
      'P':
        begin
          Result := Format('MM%d', [(ModRM and modrmReg) div 8]);
          MustHaveSize := False;
        end;

      // MMX register or memory address specified in the ModRM byte.
      'Q': if (ModRM and modrmmod) = $C0 then
        begin
          // MMX register
          Result := Format('MM%d', [(ModRM and modrmReg) div 8]);
          MustHaveSize := False;
        end
        else
          // Effective address
          Result := GetEffectiveAddress(False);

      // Reg field in ModRM specifies a Segment register
      'S': case (ModRM and modrmReg) div 8 of
          0: Result := 'es';
          1: Result := 'cs';
          2: Result := 'ss';
          3: Result := 'ds';
          4: Result := 'fs';
          5: Result := 'gs';
        end;

      // Reg field in ModRM specifies a MMX register
      'T':
        begin
          Result := Format('T%d', [(ModRM and modrmReg) div 8]);
          MustHaveSize := False;
        end;

    end;
  end;

  function Replacer(FirstChar, SecondChar: char): string;
  const
    modrmReg = $38; // Reg part of the ModRM byte, ??XXX???
  begin
    case FirstChar of
      // escape character
      'c': if SecondChar = '2' then
          Result := TwoByteOpcodes[char(ReadByte)]
        else
          if ModRm <= $BF then
            Result := FloatingPointOpcodes[SecondChar, (ModRM and modrmReg) div 8 + $B8]
          else
            Result := FloatingPointOpcodes[SecondChar, ModRm];

      // 32 bit register or 16 bit register.
      'e': if DeffOperandSize = 4 then
          Result := 'e' + SecondChar
        else
          Result := SecondChar;

      // Seg prefix override.
      'p':
        begin
          SegOverride := True;
          SegName := SecondChar + 's';
          Result := OneByteOpcodes[char(ReadByte)];
        end;

      // Size override (address or operand).
      's':
        begin
          case SecondChar of
            'o': DeffOperandSize := 2;
            'a': AddressSize := 2;
          end;
          Result := OneByteOpcodes[char(ReadByte)];
        end;

      // Operand size
      'o': if DeffOperandSize = 4 then
          case SecondChar of
            '2': Result := 'w';
            '4': Result := 'd';
            '8': Result := 'q';
          end
        else
          case SecondChar of
            '2': Result := 'b';
            '4': Result := 'w';
            '8': Result := 'd';
          end;

      // Must have size.
      'm':
        begin
          Result := '';
          MustHaveSize := True;
        end;

      // Group, return the group insruction specified by OperandType
      // and the reg field of the ModRM byte.
      'g': Result := GroupsOpcodes[SecondChar, (ModRM and modrmReg) div 8];

      // Operand for group, return operands for the group insruction specified
      // by OperandType and the reg field of the ModRM byte.
      'h': Result := GroupsOperands[SecondChar, (ModRM and modrmReg) div 8];
    end;
  end;

var
  I, J: Integer;
begin
  DeffOperandSize := 4;
  OperandSize := 0;
  AddressSize := 4;
  SegOverride := False;
  Size := 0;
  XHasSib := False;
  XHasModRM := False;
  MustHaveSize := True;
  Ref.MultiplyReg1 := 0;
  Ref.MultiplyReg2 := 0;
  Ref.Immidiate := nil;
  Result := OneByteOpcodes[char(ReadByte)];
  I := 1;
  while I < Length(Result) - 1 do
    case Result[I] of
      '#':
        begin
          Insert(Operand(Result[I + 1], Result[I + 2], Result[I + 3]), Result, I + 4);
          Delete(Result, I, 4);
        end;
      '@':
        begin
          Insert(Replacer(Result[I + 1], Result[I + 2]), Result, I + 3);
          Delete(Result, I, 3);
        end;
      '^':
        begin
          // Skip the numbers of character indicate in the next char.
          J := I;
          Inc(I, Ord(Result[I + 1]));
          Delete(Result, J, 2);
        end;
    else Inc(I);
    end;
  // Replace '%s' with size name if MustHaveSize = true or nothing.
  I := 1;
  while I < Length(Result) - 1 do
    case Result[I] of
      '%':
        begin
          case Result[I + 1] of
            's': if MustHaveSize then
                case Result[I + 2] of
                  #1: Insert('byte ptr ', Result, I + 3);
                  #2: Insert('word ptr ', Result, I + 3);
                  #4: Insert('dword ptr ', Result, I + 3);
                  #6: ;
                  #8: Insert('qword ptr ', Result, I + 3);
                  #10: Insert('tbyte ptr ', Result, I + 3);
                else
                  Insert('byte ptr ', Result, I + 3); //raise EDisAsmError.CreateFmt('Size out of range. %d, %p', [Ord(Result[I + 2]), Pointer(Address)]);
                end;
            'c':
              begin
                // Include the opcode as DB.
                Insert('  //', Result, I + 3);
                for J := Size - 1 downto 1 do
                  Insert(', $' + IntToHex(PByte(Address + J)^, 2), Result, I + 3);
                Insert('DB      $' + IntToHex(PByte(Address)^, 2), Result, I + 3);
              end;
          end;
          Delete(Result, I, 3);
        end;
    else Inc(I);
    end;
end;

end.

