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
    %34 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_7 = arith.constant 4 : i64
    %35 = openfhe.lwe_mul_const %34, %24, %c4_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_8 = arith.constant 2 : i64
    %36 = openfhe.lwe_mul_const %34, %25, %c2_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_9 = arith.constant 1 : i64
    %37 = openfhe.lwe_mul_const %34, %23, %c1_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %38 = openfhe.lwe_add %34, %35, %36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %39 = openfhe.lwe_add %34, %38, %37 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %40 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %41 = openfhe.eval_func %arg0, %40, %39 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %42 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %43 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %44 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_10 = arith.constant 4 : i64
    %45 = openfhe.lwe_mul_const %44, %42, %c4_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_11 = arith.constant 2 : i64
    %46 = openfhe.lwe_mul_const %44, %43, %c2_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_12 = arith.constant 1 : i64
    %47 = openfhe.lwe_mul_const %44, %41, %c1_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %48 = openfhe.lwe_add %44, %45, %46 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %49 = openfhe.lwe_add %44, %48, %47 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %50 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %51 = openfhe.eval_func %arg0, %50, %49 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %52 = memref.load %arg2[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %53 = memref.load %arg1[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %54 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_13 = arith.constant 2 : i64
    %55 = openfhe.lwe_mul_const %54, %52, %c2_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64 = arith.constant -2 : i64
    %56 = openfhe.lwe_mul_const %54, %53, %c-2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_14 = arith.constant 1 : i64
    %57 = openfhe.lwe_mul_const %54, %42, %c1_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_15 = arith.constant 1 : i64
    %58 = openfhe.lwe_mul_const %54, %43, %c1_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64 = arith.constant -5 : i64
    %59 = openfhe.lwe_mul_const %54, %41, %c-5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %60 = openfhe.lwe_add %54, %55, %56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %61 = openfhe.lwe_add %54, %60, %57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %62 = openfhe.lwe_add %54, %61, %58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %63 = openfhe.lwe_add %54, %62, %59 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %64 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %65 = openfhe.eval_func %arg0, %64, %63 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %66 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-2_i64_16 = arith.constant -2 : i64
    %67 = openfhe.lwe_mul_const %66, %52, %c-2_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_17 = arith.constant -2 : i64
    %68 = openfhe.lwe_mul_const %66, %53, %c-2_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64 = arith.constant 3 : i64
    %69 = openfhe.lwe_mul_const %66, %42, %c3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_18 = arith.constant 3 : i64
    %70 = openfhe.lwe_mul_const %66, %43, %c3_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64 = arith.constant -3 : i64
    %71 = openfhe.lwe_mul_const %66, %41, %c-3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %72 = openfhe.lwe_add %66, %67, %68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %73 = openfhe.lwe_add %66, %72, %69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %74 = openfhe.lwe_add %66, %73, %70 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %75 = openfhe.lwe_add %66, %74, %71 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %76 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %77 = openfhe.eval_func %arg0, %76, %75 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %78 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %79 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %80 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_19 = arith.constant 4 : i64
    %81 = openfhe.lwe_mul_const %80, %78, %c4_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_20 = arith.constant 2 : i64
    %82 = openfhe.lwe_mul_const %80, %79, %c2_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_21 = arith.constant 1 : i64
    %83 = openfhe.lwe_mul_const %80, %77, %c1_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %84 = openfhe.lwe_add %80, %81, %82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %85 = openfhe.lwe_add %80, %84, %83 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %86 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %87 = openfhe.eval_func %arg0, %86, %85 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %88 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_22 = arith.constant 4 : i64
    %89 = openfhe.lwe_mul_const %88, %78, %c4_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_23 = arith.constant 2 : i64
    %90 = openfhe.lwe_mul_const %88, %79, %c2_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_24 = arith.constant 1 : i64
    %91 = openfhe.lwe_mul_const %88, %77, %c1_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %92 = openfhe.lwe_add %88, %89, %90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %93 = openfhe.lwe_add %88, %92, %91 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %94 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %95 = openfhe.eval_func %arg0, %94, %93 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %96 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %97 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %98 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_25 = arith.constant 4 : i64
    %99 = openfhe.lwe_mul_const %98, %96, %c4_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_26 = arith.constant 2 : i64
    %100 = openfhe.lwe_mul_const %98, %97, %c2_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_27 = arith.constant 1 : i64
    %101 = openfhe.lwe_mul_const %98, %95, %c1_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %102 = openfhe.lwe_add %98, %99, %100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %103 = openfhe.lwe_add %98, %102, %101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %104 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %105 = openfhe.eval_func %arg0, %104, %103 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %106 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %107 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %108 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_28 = arith.constant 2 : i64
    %109 = openfhe.lwe_mul_const %108, %106, %c2_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_29 = arith.constant -2 : i64
    %110 = openfhe.lwe_mul_const %108, %107, %c-2_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_30 = arith.constant 1 : i64
    %111 = openfhe.lwe_mul_const %108, %96, %c1_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_31 = arith.constant 1 : i64
    %112 = openfhe.lwe_mul_const %108, %97, %c1_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_32 = arith.constant -5 : i64
    %113 = openfhe.lwe_mul_const %108, %95, %c-5_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %114 = openfhe.lwe_add %108, %109, %110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %115 = openfhe.lwe_add %108, %114, %111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %116 = openfhe.lwe_add %108, %115, %112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %117 = openfhe.lwe_add %108, %116, %113 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %118 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %119 = openfhe.eval_func %arg0, %118, %117 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %120 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_33 = arith.constant 2 : i64
    %121 = openfhe.lwe_mul_const %120, %0, %c2_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_34 = arith.constant 1 : i64
    %122 = openfhe.lwe_mul_const %120, %1, %c1_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %123 = openfhe.lwe_add %120, %121, %122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %124 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %125 = openfhe.eval_func %arg0, %124, %123 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %125, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %13, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %33, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %51, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %65, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %87, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
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
    %21 = memref.load %arg1[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %22 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_2 = arith.constant 3 : i64
    %23 = openfhe.lwe_mul_const %22, %20, %c3_i64_2 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_3 = arith.constant 3 : i64
    %24 = openfhe.lwe_mul_const %22, %1, %c3_i64_3 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_4 = arith.constant 1 : i64
    %25 = openfhe.lwe_mul_const %22, %0, %c1_i64_4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_5 = arith.constant -7 : i64
    %26 = openfhe.lwe_mul_const %22, %21, %c-7_i64_5 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %27 = openfhe.lwe_add %22, %23, %24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %28 = openfhe.lwe_add %22, %27, %25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %29 = openfhe.lwe_add %22, %28, %26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %30 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %31 = openfhe.eval_func %arg0, %30, %29 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %32 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64 = arith.constant 4 : i64
    %33 = openfhe.lwe_mul_const %32, %31, %c4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_6 = arith.constant 3 : i64
    %34 = openfhe.lwe_mul_const %32, %8, %c3_i64_6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64 = arith.constant -2 : i64
    %35 = openfhe.lwe_mul_const %32, %9, %c-2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64 = arith.constant -3 : i64
    %36 = openfhe.lwe_mul_const %32, %7, %c-3_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %37 = openfhe.lwe_add %32, %33, %34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %38 = openfhe.lwe_add %32, %37, %35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %39 = openfhe.lwe_add %32, %38, %36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %40 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %41 = openfhe.eval_func %arg0, %40, %39 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %42 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_7 = arith.constant 2 : i64
    %43 = openfhe.lwe_mul_const %42, %21, %c2_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_8 = arith.constant 1 : i64
    %44 = openfhe.lwe_mul_const %42, %20, %c1_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %45 = openfhe.lwe_add %42, %43, %44 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %46 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %47 = openfhe.eval_func %arg0, %46, %45 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %48 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_9 = arith.constant 2 : i64
    %49 = openfhe.lwe_mul_const %48, %47, %c2_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_10 = arith.constant 1 : i64
    %50 = openfhe.lwe_mul_const %48, %7, %c1_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %51 = openfhe.lwe_add %48, %49, %50 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %52 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %53 = openfhe.eval_func %arg0, %52, %51 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %54 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %55 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %56 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_11 = arith.constant 2 : i64
    %57 = openfhe.lwe_mul_const %56, %55, %c2_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_12 = arith.constant 1 : i64
    %58 = openfhe.lwe_mul_const %56, %1, %c1_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %59 = openfhe.lwe_add %56, %57, %58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %60 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %61 = openfhe.eval_func %arg0, %60, %59 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %62 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_13 = arith.constant 2 : i64
    %63 = openfhe.lwe_mul_const %62, %9, %c2_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_14 = arith.constant 1 : i64
    %64 = openfhe.lwe_mul_const %62, %20, %c1_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %65 = openfhe.lwe_add %62, %63, %64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %66 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %67 = openfhe.eval_func %arg0, %66, %65 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %68 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_15 = arith.constant 2 : i64
    %69 = openfhe.lwe_mul_const %68, %67, %c2_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_16 = arith.constant 2 : i64
    %70 = openfhe.lwe_mul_const %68, %61, %c2_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_17 = arith.constant 1 : i64
    %71 = openfhe.lwe_mul_const %68, %0, %c1_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_18 = arith.constant -7 : i64
    %72 = openfhe.lwe_mul_const %68, %54, %c-7_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %73 = openfhe.lwe_add %68, %69, %70 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %74 = openfhe.lwe_add %68, %73, %71 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %75 = openfhe.lwe_add %68, %74, %72 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %76 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %77 = openfhe.eval_func %arg0, %76, %75 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %78 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_19 = arith.constant 3 : i64
    %79 = openfhe.lwe_mul_const %78, %8, %c3_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64 = arith.constant -1 : i64
    %80 = openfhe.lwe_mul_const %78, %21, %c-1_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_20 = arith.constant 2 : i64
    %81 = openfhe.lwe_mul_const %78, %77, %c2_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64 = arith.constant -6 : i64
    %82 = openfhe.lwe_mul_const %78, %53, %c-6_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %83 = openfhe.lwe_add %78, %79, %80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %84 = openfhe.lwe_add %78, %83, %81 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %85 = openfhe.lwe_add %78, %84, %82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %86 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %87 = openfhe.eval_func %arg0, %86, %85 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %88 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_21 = arith.constant 3 : i64
    %89 = openfhe.lwe_mul_const %88, %87, %c3_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_22 = arith.constant 3 : i64
    %90 = openfhe.lwe_mul_const %88, %8, %c3_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_23 = arith.constant -2 : i64
    %91 = openfhe.lwe_mul_const %88, %9, %c-2_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_24 = arith.constant -2 : i64
    %92 = openfhe.lwe_mul_const %88, %7, %c-2_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_25 = arith.constant -3 : i64
    %93 = openfhe.lwe_mul_const %88, %31, %c-3_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %94 = openfhe.lwe_add %88, %89, %90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %95 = openfhe.lwe_add %88, %94, %91 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %96 = openfhe.lwe_add %88, %95, %92 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %97 = openfhe.lwe_add %88, %96, %93 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %98 = openfhe.make_lut %arg0 {values = array<i32: 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %99 = openfhe.eval_func %arg0, %98, %97 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %100 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_26 = arith.constant 1 : i64
    %101 = openfhe.lwe_mul_const %100, %8, %c1_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_27 = arith.constant 1 : i64
    %102 = openfhe.lwe_mul_const %100, %9, %c1_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_28 = arith.constant -7 : i64
    %103 = openfhe.lwe_mul_const %100, %31, %c-7_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %104 = openfhe.lwe_add %100, %101, %102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %105 = openfhe.lwe_add %100, %104, %103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %106 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %107 = openfhe.eval_func %arg0, %106, %105 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %108 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_29 = arith.constant 1 : i64
    %109 = openfhe.lwe_mul_const %108, %8, %c1_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_30 = arith.constant 1 : i64
    %110 = openfhe.lwe_mul_const %108, %21, %c1_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_31 = arith.constant 2 : i64
    %111 = openfhe.lwe_mul_const %108, %77, %c2_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_32 = arith.constant -6 : i64
    %112 = openfhe.lwe_mul_const %108, %53, %c-6_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %113 = openfhe.lwe_add %108, %109, %110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %114 = openfhe.lwe_add %108, %113, %111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %115 = openfhe.lwe_add %108, %114, %112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %116 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %117 = openfhe.eval_func %arg0, %116, %115 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %118 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_33 = arith.constant 2 : i64
    %119 = openfhe.lwe_mul_const %118, %0, %c2_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_34 = arith.constant 2 : i64
    %120 = openfhe.lwe_mul_const %118, %54, %c2_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_35 = arith.constant 1 : i64
    %121 = openfhe.lwe_mul_const %118, %67, %c1_i64_35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_36 = arith.constant -7 : i64
    %122 = openfhe.lwe_mul_const %118, %61, %c-7_i64_36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %123 = openfhe.lwe_add %118, %119, %120 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %124 = openfhe.lwe_add %118, %123, %121 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %125 = openfhe.lwe_add %118, %124, %122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %126 = openfhe.make_lut %arg0 {values = array<i32: 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %127 = openfhe.eval_func %arg0, %126, %125 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %128 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_37 = arith.constant 2 : i64
    %129 = openfhe.lwe_mul_const %128, %55, %c2_i64_37 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_38 = arith.constant 1 : i64
    %130 = openfhe.lwe_mul_const %128, %9, %c1_i64_38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %131 = openfhe.lwe_add %128, %129, %130 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %132 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %133 = openfhe.eval_func %arg0, %132, %131 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %134 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_39 = arith.constant 4 : i64
    %135 = openfhe.lwe_mul_const %134, %47, %c4_i64_39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_40 = arith.constant -1 : i64
    %136 = openfhe.lwe_mul_const %134, %133, %c-1_i64_40 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_41 = arith.constant 3 : i64
    %137 = openfhe.lwe_mul_const %134, %20, %c3_i64_41 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64 = arith.constant -5 : i64
    %138 = openfhe.lwe_mul_const %134, %1, %c-5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
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
    %154 = openfhe.lwe_mul_const %152, %54, %c3_i64_45 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
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
    %166 = openfhe.lwe_mul_const %162, %127, %c1_i64_51 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_52 = arith.constant -7 : i64
    %167 = openfhe.lwe_mul_const %162, %117, %c-7_i64_52 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %168 = openfhe.lwe_add %162, %163, %164 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %169 = openfhe.lwe_add %162, %168, %165 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %170 = openfhe.lwe_add %162, %169, %166 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %171 = openfhe.lwe_add %162, %170, %167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %172 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %173 = openfhe.eval_func %arg0, %172, %171 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %174 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_53 = arith.constant 2 : i64
    %175 = openfhe.lwe_mul_const %174, %173, %c2_i64_53 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_54 = arith.constant 3 : i64
    %176 = openfhe.lwe_mul_const %174, %107, %c3_i64_54 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_55 = arith.constant -1 : i64
    %177 = openfhe.lwe_mul_const %174, %87, %c-1_i64_55 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_56 = arith.constant -6 : i64
    %178 = openfhe.lwe_mul_const %174, %99, %c-6_i64_56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %179 = openfhe.lwe_add %174, %175, %176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %180 = openfhe.lwe_add %174, %179, %177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %181 = openfhe.lwe_add %174, %180, %178 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %182 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %183 = openfhe.eval_func %arg0, %182, %181 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %184 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_57 = arith.constant 2 : i64
    %185 = openfhe.lwe_mul_const %184, %173, %c2_i64_57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_58 = arith.constant 1 : i64
    %186 = openfhe.lwe_mul_const %184, %107, %c1_i64_58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_59 = arith.constant 1 : i64
    %187 = openfhe.lwe_mul_const %184, %87, %c1_i64_59 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_60 = arith.constant -6 : i64
    %188 = openfhe.lwe_mul_const %184, %99, %c-6_i64_60 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %189 = openfhe.lwe_add %184, %185, %186 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %190 = openfhe.lwe_add %184, %189, %187 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %191 = openfhe.lwe_add %184, %190, %188 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %192 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %193 = openfhe.eval_func %arg0, %192, %191 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %194 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_61 = arith.constant 4 : i64
    %195 = openfhe.lwe_mul_const %194, %150, %c4_i64_61 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64 = arith.constant -4 : i64
    %196 = openfhe.lwe_mul_const %194, %143, %c-4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_62 = arith.constant 2 : i64
    %197 = openfhe.lwe_mul_const %194, %127, %c2_i64_62 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_63 = arith.constant -3 : i64
    %198 = openfhe.lwe_mul_const %194, %161, %c-3_i64_63 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %199 = openfhe.lwe_add %194, %195, %196 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %200 = openfhe.lwe_add %194, %199, %197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %201 = openfhe.lwe_add %194, %200, %198 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %202 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %203 = openfhe.eval_func %arg0, %202, %201 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %204 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_64 = arith.constant 2 : i64
    %205 = openfhe.lwe_mul_const %204, %143, %c2_i64_64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_65 = arith.constant -3 : i64
    %206 = openfhe.lwe_mul_const %204, %150, %c-3_i64_65 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c4_i64_66 = arith.constant 4 : i64
    %207 = openfhe.lwe_mul_const %204, %133, %c4_i64_66 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64_67 = arith.constant -4 : i64
    %208 = openfhe.lwe_mul_const %204, %47, %c-4_i64_67 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %209 = openfhe.lwe_add %204, %205, %206 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %210 = openfhe.lwe_add %204, %209, %207 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %211 = openfhe.lwe_add %204, %210, %208 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %212 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %213 = openfhe.eval_func %arg0, %212, %211 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %214 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_68 = arith.constant 2 : i64
    %215 = openfhe.lwe_mul_const %214, %54, %c2_i64_68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_69 = arith.constant 1 : i64
    %216 = openfhe.lwe_mul_const %214, %20, %c1_i64_69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %217 = openfhe.lwe_add %214, %215, %216 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %218 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %219 = openfhe.eval_func %arg0, %218, %217 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %220 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %221 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_70 = arith.constant 2 : i64
    %222 = openfhe.lwe_mul_const %221, %220, %c2_i64_70 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_71 = arith.constant 2 : i64
    %223 = openfhe.lwe_mul_const %221, %1, %c2_i64_71 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_72 = arith.constant -7 : i64
    %224 = openfhe.lwe_mul_const %221, %219, %c-7_i64_72 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %225 = openfhe.lwe_add %221, %222, %223 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %226 = openfhe.lwe_add %221, %225, %224 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %227 = openfhe.make_lut %arg0 {values = array<i32: 1, 3, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %228 = openfhe.eval_func %arg0, %227, %226 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %229 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_73 = arith.constant 2 : i64
    %230 = openfhe.lwe_mul_const %229, %55, %c2_i64_73 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_74 = arith.constant 1 : i64
    %231 = openfhe.lwe_mul_const %229, %21, %c1_i64_74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %232 = openfhe.lwe_add %229, %230, %231 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %233 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %234 = openfhe.eval_func %arg0, %233, %232 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %235 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_75 = arith.constant 2 : i64
    %236 = openfhe.lwe_mul_const %235, %234, %c2_i64_75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_76 = arith.constant 1 : i64
    %237 = openfhe.lwe_mul_const %235, %67, %c1_i64_76 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %238 = openfhe.lwe_add %235, %236, %237 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %239 = openfhe.make_lut %arg0 {values = array<i32: 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %240 = openfhe.eval_func %arg0, %239, %238 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %241 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %242 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_77 = arith.constant 3 : i64
    %243 = openfhe.lwe_mul_const %242, %0, %c3_i64_77 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_78 = arith.constant -1 : i64
    %244 = openfhe.lwe_mul_const %242, %241, %c-1_i64_78 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_79 = arith.constant 2 : i64
    %245 = openfhe.lwe_mul_const %242, %240, %c2_i64_79 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_80 = arith.constant -6 : i64
    %246 = openfhe.lwe_mul_const %242, %228, %c-6_i64_80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %247 = openfhe.lwe_add %242, %243, %244 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %248 = openfhe.lwe_add %242, %247, %245 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %249 = openfhe.lwe_add %242, %248, %246 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %250 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %251 = openfhe.eval_func %arg0, %250, %249 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %252 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_81 = arith.constant 3 : i64
    %253 = openfhe.lwe_mul_const %252, %8, %c3_i64_81 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_82 = arith.constant 3 : i64
    %254 = openfhe.lwe_mul_const %252, %144, %c3_i64_82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_83 = arith.constant 1 : i64
    %255 = openfhe.lwe_mul_const %252, %151, %c1_i64_83 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_84 = arith.constant -7 : i64
    %256 = openfhe.lwe_mul_const %252, %9, %c-7_i64_84 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %257 = openfhe.lwe_add %252, %253, %254 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %258 = openfhe.lwe_add %252, %257, %255 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %259 = openfhe.lwe_add %252, %258, %256 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %260 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %261 = openfhe.eval_func %arg0, %260, %259 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %262 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_85 = arith.constant 4 : i64
    %263 = openfhe.lwe_mul_const %262, %261, %c4_i64_85 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_86 = arith.constant 1 : i64
    %264 = openfhe.lwe_mul_const %262, %151, %c1_i64_86 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_87 = arith.constant 1 : i64
    %265 = openfhe.lwe_mul_const %262, %54, %c1_i64_87 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_88 = arith.constant 1 : i64
    %266 = openfhe.lwe_mul_const %262, %8, %c1_i64_88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_89 = arith.constant -7 : i64
    %267 = openfhe.lwe_mul_const %262, %1, %c-7_i64_89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %268 = openfhe.lwe_add %262, %263, %264 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %269 = openfhe.lwe_add %262, %268, %265 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %270 = openfhe.lwe_add %262, %269, %266 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %271 = openfhe.lwe_add %262, %270, %267 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %272 = openfhe.make_lut %arg0 {values = array<i32: 4, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %273 = openfhe.eval_func %arg0, %272, %271 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %274 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_90 = arith.constant 4 : i64
    %275 = openfhe.lwe_mul_const %274, %273, %c4_i64_90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_91 = arith.constant 2 : i64
    %276 = openfhe.lwe_mul_const %274, %251, %c2_i64_91 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_92 = arith.constant 1 : i64
    %277 = openfhe.lwe_mul_const %274, %213, %c1_i64_92 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %278 = openfhe.lwe_add %274, %275, %276 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %279 = openfhe.lwe_add %274, %278, %277 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %280 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %281 = openfhe.eval_func %arg0, %280, %279 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %282 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_93 = arith.constant 2 : i64
    %283 = openfhe.lwe_mul_const %282, %161, %c2_i64_93 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_94 = arith.constant 2 : i64
    %284 = openfhe.lwe_mul_const %282, %150, %c2_i64_94 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_95 = arith.constant 2 : i64
    %285 = openfhe.lwe_mul_const %282, %143, %c2_i64_95 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-2_i64_96 = arith.constant -2 : i64
    %286 = openfhe.lwe_mul_const %282, %127, %c-2_i64_96 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_97 = arith.constant -5 : i64
    %287 = openfhe.lwe_mul_const %282, %117, %c-5_i64_97 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %288 = openfhe.lwe_add %282, %283, %284 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %289 = openfhe.lwe_add %282, %288, %285 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %290 = openfhe.lwe_add %282, %289, %286 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %291 = openfhe.lwe_add %282, %290, %287 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %292 = openfhe.make_lut %arg0 {values = array<i32: 2, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %293 = openfhe.eval_func %arg0, %292, %291 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %294 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_98 = arith.constant 1 : i64
    %295 = openfhe.lwe_mul_const %294, %293, %c1_i64_98 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_99 = arith.constant 1 : i64
    %296 = openfhe.lwe_mul_const %294, %281, %c1_i64_99 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_100 = arith.constant 1 : i64
    %297 = openfhe.lwe_mul_const %294, %203, %c1_i64_100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_101 = arith.constant -7 : i64
    %298 = openfhe.lwe_mul_const %294, %193, %c-7_i64_101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %299 = openfhe.lwe_add %294, %295, %296 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %300 = openfhe.lwe_add %294, %299, %297 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %301 = openfhe.lwe_add %294, %300, %298 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %302 = openfhe.make_lut %arg0 {values = array<i32: 1, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %303 = openfhe.eval_func %arg0, %302, %301 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %304 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_102 = arith.constant 4 : i64
    %305 = openfhe.lwe_mul_const %304, %273, %c4_i64_102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_103 = arith.constant 2 : i64
    %306 = openfhe.lwe_mul_const %304, %251, %c2_i64_103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_104 = arith.constant 1 : i64
    %307 = openfhe.lwe_mul_const %304, %213, %c1_i64_104 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %308 = openfhe.lwe_add %304, %305, %306 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %309 = openfhe.lwe_add %304, %308, %307 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %310 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %311 = openfhe.eval_func %arg0, %310, %309 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %312 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_105 = arith.constant 2 : i64
    %313 = openfhe.lwe_mul_const %312, %0, %c2_i64_105 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_106 = arith.constant 2 : i64
    %314 = openfhe.lwe_mul_const %312, %241, %c2_i64_106 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_107 = arith.constant 1 : i64
    %315 = openfhe.lwe_mul_const %312, %240, %c1_i64_107 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_108 = arith.constant -7 : i64
    %316 = openfhe.lwe_mul_const %312, %228, %c-7_i64_108 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %317 = openfhe.lwe_add %312, %313, %314 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %318 = openfhe.lwe_add %312, %317, %315 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %319 = openfhe.lwe_add %312, %318, %316 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %320 = openfhe.make_lut %arg0 {values = array<i32: 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %321 = openfhe.eval_func %arg0, %320, %319 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %322 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_109 = arith.constant 2 : i64
    %323 = openfhe.lwe_mul_const %322, %55, %c2_i64_109 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_110 = arith.constant 1 : i64
    %324 = openfhe.lwe_mul_const %322, %54, %c1_i64_110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %325 = openfhe.lwe_add %322, %323, %324 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %326 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %327 = openfhe.eval_func %arg0, %326, %325 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %328 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_111 = arith.constant 2 : i64
    %329 = openfhe.lwe_mul_const %328, %220, %c2_i64_111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_112 = arith.constant 1 : i64
    %330 = openfhe.lwe_mul_const %328, %9, %c1_i64_112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %331 = openfhe.lwe_add %328, %329, %330 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %332 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %333 = openfhe.eval_func %arg0, %332, %331 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %334 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_113 = arith.constant 2 : i64
    %335 = openfhe.lwe_mul_const %334, %333, %c2_i64_113 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_114 = arith.constant 3 : i64
    %336 = openfhe.lwe_mul_const %334, %144, %c3_i64_114 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_115 = arith.constant -1 : i64
    %337 = openfhe.lwe_mul_const %334, %20, %c-1_i64_115 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_116 = arith.constant -6 : i64
    %338 = openfhe.lwe_mul_const %334, %327, %c-6_i64_116 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %339 = openfhe.lwe_add %334, %335, %336 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %340 = openfhe.lwe_add %334, %339, %337 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %341 = openfhe.lwe_add %334, %340, %338 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %342 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %343 = openfhe.eval_func %arg0, %342, %341 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %344 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_117 = arith.constant 1 : i64
    %345 = openfhe.lwe_mul_const %344, %220, %c1_i64_117 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_118 = arith.constant 1 : i64
    %346 = openfhe.lwe_mul_const %344, %1, %c1_i64_118 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_119 = arith.constant 2 : i64
    %347 = openfhe.lwe_mul_const %344, %219, %c2_i64_119 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_120 = arith.constant -6 : i64
    %348 = openfhe.lwe_mul_const %344, %234, %c-6_i64_120 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %349 = openfhe.lwe_add %344, %345, %346 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %350 = openfhe.lwe_add %344, %349, %347 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %351 = openfhe.lwe_add %344, %350, %348 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %352 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %353 = openfhe.eval_func %arg0, %352, %351 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %354 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %355 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %356 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_121 = arith.constant 3 : i64
    %357 = openfhe.lwe_mul_const %356, %354, %c3_i64_121 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_122 = arith.constant 3 : i64
    %358 = openfhe.lwe_mul_const %356, %1, %c3_i64_122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_123 = arith.constant 1 : i64
    %359 = openfhe.lwe_mul_const %356, %0, %c1_i64_123 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_124 = arith.constant -7 : i64
    %360 = openfhe.lwe_mul_const %356, %355, %c-7_i64_124 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %361 = openfhe.lwe_add %356, %357, %358 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %362 = openfhe.lwe_add %356, %361, %359 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %363 = openfhe.lwe_add %356, %362, %360 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %364 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %365 = openfhe.eval_func %arg0, %364, %363 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %366 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_125 = arith.constant 4 : i64
    %367 = openfhe.lwe_mul_const %366, %365, %c4_i64_125 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_126 = arith.constant 2 : i64
    %368 = openfhe.lwe_mul_const %366, %353, %c2_i64_126 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_127 = arith.constant 1 : i64
    %369 = openfhe.lwe_mul_const %366, %343, %c1_i64_127 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %370 = openfhe.lwe_add %366, %367, %368 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %371 = openfhe.lwe_add %366, %370, %369 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %372 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %373 = openfhe.eval_func %arg0, %372, %371 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %374 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_128 = arith.constant 4 : i64
    %375 = openfhe.lwe_mul_const %374, %373, %c4_i64_128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_129 = arith.constant 1 : i64
    %376 = openfhe.lwe_mul_const %374, %133, %c1_i64_129 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_130 = arith.constant 1 : i64
    %377 = openfhe.lwe_mul_const %374, %47, %c1_i64_130 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_131 = arith.constant -1 : i64
    %378 = openfhe.lwe_mul_const %374, %228, %c-1_i64_131 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_132 = arith.constant -5 : i64
    %379 = openfhe.lwe_mul_const %374, %321, %c-5_i64_132 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %380 = openfhe.lwe_add %374, %375, %376 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %381 = openfhe.lwe_add %374, %380, %377 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %382 = openfhe.lwe_add %374, %381, %378 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %383 = openfhe.lwe_add %374, %382, %379 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %384 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %385 = openfhe.eval_func %arg0, %384, %383 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %386 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_133 = arith.constant 1 : i64
    %387 = openfhe.lwe_mul_const %386, %151, %c1_i64_133 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_134 = arith.constant 1 : i64
    %388 = openfhe.lwe_mul_const %386, %9, %c1_i64_134 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_135 = arith.constant 1 : i64
    %389 = openfhe.lwe_mul_const %386, %8, %c1_i64_135 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_136 = arith.constant -7 : i64
    %390 = openfhe.lwe_mul_const %386, %144, %c-7_i64_136 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %391 = openfhe.lwe_add %386, %387, %388 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %392 = openfhe.lwe_add %386, %391, %389 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %393 = openfhe.lwe_add %386, %392, %390 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %394 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %395 = openfhe.eval_func %arg0, %394, %393 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %396 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_137 = arith.constant 3 : i64
    %397 = openfhe.lwe_mul_const %396, %8, %c3_i64_137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_138 = arith.constant 3 : i64
    %398 = openfhe.lwe_mul_const %396, %241, %c3_i64_138 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_139 = arith.constant 1 : i64
    %399 = openfhe.lwe_mul_const %396, %151, %c1_i64_139 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_140 = arith.constant -7 : i64
    %400 = openfhe.lwe_mul_const %396, %21, %c-7_i64_140 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %401 = openfhe.lwe_add %396, %397, %398 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %402 = openfhe.lwe_add %396, %401, %399 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %403 = openfhe.lwe_add %396, %402, %400 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %404 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %405 = openfhe.eval_func %arg0, %404, %403 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %406 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_141 = arith.constant 1 : i64
    %407 = openfhe.lwe_mul_const %406, %405, %c1_i64_141 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_142 = arith.constant 1 : i64
    %408 = openfhe.lwe_mul_const %406, %395, %c1_i64_142 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_143 = arith.constant 1 : i64
    %409 = openfhe.lwe_mul_const %406, %385, %c1_i64_143 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_144 = arith.constant -7 : i64
    %410 = openfhe.lwe_mul_const %406, %311, %c-7_i64_144 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %411 = openfhe.lwe_add %406, %407, %408 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %412 = openfhe.lwe_add %406, %411, %409 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %413 = openfhe.lwe_add %406, %412, %410 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %414 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %415 = openfhe.eval_func %arg0, %414, %413 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %416 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_145 = arith.constant 1 : i64
    %417 = openfhe.lwe_mul_const %416, %261, %c1_i64_145 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_146 = arith.constant 1 : i64
    %418 = openfhe.lwe_mul_const %416, %151, %c1_i64_146 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_147 = arith.constant 1 : i64
    %419 = openfhe.lwe_mul_const %416, %54, %c1_i64_147 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_148 = arith.constant 1 : i64
    %420 = openfhe.lwe_mul_const %416, %8, %c1_i64_148 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_149 = arith.constant -7 : i64
    %421 = openfhe.lwe_mul_const %416, %1, %c-7_i64_149 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %422 = openfhe.lwe_add %416, %417, %418 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %423 = openfhe.lwe_add %416, %422, %419 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %424 = openfhe.lwe_add %416, %423, %420 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %425 = openfhe.lwe_add %416, %424, %421 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %426 = openfhe.make_lut %arg0 {values = array<i32: 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %427 = openfhe.eval_func %arg0, %426, %425 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %428 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_150 = arith.constant 2 : i64
    %429 = openfhe.lwe_mul_const %428, %427, %c2_i64_150 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_151 = arith.constant 1 : i64
    %430 = openfhe.lwe_mul_const %428, %415, %c1_i64_151 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %431 = openfhe.lwe_add %428, %429, %430 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %432 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %433 = openfhe.eval_func %arg0, %432, %431 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %434 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_152 = arith.constant 1 : i64
    %435 = openfhe.lwe_mul_const %434, %281, %c1_i64_152 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_153 = arith.constant -1 : i64
    %436 = openfhe.lwe_mul_const %434, %203, %c-1_i64_153 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_154 = arith.constant 2 : i64
    %437 = openfhe.lwe_mul_const %434, %433, %c2_i64_154 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_155 = arith.constant 1 : i64
    %438 = openfhe.lwe_mul_const %434, %293, %c1_i64_155 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_156 = arith.constant -5 : i64
    %439 = openfhe.lwe_mul_const %434, %193, %c-5_i64_156 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %440 = openfhe.lwe_add %434, %435, %436 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %441 = openfhe.lwe_add %434, %440, %437 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %442 = openfhe.lwe_add %434, %441, %438 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %443 = openfhe.lwe_add %434, %442, %439 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %444 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %445 = openfhe.eval_func %arg0, %444, %443 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %446 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_157 = arith.constant 4 : i64
    %447 = openfhe.lwe_mul_const %446, %415, %c4_i64_157 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_158 = arith.constant 2 : i64
    %448 = openfhe.lwe_mul_const %446, %311, %c2_i64_158 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_159 = arith.constant 1 : i64
    %449 = openfhe.lwe_mul_const %446, %427, %c1_i64_159 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %450 = openfhe.lwe_add %446, %447, %448 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %451 = openfhe.lwe_add %446, %450, %449 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %452 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 4, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %453 = openfhe.eval_func %arg0, %452, %451 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %454 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_160 = arith.constant 2 : i64
    %455 = openfhe.lwe_mul_const %454, %385, %c2_i64_160 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c4_i64_161 = arith.constant 4 : i64
    %456 = openfhe.lwe_mul_const %454, %405, %c4_i64_161 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-4_i64_162 = arith.constant -4 : i64
    %457 = openfhe.lwe_mul_const %454, %395, %c-4_i64_162 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-3_i64_163 = arith.constant -3 : i64
    %458 = openfhe.lwe_mul_const %454, %373, %c-3_i64_163 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %459 = openfhe.lwe_add %454, %455, %456 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %460 = openfhe.lwe_add %454, %459, %457 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %461 = openfhe.lwe_add %454, %460, %458 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %462 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %463 = openfhe.eval_func %arg0, %462, %461 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %464 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_164 = arith.constant 1 : i64
    %465 = openfhe.lwe_mul_const %464, %0, %c1_i64_164 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_165 = arith.constant 1 : i64
    %466 = openfhe.lwe_mul_const %464, %355, %c1_i64_165 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_166 = arith.constant 1 : i64
    %467 = openfhe.lwe_mul_const %464, %354, %c1_i64_166 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_167 = arith.constant -7 : i64
    %468 = openfhe.lwe_mul_const %464, %1, %c-7_i64_167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %469 = openfhe.lwe_add %464, %465, %466 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %470 = openfhe.lwe_add %464, %469, %467 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %471 = openfhe.lwe_add %464, %470, %468 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %472 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %473 = openfhe.eval_func %arg0, %472, %471 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %474 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_168 = arith.constant 4 : i64
    %475 = openfhe.lwe_mul_const %474, %8, %c4_i64_168 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_169 = arith.constant 2 : i64
    %476 = openfhe.lwe_mul_const %474, %473, %c2_i64_169 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_170 = arith.constant 1 : i64
    %477 = openfhe.lwe_mul_const %474, %355, %c1_i64_170 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %478 = openfhe.lwe_add %474, %475, %476 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %479 = openfhe.lwe_add %474, %478, %477 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %480 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %481 = openfhe.eval_func %arg0, %480, %479 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %482 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_171 = arith.constant 1 : i64
    %483 = openfhe.lwe_mul_const %482, %151, %c1_i64_171 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_172 = arith.constant 1 : i64
    %484 = openfhe.lwe_mul_const %482, %21, %c1_i64_172 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_173 = arith.constant 1 : i64
    %485 = openfhe.lwe_mul_const %482, %8, %c1_i64_173 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_174 = arith.constant -7 : i64
    %486 = openfhe.lwe_mul_const %482, %241, %c-7_i64_174 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %487 = openfhe.lwe_add %482, %483, %484 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %488 = openfhe.lwe_add %482, %487, %485 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %489 = openfhe.lwe_add %482, %488, %486 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %490 = openfhe.make_lut %arg0 {values = array<i32: 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %491 = openfhe.eval_func %arg0, %490, %489 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %492 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %493 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-1_i64_175 = arith.constant -1 : i64
    %494 = openfhe.lwe_mul_const %493, %151, %c-1_i64_175 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_176 = arith.constant -1 : i64
    %495 = openfhe.lwe_mul_const %493, %54, %c-1_i64_176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c5_i64 = arith.constant 5 : i64
    %496 = openfhe.lwe_mul_const %493, %492, %c5_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_177 = arith.constant -5 : i64
    %497 = openfhe.lwe_mul_const %493, %1, %c-5_i64_177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %498 = openfhe.lwe_add %493, %494, %495 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %499 = openfhe.lwe_add %493, %498, %496 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %500 = openfhe.lwe_add %493, %499, %497 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %501 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 3, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %502 = openfhe.eval_func %arg0, %501, %500 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %503 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_178 = arith.constant 2 : i64
    %504 = openfhe.lwe_mul_const %503, %333, %c2_i64_178 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_179 = arith.constant 1 : i64
    %505 = openfhe.lwe_mul_const %503, %144, %c1_i64_179 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_180 = arith.constant 1 : i64
    %506 = openfhe.lwe_mul_const %503, %20, %c1_i64_180 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-6_i64_181 = arith.constant -6 : i64
    %507 = openfhe.lwe_mul_const %503, %327, %c-6_i64_181 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %508 = openfhe.lwe_add %503, %504, %505 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %509 = openfhe.lwe_add %503, %508, %506 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %510 = openfhe.lwe_add %503, %509, %507 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %511 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %512 = openfhe.eval_func %arg0, %511, %510 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %513 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %514 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c3_i64_182 = arith.constant 3 : i64
    %515 = openfhe.lwe_mul_const %514, %513, %c3_i64_182 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c3_i64_183 = arith.constant 3 : i64
    %516 = openfhe.lwe_mul_const %514, %0, %c3_i64_183 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_184 = arith.constant 1 : i64
    %517 = openfhe.lwe_mul_const %514, %55, %c1_i64_184 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_185 = arith.constant -7 : i64
    %518 = openfhe.lwe_mul_const %514, %144, %c-7_i64_185 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %519 = openfhe.lwe_add %514, %515, %516 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %520 = openfhe.lwe_add %514, %519, %517 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %521 = openfhe.lwe_add %514, %520, %518 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %522 = openfhe.make_lut %arg0 {values = array<i32: 2, 5, 6, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %523 = openfhe.eval_func %arg0, %522, %521 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %524 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_186 = arith.constant 4 : i64
    %525 = openfhe.lwe_mul_const %524, %492, %c4_i64_186 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_187 = arith.constant 2 : i64
    %526 = openfhe.lwe_mul_const %524, %241, %c2_i64_187 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_188 = arith.constant 1 : i64
    %527 = openfhe.lwe_mul_const %524, %20, %c1_i64_188 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %528 = openfhe.lwe_add %524, %525, %526 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %529 = openfhe.lwe_add %524, %528, %527 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %530 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %531 = openfhe.eval_func %arg0, %530, %529 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %532 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_189 = arith.constant 4 : i64
    %533 = openfhe.lwe_mul_const %532, %531, %c4_i64_189 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_190 = arith.constant 2 : i64
    %534 = openfhe.lwe_mul_const %532, %220, %c2_i64_190 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_191 = arith.constant 1 : i64
    %535 = openfhe.lwe_mul_const %532, %21, %c1_i64_191 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %536 = openfhe.lwe_add %532, %533, %534 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %537 = openfhe.lwe_add %532, %536, %535 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %538 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %539 = openfhe.eval_func %arg0, %538, %537 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %540 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_192 = arith.constant 2 : i64
    %541 = openfhe.lwe_mul_const %540, %539, %c2_i64_192 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_193 = arith.constant 2 : i64
    %542 = openfhe.lwe_mul_const %540, %523, %c2_i64_193 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_194 = arith.constant 2 : i64
    %543 = openfhe.lwe_mul_const %540, %512, %c2_i64_194 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_195 = arith.constant 1 : i64
    %544 = openfhe.lwe_mul_const %540, %354, %c1_i64_195 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_196 = arith.constant -7 : i64
    %545 = openfhe.lwe_mul_const %540, %9, %c-7_i64_196 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %546 = openfhe.lwe_add %540, %541, %542 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %547 = openfhe.lwe_add %540, %546, %543 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %548 = openfhe.lwe_add %540, %547, %544 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %549 = openfhe.lwe_add %540, %548, %545 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %550 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %551 = openfhe.eval_func %arg0, %550, %549 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %552 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_197 = arith.constant 4 : i64
    %553 = openfhe.lwe_mul_const %552, %353, %c4_i64_197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_198 = arith.constant 2 : i64
    %554 = openfhe.lwe_mul_const %552, %365, %c2_i64_198 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_199 = arith.constant 1 : i64
    %555 = openfhe.lwe_mul_const %552, %343, %c1_i64_199 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %556 = openfhe.lwe_add %552, %553, %554 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %557 = openfhe.lwe_add %552, %556, %555 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %558 = openfhe.make_lut %arg0 {values = array<i32: 0, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %559 = openfhe.eval_func %arg0, %558, %557 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %560 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_200 = arith.constant 4 : i64
    %561 = openfhe.lwe_mul_const %560, %559, %c4_i64_200 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_201 = arith.constant 2 : i64
    %562 = openfhe.lwe_mul_const %560, %405, %c2_i64_201 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_202 = arith.constant 1 : i64
    %563 = openfhe.lwe_mul_const %560, %395, %c1_i64_202 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %564 = openfhe.lwe_add %560, %561, %562 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %565 = openfhe.lwe_add %560, %564, %563 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %566 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %567 = openfhe.eval_func %arg0, %566, %565 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %568 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c1_i64_203 = arith.constant 1 : i64
    %569 = openfhe.lwe_mul_const %568, %567, %c1_i64_203 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_204 = arith.constant 1 : i64
    %570 = openfhe.lwe_mul_const %568, %551, %c1_i64_204 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_205 = arith.constant 1 : i64
    %571 = openfhe.lwe_mul_const %568, %502, %c1_i64_205 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_206 = arith.constant 1 : i64
    %572 = openfhe.lwe_mul_const %568, %491, %c1_i64_206 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_207 = arith.constant 1 : i64
    %573 = openfhe.lwe_mul_const %568, %481, %c1_i64_207 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_208 = arith.constant 1 : i64
    %574 = openfhe.lwe_mul_const %568, %463, %c1_i64_208 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-7_i64_209 = arith.constant -7 : i64
    %575 = openfhe.lwe_mul_const %568, %453, %c-7_i64_209 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %576 = openfhe.lwe_add %568, %569, %570 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %577 = openfhe.lwe_add %568, %576, %571 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %578 = openfhe.lwe_add %568, %577, %572 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %579 = openfhe.lwe_add %568, %578, %573 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %580 = openfhe.lwe_add %568, %579, %574 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %581 = openfhe.lwe_add %568, %580, %575 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %582 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %583 = openfhe.eval_func %arg0, %582, %581 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %584 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c-4_i64_210 = arith.constant -4 : i64
    %585 = openfhe.lwe_mul_const %584, %583, %c-4_i64_210 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_211 = arith.constant 1 : i64
    %586 = openfhe.lwe_mul_const %584, %281, %c1_i64_211 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_212 = arith.constant -1 : i64
    %587 = openfhe.lwe_mul_const %584, %203, %c-1_i64_212 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_213 = arith.constant 2 : i64
    %588 = openfhe.lwe_mul_const %584, %433, %c2_i64_213 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_214 = arith.constant 1 : i64
    %589 = openfhe.lwe_mul_const %584, %293, %c1_i64_214 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-1_i64_215 = arith.constant -1 : i64
    %590 = openfhe.lwe_mul_const %584, %193, %c-1_i64_215 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %591 = openfhe.lwe_add %584, %585, %586 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %592 = openfhe.lwe_add %584, %591, %587 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %593 = openfhe.lwe_add %584, %592, %588 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %594 = openfhe.lwe_add %584, %593, %589 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %595 = openfhe.lwe_add %584, %594, %590 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %596 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %597 = openfhe.eval_func %arg0, %596, %595 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %598 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_216 = arith.constant 4 : i64
    %599 = openfhe.lwe_mul_const %598, %87, %c4_i64_216 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_217 = arith.constant 1 : i64
    %600 = openfhe.lwe_mul_const %598, %8, %c1_i64_217 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_218 = arith.constant 1 : i64
    %601 = openfhe.lwe_mul_const %598, %9, %c1_i64_218 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_219 = arith.constant 1 : i64
    %602 = openfhe.lwe_mul_const %598, %7, %c1_i64_219 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c-5_i64_220 = arith.constant -5 : i64
    %603 = openfhe.lwe_mul_const %598, %107, %c-5_i64_220 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %604 = openfhe.lwe_add %598, %599, %600 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %605 = openfhe.lwe_add %598, %604, %601 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %606 = openfhe.lwe_add %598, %605, %602 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %607 = openfhe.lwe_add %598, %606, %603 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %608 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %609 = openfhe.eval_func %arg0, %608, %607 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %7, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %19, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %41, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %609, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %183, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %303, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %445, %alloc[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %597, %alloc[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    return %alloc : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
  }
}

