module {
  func.func @mac8(%arg0: !openfhe.binfhe_context, %arg1: memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>, %arg2: memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>, %arg3: memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>) -> memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>> {
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = memref.load %arg2[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %1 = memref.load %arg1[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %2 = memref.load %arg2[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %3 = memref.load %arg1[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %4 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64 = arith.constant 3 : i64
    %5 = openfhe.lwe_mul_const %4, %0, %c3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_0 = arith.constant 3 : i64
    %6 = openfhe.lwe_mul_const %4, %1, %c3_i64_0 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64 = arith.constant 1 : i64
    %7 = openfhe.lwe_mul_const %4, %2, %c1_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64 = arith.constant -7 : i64
    %8 = openfhe.lwe_mul_const %4, %3, %c-7_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %9 = openfhe.lwe_add %4, %5, %6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %10 = openfhe.lwe_add %4, %9, %7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %11 = openfhe.lwe_add %4, %10, %8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %12 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %13 = openfhe.eval_func %arg0, %12, %11 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %14 = memref.load %arg3[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %15 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64 = arith.constant 4 : i64
    %16 = openfhe.lwe_mul_const %15, %14, %c4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64 = arith.constant 2 : i64
    %17 = openfhe.lwe_mul_const %15, %0, %c2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_1 = arith.constant 1 : i64
    %18 = openfhe.lwe_mul_const %15, %3, %c1_i64_1 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %19 = openfhe.lwe_add %15, %16, %17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %20 = openfhe.lwe_add %15, %19, %18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %21 = openfhe.make_lut %arg0 {values = array<i32: 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %22 = openfhe.eval_func %arg0, %21, %20 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %23 = memref.load %arg3[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %24 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_2 = arith.constant 4 : i64
    %25 = openfhe.lwe_mul_const %24, %23, %c4_i64_2 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_3 = arith.constant 2 : i64
    %26 = openfhe.lwe_mul_const %24, %22, %c2_i64_3 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_4 = arith.constant 1 : i64
    %27 = openfhe.lwe_mul_const %24, %13, %c1_i64_4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %28 = openfhe.lwe_add %24, %25, %26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %29 = openfhe.lwe_add %24, %28, %27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %30 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %31 = openfhe.eval_func %arg0, %30, %29 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %32 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_5 = arith.constant 4 : i64
    %33 = openfhe.lwe_mul_const %32, %23, %c4_i64_5 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_6 = arith.constant 2 : i64
    %34 = openfhe.lwe_mul_const %32, %22, %c2_i64_6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_7 = arith.constant 1 : i64
    %35 = openfhe.lwe_mul_const %32, %13, %c1_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %36 = openfhe.lwe_add %32, %33, %34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %37 = openfhe.lwe_add %32, %36, %35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %38 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %39 = openfhe.eval_func %arg0, %38, %37 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %40 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_8 = arith.constant 2 : i64
    %41 = openfhe.lwe_mul_const %40, %1, %c2_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_9 = arith.constant 1 : i64
    %42 = openfhe.lwe_mul_const %40, %2, %c1_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %43 = openfhe.lwe_add %40, %41, %42 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %44 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %45 = openfhe.eval_func %arg0, %44, %43 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %46 = memref.load %arg2[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %47 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_10 = arith.constant 2 : i64
    %48 = openfhe.lwe_mul_const %47, %46, %c2_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_11 = arith.constant 1 : i64
    %49 = openfhe.lwe_mul_const %47, %3, %c1_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %50 = openfhe.lwe_add %47, %48, %49 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %51 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %52 = openfhe.eval_func %arg0, %51, %50 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %53 = memref.load %arg1[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %54 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_12 = arith.constant 3 : i64
    %55 = openfhe.lwe_mul_const %54, %0, %c3_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64 = arith.constant -1 : i64
    %56 = openfhe.lwe_mul_const %54, %53, %c-1_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_13 = arith.constant 2 : i64
    %57 = openfhe.lwe_mul_const %54, %52, %c2_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64 = arith.constant -6 : i64
    %58 = openfhe.lwe_mul_const %54, %45, %c-6_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %59 = openfhe.lwe_add %54, %55, %56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %60 = openfhe.lwe_add %54, %59, %57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %61 = openfhe.lwe_add %54, %60, %58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %62 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %63 = openfhe.eval_func %arg0, %62, %61 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %64 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_14 = arith.constant 4 : i64
    %65 = openfhe.lwe_mul_const %64, %63, %c4_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_15 = arith.constant 1 : i64
    %66 = openfhe.lwe_mul_const %64, %2, %c1_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_16 = arith.constant 1 : i64
    %67 = openfhe.lwe_mul_const %64, %3, %c1_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_17 = arith.constant 1 : i64
    %68 = openfhe.lwe_mul_const %64, %0, %c1_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_18 = arith.constant -7 : i64
    %69 = openfhe.lwe_mul_const %64, %1, %c-7_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %70 = openfhe.lwe_add %64, %65, %66 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %71 = openfhe.lwe_add %64, %70, %67 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %72 = openfhe.lwe_add %64, %71, %68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %73 = openfhe.lwe_add %64, %72, %69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %74 = openfhe.make_lut %arg0 {values = array<i32: 4, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %75 = openfhe.eval_func %arg0, %74, %73 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %76 = memref.load %arg3[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %77 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_19 = arith.constant 4 : i64
    %78 = openfhe.lwe_mul_const %77, %76, %c4_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_20 = arith.constant 2 : i64
    %79 = openfhe.lwe_mul_const %77, %75, %c2_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_21 = arith.constant 1 : i64
    %80 = openfhe.lwe_mul_const %77, %39, %c1_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %81 = openfhe.lwe_add %77, %78, %79 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %82 = openfhe.lwe_add %77, %81, %80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %83 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %84 = openfhe.eval_func %arg0, %83, %82 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %85 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_22 = arith.constant 1 : i64
    %86 = openfhe.lwe_mul_const %85, %63, %c1_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_23 = arith.constant 1 : i64
    %87 = openfhe.lwe_mul_const %85, %2, %c1_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_24 = arith.constant 1 : i64
    %88 = openfhe.lwe_mul_const %85, %3, %c1_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_25 = arith.constant 1 : i64
    %89 = openfhe.lwe_mul_const %85, %0, %c1_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_26 = arith.constant -7 : i64
    %90 = openfhe.lwe_mul_const %85, %1, %c-7_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %91 = openfhe.lwe_add %85, %86, %87 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %92 = openfhe.lwe_add %85, %91, %88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %93 = openfhe.lwe_add %85, %92, %89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %94 = openfhe.lwe_add %85, %93, %90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %95 = openfhe.make_lut %arg0 {values = array<i32: 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %96 = openfhe.eval_func %arg0, %95, %94 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %97 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_27 = arith.constant 1 : i64
    %98 = openfhe.lwe_mul_const %97, %0, %c1_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_28 = arith.constant 1 : i64
    %99 = openfhe.lwe_mul_const %97, %53, %c1_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_29 = arith.constant 2 : i64
    %100 = openfhe.lwe_mul_const %97, %52, %c2_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_30 = arith.constant -6 : i64
    %101 = openfhe.lwe_mul_const %97, %45, %c-6_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %102 = openfhe.lwe_add %97, %98, %99 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %103 = openfhe.lwe_add %97, %102, %100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %104 = openfhe.lwe_add %97, %103, %101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %105 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %106 = openfhe.eval_func %arg0, %105, %104 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %107 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_31 = arith.constant 2 : i64
    %108 = openfhe.lwe_mul_const %107, %53, %c2_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_32 = arith.constant 1 : i64
    %109 = openfhe.lwe_mul_const %107, %2, %c1_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %110 = openfhe.lwe_add %107, %108, %109 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %111 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %112 = openfhe.eval_func %arg0, %111, %110 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %113 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_33 = arith.constant 2 : i64
    %114 = openfhe.lwe_mul_const %113, %46, %c2_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_34 = arith.constant 1 : i64
    %115 = openfhe.lwe_mul_const %113, %1, %c1_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %116 = openfhe.lwe_add %113, %114, %115 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %117 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %118 = openfhe.eval_func %arg0, %117, %116 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %119 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %120 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_35 = arith.constant 2 : i64
    %121 = openfhe.lwe_mul_const %120, %0, %c2_i64_35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_36 = arith.constant 1 : i64
    %122 = openfhe.lwe_mul_const %120, %119, %c1_i64_36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %123 = openfhe.lwe_add %120, %121, %122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %124 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %125 = openfhe.eval_func %arg0, %124, %123 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %126 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_37 = arith.constant 4 : i64
    %127 = openfhe.lwe_mul_const %126, %125, %c4_i64_37 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_38 = arith.constant 2 : i64
    %128 = openfhe.lwe_mul_const %126, %118, %c2_i64_38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_39 = arith.constant 1 : i64
    %129 = openfhe.lwe_mul_const %126, %112, %c1_i64_39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %130 = openfhe.lwe_add %126, %127, %128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %131 = openfhe.lwe_add %126, %130, %129 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %132 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %133 = openfhe.eval_func %arg0, %132, %131 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %134 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %135 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_40 = arith.constant 2 : i64
    %136 = openfhe.lwe_mul_const %135, %134, %c2_i64_40 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_41 = arith.constant 1 : i64
    %137 = openfhe.lwe_mul_const %135, %3, %c1_i64_41 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %138 = openfhe.lwe_add %135, %136, %137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %139 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %140 = openfhe.eval_func %arg0, %139, %138 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %141 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_42 = arith.constant 4 : i64
    %142 = openfhe.lwe_mul_const %141, %140, %c4_i64_42 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_43 = arith.constant 2 : i64
    %143 = openfhe.lwe_mul_const %141, %133, %c2_i64_43 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_44 = arith.constant 1 : i64
    %144 = openfhe.lwe_mul_const %141, %106, %c1_i64_44 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %145 = openfhe.lwe_add %141, %142, %143 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %146 = openfhe.lwe_add %141, %145, %144 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %147 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %148 = openfhe.eval_func %arg0, %147, %146 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %149 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_45 = arith.constant 2 : i64
    %150 = openfhe.lwe_mul_const %149, %148, %c2_i64_45 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_46 = arith.constant 1 : i64
    %151 = openfhe.lwe_mul_const %149, %96, %c1_i64_46 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %152 = openfhe.lwe_add %149, %150, %151 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %153 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %154 = openfhe.eval_func %arg0, %153, %152 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %155 = memref.load %arg3[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %156 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_47 = arith.constant 2 : i64
    %157 = openfhe.lwe_mul_const %156, %155, %c2_i64_47 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64 = arith.constant -2 : i64
    %158 = openfhe.lwe_mul_const %156, %154, %c-2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_48 = arith.constant 1 : i64
    %159 = openfhe.lwe_mul_const %156, %76, %c1_i64_48 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_49 = arith.constant 1 : i64
    %160 = openfhe.lwe_mul_const %156, %75, %c1_i64_49 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64 = arith.constant -5 : i64
    %161 = openfhe.lwe_mul_const %156, %39, %c-5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %162 = openfhe.lwe_add %156, %157, %158 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %163 = openfhe.lwe_add %156, %162, %159 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %164 = openfhe.lwe_add %156, %163, %160 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %165 = openfhe.lwe_add %156, %164, %161 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %166 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %167 = openfhe.eval_func %arg0, %166, %165 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %168 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-2_i64_50 = arith.constant -2 : i64
    %169 = openfhe.lwe_mul_const %168, %155, %c-2_i64_50 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_51 = arith.constant -2 : i64
    %170 = openfhe.lwe_mul_const %168, %154, %c-2_i64_51 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_52 = arith.constant 3 : i64
    %171 = openfhe.lwe_mul_const %168, %76, %c3_i64_52 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_53 = arith.constant 3 : i64
    %172 = openfhe.lwe_mul_const %168, %75, %c3_i64_53 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64 = arith.constant -3 : i64
    %173 = openfhe.lwe_mul_const %168, %39, %c-3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %174 = openfhe.lwe_add %168, %169, %170 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %175 = openfhe.lwe_add %168, %174, %171 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %176 = openfhe.lwe_add %168, %175, %172 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %177 = openfhe.lwe_add %168, %176, %173 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %178 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %179 = openfhe.eval_func %arg0, %178, %177 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %180 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_54 = arith.constant 4 : i64
    %181 = openfhe.lwe_mul_const %180, %140, %c4_i64_54 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_55 = arith.constant 2 : i64
    %182 = openfhe.lwe_mul_const %180, %133, %c2_i64_55 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_56 = arith.constant 1 : i64
    %183 = openfhe.lwe_mul_const %180, %106, %c1_i64_56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %184 = openfhe.lwe_add %180, %181, %182 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %185 = openfhe.lwe_add %180, %184, %183 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %186 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %187 = openfhe.eval_func %arg0, %186, %185 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %188 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_57 = arith.constant 2 : i64
    %189 = openfhe.lwe_mul_const %188, %46, %c2_i64_57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_58 = arith.constant 1 : i64
    %190 = openfhe.lwe_mul_const %188, %53, %c1_i64_58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %191 = openfhe.lwe_add %188, %189, %190 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %192 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %193 = openfhe.eval_func %arg0, %192, %191 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %194 = memref.load %arg1[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %195 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_59 = arith.constant 2 : i64
    %196 = openfhe.lwe_mul_const %195, %0, %c2_i64_59 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_60 = arith.constant 1 : i64
    %197 = openfhe.lwe_mul_const %195, %194, %c1_i64_60 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %198 = openfhe.lwe_add %195, %196, %197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %199 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %200 = openfhe.eval_func %arg0, %199, %198 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %201 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_61 = arith.constant 2 : i64
    %202 = openfhe.lwe_mul_const %201, %200, %c2_i64_61 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_62 = arith.constant 2 : i64
    %203 = openfhe.lwe_mul_const %201, %193, %c2_i64_62 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_63 = arith.constant 1 : i64
    %204 = openfhe.lwe_mul_const %201, %119, %c1_i64_63 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_64 = arith.constant -7 : i64
    %205 = openfhe.lwe_mul_const %201, %2, %c-7_i64_64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %206 = openfhe.lwe_add %201, %202, %203 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %207 = openfhe.lwe_add %201, %206, %204 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %208 = openfhe.lwe_add %201, %207, %205 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %209 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %210 = openfhe.eval_func %arg0, %209, %208 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %211 = memref.load %arg2[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %212 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_65 = arith.constant 3 : i64
    %213 = openfhe.lwe_mul_const %212, %134, %c3_i64_65 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_66 = arith.constant 3 : i64
    %214 = openfhe.lwe_mul_const %212, %1, %c3_i64_66 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_67 = arith.constant 1 : i64
    %215 = openfhe.lwe_mul_const %212, %211, %c1_i64_67 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_68 = arith.constant -7 : i64
    %216 = openfhe.lwe_mul_const %212, %3, %c-7_i64_68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %217 = openfhe.lwe_add %212, %213, %214 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %218 = openfhe.lwe_add %212, %217, %215 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %219 = openfhe.lwe_add %212, %218, %216 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %220 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %221 = openfhe.eval_func %arg0, %220, %219 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %222 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_69 = arith.constant 2 : i64
    %223 = openfhe.lwe_mul_const %222, %221, %c2_i64_69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_70 = arith.constant 2 : i64
    %224 = openfhe.lwe_mul_const %222, %210, %c2_i64_70 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_71 = arith.constant 1 : i64
    %225 = openfhe.lwe_mul_const %222, %125, %c1_i64_71 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_72 = arith.constant 1 : i64
    %226 = openfhe.lwe_mul_const %222, %118, %c1_i64_72 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_73 = arith.constant -7 : i64
    %227 = openfhe.lwe_mul_const %222, %112, %c-7_i64_73 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %228 = openfhe.lwe_add %222, %223, %224 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %229 = openfhe.lwe_add %222, %228, %225 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %230 = openfhe.lwe_add %222, %229, %226 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %231 = openfhe.lwe_add %222, %230, %227 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %232 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %233 = openfhe.eval_func %arg0, %232, %231 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %234 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_74 = arith.constant 2 : i64
    %235 = openfhe.lwe_mul_const %234, %233, %c2_i64_74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_75 = arith.constant 2 : i64
    %236 = openfhe.lwe_mul_const %234, %187, %c2_i64_75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_76 = arith.constant 1 : i64
    %237 = openfhe.lwe_mul_const %234, %148, %c1_i64_76 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_77 = arith.constant -7 : i64
    %238 = openfhe.lwe_mul_const %234, %96, %c-7_i64_77 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %239 = openfhe.lwe_add %234, %235, %236 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %240 = openfhe.lwe_add %234, %239, %237 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %241 = openfhe.lwe_add %234, %240, %238 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %242 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %243 = openfhe.eval_func %arg0, %242, %241 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %244 = memref.load %arg3[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %245 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_78 = arith.constant 4 : i64
    %246 = openfhe.lwe_mul_const %245, %244, %c4_i64_78 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_79 = arith.constant 2 : i64
    %247 = openfhe.lwe_mul_const %245, %243, %c2_i64_79 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_80 = arith.constant 1 : i64
    %248 = openfhe.lwe_mul_const %245, %179, %c1_i64_80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %249 = openfhe.lwe_add %245, %246, %247 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %250 = openfhe.lwe_add %245, %249, %248 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %251 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %252 = openfhe.eval_func %arg0, %251, %250 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %253 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_81 = arith.constant 4 : i64
    %254 = openfhe.lwe_mul_const %253, %244, %c4_i64_81 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_82 = arith.constant 2 : i64
    %255 = openfhe.lwe_mul_const %253, %243, %c2_i64_82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_83 = arith.constant 1 : i64
    %256 = openfhe.lwe_mul_const %253, %179, %c1_i64_83 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %257 = openfhe.lwe_add %253, %254, %255 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %258 = openfhe.lwe_add %253, %257, %256 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %259 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %260 = openfhe.eval_func %arg0, %259, %258 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %261 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_84 = arith.constant 1 : i64
    %262 = openfhe.lwe_mul_const %261, %233, %c1_i64_84 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_85 = arith.constant -1 : i64
    %263 = openfhe.lwe_mul_const %261, %187, %c-1_i64_85 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_86 = arith.constant 2 : i64
    %264 = openfhe.lwe_mul_const %261, %148, %c2_i64_86 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_87 = arith.constant -6 : i64
    %265 = openfhe.lwe_mul_const %261, %96, %c-6_i64_87 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %266 = openfhe.lwe_add %261, %262, %263 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %267 = openfhe.lwe_add %261, %266, %264 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %268 = openfhe.lwe_add %261, %267, %265 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %269 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %270 = openfhe.eval_func %arg0, %269, %268 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %271 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_88 = arith.constant 2 : i64
    %272 = openfhe.lwe_mul_const %271, %221, %c2_i64_88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_89 = arith.constant 2 : i64
    %273 = openfhe.lwe_mul_const %271, %210, %c2_i64_89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_90 = arith.constant 1 : i64
    %274 = openfhe.lwe_mul_const %271, %125, %c1_i64_90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_91 = arith.constant 1 : i64
    %275 = openfhe.lwe_mul_const %271, %118, %c1_i64_91 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_92 = arith.constant -7 : i64
    %276 = openfhe.lwe_mul_const %271, %112, %c-7_i64_92 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %277 = openfhe.lwe_add %271, %272, %273 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %278 = openfhe.lwe_add %271, %277, %274 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %279 = openfhe.lwe_add %271, %278, %275 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %280 = openfhe.lwe_add %271, %279, %276 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %281 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %282 = openfhe.eval_func %arg0, %281, %280 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %283 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_93 = arith.constant 2 : i64
    %284 = openfhe.lwe_mul_const %283, %200, %c2_i64_93 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_94 = arith.constant 2 : i64
    %285 = openfhe.lwe_mul_const %283, %193, %c2_i64_94 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_95 = arith.constant 1 : i64
    %286 = openfhe.lwe_mul_const %283, %119, %c1_i64_95 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_96 = arith.constant -7 : i64
    %287 = openfhe.lwe_mul_const %283, %2, %c-7_i64_96 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %288 = openfhe.lwe_add %283, %284, %285 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %289 = openfhe.lwe_add %283, %288, %286 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %290 = openfhe.lwe_add %283, %289, %287 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %291 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %292 = openfhe.eval_func %arg0, %291, %290 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %293 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_97 = arith.constant 2 : i64
    %294 = openfhe.lwe_mul_const %293, %46, %c2_i64_97 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_98 = arith.constant 1 : i64
    %295 = openfhe.lwe_mul_const %293, %119, %c1_i64_98 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %296 = openfhe.lwe_add %293, %294, %295 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %297 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %298 = openfhe.eval_func %arg0, %297, %296 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %299 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %300 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_99 = arith.constant 2 : i64
    %301 = openfhe.lwe_mul_const %300, %0, %c2_i64_99 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_100 = arith.constant 1 : i64
    %302 = openfhe.lwe_mul_const %300, %299, %c1_i64_100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %303 = openfhe.lwe_add %300, %301, %302 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %304 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %305 = openfhe.eval_func %arg0, %304, %303 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %306 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_101 = arith.constant 2 : i64
    %307 = openfhe.lwe_mul_const %306, %305, %c2_i64_101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_102 = arith.constant 2 : i64
    %308 = openfhe.lwe_mul_const %306, %298, %c2_i64_102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_103 = arith.constant 1 : i64
    %309 = openfhe.lwe_mul_const %306, %194, %c1_i64_103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_104 = arith.constant -7 : i64
    %310 = openfhe.lwe_mul_const %306, %2, %c-7_i64_104 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %311 = openfhe.lwe_add %306, %307, %308 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %312 = openfhe.lwe_add %306, %311, %309 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %313 = openfhe.lwe_add %306, %312, %310 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %314 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %315 = openfhe.eval_func %arg0, %314, %313 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %316 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_105 = arith.constant 2 : i64
    %317 = openfhe.lwe_mul_const %316, %211, %c2_i64_105 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_106 = arith.constant 1 : i64
    %318 = openfhe.lwe_mul_const %316, %1, %c1_i64_106 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %319 = openfhe.lwe_add %316, %317, %318 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %320 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %321 = openfhe.eval_func %arg0, %320, %319 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %322 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %323 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_107 = arith.constant 2 : i64
    %324 = openfhe.lwe_mul_const %323, %134, %c2_i64_107 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_108 = arith.constant 1 : i64
    %325 = openfhe.lwe_mul_const %323, %53, %c1_i64_108 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %326 = openfhe.lwe_add %323, %324, %325 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %327 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %328 = openfhe.eval_func %arg0, %327, %326 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %329 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_109 = arith.constant 2 : i64
    %330 = openfhe.lwe_mul_const %329, %328, %c2_i64_109 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_110 = arith.constant 3 : i64
    %331 = openfhe.lwe_mul_const %329, %322, %c3_i64_110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_111 = arith.constant -1 : i64
    %332 = openfhe.lwe_mul_const %329, %3, %c-1_i64_111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_112 = arith.constant -6 : i64
    %333 = openfhe.lwe_mul_const %329, %321, %c-6_i64_112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %334 = openfhe.lwe_add %329, %330, %331 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %335 = openfhe.lwe_add %329, %334, %332 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %336 = openfhe.lwe_add %329, %335, %333 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %337 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %338 = openfhe.eval_func %arg0, %337, %336 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %339 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_113 = arith.constant 4 : i64
    %340 = openfhe.lwe_mul_const %339, %338, %c4_i64_113 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_114 = arith.constant 2 : i64
    %341 = openfhe.lwe_mul_const %339, %315, %c2_i64_114 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_115 = arith.constant 1 : i64
    %342 = openfhe.lwe_mul_const %339, %292, %c1_i64_115 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %343 = openfhe.lwe_add %339, %340, %341 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %344 = openfhe.lwe_add %339, %343, %342 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %345 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %346 = openfhe.eval_func %arg0, %345, %344 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %347 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_116 = arith.constant 3 : i64
    %348 = openfhe.lwe_mul_const %347, %321, %c3_i64_116 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_117 = arith.constant -1 : i64
    %349 = openfhe.lwe_mul_const %347, %140, %c-1_i64_117 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_118 = arith.constant 2 : i64
    %350 = openfhe.lwe_mul_const %347, %346, %c2_i64_118 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_119 = arith.constant -6 : i64
    %351 = openfhe.lwe_mul_const %347, %282, %c-6_i64_119 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %352 = openfhe.lwe_add %347, %348, %349 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %353 = openfhe.lwe_add %347, %352, %350 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %354 = openfhe.lwe_add %347, %353, %351 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %355 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %356 = openfhe.eval_func %arg0, %355, %354 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %357 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_120 = arith.constant 2 : i64
    %358 = openfhe.lwe_mul_const %357, %356, %c2_i64_120 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_121 = arith.constant 1 : i64
    %359 = openfhe.lwe_mul_const %357, %233, %c1_i64_121 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_122 = arith.constant -1 : i64
    %360 = openfhe.lwe_mul_const %357, %187, %c-1_i64_122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_123 = arith.constant -6 : i64
    %361 = openfhe.lwe_mul_const %357, %270, %c-6_i64_123 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %362 = openfhe.lwe_add %357, %358, %359 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %363 = openfhe.lwe_add %357, %362, %360 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %364 = openfhe.lwe_add %357, %363, %361 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %365 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %366 = openfhe.eval_func %arg0, %365, %364 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %367 = memref.load %arg3[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %368 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_124 = arith.constant 4 : i64
    %369 = openfhe.lwe_mul_const %368, %367, %c4_i64_124 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_125 = arith.constant 2 : i64
    %370 = openfhe.lwe_mul_const %368, %366, %c2_i64_125 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_126 = arith.constant 1 : i64
    %371 = openfhe.lwe_mul_const %368, %260, %c1_i64_126 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %372 = openfhe.lwe_add %368, %369, %370 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %373 = openfhe.lwe_add %368, %372, %371 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %374 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %375 = openfhe.eval_func %arg0, %374, %373 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %376 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_127 = arith.constant 4 : i64
    %377 = openfhe.lwe_mul_const %376, %356, %c4_i64_127 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_128 = arith.constant 2 : i64
    %378 = openfhe.lwe_mul_const %376, %233, %c2_i64_128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_129 = arith.constant -2 : i64
    %379 = openfhe.lwe_mul_const %376, %187, %c-2_i64_129 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_130 = arith.constant -5 : i64
    %380 = openfhe.lwe_mul_const %376, %270, %c-5_i64_130 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %381 = openfhe.lwe_add %376, %377, %378 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %382 = openfhe.lwe_add %376, %381, %379 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %383 = openfhe.lwe_add %376, %382, %380 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %384 = openfhe.make_lut %arg0 {values = array<i32: 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %385 = openfhe.eval_func %arg0, %384, %383 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %386 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_131 = arith.constant 2 : i64
    %387 = openfhe.lwe_mul_const %386, %356, %c2_i64_131 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_132 = arith.constant 2 : i64
    %388 = openfhe.lwe_mul_const %386, %233, %c2_i64_132 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_133 = arith.constant -7 : i64
    %389 = openfhe.lwe_mul_const %386, %187, %c-7_i64_133 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %390 = openfhe.lwe_add %386, %387, %388 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %391 = openfhe.lwe_add %386, %390, %389 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %392 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %393 = openfhe.eval_func %arg0, %392, %391 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %394 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c5_i64 = arith.constant 5 : i64
    %395 = openfhe.lwe_mul_const %394, %321, %c5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_134 = arith.constant -3 : i64
    %396 = openfhe.lwe_mul_const %394, %140, %c-3_i64_134 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_135 = arith.constant 2 : i64
    %397 = openfhe.lwe_mul_const %394, %346, %c2_i64_135 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_136 = arith.constant -2 : i64
    %398 = openfhe.lwe_mul_const %394, %282, %c-2_i64_136 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %399 = openfhe.lwe_add %394, %395, %396 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %400 = openfhe.lwe_add %394, %399, %397 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %401 = openfhe.lwe_add %394, %400, %398 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %402 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %403 = openfhe.eval_func %arg0, %402, %401 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %404 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_137 = arith.constant 2 : i64
    %405 = openfhe.lwe_mul_const %404, %305, %c2_i64_137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_138 = arith.constant 2 : i64
    %406 = openfhe.lwe_mul_const %404, %298, %c2_i64_138 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_139 = arith.constant 1 : i64
    %407 = openfhe.lwe_mul_const %404, %194, %c1_i64_139 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_140 = arith.constant -7 : i64
    %408 = openfhe.lwe_mul_const %404, %2, %c-7_i64_140 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %409 = openfhe.lwe_add %404, %405, %406 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %410 = openfhe.lwe_add %404, %409, %407 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %411 = openfhe.lwe_add %404, %410, %408 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %412 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %413 = openfhe.eval_func %arg0, %412, %411 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %414 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_141 = arith.constant 2 : i64
    %415 = openfhe.lwe_mul_const %414, %46, %c2_i64_141 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_142 = arith.constant 1 : i64
    %416 = openfhe.lwe_mul_const %414, %194, %c1_i64_142 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %417 = openfhe.lwe_add %414, %415, %416 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %418 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %419 = openfhe.eval_func %arg0, %418, %417 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %420 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %421 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_143 = arith.constant 2 : i64
    %422 = openfhe.lwe_mul_const %421, %0, %c2_i64_143 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_144 = arith.constant 1 : i64
    %423 = openfhe.lwe_mul_const %421, %420, %c1_i64_144 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %424 = openfhe.lwe_add %421, %422, %423 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %425 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %426 = openfhe.eval_func %arg0, %425, %424 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %427 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_145 = arith.constant 2 : i64
    %428 = openfhe.lwe_mul_const %427, %426, %c2_i64_145 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_146 = arith.constant 2 : i64
    %429 = openfhe.lwe_mul_const %427, %419, %c2_i64_146 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_147 = arith.constant 1 : i64
    %430 = openfhe.lwe_mul_const %427, %299, %c1_i64_147 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_148 = arith.constant -7 : i64
    %431 = openfhe.lwe_mul_const %427, %2, %c-7_i64_148 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %432 = openfhe.lwe_add %427, %428, %429 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %433 = openfhe.lwe_add %427, %432, %430 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %434 = openfhe.lwe_add %427, %433, %431 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %435 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %436 = openfhe.eval_func %arg0, %435, %434 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %437 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_149 = arith.constant 2 : i64
    %438 = openfhe.lwe_mul_const %437, %322, %c2_i64_149 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_150 = arith.constant 1 : i64
    %439 = openfhe.lwe_mul_const %437, %1, %c1_i64_150 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %440 = openfhe.lwe_add %437, %438, %439 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %441 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %442 = openfhe.eval_func %arg0, %441, %440 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %443 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_151 = arith.constant 2 : i64
    %444 = openfhe.lwe_mul_const %443, %134, %c2_i64_151 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_152 = arith.constant 1 : i64
    %445 = openfhe.lwe_mul_const %443, %119, %c1_i64_152 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %446 = openfhe.lwe_add %443, %444, %445 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %447 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %448 = openfhe.eval_func %arg0, %447, %446 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %449 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_153 = arith.constant 2 : i64
    %450 = openfhe.lwe_mul_const %449, %448, %c2_i64_153 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_154 = arith.constant 2 : i64
    %451 = openfhe.lwe_mul_const %449, %442, %c2_i64_154 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_155 = arith.constant 1 : i64
    %452 = openfhe.lwe_mul_const %449, %211, %c1_i64_155 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_156 = arith.constant -7 : i64
    %453 = openfhe.lwe_mul_const %449, %53, %c-7_i64_156 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %454 = openfhe.lwe_add %449, %450, %451 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %455 = openfhe.lwe_add %449, %454, %452 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %456 = openfhe.lwe_add %449, %455, %453 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %457 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %458 = openfhe.eval_func %arg0, %457, %456 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %459 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_157 = arith.constant 4 : i64
    %460 = openfhe.lwe_mul_const %459, %458, %c4_i64_157 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_158 = arith.constant 2 : i64
    %461 = openfhe.lwe_mul_const %459, %436, %c2_i64_158 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_159 = arith.constant 1 : i64
    %462 = openfhe.lwe_mul_const %459, %413, %c1_i64_159 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %463 = openfhe.lwe_add %459, %460, %461 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %464 = openfhe.lwe_add %459, %463, %462 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %465 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %466 = openfhe.eval_func %arg0, %465, %464 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %467 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_160 = arith.constant 2 : i64
    %468 = openfhe.lwe_mul_const %467, %328, %c2_i64_160 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_161 = arith.constant 1 : i64
    %469 = openfhe.lwe_mul_const %467, %322, %c1_i64_161 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_162 = arith.constant 1 : i64
    %470 = openfhe.lwe_mul_const %467, %3, %c1_i64_162 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_163 = arith.constant -6 : i64
    %471 = openfhe.lwe_mul_const %467, %321, %c-6_i64_163 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %472 = openfhe.lwe_add %467, %468, %469 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %473 = openfhe.lwe_add %467, %472, %470 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %474 = openfhe.lwe_add %467, %473, %471 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %475 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %476 = openfhe.eval_func %arg0, %475, %474 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %477 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %478 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_164 = arith.constant 4 : i64
    %479 = openfhe.lwe_mul_const %478, %476, %c4_i64_164 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_165 = arith.constant 2 : i64
    %480 = openfhe.lwe_mul_const %478, %477, %c2_i64_165 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_166 = arith.constant 1 : i64
    %481 = openfhe.lwe_mul_const %478, %3, %c1_i64_166 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %482 = openfhe.lwe_add %478, %479, %480 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %483 = openfhe.lwe_add %478, %482, %481 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %484 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %485 = openfhe.eval_func %arg0, %484, %483 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %486 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_167 = arith.constant 2 : i64
    %487 = openfhe.lwe_mul_const %486, %485, %c2_i64_167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_168 = arith.constant -2 : i64
    %488 = openfhe.lwe_mul_const %486, %466, %c-2_i64_168 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_169 = arith.constant 1 : i64
    %489 = openfhe.lwe_mul_const %486, %338, %c1_i64_169 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_170 = arith.constant 1 : i64
    %490 = openfhe.lwe_mul_const %486, %315, %c1_i64_170 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_171 = arith.constant -5 : i64
    %491 = openfhe.lwe_mul_const %486, %292, %c-5_i64_171 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %492 = openfhe.lwe_add %486, %487, %488 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %493 = openfhe.lwe_add %486, %492, %489 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %494 = openfhe.lwe_add %486, %493, %490 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %495 = openfhe.lwe_add %486, %494, %491 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %496 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %497 = openfhe.eval_func %arg0, %496, %495 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %498 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_172 = arith.constant 1 : i64
    %499 = openfhe.lwe_mul_const %498, %497, %c1_i64_172 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_173 = arith.constant 1 : i64
    %500 = openfhe.lwe_mul_const %498, %403, %c1_i64_173 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_174 = arith.constant 1 : i64
    %501 = openfhe.lwe_mul_const %498, %393, %c1_i64_174 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_175 = arith.constant -7 : i64
    %502 = openfhe.lwe_mul_const %498, %385, %c-7_i64_175 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %503 = openfhe.lwe_add %498, %499, %500 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %504 = openfhe.lwe_add %498, %503, %501 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %505 = openfhe.lwe_add %498, %504, %502 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %506 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %507 = openfhe.eval_func %arg0, %506, %505 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %508 = memref.load %arg3[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %509 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_176 = arith.constant 2 : i64
    %510 = openfhe.lwe_mul_const %509, %508, %c2_i64_176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_177 = arith.constant -2 : i64
    %511 = openfhe.lwe_mul_const %509, %507, %c-2_i64_177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_178 = arith.constant 1 : i64
    %512 = openfhe.lwe_mul_const %509, %367, %c1_i64_178 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_179 = arith.constant 1 : i64
    %513 = openfhe.lwe_mul_const %509, %366, %c1_i64_179 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_180 = arith.constant -5 : i64
    %514 = openfhe.lwe_mul_const %509, %260, %c-5_i64_180 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %515 = openfhe.lwe_add %509, %510, %511 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %516 = openfhe.lwe_add %509, %515, %512 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %517 = openfhe.lwe_add %509, %516, %513 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %518 = openfhe.lwe_add %509, %517, %514 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %519 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %520 = openfhe.eval_func %arg0, %519, %518 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %521 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-2_i64_181 = arith.constant -2 : i64
    %522 = openfhe.lwe_mul_const %521, %508, %c-2_i64_181 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_182 = arith.constant -2 : i64
    %523 = openfhe.lwe_mul_const %521, %507, %c-2_i64_182 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_183 = arith.constant 3 : i64
    %524 = openfhe.lwe_mul_const %521, %367, %c3_i64_183 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_184 = arith.constant 3 : i64
    %525 = openfhe.lwe_mul_const %521, %366, %c3_i64_184 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_185 = arith.constant -3 : i64
    %526 = openfhe.lwe_mul_const %521, %260, %c-3_i64_185 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %527 = openfhe.lwe_add %521, %522, %523 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %528 = openfhe.lwe_add %521, %527, %524 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %529 = openfhe.lwe_add %521, %528, %525 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %530 = openfhe.lwe_add %521, %529, %526 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %531 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %532 = openfhe.eval_func %arg0, %531, %530 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %533 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_186 = arith.constant 4 : i64
    %534 = openfhe.lwe_mul_const %533, %497, %c4_i64_186 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64 = arith.constant -4 : i64
    %535 = openfhe.lwe_mul_const %533, %403, %c-4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_187 = arith.constant 2 : i64
    %536 = openfhe.lwe_mul_const %533, %393, %c2_i64_187 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_188 = arith.constant -3 : i64
    %537 = openfhe.lwe_mul_const %533, %385, %c-3_i64_188 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %538 = openfhe.lwe_add %533, %534, %535 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %539 = openfhe.lwe_add %533, %538, %536 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %540 = openfhe.lwe_add %533, %539, %537 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %541 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 4, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %542 = openfhe.eval_func %arg0, %541, %540 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %543 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_189 = arith.constant 3 : i64
    %544 = openfhe.lwe_mul_const %543, %477, %c3_i64_189 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_190 = arith.constant 3 : i64
    %545 = openfhe.lwe_mul_const %543, %1, %c3_i64_190 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_191 = arith.constant 1 : i64
    %546 = openfhe.lwe_mul_const %543, %322, %c1_i64_191 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_192 = arith.constant -7 : i64
    %547 = openfhe.lwe_mul_const %543, %53, %c-7_i64_192 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %548 = openfhe.lwe_add %543, %544, %545 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %549 = openfhe.lwe_add %543, %548, %546 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %550 = openfhe.lwe_add %543, %549, %547 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %551 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %552 = openfhe.eval_func %arg0, %551, %550 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %553 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %554 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_193 = arith.constant 4 : i64
    %555 = openfhe.lwe_mul_const %554, %552, %c4_i64_193 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_194 = arith.constant 2 : i64
    %556 = openfhe.lwe_mul_const %554, %553, %c2_i64_194 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_195 = arith.constant 1 : i64
    %557 = openfhe.lwe_mul_const %554, %3, %c1_i64_195 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %558 = openfhe.lwe_add %554, %555, %556 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %559 = openfhe.lwe_add %554, %558, %557 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %560 = openfhe.make_lut %arg0 {values = array<i32: 2, 4, 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %561 = openfhe.eval_func %arg0, %560, %559 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %562 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_196 = arith.constant 3 : i64
    %563 = openfhe.lwe_mul_const %562, %134, %c3_i64_196 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_197 = arith.constant 3 : i64
    %564 = openfhe.lwe_mul_const %562, %194, %c3_i64_197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_198 = arith.constant 1 : i64
    %565 = openfhe.lwe_mul_const %562, %46, %c1_i64_198 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_199 = arith.constant -7 : i64
    %566 = openfhe.lwe_mul_const %562, %299, %c-7_i64_199 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %567 = openfhe.lwe_add %562, %563, %564 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %568 = openfhe.lwe_add %562, %567, %565 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %569 = openfhe.lwe_add %562, %568, %566 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %570 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %571 = openfhe.eval_func %arg0, %570, %569 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %572 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %573 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_200 = arith.constant 4 : i64
    %574 = openfhe.lwe_mul_const %573, %553, %c4_i64_200 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_201 = arith.constant 2 : i64
    %575 = openfhe.lwe_mul_const %573, %572, %c2_i64_201 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_202 = arith.constant 1 : i64
    %576 = openfhe.lwe_mul_const %573, %0, %c1_i64_202 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %577 = openfhe.lwe_add %573, %574, %575 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %578 = openfhe.lwe_add %573, %577, %576 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %579 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %580 = openfhe.eval_func %arg0, %579, %578 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %581 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_203 = arith.constant 2 : i64
    %582 = openfhe.lwe_mul_const %581, %580, %c2_i64_203 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_204 = arith.constant 3 : i64
    %583 = openfhe.lwe_mul_const %581, %420, %c3_i64_204 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_205 = arith.constant -1 : i64
    %584 = openfhe.lwe_mul_const %581, %2, %c-1_i64_205 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_206 = arith.constant 2 : i64
    %585 = openfhe.lwe_mul_const %581, %571, %c2_i64_206 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_207 = arith.constant -6 : i64
    %586 = openfhe.lwe_mul_const %581, %561, %c-6_i64_207 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %587 = openfhe.lwe_add %581, %582, %583 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %588 = openfhe.lwe_add %581, %587, %584 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %589 = openfhe.lwe_add %581, %588, %585 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %590 = openfhe.lwe_add %581, %589, %586 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %591 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %592 = openfhe.eval_func %arg0, %591, %590 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %593 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_208 = arith.constant 4 : i64
    %594 = openfhe.lwe_mul_const %593, %477, %c4_i64_208 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_209 = arith.constant 2 : i64
    %595 = openfhe.lwe_mul_const %593, %3, %c2_i64_209 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_210 = arith.constant 1 : i64
    %596 = openfhe.lwe_mul_const %593, %476, %c1_i64_210 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %597 = openfhe.lwe_add %593, %594, %595 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %598 = openfhe.lwe_add %593, %597, %596 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %599 = openfhe.make_lut %arg0 {values = array<i32: 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %600 = openfhe.eval_func %arg0, %599, %598 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %601 = memref.load %arg3[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %602 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_211 = arith.constant 2 : i64
    %603 = openfhe.lwe_mul_const %602, %426, %c2_i64_211 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_212 = arith.constant 2 : i64
    %604 = openfhe.lwe_mul_const %602, %419, %c2_i64_212 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_213 = arith.constant 1 : i64
    %605 = openfhe.lwe_mul_const %602, %299, %c1_i64_213 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_214 = arith.constant -7 : i64
    %606 = openfhe.lwe_mul_const %602, %2, %c-7_i64_214 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %607 = openfhe.lwe_add %602, %603, %604 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %608 = openfhe.lwe_add %602, %607, %605 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %609 = openfhe.lwe_add %602, %608, %606 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %610 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %611 = openfhe.eval_func %arg0, %610, %609 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %612 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_215 = arith.constant 2 : i64
    %613 = openfhe.lwe_mul_const %612, %611, %c2_i64_215 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_216 = arith.constant 3 : i64
    %614 = openfhe.lwe_mul_const %612, %211, %c3_i64_216 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_217 = arith.constant -1 : i64
    %615 = openfhe.lwe_mul_const %612, %119, %c-1_i64_217 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_218 = arith.constant -2 : i64
    %616 = openfhe.lwe_mul_const %612, %601, %c-2_i64_218 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_219 = arith.constant -2 : i64
    %617 = openfhe.lwe_mul_const %612, %600, %c-2_i64_219 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_220 = arith.constant -2 : i64
    %618 = openfhe.lwe_mul_const %612, %592, %c-2_i64_220 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %619 = openfhe.lwe_add %612, %613, %614 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %620 = openfhe.lwe_add %612, %619, %615 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %621 = openfhe.lwe_add %612, %620, %616 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %622 = openfhe.lwe_add %612, %621, %617 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %623 = openfhe.lwe_add %612, %622, %618 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %624 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %625 = openfhe.eval_func %arg0, %624, %623 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %626 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-2_i64_221 = arith.constant -2 : i64
    %627 = openfhe.lwe_mul_const %626, %485, %c-2_i64_221 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_222 = arith.constant -2 : i64
    %628 = openfhe.lwe_mul_const %626, %466, %c-2_i64_222 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_223 = arith.constant 3 : i64
    %629 = openfhe.lwe_mul_const %626, %338, %c3_i64_223 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_224 = arith.constant 3 : i64
    %630 = openfhe.lwe_mul_const %626, %315, %c3_i64_224 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_225 = arith.constant -3 : i64
    %631 = openfhe.lwe_mul_const %626, %292, %c-3_i64_225 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %632 = openfhe.lwe_add %626, %627, %628 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %633 = openfhe.lwe_add %626, %632, %629 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %634 = openfhe.lwe_add %626, %633, %630 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %635 = openfhe.lwe_add %626, %634, %631 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %636 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %637 = openfhe.eval_func %arg0, %636, %635 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %638 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_226 = arith.constant 2 : i64
    %639 = openfhe.lwe_mul_const %638, %448, %c2_i64_226 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_227 = arith.constant 2 : i64
    %640 = openfhe.lwe_mul_const %638, %442, %c2_i64_227 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_228 = arith.constant 1 : i64
    %641 = openfhe.lwe_mul_const %638, %211, %c1_i64_228 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_229 = arith.constant -7 : i64
    %642 = openfhe.lwe_mul_const %638, %53, %c-7_i64_229 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %643 = openfhe.lwe_add %638, %639, %640 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %644 = openfhe.lwe_add %638, %643, %641 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %645 = openfhe.lwe_add %638, %644, %642 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %646 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %647 = openfhe.eval_func %arg0, %646, %645 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %648 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_230 = arith.constant 4 : i64
    %649 = openfhe.lwe_mul_const %648, %647, %c4_i64_230 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_231 = arith.constant -1 : i64
    %650 = openfhe.lwe_mul_const %648, %458, %c-1_i64_231 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_232 = arith.constant -1 : i64
    %651 = openfhe.lwe_mul_const %648, %436, %c-1_i64_232 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_233 = arith.constant -5 : i64
    %652 = openfhe.lwe_mul_const %648, %413, %c-5_i64_233 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %653 = openfhe.lwe_add %648, %649, %650 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %654 = openfhe.lwe_add %648, %653, %651 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %655 = openfhe.lwe_add %648, %654, %652 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %656 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %657 = openfhe.eval_func %arg0, %656, %655 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %658 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_234 = arith.constant 2 : i64
    %659 = openfhe.lwe_mul_const %658, %657, %c2_i64_234 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_235 = arith.constant 2 : i64
    %660 = openfhe.lwe_mul_const %658, %637, %c2_i64_235 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_236 = arith.constant 1 : i64
    %661 = openfhe.lwe_mul_const %658, %497, %c1_i64_236 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_237 = arith.constant -1 : i64
    %662 = openfhe.lwe_mul_const %658, %403, %c-1_i64_237 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_238 = arith.constant -2 : i64
    %663 = openfhe.lwe_mul_const %658, %625, %c-2_i64_238 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_239 = arith.constant -2 : i64
    %664 = openfhe.lwe_mul_const %658, %542, %c-2_i64_239 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_240 = arith.constant -2 : i64
    %665 = openfhe.lwe_mul_const %658, %532, %c-2_i64_240 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %666 = openfhe.lwe_add %658, %659, %660 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %667 = openfhe.lwe_add %658, %666, %661 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %668 = openfhe.lwe_add %658, %667, %662 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %669 = openfhe.lwe_add %658, %668, %663 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %670 = openfhe.lwe_add %658, %669, %664 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %671 = openfhe.lwe_add %658, %670, %665 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %672 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %673 = openfhe.eval_func %arg0, %672, %671 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %674 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_241 = arith.constant 4 : i64
    %675 = openfhe.lwe_mul_const %674, %14, %c4_i64_241 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_242 = arith.constant 2 : i64
    %676 = openfhe.lwe_mul_const %674, %0, %c2_i64_242 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_243 = arith.constant 1 : i64
    %677 = openfhe.lwe_mul_const %674, %3, %c1_i64_243 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %678 = openfhe.lwe_add %674, %675, %676 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %679 = openfhe.lwe_add %674, %678, %677 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %680 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %681 = openfhe.eval_func %arg0, %680, %679 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %681, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %31, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %84, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %167, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %252, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %375, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %520, %alloc[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %673, %alloc[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    return %alloc : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
  }
}

