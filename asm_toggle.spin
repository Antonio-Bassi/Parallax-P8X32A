{{asm_toggle.spin}}
CON
  _clkmode = xtal1 + pll16x     'Configures clock external crystal and pll division value
  _xinfreq = 5_000_000          'Specifies external crystal input frequency

PUB Main
  cognew(@toggle, 0)            'Is this assembly code?
  
DAT
  org     0
  toggle  mov     dira, pin     'Sets pin direction to output
          mov     time, cnt     'Gets system counter register
          add     time, #9      'Adds number literal '9' to content of time register and stores result in it.
  :loop   waitcnt time, delay   'compares time register with value in sys_counter_register, waits until condition is met and adds delay to it
          xor     outa, pin     'toggles pinby xor'ing the long encoded pin value into the gpio register.
          jmp     #:loop        'goes to :loop label

pin       long    |<16          'encodes long into (0 - 32) 00000000_00000001_00000000_00000000
delay     long    6_000_000     '
time      res     1             'Reserves a long (32-bit) size for uninitialised variable