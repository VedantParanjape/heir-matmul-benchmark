module {
  func.func @add8(%arg0: !openfhe.binfhe_context, %arg1: memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>, %arg2: memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>) -> memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>> {
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = memref.load %arg2[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %1 = memref.load %arg1[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %2 = memref.load %arg2[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %3 = memref.load %arg1[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %4 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64 = arith.constant 2 : i64
    %5 = openfhe.lwe_mul_const %4, %2, %c2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_0 = arith.constant 2 : i64
    %6 = openfhe.lwe_mul_const %4, %3, %c2_i64_0 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64 = arith.constant 1 : i64
    %7 = openfhe.lwe_mul_const %4, %0, %c1_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64 = arith.constant -7 : i64
    %8 = openfhe.lwe_mul_const %4, %1, %c-7_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %9 = openfhe.lwe_add %4, %5, %6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %10 = openfhe.lwe_add %4, %9, %7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %11 = openfhe.lwe_add %4, %10, %8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %12 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %13 = openfhe.eval_func %arg0, %12, %11 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %14 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_1 = arith.constant 2 : i64
    %15 = openfhe.lwe_mul_const %14, %2, %c2_i64_1 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_2 = arith.constant 2 : i64
    %16 = openfhe.lwe_mul_const %14, %3, %c2_i64_2 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_3 = arith.constant 1 : i64
    %17 = openfhe.lwe_mul_const %14, %0, %c1_i64_3 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_4 = arith.constant -7 : i64
    %18 = openfhe.lwe_mul_const %14, %1, %c-7_i64_4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %19 = openfhe.lwe_add %14, %15, %16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %20 = openfhe.lwe_add %14, %19, %17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %21 = openfhe.lwe_add %14, %20, %18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %22 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %23 = openfhe.eval_func %arg0, %22, %21 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %24 = memref.load %arg2[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %25 = memref.load %arg1[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %26 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64 = arith.constant 4 : i64
    %27 = openfhe.lwe_mul_const %26, %24, %c4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_5 = arith.constant 2 : i64
    %28 = openfhe.lwe_mul_const %26, %25, %c2_i64_5 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_6 = arith.constant 1 : i64
    %29 = openfhe.lwe_mul_const %26, %23, %c1_i64_6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %30 = openfhe.lwe_add %26, %27, %28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %31 = openfhe.lwe_add %26, %30, %29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %32 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %33 = openfhe.eval_func %arg0, %32, %31 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %34 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %35 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %36 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_7 = arith.constant 2 : i64
    %37 = openfhe.lwe_mul_const %36, %34, %c2_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64 = arith.constant -2 : i64
    %38 = openfhe.lwe_mul_const %36, %35, %c-2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_8 = arith.constant 1 : i64
    %39 = openfhe.lwe_mul_const %36, %24, %c1_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_9 = arith.constant 1 : i64
    %40 = openfhe.lwe_mul_const %36, %25, %c1_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64 = arith.constant -5 : i64
    %41 = openfhe.lwe_mul_const %36, %23, %c-5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %42 = openfhe.lwe_add %36, %37, %38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %43 = openfhe.lwe_add %36, %42, %39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %44 = openfhe.lwe_add %36, %43, %40 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %45 = openfhe.lwe_add %36, %44, %41 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %46 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %47 = openfhe.eval_func %arg0, %46, %45 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %48 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-2_i64_10 = arith.constant -2 : i64
    %49 = openfhe.lwe_mul_const %48, %34, %c-2_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_11 = arith.constant -2 : i64
    %50 = openfhe.lwe_mul_const %48, %35, %c-2_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64 = arith.constant 3 : i64
    %51 = openfhe.lwe_mul_const %48, %24, %c3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_12 = arith.constant 3 : i64
    %52 = openfhe.lwe_mul_const %48, %25, %c3_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64 = arith.constant -3 : i64
    %53 = openfhe.lwe_mul_const %48, %23, %c-3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %54 = openfhe.lwe_add %48, %49, %50 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %55 = openfhe.lwe_add %48, %54, %51 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %56 = openfhe.lwe_add %48, %55, %52 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %57 = openfhe.lwe_add %48, %56, %53 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %58 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %59 = openfhe.eval_func %arg0, %58, %57 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %60 = memref.load %arg2[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %61 = memref.load %arg1[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %62 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_13 = arith.constant 4 : i64
    %63 = openfhe.lwe_mul_const %62, %60, %c4_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_14 = arith.constant 2 : i64
    %64 = openfhe.lwe_mul_const %62, %61, %c2_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_15 = arith.constant 1 : i64
    %65 = openfhe.lwe_mul_const %62, %59, %c1_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %66 = openfhe.lwe_add %62, %63, %64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %67 = openfhe.lwe_add %62, %66, %65 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %68 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %69 = openfhe.eval_func %arg0, %68, %67 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %70 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %71 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %72 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_16 = arith.constant 2 : i64
    %73 = openfhe.lwe_mul_const %72, %70, %c2_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_17 = arith.constant -2 : i64
    %74 = openfhe.lwe_mul_const %72, %71, %c-2_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_18 = arith.constant 1 : i64
    %75 = openfhe.lwe_mul_const %72, %60, %c1_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_19 = arith.constant 1 : i64
    %76 = openfhe.lwe_mul_const %72, %61, %c1_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_20 = arith.constant -5 : i64
    %77 = openfhe.lwe_mul_const %72, %59, %c-5_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %78 = openfhe.lwe_add %72, %73, %74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %79 = openfhe.lwe_add %72, %78, %75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %80 = openfhe.lwe_add %72, %79, %76 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %81 = openfhe.lwe_add %72, %80, %77 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %82 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %83 = openfhe.eval_func %arg0, %82, %81 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %84 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-2_i64_21 = arith.constant -2 : i64
    %85 = openfhe.lwe_mul_const %84, %70, %c-2_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_22 = arith.constant -2 : i64
    %86 = openfhe.lwe_mul_const %84, %71, %c-2_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_23 = arith.constant 3 : i64
    %87 = openfhe.lwe_mul_const %84, %60, %c3_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_24 = arith.constant 3 : i64
    %88 = openfhe.lwe_mul_const %84, %61, %c3_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_25 = arith.constant -3 : i64
    %89 = openfhe.lwe_mul_const %84, %59, %c-3_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %90 = openfhe.lwe_add %84, %85, %86 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %91 = openfhe.lwe_add %84, %90, %87 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %92 = openfhe.lwe_add %84, %91, %88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %93 = openfhe.lwe_add %84, %92, %89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %94 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %95 = openfhe.eval_func %arg0, %94, %93 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %96 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %97 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %98 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_26 = arith.constant 4 : i64
    %99 = openfhe.lwe_mul_const %98, %96, %c4_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_27 = arith.constant 2 : i64
    %100 = openfhe.lwe_mul_const %98, %97, %c2_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_28 = arith.constant 1 : i64
    %101 = openfhe.lwe_mul_const %98, %95, %c1_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %102 = openfhe.lwe_add %98, %99, %100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %103 = openfhe.lwe_add %98, %102, %101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %104 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %105 = openfhe.eval_func %arg0, %104, %103 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %106 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %107 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %108 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_29 = arith.constant 2 : i64
    %109 = openfhe.lwe_mul_const %108, %106, %c2_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_30 = arith.constant -2 : i64
    %110 = openfhe.lwe_mul_const %108, %107, %c-2_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_31 = arith.constant 1 : i64
    %111 = openfhe.lwe_mul_const %108, %96, %c1_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_32 = arith.constant 1 : i64
    %112 = openfhe.lwe_mul_const %108, %97, %c1_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_33 = arith.constant -5 : i64
    %113 = openfhe.lwe_mul_const %108, %95, %c-5_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %114 = openfhe.lwe_add %108, %109, %110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %115 = openfhe.lwe_add %108, %114, %111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %116 = openfhe.lwe_add %108, %115, %112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %117 = openfhe.lwe_add %108, %116, %113 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %118 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %119 = openfhe.eval_func %arg0, %118, %117 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %120 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_34 = arith.constant 2 : i64
    %121 = openfhe.lwe_mul_const %120, %0, %c2_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_35 = arith.constant 1 : i64
    %122 = openfhe.lwe_mul_const %120, %1, %c1_i64_35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %123 = openfhe.lwe_add %120, %121, %122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %124 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %125 = openfhe.eval_func %arg0, %124, %123 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %125, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %13, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %33, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %47, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %69, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %83, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %105, %alloc[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %119, %alloc[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    return %alloc : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
  }
  func.func @mul8(%arg0: !openfhe.binfhe_context, %arg1: memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>, %arg2: memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>) -> memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>> {
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = memref.load %arg2[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %1 = memref.load %arg1[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %2 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64 = arith.constant 2 : i64
    %3 = openfhe.lwe_mul_const %2, %0, %c2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64 = arith.constant 1 : i64
    %4 = openfhe.lwe_mul_const %2, %1, %c1_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %5 = openfhe.lwe_add %2, %3, %4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %6 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %7 = openfhe.eval_func %arg0, %6, %5 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %8 = memref.load %arg2[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %9 = memref.load %arg1[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %10 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64 = arith.constant 3 : i64
    %11 = openfhe.lwe_mul_const %10, %8, %c3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_0 = arith.constant 3 : i64
    %12 = openfhe.lwe_mul_const %10, %1, %c3_i64_0 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_1 = arith.constant 1 : i64
    %13 = openfhe.lwe_mul_const %10, %0, %c1_i64_1 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64 = arith.constant -7 : i64
    %14 = openfhe.lwe_mul_const %10, %9, %c-7_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %15 = openfhe.lwe_add %10, %11, %12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %16 = openfhe.lwe_add %10, %15, %13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %17 = openfhe.lwe_add %10, %16, %14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %18 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %19 = openfhe.eval_func %arg0, %18, %17 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %20 = memref.load %arg2[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %21 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_2 = arith.constant 2 : i64
    %22 = openfhe.lwe_mul_const %21, %20, %c2_i64_2 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_3 = arith.constant 1 : i64
    %23 = openfhe.lwe_mul_const %21, %1, %c1_i64_3 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %24 = openfhe.lwe_add %21, %22, %23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %25 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %26 = openfhe.eval_func %arg0, %25, %24 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %27 = memref.load %arg1[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %28 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64 = arith.constant 4 : i64
    %29 = openfhe.lwe_mul_const %28, %26, %c4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_4 = arith.constant 2 : i64
    %30 = openfhe.lwe_mul_const %28, %0, %c2_i64_4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_5 = arith.constant 1 : i64
    %31 = openfhe.lwe_mul_const %28, %27, %c1_i64_5 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %32 = openfhe.lwe_add %28, %29, %30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %33 = openfhe.lwe_add %28, %32, %31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %34 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %35 = openfhe.eval_func %arg0, %34, %33 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %36 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_6 = arith.constant 2 : i64
    %37 = openfhe.lwe_mul_const %36, %8, %c2_i64_6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_7 = arith.constant 1 : i64
    %38 = openfhe.lwe_mul_const %36, %9, %c1_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %39 = openfhe.lwe_add %36, %37, %38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %40 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %41 = openfhe.eval_func %arg0, %40, %39 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %42 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_8 = arith.constant 4 : i64
    %43 = openfhe.lwe_mul_const %42, %35, %c4_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_9 = arith.constant 2 : i64
    %44 = openfhe.lwe_mul_const %42, %41, %c2_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_10 = arith.constant 1 : i64
    %45 = openfhe.lwe_mul_const %42, %7, %c1_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %46 = openfhe.lwe_add %42, %43, %44 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %47 = openfhe.lwe_add %42, %46, %45 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %48 = openfhe.make_lut %arg0 {values = array<i32: 2, 4, 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %49 = openfhe.eval_func %arg0, %48, %47 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %50 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_11 = arith.constant 2 : i64
    %51 = openfhe.lwe_mul_const %50, %27, %c2_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_12 = arith.constant 1 : i64
    %52 = openfhe.lwe_mul_const %50, %20, %c1_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %53 = openfhe.lwe_add %50, %51, %52 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %54 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %55 = openfhe.eval_func %arg0, %54, %53 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %56 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_13 = arith.constant 2 : i64
    %57 = openfhe.lwe_mul_const %56, %55, %c2_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_14 = arith.constant 1 : i64
    %58 = openfhe.lwe_mul_const %56, %7, %c1_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %59 = openfhe.lwe_add %56, %57, %58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %60 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %61 = openfhe.eval_func %arg0, %60, %59 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %62 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %63 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_15 = arith.constant 2 : i64
    %64 = openfhe.lwe_mul_const %63, %0, %c2_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_16 = arith.constant 1 : i64
    %65 = openfhe.lwe_mul_const %63, %62, %c1_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %66 = openfhe.lwe_add %63, %64, %65 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %67 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %68 = openfhe.eval_func %arg0, %67, %66 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %69 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %70 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_17 = arith.constant 2 : i64
    %71 = openfhe.lwe_mul_const %70, %69, %c2_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_18 = arith.constant 1 : i64
    %72 = openfhe.lwe_mul_const %70, %1, %c1_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %73 = openfhe.lwe_add %70, %71, %72 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %74 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %75 = openfhe.eval_func %arg0, %74, %73 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %76 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_19 = arith.constant 3 : i64
    %77 = openfhe.lwe_mul_const %76, %9, %c3_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64 = arith.constant -1 : i64
    %78 = openfhe.lwe_mul_const %76, %20, %c-1_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_20 = arith.constant 2 : i64
    %79 = openfhe.lwe_mul_const %76, %75, %c2_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64 = arith.constant -6 : i64
    %80 = openfhe.lwe_mul_const %76, %68, %c-6_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %81 = openfhe.lwe_add %76, %77, %78 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %82 = openfhe.lwe_add %76, %81, %79 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %83 = openfhe.lwe_add %76, %82, %80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %84 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %85 = openfhe.eval_func %arg0, %84, %83 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %86 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_21 = arith.constant 3 : i64
    %87 = openfhe.lwe_mul_const %86, %8, %c3_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_22 = arith.constant -1 : i64
    %88 = openfhe.lwe_mul_const %86, %27, %c-1_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_23 = arith.constant 2 : i64
    %89 = openfhe.lwe_mul_const %86, %85, %c2_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_24 = arith.constant -6 : i64
    %90 = openfhe.lwe_mul_const %86, %61, %c-6_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %91 = openfhe.lwe_add %86, %87, %88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %92 = openfhe.lwe_add %86, %91, %89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %93 = openfhe.lwe_add %86, %92, %90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %94 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %95 = openfhe.eval_func %arg0, %94, %93 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %96 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_25 = arith.constant 2 : i64
    %97 = openfhe.lwe_mul_const %96, %95, %c2_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_26 = arith.constant 2 : i64
    %98 = openfhe.lwe_mul_const %96, %41, %c2_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_27 = arith.constant 2 : i64
    %99 = openfhe.lwe_mul_const %96, %7, %c2_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_28 = arith.constant -7 : i64
    %100 = openfhe.lwe_mul_const %96, %35, %c-7_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %101 = openfhe.lwe_add %96, %97, %98 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %102 = openfhe.lwe_add %96, %101, %99 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %103 = openfhe.lwe_add %96, %102, %100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %104 = openfhe.make_lut %arg0 {values = array<i32: 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %105 = openfhe.eval_func %arg0, %104, %103 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %106 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_29 = arith.constant 1 : i64
    %107 = openfhe.lwe_mul_const %106, %41, %c1_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_30 = arith.constant 1 : i64
    %108 = openfhe.lwe_mul_const %106, %35, %c1_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_31 = arith.constant -7 : i64
    %109 = openfhe.lwe_mul_const %106, %95, %c-7_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %110 = openfhe.lwe_add %106, %107, %108 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %111 = openfhe.lwe_add %106, %110, %109 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %112 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %113 = openfhe.eval_func %arg0, %112, %111 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %114 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_32 = arith.constant 1 : i64
    %115 = openfhe.lwe_mul_const %114, %8, %c1_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_33 = arith.constant 1 : i64
    %116 = openfhe.lwe_mul_const %114, %27, %c1_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_34 = arith.constant 2 : i64
    %117 = openfhe.lwe_mul_const %114, %85, %c2_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_35 = arith.constant -6 : i64
    %118 = openfhe.lwe_mul_const %114, %61, %c-6_i64_35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %119 = openfhe.lwe_add %114, %115, %116 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %120 = openfhe.lwe_add %114, %119, %117 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %121 = openfhe.lwe_add %114, %120, %118 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %122 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %123 = openfhe.eval_func %arg0, %122, %121 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %124 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_36 = arith.constant 3 : i64
    %125 = openfhe.lwe_mul_const %124, %68, %c3_i64_36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_37 = arith.constant 1 : i64
    %126 = openfhe.lwe_mul_const %124, %9, %c1_i64_37 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_38 = arith.constant 1 : i64
    %127 = openfhe.lwe_mul_const %124, %20, %c1_i64_38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_39 = arith.constant -6 : i64
    %128 = openfhe.lwe_mul_const %124, %75, %c-6_i64_39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %129 = openfhe.lwe_add %124, %125, %126 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %130 = openfhe.lwe_add %124, %129, %127 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %131 = openfhe.lwe_add %124, %130, %128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %132 = openfhe.make_lut %arg0 {values = array<i32: 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %133 = openfhe.eval_func %arg0, %132, %131 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %134 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_40 = arith.constant 4 : i64
    %135 = openfhe.lwe_mul_const %134, %55, %c4_i64_40 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_41 = arith.constant 3 : i64
    %136 = openfhe.lwe_mul_const %134, %69, %c3_i64_41 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64 = arith.constant -2 : i64
    %137 = openfhe.lwe_mul_const %134, %9, %c-2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64 = arith.constant -3 : i64
    %138 = openfhe.lwe_mul_const %134, %26, %c-3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %139 = openfhe.lwe_add %134, %135, %136 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %140 = openfhe.lwe_add %134, %139, %137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %141 = openfhe.lwe_add %134, %140, %138 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %142 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %143 = openfhe.eval_func %arg0, %142, %141 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %144 = memref.load %arg1[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %145 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_42 = arith.constant 2 : i64
    %146 = openfhe.lwe_mul_const %145, %0, %c2_i64_42 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_43 = arith.constant 1 : i64
    %147 = openfhe.lwe_mul_const %145, %144, %c1_i64_43 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %148 = openfhe.lwe_add %145, %146, %147 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %149 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %150 = openfhe.eval_func %arg0, %149, %148 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %151 = memref.load %arg2[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %152 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_44 = arith.constant 3 : i64
    %153 = openfhe.lwe_mul_const %152, %8, %c3_i64_44 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_45 = arith.constant 3 : i64
    %154 = openfhe.lwe_mul_const %152, %62, %c3_i64_45 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_46 = arith.constant 1 : i64
    %155 = openfhe.lwe_mul_const %152, %151, %c1_i64_46 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_47 = arith.constant -7 : i64
    %156 = openfhe.lwe_mul_const %152, %1, %c-7_i64_47 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %157 = openfhe.lwe_add %152, %153, %154 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %158 = openfhe.lwe_add %152, %157, %155 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %159 = openfhe.lwe_add %152, %158, %156 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %160 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %161 = openfhe.eval_func %arg0, %160, %159 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %162 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_48 = arith.constant 1 : i64
    %163 = openfhe.lwe_mul_const %162, %161, %c1_i64_48 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_49 = arith.constant 1 : i64
    %164 = openfhe.lwe_mul_const %162, %150, %c1_i64_49 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_50 = arith.constant 1 : i64
    %165 = openfhe.lwe_mul_const %162, %143, %c1_i64_50 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_51 = arith.constant 1 : i64
    %166 = openfhe.lwe_mul_const %162, %133, %c1_i64_51 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_52 = arith.constant -7 : i64
    %167 = openfhe.lwe_mul_const %162, %123, %c-7_i64_52 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %168 = openfhe.lwe_add %162, %163, %164 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %169 = openfhe.lwe_add %162, %168, %165 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %170 = openfhe.lwe_add %162, %169, %166 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %171 = openfhe.lwe_add %162, %170, %167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %172 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %173 = openfhe.eval_func %arg0, %172, %171 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %174 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_53 = arith.constant 4 : i64
    %175 = openfhe.lwe_mul_const %174, %173, %c4_i64_53 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_54 = arith.constant 2 : i64
    %176 = openfhe.lwe_mul_const %174, %113, %c2_i64_54 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_55 = arith.constant 1 : i64
    %177 = openfhe.lwe_mul_const %174, %105, %c1_i64_55 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %178 = openfhe.lwe_add %174, %175, %176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %179 = openfhe.lwe_add %174, %178, %177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %180 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %181 = openfhe.eval_func %arg0, %180, %179 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %182 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_56 = arith.constant 4 : i64
    %183 = openfhe.lwe_mul_const %182, %173, %c4_i64_56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_57 = arith.constant 2 : i64
    %184 = openfhe.lwe_mul_const %182, %113, %c2_i64_57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_58 = arith.constant 1 : i64
    %185 = openfhe.lwe_mul_const %182, %105, %c1_i64_58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %186 = openfhe.lwe_add %182, %183, %184 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %187 = openfhe.lwe_add %182, %186, %185 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %188 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %189 = openfhe.eval_func %arg0, %188, %187 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %190 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_59 = arith.constant 4 : i64
    %191 = openfhe.lwe_mul_const %190, %150, %c4_i64_59 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64 = arith.constant -4 : i64
    %192 = openfhe.lwe_mul_const %190, %143, %c-4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_60 = arith.constant 2 : i64
    %193 = openfhe.lwe_mul_const %190, %133, %c2_i64_60 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_61 = arith.constant -3 : i64
    %194 = openfhe.lwe_mul_const %190, %161, %c-3_i64_61 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %195 = openfhe.lwe_add %190, %191, %192 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %196 = openfhe.lwe_add %190, %195, %193 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %197 = openfhe.lwe_add %190, %196, %194 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %198 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %199 = openfhe.eval_func %arg0, %198, %197 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %200 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_62 = arith.constant 2 : i64
    %201 = openfhe.lwe_mul_const %200, %69, %c2_i64_62 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_63 = arith.constant 2 : i64
    %202 = openfhe.lwe_mul_const %200, %9, %c2_i64_63 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_64 = arith.constant -7 : i64
    %203 = openfhe.lwe_mul_const %200, %55, %c-7_i64_64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %204 = openfhe.lwe_add %200, %201, %202 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %205 = openfhe.lwe_add %200, %204, %203 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %206 = openfhe.make_lut %arg0 {values = array<i32: 1, 3, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %207 = openfhe.eval_func %arg0, %206, %205 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %208 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_65 = arith.constant 4 : i64
    %209 = openfhe.lwe_mul_const %208, %143, %c4_i64_65 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_66 = arith.constant 2 : i64
    %210 = openfhe.lwe_mul_const %208, %150, %c2_i64_66 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_67 = arith.constant 1 : i64
    %211 = openfhe.lwe_mul_const %208, %207, %c1_i64_67 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %212 = openfhe.lwe_add %208, %209, %210 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %213 = openfhe.lwe_add %208, %212, %211 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %214 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %215 = openfhe.eval_func %arg0, %214, %213 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %216 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_68 = arith.constant 2 : i64
    %217 = openfhe.lwe_mul_const %216, %62, %c2_i64_68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_69 = arith.constant 1 : i64
    %218 = openfhe.lwe_mul_const %216, %20, %c1_i64_69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %219 = openfhe.lwe_add %216, %217, %218 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %220 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %221 = openfhe.eval_func %arg0, %220, %219 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %222 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %223 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_70 = arith.constant 2 : i64
    %224 = openfhe.lwe_mul_const %223, %222, %c2_i64_70 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_71 = arith.constant 1 : i64
    %225 = openfhe.lwe_mul_const %223, %1, %c1_i64_71 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %226 = openfhe.lwe_add %223, %224, %225 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %227 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %228 = openfhe.eval_func %arg0, %227, %226 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %229 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_72 = arith.constant 2 : i64
    %230 = openfhe.lwe_mul_const %229, %228, %c2_i64_72 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_73 = arith.constant 1 : i64
    %231 = openfhe.lwe_mul_const %229, %221, %c1_i64_73 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %232 = openfhe.lwe_add %229, %230, %231 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %233 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %234 = openfhe.eval_func %arg0, %233, %232 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %235 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_74 = arith.constant 3 : i64
    %236 = openfhe.lwe_mul_const %235, %69, %c3_i64_74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_75 = arith.constant 3 : i64
    %237 = openfhe.lwe_mul_const %235, %27, %c3_i64_75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_76 = arith.constant 1 : i64
    %238 = openfhe.lwe_mul_const %235, %9, %c1_i64_76 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_77 = arith.constant -7 : i64
    %239 = openfhe.lwe_mul_const %235, %20, %c-7_i64_77 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %240 = openfhe.lwe_add %235, %236, %237 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %241 = openfhe.lwe_add %235, %240, %238 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %242 = openfhe.lwe_add %235, %241, %239 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %243 = openfhe.make_lut %arg0 {values = array<i32: 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %244 = openfhe.eval_func %arg0, %243, %242 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %245 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %246 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_78 = arith.constant 3 : i64
    %247 = openfhe.lwe_mul_const %246, %0, %c3_i64_78 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_79 = arith.constant -1 : i64
    %248 = openfhe.lwe_mul_const %246, %245, %c-1_i64_79 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_80 = arith.constant 2 : i64
    %249 = openfhe.lwe_mul_const %246, %244, %c2_i64_80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_81 = arith.constant -6 : i64
    %250 = openfhe.lwe_mul_const %246, %234, %c-6_i64_81 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %251 = openfhe.lwe_add %246, %247, %248 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %252 = openfhe.lwe_add %246, %251, %249 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %253 = openfhe.lwe_add %246, %252, %250 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %254 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %255 = openfhe.eval_func %arg0, %254, %253 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %256 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_82 = arith.constant 1 : i64
    %257 = openfhe.lwe_mul_const %256, %151, %c1_i64_82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_83 = arith.constant 1 : i64
    %258 = openfhe.lwe_mul_const %256, %62, %c1_i64_83 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_84 = arith.constant 1 : i64
    %259 = openfhe.lwe_mul_const %256, %8, %c1_i64_84 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_85 = arith.constant -7 : i64
    %260 = openfhe.lwe_mul_const %256, %1, %c-7_i64_85 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %261 = openfhe.lwe_add %256, %257, %258 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %262 = openfhe.lwe_add %256, %261, %259 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %263 = openfhe.lwe_add %256, %262, %260 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %264 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %265 = openfhe.eval_func %arg0, %264, %263 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %266 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_86 = arith.constant 3 : i64
    %267 = openfhe.lwe_mul_const %266, %8, %c3_i64_86 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_87 = arith.constant 3 : i64
    %268 = openfhe.lwe_mul_const %266, %144, %c3_i64_87 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_88 = arith.constant 1 : i64
    %269 = openfhe.lwe_mul_const %266, %151, %c1_i64_88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_89 = arith.constant -7 : i64
    %270 = openfhe.lwe_mul_const %266, %9, %c-7_i64_89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %271 = openfhe.lwe_add %266, %267, %268 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %272 = openfhe.lwe_add %266, %271, %269 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %273 = openfhe.lwe_add %266, %272, %270 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %274 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %275 = openfhe.eval_func %arg0, %274, %273 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %276 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_90 = arith.constant 1 : i64
    %277 = openfhe.lwe_mul_const %276, %275, %c1_i64_90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_91 = arith.constant 1 : i64
    %278 = openfhe.lwe_mul_const %276, %265, %c1_i64_91 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_92 = arith.constant 1 : i64
    %279 = openfhe.lwe_mul_const %276, %255, %c1_i64_92 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_93 = arith.constant -7 : i64
    %280 = openfhe.lwe_mul_const %276, %215, %c-7_i64_93 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %281 = openfhe.lwe_add %276, %277, %278 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %282 = openfhe.lwe_add %276, %281, %279 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %283 = openfhe.lwe_add %276, %282, %280 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %284 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %285 = openfhe.eval_func %arg0, %284, %283 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %286 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_94 = arith.constant 2 : i64
    %287 = openfhe.lwe_mul_const %286, %161, %c2_i64_94 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_95 = arith.constant 2 : i64
    %288 = openfhe.lwe_mul_const %286, %150, %c2_i64_95 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_96 = arith.constant 2 : i64
    %289 = openfhe.lwe_mul_const %286, %143, %c2_i64_96 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_97 = arith.constant -2 : i64
    %290 = openfhe.lwe_mul_const %286, %133, %c-2_i64_97 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64 = arith.constant -5 : i64
    %291 = openfhe.lwe_mul_const %286, %123, %c-5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %292 = openfhe.lwe_add %286, %287, %288 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %293 = openfhe.lwe_add %286, %292, %289 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %294 = openfhe.lwe_add %286, %293, %290 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %295 = openfhe.lwe_add %286, %294, %291 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %296 = openfhe.make_lut %arg0 {values = array<i32: 2, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %297 = openfhe.eval_func %arg0, %296, %295 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %298 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_98 = arith.constant 1 : i64
    %299 = openfhe.lwe_mul_const %298, %297, %c1_i64_98 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_99 = arith.constant 1 : i64
    %300 = openfhe.lwe_mul_const %298, %285, %c1_i64_99 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_100 = arith.constant 1 : i64
    %301 = openfhe.lwe_mul_const %298, %199, %c1_i64_100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_101 = arith.constant -7 : i64
    %302 = openfhe.lwe_mul_const %298, %189, %c-7_i64_101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %303 = openfhe.lwe_add %298, %299, %300 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %304 = openfhe.lwe_add %298, %303, %301 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %305 = openfhe.lwe_add %298, %304, %302 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %306 = openfhe.make_lut %arg0 {values = array<i32: 1, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %307 = openfhe.eval_func %arg0, %306, %305 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %308 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_102 = arith.constant 2 : i64
    %309 = openfhe.lwe_mul_const %308, %297, %c2_i64_102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c4_i64_103 = arith.constant 4 : i64
    %310 = openfhe.lwe_mul_const %308, %285, %c4_i64_103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64_104 = arith.constant -4 : i64
    %311 = openfhe.lwe_mul_const %308, %199, %c-4_i64_104 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_105 = arith.constant -3 : i64
    %312 = openfhe.lwe_mul_const %308, %189, %c-3_i64_105 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %313 = openfhe.lwe_add %308, %309, %310 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %314 = openfhe.lwe_add %308, %313, %311 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %315 = openfhe.lwe_add %308, %314, %312 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %316 = openfhe.make_lut %arg0 {values = array<i32: 1, 3, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %317 = openfhe.eval_func %arg0, %316, %315 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %318 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_106 = arith.constant 4 : i64
    %319 = openfhe.lwe_mul_const %318, %275, %c4_i64_106 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64_107 = arith.constant -4 : i64
    %320 = openfhe.lwe_mul_const %318, %265, %c-4_i64_107 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_108 = arith.constant 2 : i64
    %321 = openfhe.lwe_mul_const %318, %255, %c2_i64_108 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_109 = arith.constant -3 : i64
    %322 = openfhe.lwe_mul_const %318, %215, %c-3_i64_109 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %323 = openfhe.lwe_add %318, %319, %320 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %324 = openfhe.lwe_add %318, %323, %321 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %325 = openfhe.lwe_add %318, %324, %322 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %326 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %327 = openfhe.eval_func %arg0, %326, %325 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %328 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_110 = arith.constant 2 : i64
    %329 = openfhe.lwe_mul_const %328, %0, %c2_i64_110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_111 = arith.constant 2 : i64
    %330 = openfhe.lwe_mul_const %328, %245, %c2_i64_111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_112 = arith.constant 1 : i64
    %331 = openfhe.lwe_mul_const %328, %244, %c1_i64_112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_113 = arith.constant -7 : i64
    %332 = openfhe.lwe_mul_const %328, %234, %c-7_i64_113 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %333 = openfhe.lwe_add %328, %329, %330 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %334 = openfhe.lwe_add %328, %333, %331 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %335 = openfhe.lwe_add %328, %334, %332 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %336 = openfhe.make_lut %arg0 {values = array<i32: 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %337 = openfhe.eval_func %arg0, %336, %335 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %338 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_114 = arith.constant 2 : i64
    %339 = openfhe.lwe_mul_const %338, %69, %c2_i64_114 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_115 = arith.constant 2 : i64
    %340 = openfhe.lwe_mul_const %338, %9, %c2_i64_115 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_116 = arith.constant 2 : i64
    %341 = openfhe.lwe_mul_const %338, %55, %c2_i64_116 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_117 = arith.constant -7 : i64
    %342 = openfhe.lwe_mul_const %338, %234, %c-7_i64_117 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %343 = openfhe.lwe_add %338, %339, %340 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %344 = openfhe.lwe_add %338, %343, %341 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %345 = openfhe.lwe_add %338, %344, %342 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %346 = openfhe.make_lut %arg0 {values = array<i32: 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %347 = openfhe.eval_func %arg0, %346, %345 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %348 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_118 = arith.constant 2 : i64
    %349 = openfhe.lwe_mul_const %348, %144, %c2_i64_118 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_119 = arith.constant 1 : i64
    %350 = openfhe.lwe_mul_const %348, %20, %c1_i64_119 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %351 = openfhe.lwe_add %348, %349, %350 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %352 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %353 = openfhe.eval_func %arg0, %352, %351 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %354 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_120 = arith.constant 2 : i64
    %355 = openfhe.lwe_mul_const %354, %222, %c2_i64_120 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_121 = arith.constant 1 : i64
    %356 = openfhe.lwe_mul_const %354, %9, %c1_i64_121 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %357 = openfhe.lwe_add %354, %355, %356 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %358 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %359 = openfhe.eval_func %arg0, %358, %357 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %360 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_122 = arith.constant 2 : i64
    %361 = openfhe.lwe_mul_const %360, %359, %c2_i64_122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_123 = arith.constant 2 : i64
    %362 = openfhe.lwe_mul_const %360, %353, %c2_i64_123 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_124 = arith.constant 1 : i64
    %363 = openfhe.lwe_mul_const %360, %69, %c1_i64_124 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_125 = arith.constant -7 : i64
    %364 = openfhe.lwe_mul_const %360, %62, %c-7_i64_125 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %365 = openfhe.lwe_add %360, %361, %362 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %366 = openfhe.lwe_add %360, %365, %363 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %367 = openfhe.lwe_add %360, %366, %364 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %368 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %369 = openfhe.eval_func %arg0, %368, %367 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %370 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_126 = arith.constant 2 : i64
    %371 = openfhe.lwe_mul_const %370, %228, %c2_i64_126 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_127 = arith.constant 2 : i64
    %372 = openfhe.lwe_mul_const %370, %221, %c2_i64_127 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_128 = arith.constant 1 : i64
    %373 = openfhe.lwe_mul_const %370, %69, %c1_i64_128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_129 = arith.constant -7 : i64
    %374 = openfhe.lwe_mul_const %370, %27, %c-7_i64_129 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %375 = openfhe.lwe_add %370, %371, %372 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %376 = openfhe.lwe_add %370, %375, %373 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %377 = openfhe.lwe_add %370, %376, %374 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %378 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %379 = openfhe.eval_func %arg0, %378, %377 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %380 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %381 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %382 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_130 = arith.constant 3 : i64
    %383 = openfhe.lwe_mul_const %382, %380, %c3_i64_130 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_131 = arith.constant 3 : i64
    %384 = openfhe.lwe_mul_const %382, %1, %c3_i64_131 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_132 = arith.constant 1 : i64
    %385 = openfhe.lwe_mul_const %382, %0, %c1_i64_132 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_133 = arith.constant -7 : i64
    %386 = openfhe.lwe_mul_const %382, %381, %c-7_i64_133 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %387 = openfhe.lwe_add %382, %383, %384 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %388 = openfhe.lwe_add %382, %387, %385 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %389 = openfhe.lwe_add %382, %388, %386 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %390 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %391 = openfhe.eval_func %arg0, %390, %389 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %392 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_134 = arith.constant 4 : i64
    %393 = openfhe.lwe_mul_const %392, %391, %c4_i64_134 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_135 = arith.constant 2 : i64
    %394 = openfhe.lwe_mul_const %392, %379, %c2_i64_135 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_136 = arith.constant 1 : i64
    %395 = openfhe.lwe_mul_const %392, %369, %c1_i64_136 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %396 = openfhe.lwe_add %392, %393, %394 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %397 = openfhe.lwe_add %392, %396, %395 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %398 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %399 = openfhe.eval_func %arg0, %398, %397 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %400 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_137 = arith.constant 4 : i64
    %401 = openfhe.lwe_mul_const %400, %399, %c4_i64_137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_138 = arith.constant 2 : i64
    %402 = openfhe.lwe_mul_const %400, %347, %c2_i64_138 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_139 = arith.constant 1 : i64
    %403 = openfhe.lwe_mul_const %400, %337, %c1_i64_139 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %404 = openfhe.lwe_add %400, %401, %402 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %405 = openfhe.lwe_add %400, %404, %403 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %406 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 3, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %407 = openfhe.eval_func %arg0, %406, %405 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %408 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_140 = arith.constant 1 : i64
    %409 = openfhe.lwe_mul_const %408, %151, %c1_i64_140 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_141 = arith.constant 1 : i64
    %410 = openfhe.lwe_mul_const %408, %9, %c1_i64_141 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_142 = arith.constant 1 : i64
    %411 = openfhe.lwe_mul_const %408, %8, %c1_i64_142 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_143 = arith.constant -7 : i64
    %412 = openfhe.lwe_mul_const %408, %144, %c-7_i64_143 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %413 = openfhe.lwe_add %408, %409, %410 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %414 = openfhe.lwe_add %408, %413, %411 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %415 = openfhe.lwe_add %408, %414, %412 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %416 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %417 = openfhe.eval_func %arg0, %416, %415 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %418 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_144 = arith.constant 3 : i64
    %419 = openfhe.lwe_mul_const %418, %8, %c3_i64_144 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_145 = arith.constant 3 : i64
    %420 = openfhe.lwe_mul_const %418, %245, %c3_i64_145 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_146 = arith.constant 1 : i64
    %421 = openfhe.lwe_mul_const %418, %151, %c1_i64_146 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_147 = arith.constant -7 : i64
    %422 = openfhe.lwe_mul_const %418, %27, %c-7_i64_147 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %423 = openfhe.lwe_add %418, %419, %420 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %424 = openfhe.lwe_add %418, %423, %421 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %425 = openfhe.lwe_add %418, %424, %422 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %426 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %427 = openfhe.eval_func %arg0, %426, %425 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %428 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_148 = arith.constant 1 : i64
    %429 = openfhe.lwe_mul_const %428, %427, %c1_i64_148 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_149 = arith.constant 1 : i64
    %430 = openfhe.lwe_mul_const %428, %417, %c1_i64_149 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_150 = arith.constant 1 : i64
    %431 = openfhe.lwe_mul_const %428, %407, %c1_i64_150 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_151 = arith.constant -7 : i64
    %432 = openfhe.lwe_mul_const %428, %327, %c-7_i64_151 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %433 = openfhe.lwe_add %428, %429, %430 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %434 = openfhe.lwe_add %428, %433, %431 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %435 = openfhe.lwe_add %428, %434, %432 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %436 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %437 = openfhe.eval_func %arg0, %436, %435 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %438 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_152 = arith.constant 2 : i64
    %439 = openfhe.lwe_mul_const %438, %275, %c2_i64_152 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_153 = arith.constant 1 : i64
    %440 = openfhe.lwe_mul_const %438, %265, %c1_i64_153 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %441 = openfhe.lwe_add %438, %439, %440 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %442 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %443 = openfhe.eval_func %arg0, %442, %441 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %444 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_154 = arith.constant 2 : i64
    %445 = openfhe.lwe_mul_const %444, %285, %c2_i64_154 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_155 = arith.constant 1 : i64
    %446 = openfhe.lwe_mul_const %444, %199, %c1_i64_155 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %447 = openfhe.lwe_add %444, %445, %446 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %448 = openfhe.make_lut %arg0 {values = array<i32: 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %449 = openfhe.eval_func %arg0, %448, %447 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %450 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_156 = arith.constant 1 : i64
    %451 = openfhe.lwe_mul_const %450, %449, %c1_i64_156 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_157 = arith.constant 1 : i64
    %452 = openfhe.lwe_mul_const %450, %443, %c1_i64_157 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_158 = arith.constant 1 : i64
    %453 = openfhe.lwe_mul_const %450, %437, %c1_i64_158 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_159 = arith.constant -7 : i64
    %454 = openfhe.lwe_mul_const %450, %317, %c-7_i64_159 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %455 = openfhe.lwe_add %450, %451, %452 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %456 = openfhe.lwe_add %450, %455, %453 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %457 = openfhe.lwe_add %450, %456, %454 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %458 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %459 = openfhe.eval_func %arg0, %458, %457 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %460 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_160 = arith.constant 4 : i64
    %461 = openfhe.lwe_mul_const %460, %437, %c4_i64_160 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_161 = arith.constant 2 : i64
    %462 = openfhe.lwe_mul_const %460, %327, %c2_i64_161 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_162 = arith.constant 1 : i64
    %463 = openfhe.lwe_mul_const %460, %443, %c1_i64_162 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %464 = openfhe.lwe_add %460, %461, %462 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %465 = openfhe.lwe_add %460, %464, %463 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %466 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 4, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %467 = openfhe.eval_func %arg0, %466, %465 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %468 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_163 = arith.constant 2 : i64
    %469 = openfhe.lwe_mul_const %468, %407, %c2_i64_163 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c4_i64_164 = arith.constant 4 : i64
    %470 = openfhe.lwe_mul_const %468, %427, %c4_i64_164 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64_165 = arith.constant -4 : i64
    %471 = openfhe.lwe_mul_const %468, %417, %c-4_i64_165 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_166 = arith.constant -3 : i64
    %472 = openfhe.lwe_mul_const %468, %399, %c-3_i64_166 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %473 = openfhe.lwe_add %468, %469, %470 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %474 = openfhe.lwe_add %468, %473, %471 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %475 = openfhe.lwe_add %468, %474, %472 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %476 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %477 = openfhe.eval_func %arg0, %476, %475 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %478 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_167 = arith.constant 1 : i64
    %479 = openfhe.lwe_mul_const %478, %0, %c1_i64_167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_168 = arith.constant 1 : i64
    %480 = openfhe.lwe_mul_const %478, %381, %c1_i64_168 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_169 = arith.constant 1 : i64
    %481 = openfhe.lwe_mul_const %478, %380, %c1_i64_169 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_170 = arith.constant -7 : i64
    %482 = openfhe.lwe_mul_const %478, %1, %c-7_i64_170 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %483 = openfhe.lwe_add %478, %479, %480 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %484 = openfhe.lwe_add %478, %483, %481 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %485 = openfhe.lwe_add %478, %484, %482 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %486 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %487 = openfhe.eval_func %arg0, %486, %485 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %488 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_171 = arith.constant 1 : i64
    %489 = openfhe.lwe_mul_const %488, %151, %c1_i64_171 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_172 = arith.constant 1 : i64
    %490 = openfhe.lwe_mul_const %488, %27, %c1_i64_172 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_173 = arith.constant 1 : i64
    %491 = openfhe.lwe_mul_const %488, %8, %c1_i64_173 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_174 = arith.constant -7 : i64
    %492 = openfhe.lwe_mul_const %488, %245, %c-7_i64_174 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %493 = openfhe.lwe_add %488, %489, %490 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %494 = openfhe.lwe_add %488, %493, %491 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %495 = openfhe.lwe_add %488, %494, %492 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %496 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %497 = openfhe.eval_func %arg0, %496, %495 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %498 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %499 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-1_i64_175 = arith.constant -1 : i64
    %500 = openfhe.lwe_mul_const %499, %151, %c-1_i64_175 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_176 = arith.constant -1 : i64
    %501 = openfhe.lwe_mul_const %499, %62, %c-1_i64_176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c5_i64 = arith.constant 5 : i64
    %502 = openfhe.lwe_mul_const %499, %498, %c5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_177 = arith.constant -5 : i64
    %503 = openfhe.lwe_mul_const %499, %1, %c-5_i64_177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %504 = openfhe.lwe_add %499, %500, %501 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %505 = openfhe.lwe_add %499, %504, %502 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %506 = openfhe.lwe_add %499, %505, %503 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %507 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 3, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %508 = openfhe.eval_func %arg0, %507, %506 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %509 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_178 = arith.constant 4 : i64
    %510 = openfhe.lwe_mul_const %509, %508, %c4_i64_178 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64_179 = arith.constant -4 : i64
    %511 = openfhe.lwe_mul_const %509, %497, %c-4_i64_179 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_180 = arith.constant 2 : i64
    %512 = openfhe.lwe_mul_const %509, %8, %c2_i64_180 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_181 = arith.constant 1 : i64
    %513 = openfhe.lwe_mul_const %509, %487, %c1_i64_181 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_182 = arith.constant -3 : i64
    %514 = openfhe.lwe_mul_const %509, %381, %c-3_i64_182 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %515 = openfhe.lwe_add %509, %510, %511 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %516 = openfhe.lwe_add %509, %515, %512 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %517 = openfhe.lwe_add %509, %516, %513 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %518 = openfhe.lwe_add %509, %517, %514 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %519 = openfhe.make_lut %arg0 {values = array<i32: 1, 4, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %520 = openfhe.eval_func %arg0, %519, %518 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %521 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_183 = arith.constant 2 : i64
    %522 = openfhe.lwe_mul_const %521, %359, %c2_i64_183 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_184 = arith.constant 2 : i64
    %523 = openfhe.lwe_mul_const %521, %353, %c2_i64_184 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_185 = arith.constant 1 : i64
    %524 = openfhe.lwe_mul_const %521, %69, %c1_i64_185 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_186 = arith.constant -7 : i64
    %525 = openfhe.lwe_mul_const %521, %62, %c-7_i64_186 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %526 = openfhe.lwe_add %521, %522, %523 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %527 = openfhe.lwe_add %521, %526, %524 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %528 = openfhe.lwe_add %521, %527, %525 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %529 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %530 = openfhe.eval_func %arg0, %529, %528 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %531 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %532 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_187 = arith.constant 3 : i64
    %533 = openfhe.lwe_mul_const %532, %531, %c3_i64_187 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_188 = arith.constant 3 : i64
    %534 = openfhe.lwe_mul_const %532, %0, %c3_i64_188 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_189 = arith.constant 1 : i64
    %535 = openfhe.lwe_mul_const %532, %69, %c1_i64_189 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_190 = arith.constant -7 : i64
    %536 = openfhe.lwe_mul_const %532, %144, %c-7_i64_190 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %537 = openfhe.lwe_add %532, %533, %534 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %538 = openfhe.lwe_add %532, %537, %535 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %539 = openfhe.lwe_add %532, %538, %536 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %540 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %541 = openfhe.eval_func %arg0, %540, %539 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %542 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_191 = arith.constant 4 : i64
    %543 = openfhe.lwe_mul_const %542, %498, %c4_i64_191 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_192 = arith.constant 2 : i64
    %544 = openfhe.lwe_mul_const %542, %245, %c2_i64_192 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_193 = arith.constant 1 : i64
    %545 = openfhe.lwe_mul_const %542, %20, %c1_i64_193 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %546 = openfhe.lwe_add %542, %543, %544 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %547 = openfhe.lwe_add %542, %546, %545 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %548 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %549 = openfhe.eval_func %arg0, %548, %547 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %550 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_194 = arith.constant 4 : i64
    %551 = openfhe.lwe_mul_const %550, %549, %c4_i64_194 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_195 = arith.constant 2 : i64
    %552 = openfhe.lwe_mul_const %550, %222, %c2_i64_195 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_196 = arith.constant 1 : i64
    %553 = openfhe.lwe_mul_const %550, %27, %c1_i64_196 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %554 = openfhe.lwe_add %550, %551, %552 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %555 = openfhe.lwe_add %550, %554, %553 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %556 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %557 = openfhe.eval_func %arg0, %556, %555 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %558 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_197 = arith.constant 4 : i64
    %559 = openfhe.lwe_mul_const %558, %379, %c4_i64_197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_198 = arith.constant 2 : i64
    %560 = openfhe.lwe_mul_const %558, %391, %c2_i64_198 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_199 = arith.constant 1 : i64
    %561 = openfhe.lwe_mul_const %558, %369, %c1_i64_199 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %562 = openfhe.lwe_add %558, %559, %560 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %563 = openfhe.lwe_add %558, %562, %561 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %564 = openfhe.make_lut %arg0 {values = array<i32: 0, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %565 = openfhe.eval_func %arg0, %564, %563 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %566 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_200 = arith.constant 4 : i64
    %567 = openfhe.lwe_mul_const %566, %565, %c4_i64_200 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_201 = arith.constant 2 : i64
    %568 = openfhe.lwe_mul_const %566, %427, %c2_i64_201 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_202 = arith.constant 1 : i64
    %569 = openfhe.lwe_mul_const %566, %417, %c1_i64_202 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %570 = openfhe.lwe_add %566, %567, %568 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %571 = openfhe.lwe_add %566, %570, %569 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %572 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %573 = openfhe.eval_func %arg0, %572, %571 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %574 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_203 = arith.constant 2 : i64
    %575 = openfhe.lwe_mul_const %574, %573, %c2_i64_203 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_204 = arith.constant 2 : i64
    %576 = openfhe.lwe_mul_const %574, %557, %c2_i64_204 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_205 = arith.constant 2 : i64
    %577 = openfhe.lwe_mul_const %574, %541, %c2_i64_205 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_206 = arith.constant -2 : i64
    %578 = openfhe.lwe_mul_const %574, %530, %c-2_i64_206 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_207 = arith.constant 1 : i64
    %579 = openfhe.lwe_mul_const %574, %380, %c1_i64_207 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_208 = arith.constant -3 : i64
    %580 = openfhe.lwe_mul_const %574, %9, %c-3_i64_208 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_209 = arith.constant -2 : i64
    %581 = openfhe.lwe_mul_const %574, %520, %c-2_i64_209 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %582 = openfhe.lwe_add %574, %575, %576 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %583 = openfhe.lwe_add %574, %582, %577 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %584 = openfhe.lwe_add %574, %583, %578 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %585 = openfhe.lwe_add %574, %584, %579 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %586 = openfhe.lwe_add %574, %585, %580 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %587 = openfhe.lwe_add %574, %586, %581 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %588 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %589 = openfhe.eval_func %arg0, %588, %587 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %590 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_210 = arith.constant 4 : i64
    %591 = openfhe.lwe_mul_const %590, %589, %c4_i64_210 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_211 = arith.constant 2 : i64
    %592 = openfhe.lwe_mul_const %590, %477, %c2_i64_211 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_212 = arith.constant 1 : i64
    %593 = openfhe.lwe_mul_const %590, %467, %c1_i64_212 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %594 = openfhe.lwe_add %590, %591, %592 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %595 = openfhe.lwe_add %590, %594, %593 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %596 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %597 = openfhe.eval_func %arg0, %596, %595 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %598 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-2_i64_213 = arith.constant -2 : i64
    %599 = openfhe.lwe_mul_const %598, %597, %c-2_i64_213 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_214 = arith.constant 1 : i64
    %600 = openfhe.lwe_mul_const %598, %449, %c1_i64_214 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c4_i64_215 = arith.constant 4 : i64
    %601 = openfhe.lwe_mul_const %598, %443, %c4_i64_215 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64_216 = arith.constant -4 : i64
    %602 = openfhe.lwe_mul_const %598, %437, %c-4_i64_216 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_217 = arith.constant -1 : i64
    %603 = openfhe.lwe_mul_const %598, %317, %c-1_i64_217 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %604 = openfhe.lwe_add %598, %599, %600 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %605 = openfhe.lwe_add %598, %604, %601 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %606 = openfhe.lwe_add %598, %605, %602 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %607 = openfhe.lwe_add %598, %606, %603 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %608 = openfhe.make_lut %arg0 {values = array<i32: 1, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %609 = openfhe.eval_func %arg0, %608, %607 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %610 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_218 = arith.constant 3 : i64
    %611 = openfhe.lwe_mul_const %610, %95, %c3_i64_218 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_219 = arith.constant 2 : i64
    %612 = openfhe.lwe_mul_const %610, %41, %c2_i64_219 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_220 = arith.constant 1 : i64
    %613 = openfhe.lwe_mul_const %610, %7, %c1_i64_220 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_221 = arith.constant -7 : i64
    %614 = openfhe.lwe_mul_const %610, %35, %c-7_i64_221 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %615 = openfhe.lwe_add %610, %611, %612 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %616 = openfhe.lwe_add %610, %615, %613 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %617 = openfhe.lwe_add %610, %616, %614 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %618 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %619 = openfhe.eval_func %arg0, %618, %617 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %7, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %19, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %49, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %619, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %181, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %307, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %459, %alloc[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %609, %alloc[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    return %alloc : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
  }
}

