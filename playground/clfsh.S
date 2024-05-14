// RUN: llvm-mc -triple x86_64-unknown-unknown --show-encoding %s | FileCheck %s
// echo "clflush 11" |llvm-mc -triple x86_64-unknown-unknown --show-encoding

// CHECK: clflush 485498096
// CHECK: encoding: [0x0f,0xae,0x3c,0x25,0xf0,0x1c,0xf0,0x1c]
clflush 485498096 // 0x1cf01cf0

// CHECK: clflush 64(%rdx)
// CHECK: encoding: [0x0f,0xae,0x7a,0x40]
clflush 64(%rdx)

// CHECK: clflush 64(%rdx,%rax,4)
// CHECK: encoding: [0x0f,0xae,0x7c,0x82,0x40]
clflush 64(%rdx,%rax,4)

// CHECK: clflush -64(%rdx,%rax,4)
// CHECK: encoding: [0x0f,0xae,0x7c,0x82,0xc0]
clflush -64(%rdx,%rax,4)

// CHECK: clflush 64(%rdx,%rax)
// CHECK: encoding: [0x0f,0xae,0x7c,0x02,0x40]
clflush 64(%rdx,%rax)

// CHECK: clflush (%rdx)
// CHECK: encoding: [0x0f,0xae,0x3a]
clflush (%rdx)

// CHECK: cldemote 4(%rax)
// CHECK:  encoding: [0x0f,0x1c,0x40,0x04]
cldemote 4(%rax)

// CHECK: cldemote 2125315823(%rbx,%rcx,8)
// CHECK:  encoding: [0x0f,0x1c,0x84,0xcb,0xef,0xbe,0xad,0x7e]
cldemote 0x7eadbeef(%rbx,%rcx,8)
