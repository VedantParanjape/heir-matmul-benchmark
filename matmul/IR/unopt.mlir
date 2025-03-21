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
    %c4_i64 = arith.constant 4 : i64
    %11 = openfhe.lwe_mul_const %10, %8, %c4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_0 = arith.constant 2 : i64
    %12 = openfhe.lwe_mul_const %10, %9, %c2_i64_0 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_1 = arith.constant 1 : i64
    %13 = openfhe.lwe_mul_const %10, %7, %c1_i64_1 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %14 = openfhe.lwe_add %10, %11, %12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %15 = openfhe.lwe_add %10, %14, %13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %16 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %17 = openfhe.eval_func %arg0, %16, %15 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %18 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_2 = arith.constant 4 : i64
    %19 = openfhe.lwe_mul_const %18, %8, %c4_i64_2 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_3 = arith.constant 2 : i64
    %20 = openfhe.lwe_mul_const %18, %9, %c2_i64_3 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_4 = arith.constant 1 : i64
    %21 = openfhe.lwe_mul_const %18, %7, %c1_i64_4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %22 = openfhe.lwe_add %18, %19, %20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %23 = openfhe.lwe_add %18, %22, %21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %24 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %25 = openfhe.eval_func %arg0, %24, %23 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %26 = memref.load %arg2[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %27 = memref.load %arg1[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %28 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_5 = arith.constant 4 : i64
    %29 = openfhe.lwe_mul_const %28, %26, %c4_i64_5 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_6 = arith.constant 2 : i64
    %30 = openfhe.lwe_mul_const %28, %27, %c2_i64_6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_7 = arith.constant 1 : i64
    %31 = openfhe.lwe_mul_const %28, %25, %c1_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %32 = openfhe.lwe_add %28, %29, %30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %33 = openfhe.lwe_add %28, %32, %31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %34 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %35 = openfhe.eval_func %arg0, %34, %33 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %36 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_8 = arith.constant 4 : i64
    %37 = openfhe.lwe_mul_const %36, %26, %c4_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_9 = arith.constant 2 : i64
    %38 = openfhe.lwe_mul_const %36, %27, %c2_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_10 = arith.constant 1 : i64
    %39 = openfhe.lwe_mul_const %36, %25, %c1_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %40 = openfhe.lwe_add %36, %37, %38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %41 = openfhe.lwe_add %36, %40, %39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %42 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %43 = openfhe.eval_func %arg0, %42, %41 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %44 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %45 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %46 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_11 = arith.constant 4 : i64
    %47 = openfhe.lwe_mul_const %46, %44, %c4_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_12 = arith.constant 2 : i64
    %48 = openfhe.lwe_mul_const %46, %45, %c2_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_13 = arith.constant 1 : i64
    %49 = openfhe.lwe_mul_const %46, %43, %c1_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %50 = openfhe.lwe_add %46, %47, %48 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %51 = openfhe.lwe_add %46, %50, %49 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %52 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %53 = openfhe.eval_func %arg0, %52, %51 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %54 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_14 = arith.constant 4 : i64
    %55 = openfhe.lwe_mul_const %54, %44, %c4_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_15 = arith.constant 2 : i64
    %56 = openfhe.lwe_mul_const %54, %45, %c2_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_16 = arith.constant 1 : i64
    %57 = openfhe.lwe_mul_const %54, %43, %c1_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %58 = openfhe.lwe_add %54, %55, %56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %59 = openfhe.lwe_add %54, %58, %57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %60 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %61 = openfhe.eval_func %arg0, %60, %59 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %62 = memref.load %arg2[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %63 = memref.load %arg1[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %64 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_17 = arith.constant 4 : i64
    %65 = openfhe.lwe_mul_const %64, %62, %c4_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_18 = arith.constant 2 : i64
    %66 = openfhe.lwe_mul_const %64, %63, %c2_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_19 = arith.constant 1 : i64
    %67 = openfhe.lwe_mul_const %64, %61, %c1_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %68 = openfhe.lwe_add %64, %65, %66 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %69 = openfhe.lwe_add %64, %68, %67 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %70 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %71 = openfhe.eval_func %arg0, %70, %69 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %72 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_20 = arith.constant 4 : i64
    %73 = openfhe.lwe_mul_const %72, %62, %c4_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_21 = arith.constant 2 : i64
    %74 = openfhe.lwe_mul_const %72, %63, %c2_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_22 = arith.constant 1 : i64
    %75 = openfhe.lwe_mul_const %72, %61, %c1_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %76 = openfhe.lwe_add %72, %73, %74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %77 = openfhe.lwe_add %72, %76, %75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %78 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %79 = openfhe.eval_func %arg0, %78, %77 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %80 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %81 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %82 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_23 = arith.constant 4 : i64
    %83 = openfhe.lwe_mul_const %82, %80, %c4_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_24 = arith.constant 2 : i64
    %84 = openfhe.lwe_mul_const %82, %81, %c2_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_25 = arith.constant 1 : i64
    %85 = openfhe.lwe_mul_const %82, %79, %c1_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %86 = openfhe.lwe_add %82, %83, %84 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %87 = openfhe.lwe_add %82, %86, %85 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %88 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %89 = openfhe.eval_func %arg0, %88, %87 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %90 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_26 = arith.constant 4 : i64
    %91 = openfhe.lwe_mul_const %90, %80, %c4_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_27 = arith.constant 2 : i64
    %92 = openfhe.lwe_mul_const %90, %81, %c2_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_28 = arith.constant 1 : i64
    %93 = openfhe.lwe_mul_const %90, %79, %c1_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %94 = openfhe.lwe_add %90, %91, %92 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %95 = openfhe.lwe_add %90, %94, %93 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %96 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %97 = openfhe.eval_func %arg0, %96, %95 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %98 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %99 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %100 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_29 = arith.constant 4 : i64
    %101 = openfhe.lwe_mul_const %100, %98, %c4_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_30 = arith.constant 2 : i64
    %102 = openfhe.lwe_mul_const %100, %99, %c2_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_31 = arith.constant 1 : i64
    %103 = openfhe.lwe_mul_const %100, %97, %c1_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %104 = openfhe.lwe_add %100, %101, %102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %105 = openfhe.lwe_add %100, %104, %103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %106 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %107 = openfhe.eval_func %arg0, %106, %105 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %108 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_32 = arith.constant 4 : i64
    %109 = openfhe.lwe_mul_const %108, %98, %c4_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_33 = arith.constant 2 : i64
    %110 = openfhe.lwe_mul_const %108, %99, %c2_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_34 = arith.constant 1 : i64
    %111 = openfhe.lwe_mul_const %108, %97, %c1_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %112 = openfhe.lwe_add %108, %109, %110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %113 = openfhe.lwe_add %108, %112, %111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %114 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %115 = openfhe.eval_func %arg0, %114, %113 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %116 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %117 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %118 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_35 = arith.constant 4 : i64
    %119 = openfhe.lwe_mul_const %118, %116, %c4_i64_35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_36 = arith.constant 2 : i64
    %120 = openfhe.lwe_mul_const %118, %117, %c2_i64_36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_37 = arith.constant 1 : i64
    %121 = openfhe.lwe_mul_const %118, %115, %c1_i64_37 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %122 = openfhe.lwe_add %118, %119, %120 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %123 = openfhe.lwe_add %118, %122, %121 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %124 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %125 = openfhe.eval_func %arg0, %124, %123 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %126 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_38 = arith.constant 2 : i64
    %127 = openfhe.lwe_mul_const %126, %0, %c2_i64_38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_39 = arith.constant 1 : i64
    %128 = openfhe.lwe_mul_const %126, %1, %c1_i64_39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %129 = openfhe.lwe_add %126, %127, %128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %130 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %131 = openfhe.eval_func %arg0, %130, %129 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %131, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %17, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %35, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %53, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %71, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %89, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %107, %alloc[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %125, %alloc[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
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
    %9 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_0 = arith.constant 2 : i64
    %10 = openfhe.lwe_mul_const %9, %8, %c2_i64_0 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_1 = arith.constant 1 : i64
    %11 = openfhe.lwe_mul_const %9, %1, %c1_i64_1 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %12 = openfhe.lwe_add %9, %10, %11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %13 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %14 = openfhe.eval_func %arg0, %13, %12 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %15 = memref.load %arg1[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %16 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64 = arith.constant 4 : i64
    %17 = openfhe.lwe_mul_const %16, %14, %c4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_2 = arith.constant 2 : i64
    %18 = openfhe.lwe_mul_const %16, %0, %c2_i64_2 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_3 = arith.constant 1 : i64
    %19 = openfhe.lwe_mul_const %16, %15, %c1_i64_3 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %20 = openfhe.lwe_add %16, %17, %18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %21 = openfhe.lwe_add %16, %20, %19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %22 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %23 = openfhe.eval_func %arg0, %22, %21 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %24 = memref.load %arg2[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %25 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_4 = arith.constant 2 : i64
    %26 = openfhe.lwe_mul_const %25, %24, %c2_i64_4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_5 = arith.constant 1 : i64
    %27 = openfhe.lwe_mul_const %25, %1, %c1_i64_5 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %28 = openfhe.lwe_add %25, %26, %27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %29 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %30 = openfhe.eval_func %arg0, %29, %28 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %31 = memref.load %arg1[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %32 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_6 = arith.constant 4 : i64
    %33 = openfhe.lwe_mul_const %32, %30, %c4_i64_6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_7 = arith.constant 2 : i64
    %34 = openfhe.lwe_mul_const %32, %0, %c2_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_8 = arith.constant 1 : i64
    %35 = openfhe.lwe_mul_const %32, %31, %c1_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %36 = openfhe.lwe_add %32, %33, %34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %37 = openfhe.lwe_add %32, %36, %35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %38 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %39 = openfhe.eval_func %arg0, %38, %37 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %40 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_9 = arith.constant 2 : i64
    %41 = openfhe.lwe_mul_const %40, %8, %c2_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_10 = arith.constant 1 : i64
    %42 = openfhe.lwe_mul_const %40, %15, %c1_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %43 = openfhe.lwe_add %40, %41, %42 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %44 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %45 = openfhe.eval_func %arg0, %44, %43 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %46 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_11 = arith.constant 4 : i64
    %47 = openfhe.lwe_mul_const %46, %39, %c4_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_12 = arith.constant 2 : i64
    %48 = openfhe.lwe_mul_const %46, %45, %c2_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_13 = arith.constant 1 : i64
    %49 = openfhe.lwe_mul_const %46, %7, %c1_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %50 = openfhe.lwe_add %46, %47, %48 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %51 = openfhe.lwe_add %46, %50, %49 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %52 = openfhe.make_lut %arg0 {values = array<i32: 2, 4, 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %53 = openfhe.eval_func %arg0, %52, %51 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %54 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_14 = arith.constant 2 : i64
    %55 = openfhe.lwe_mul_const %54, %31, %c2_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_15 = arith.constant 1 : i64
    %56 = openfhe.lwe_mul_const %54, %24, %c1_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %57 = openfhe.lwe_add %54, %55, %56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %58 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %59 = openfhe.eval_func %arg0, %58, %57 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %60 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_16 = arith.constant 2 : i64
    %61 = openfhe.lwe_mul_const %60, %59, %c2_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_17 = arith.constant 1 : i64
    %62 = openfhe.lwe_mul_const %60, %7, %c1_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %63 = openfhe.lwe_add %60, %61, %62 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %64 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %65 = openfhe.eval_func %arg0, %64, %63 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %66 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %67 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_18 = arith.constant 2 : i64
    %68 = openfhe.lwe_mul_const %67, %0, %c2_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_19 = arith.constant 1 : i64
    %69 = openfhe.lwe_mul_const %67, %66, %c1_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %70 = openfhe.lwe_add %67, %68, %69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %71 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %72 = openfhe.eval_func %arg0, %71, %70 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %73 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %74 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_20 = arith.constant 2 : i64
    %75 = openfhe.lwe_mul_const %74, %73, %c2_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_21 = arith.constant 1 : i64
    %76 = openfhe.lwe_mul_const %74, %1, %c1_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %77 = openfhe.lwe_add %74, %75, %76 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %78 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %79 = openfhe.eval_func %arg0, %78, %77 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %80 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_22 = arith.constant 2 : i64
    %81 = openfhe.lwe_mul_const %80, %15, %c2_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_23 = arith.constant 1 : i64
    %82 = openfhe.lwe_mul_const %80, %24, %c1_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %83 = openfhe.lwe_add %80, %81, %82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %84 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %85 = openfhe.eval_func %arg0, %84, %83 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %86 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_24 = arith.constant 4 : i64
    %87 = openfhe.lwe_mul_const %86, %85, %c4_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_25 = arith.constant 2 : i64
    %88 = openfhe.lwe_mul_const %86, %79, %c2_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_26 = arith.constant 1 : i64
    %89 = openfhe.lwe_mul_const %86, %72, %c1_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %90 = openfhe.lwe_add %86, %87, %88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %91 = openfhe.lwe_add %86, %90, %89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %92 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %93 = openfhe.eval_func %arg0, %92, %91 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %94 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_27 = arith.constant 2 : i64
    %95 = openfhe.lwe_mul_const %94, %8, %c2_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_28 = arith.constant 1 : i64
    %96 = openfhe.lwe_mul_const %94, %31, %c1_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %97 = openfhe.lwe_add %94, %95, %96 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %98 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %99 = openfhe.eval_func %arg0, %98, %97 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %100 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_29 = arith.constant 4 : i64
    %101 = openfhe.lwe_mul_const %100, %99, %c4_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_30 = arith.constant 2 : i64
    %102 = openfhe.lwe_mul_const %100, %93, %c2_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_31 = arith.constant 1 : i64
    %103 = openfhe.lwe_mul_const %100, %65, %c1_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %104 = openfhe.lwe_add %100, %101, %102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %105 = openfhe.lwe_add %100, %104, %103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %106 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %107 = openfhe.eval_func %arg0, %106, %105 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %108 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_32 = arith.constant 2 : i64
    %109 = openfhe.lwe_mul_const %108, %45, %c2_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_33 = arith.constant 1 : i64
    %110 = openfhe.lwe_mul_const %108, %7, %c1_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %111 = openfhe.lwe_add %108, %109, %110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %112 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %113 = openfhe.eval_func %arg0, %112, %111 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %114 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_34 = arith.constant 4 : i64
    %115 = openfhe.lwe_mul_const %114, %107, %c4_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_35 = arith.constant 2 : i64
    %116 = openfhe.lwe_mul_const %114, %113, %c2_i64_35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_36 = arith.constant 1 : i64
    %117 = openfhe.lwe_mul_const %114, %39, %c1_i64_36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %118 = openfhe.lwe_add %114, %115, %116 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %119 = openfhe.lwe_add %114, %118, %117 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %120 = openfhe.make_lut %arg0 {values = array<i32: 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %121 = openfhe.eval_func %arg0, %120, %119 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %122 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_37 = arith.constant 2 : i64
    %123 = openfhe.lwe_mul_const %122, %45, %c2_i64_37 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_38 = arith.constant 1 : i64
    %124 = openfhe.lwe_mul_const %122, %39, %c1_i64_38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %125 = openfhe.lwe_add %122, %123, %124 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %126 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %127 = openfhe.eval_func %arg0, %126, %125 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %128 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_39 = arith.constant 2 : i64
    %129 = openfhe.lwe_mul_const %128, %127, %c2_i64_39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_40 = arith.constant 1 : i64
    %130 = openfhe.lwe_mul_const %128, %107, %c1_i64_40 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %131 = openfhe.lwe_add %128, %129, %130 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %132 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %133 = openfhe.eval_func %arg0, %132, %131 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %134 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_41 = arith.constant 4 : i64
    %135 = openfhe.lwe_mul_const %134, %99, %c4_i64_41 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_42 = arith.constant 2 : i64
    %136 = openfhe.lwe_mul_const %134, %93, %c2_i64_42 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_43 = arith.constant 1 : i64
    %137 = openfhe.lwe_mul_const %134, %65, %c1_i64_43 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %138 = openfhe.lwe_add %134, %135, %136 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %139 = openfhe.lwe_add %134, %138, %137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %140 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %141 = openfhe.eval_func %arg0, %140, %139 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %142 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_44 = arith.constant 4 : i64
    %143 = openfhe.lwe_mul_const %142, %72, %c4_i64_44 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_45 = arith.constant 2 : i64
    %144 = openfhe.lwe_mul_const %142, %85, %c2_i64_45 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_46 = arith.constant 1 : i64
    %145 = openfhe.lwe_mul_const %142, %79, %c1_i64_46 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %146 = openfhe.lwe_add %142, %143, %144 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %147 = openfhe.lwe_add %142, %146, %145 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %148 = openfhe.make_lut %arg0 {values = array<i32: 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %149 = openfhe.eval_func %arg0, %148, %147 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %150 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_47 = arith.constant 2 : i64
    %151 = openfhe.lwe_mul_const %150, %73, %c2_i64_47 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_48 = arith.constant 1 : i64
    %152 = openfhe.lwe_mul_const %150, %15, %c1_i64_48 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %153 = openfhe.lwe_add %150, %151, %152 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %154 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %155 = openfhe.eval_func %arg0, %154, %153 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %156 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_49 = arith.constant 4 : i64
    %157 = openfhe.lwe_mul_const %156, %59, %c4_i64_49 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_50 = arith.constant 2 : i64
    %158 = openfhe.lwe_mul_const %156, %155, %c2_i64_50 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_51 = arith.constant 1 : i64
    %159 = openfhe.lwe_mul_const %156, %30, %c1_i64_51 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %160 = openfhe.lwe_add %156, %157, %158 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %161 = openfhe.lwe_add %156, %160, %159 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %162 = openfhe.make_lut %arg0 {values = array<i32: 2, 4, 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %163 = openfhe.eval_func %arg0, %162, %161 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %164 = memref.load %arg1[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %165 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_52 = arith.constant 2 : i64
    %166 = openfhe.lwe_mul_const %165, %0, %c2_i64_52 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_53 = arith.constant 1 : i64
    %167 = openfhe.lwe_mul_const %165, %164, %c1_i64_53 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %168 = openfhe.lwe_add %165, %166, %167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %169 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %170 = openfhe.eval_func %arg0, %169, %168 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %171 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_54 = arith.constant 4 : i64
    %172 = openfhe.lwe_mul_const %171, %170, %c4_i64_54 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_55 = arith.constant 2 : i64
    %173 = openfhe.lwe_mul_const %171, %163, %c2_i64_55 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_56 = arith.constant 1 : i64
    %174 = openfhe.lwe_mul_const %171, %149, %c1_i64_56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %175 = openfhe.lwe_add %171, %172, %173 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %176 = openfhe.lwe_add %171, %175, %174 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %177 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %178 = openfhe.eval_func %arg0, %177, %176 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %179 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_57 = arith.constant 2 : i64
    %180 = openfhe.lwe_mul_const %179, %8, %c2_i64_57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_58 = arith.constant 1 : i64
    %181 = openfhe.lwe_mul_const %179, %66, %c1_i64_58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %182 = openfhe.lwe_add %179, %180, %181 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %183 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %184 = openfhe.eval_func %arg0, %183, %182 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %185 = memref.load %arg2[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %186 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_59 = arith.constant 4 : i64
    %187 = openfhe.lwe_mul_const %186, %184, %c4_i64_59 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_60 = arith.constant 2 : i64
    %188 = openfhe.lwe_mul_const %186, %185, %c2_i64_60 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_61 = arith.constant 1 : i64
    %189 = openfhe.lwe_mul_const %186, %1, %c1_i64_61 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %190 = openfhe.lwe_add %186, %187, %188 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %191 = openfhe.lwe_add %186, %190, %189 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %192 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %193 = openfhe.eval_func %arg0, %192, %191 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %194 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_62 = arith.constant 4 : i64
    %195 = openfhe.lwe_mul_const %194, %193, %c4_i64_62 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_63 = arith.constant 2 : i64
    %196 = openfhe.lwe_mul_const %194, %178, %c2_i64_63 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_64 = arith.constant 1 : i64
    %197 = openfhe.lwe_mul_const %194, %141, %c1_i64_64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %198 = openfhe.lwe_add %194, %195, %196 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %199 = openfhe.lwe_add %194, %198, %197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %200 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %201 = openfhe.eval_func %arg0, %200, %199 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %202 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_65 = arith.constant 4 : i64
    %203 = openfhe.lwe_mul_const %202, %201, %c4_i64_65 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_66 = arith.constant 2 : i64
    %204 = openfhe.lwe_mul_const %202, %133, %c2_i64_66 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_67 = arith.constant 1 : i64
    %205 = openfhe.lwe_mul_const %202, %121, %c1_i64_67 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %206 = openfhe.lwe_add %202, %203, %204 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %207 = openfhe.lwe_add %202, %206, %205 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %208 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %209 = openfhe.eval_func %arg0, %208, %207 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %210 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_68 = arith.constant 4 : i64
    %211 = openfhe.lwe_mul_const %210, %201, %c4_i64_68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_69 = arith.constant 2 : i64
    %212 = openfhe.lwe_mul_const %210, %133, %c2_i64_69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_70 = arith.constant 1 : i64
    %213 = openfhe.lwe_mul_const %210, %121, %c1_i64_70 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %214 = openfhe.lwe_add %210, %211, %212 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %215 = openfhe.lwe_add %210, %214, %213 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %216 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %217 = openfhe.eval_func %arg0, %216, %215 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %218 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_71 = arith.constant 4 : i64
    %219 = openfhe.lwe_mul_const %218, %178, %c4_i64_71 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_72 = arith.constant 2 : i64
    %220 = openfhe.lwe_mul_const %218, %193, %c2_i64_72 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_73 = arith.constant 1 : i64
    %221 = openfhe.lwe_mul_const %218, %149, %c1_i64_73 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %222 = openfhe.lwe_add %218, %219, %220 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %223 = openfhe.lwe_add %218, %222, %221 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %224 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %225 = openfhe.eval_func %arg0, %224, %223 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %226 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_74 = arith.constant 2 : i64
    %227 = openfhe.lwe_mul_const %226, %155, %c2_i64_74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_75 = arith.constant 1 : i64
    %228 = openfhe.lwe_mul_const %226, %59, %c1_i64_75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %229 = openfhe.lwe_add %226, %227, %228 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %230 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %231 = openfhe.eval_func %arg0, %230, %229 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %232 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_76 = arith.constant 4 : i64
    %233 = openfhe.lwe_mul_const %232, %163, %c4_i64_76 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_77 = arith.constant 2 : i64
    %234 = openfhe.lwe_mul_const %232, %170, %c2_i64_77 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_78 = arith.constant 1 : i64
    %235 = openfhe.lwe_mul_const %232, %231, %c1_i64_78 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %236 = openfhe.lwe_add %232, %233, %234 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %237 = openfhe.lwe_add %232, %236, %235 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %238 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %239 = openfhe.eval_func %arg0, %238, %237 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %240 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_79 = arith.constant 2 : i64
    %241 = openfhe.lwe_mul_const %240, %66, %c2_i64_79 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_80 = arith.constant 1 : i64
    %242 = openfhe.lwe_mul_const %240, %24, %c1_i64_80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %243 = openfhe.lwe_add %240, %241, %242 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %244 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %245 = openfhe.eval_func %arg0, %244, %243 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %246 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %247 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_81 = arith.constant 2 : i64
    %248 = openfhe.lwe_mul_const %247, %246, %c2_i64_81 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_82 = arith.constant 1 : i64
    %249 = openfhe.lwe_mul_const %247, %1, %c1_i64_82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %250 = openfhe.lwe_add %247, %248, %249 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %251 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %252 = openfhe.eval_func %arg0, %251, %250 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %253 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_83 = arith.constant 2 : i64
    %254 = openfhe.lwe_mul_const %253, %252, %c2_i64_83 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_84 = arith.constant 1 : i64
    %255 = openfhe.lwe_mul_const %253, %245, %c1_i64_84 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %256 = openfhe.lwe_add %253, %254, %255 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %257 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %258 = openfhe.eval_func %arg0, %257, %256 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %259 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_85 = arith.constant 2 : i64
    %260 = openfhe.lwe_mul_const %259, %73, %c2_i64_85 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_86 = arith.constant 1 : i64
    %261 = openfhe.lwe_mul_const %259, %31, %c1_i64_86 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %262 = openfhe.lwe_add %259, %260, %261 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %263 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %264 = openfhe.eval_func %arg0, %263, %262 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %265 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_87 = arith.constant 2 : i64
    %266 = openfhe.lwe_mul_const %265, %264, %c2_i64_87 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_88 = arith.constant 1 : i64
    %267 = openfhe.lwe_mul_const %265, %85, %c1_i64_88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %268 = openfhe.lwe_add %265, %266, %267 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %269 = openfhe.make_lut %arg0 {values = array<i32: 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %270 = openfhe.eval_func %arg0, %269, %268 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %271 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %272 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_89 = arith.constant 2 : i64
    %273 = openfhe.lwe_mul_const %272, %0, %c2_i64_89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_90 = arith.constant 1 : i64
    %274 = openfhe.lwe_mul_const %272, %271, %c1_i64_90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %275 = openfhe.lwe_add %272, %273, %274 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %276 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %277 = openfhe.eval_func %arg0, %276, %275 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %278 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_91 = arith.constant 4 : i64
    %279 = openfhe.lwe_mul_const %278, %277, %c4_i64_91 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_92 = arith.constant 2 : i64
    %280 = openfhe.lwe_mul_const %278, %270, %c2_i64_92 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_93 = arith.constant 1 : i64
    %281 = openfhe.lwe_mul_const %278, %258, %c1_i64_93 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %282 = openfhe.lwe_add %278, %279, %280 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %283 = openfhe.lwe_add %278, %282, %281 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %284 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %285 = openfhe.eval_func %arg0, %284, %283 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %286 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_94 = arith.constant 2 : i64
    %287 = openfhe.lwe_mul_const %286, %185, %c2_i64_94 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_95 = arith.constant 1 : i64
    %288 = openfhe.lwe_mul_const %286, %66, %c1_i64_95 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %289 = openfhe.lwe_add %286, %287, %288 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %290 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %291 = openfhe.eval_func %arg0, %290, %289 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %292 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_96 = arith.constant 2 : i64
    %293 = openfhe.lwe_mul_const %292, %291, %c2_i64_96 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_97 = arith.constant 1 : i64
    %294 = openfhe.lwe_mul_const %292, %14, %c1_i64_97 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %295 = openfhe.lwe_add %292, %293, %294 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %296 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %297 = openfhe.eval_func %arg0, %296, %295 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %298 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_98 = arith.constant 2 : i64
    %299 = openfhe.lwe_mul_const %298, %8, %c2_i64_98 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_99 = arith.constant 1 : i64
    %300 = openfhe.lwe_mul_const %298, %164, %c1_i64_99 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %301 = openfhe.lwe_add %298, %299, %300 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %302 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %303 = openfhe.eval_func %arg0, %302, %301 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %304 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_100 = arith.constant 4 : i64
    %305 = openfhe.lwe_mul_const %304, %303, %c4_i64_100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_101 = arith.constant 2 : i64
    %306 = openfhe.lwe_mul_const %304, %185, %c2_i64_101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_102 = arith.constant 1 : i64
    %307 = openfhe.lwe_mul_const %304, %15, %c1_i64_102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %308 = openfhe.lwe_add %304, %305, %306 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %309 = openfhe.lwe_add %304, %308, %307 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %310 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %311 = openfhe.eval_func %arg0, %310, %309 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %312 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_103 = arith.constant 2 : i64
    %313 = openfhe.lwe_mul_const %312, %311, %c2_i64_103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_104 = arith.constant 1 : i64
    %314 = openfhe.lwe_mul_const %312, %297, %c1_i64_104 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %315 = openfhe.lwe_add %312, %313, %314 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %316 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %317 = openfhe.eval_func %arg0, %316, %315 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %318 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_105 = arith.constant 4 : i64
    %319 = openfhe.lwe_mul_const %318, %317, %c4_i64_105 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_106 = arith.constant 2 : i64
    %320 = openfhe.lwe_mul_const %318, %285, %c2_i64_106 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_107 = arith.constant 1 : i64
    %321 = openfhe.lwe_mul_const %318, %239, %c1_i64_107 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %322 = openfhe.lwe_add %318, %319, %320 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %323 = openfhe.lwe_add %318, %322, %321 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %324 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %325 = openfhe.eval_func %arg0, %324, %323 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %326 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_108 = arith.constant 2 : i64
    %327 = openfhe.lwe_mul_const %326, %325, %c2_i64_108 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_109 = arith.constant 1 : i64
    %328 = openfhe.lwe_mul_const %326, %225, %c1_i64_109 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %329 = openfhe.lwe_add %326, %327, %328 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %330 = openfhe.make_lut %arg0 {values = array<i32: 0, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %331 = openfhe.eval_func %arg0, %330, %329 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %332 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_110 = arith.constant 4 : i64
    %333 = openfhe.lwe_mul_const %332, %193, %c4_i64_110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_111 = arith.constant 2 : i64
    %334 = openfhe.lwe_mul_const %332, %178, %c2_i64_111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_112 = arith.constant 1 : i64
    %335 = openfhe.lwe_mul_const %332, %141, %c1_i64_112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %336 = openfhe.lwe_add %332, %333, %334 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %337 = openfhe.lwe_add %332, %336, %335 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %338 = openfhe.make_lut %arg0 {values = array<i32: 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %339 = openfhe.eval_func %arg0, %338, %337 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %340 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_113 = arith.constant 4 : i64
    %341 = openfhe.lwe_mul_const %340, %339, %c4_i64_113 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_114 = arith.constant 2 : i64
    %342 = openfhe.lwe_mul_const %340, %331, %c2_i64_114 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_115 = arith.constant 1 : i64
    %343 = openfhe.lwe_mul_const %340, %217, %c1_i64_115 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %344 = openfhe.lwe_add %340, %341, %342 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %345 = openfhe.lwe_add %340, %344, %343 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %346 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %347 = openfhe.eval_func %arg0, %346, %345 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %348 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_116 = arith.constant 4 : i64
    %349 = openfhe.lwe_mul_const %348, %339, %c4_i64_116 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_117 = arith.constant 2 : i64
    %350 = openfhe.lwe_mul_const %348, %331, %c2_i64_117 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_118 = arith.constant 1 : i64
    %351 = openfhe.lwe_mul_const %348, %217, %c1_i64_118 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %352 = openfhe.lwe_add %348, %349, %350 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %353 = openfhe.lwe_add %348, %352, %351 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %354 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %355 = openfhe.eval_func %arg0, %354, %353 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %356 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_119 = arith.constant 4 : i64
    %357 = openfhe.lwe_mul_const %356, %317, %c4_i64_119 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_120 = arith.constant 2 : i64
    %358 = openfhe.lwe_mul_const %356, %285, %c2_i64_120 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_121 = arith.constant 1 : i64
    %359 = openfhe.lwe_mul_const %356, %239, %c1_i64_121 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %360 = openfhe.lwe_add %356, %357, %358 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %361 = openfhe.lwe_add %356, %360, %359 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %362 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %363 = openfhe.eval_func %arg0, %362, %361 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %364 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_122 = arith.constant 4 : i64
    %365 = openfhe.lwe_mul_const %364, %277, %c4_i64_122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_123 = arith.constant 2 : i64
    %366 = openfhe.lwe_mul_const %364, %270, %c2_i64_123 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_124 = arith.constant 1 : i64
    %367 = openfhe.lwe_mul_const %364, %258, %c1_i64_124 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %368 = openfhe.lwe_add %364, %365, %366 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %369 = openfhe.lwe_add %364, %368, %367 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %370 = openfhe.make_lut %arg0 {values = array<i32: 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %371 = openfhe.eval_func %arg0, %370, %369 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %372 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_125 = arith.constant 4 : i64
    %373 = openfhe.lwe_mul_const %372, %155, %c4_i64_125 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_126 = arith.constant 2 : i64
    %374 = openfhe.lwe_mul_const %372, %59, %c2_i64_126 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_127 = arith.constant 1 : i64
    %375 = openfhe.lwe_mul_const %372, %258, %c1_i64_127 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %376 = openfhe.lwe_add %372, %373, %374 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %377 = openfhe.lwe_add %372, %376, %375 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %378 = openfhe.make_lut %arg0 {values = array<i32: 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %379 = openfhe.eval_func %arg0, %378, %377 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %380 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_128 = arith.constant 2 : i64
    %381 = openfhe.lwe_mul_const %380, %73, %c2_i64_128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_129 = arith.constant 1 : i64
    %382 = openfhe.lwe_mul_const %380, %66, %c1_i64_129 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %383 = openfhe.lwe_add %380, %381, %382 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %384 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %385 = openfhe.eval_func %arg0, %384, %383 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %386 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_130 = arith.constant 2 : i64
    %387 = openfhe.lwe_mul_const %386, %164, %c2_i64_130 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_131 = arith.constant 1 : i64
    %388 = openfhe.lwe_mul_const %386, %24, %c1_i64_131 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %389 = openfhe.lwe_add %386, %387, %388 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %390 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %391 = openfhe.eval_func %arg0, %390, %389 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %392 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_132 = arith.constant 2 : i64
    %393 = openfhe.lwe_mul_const %392, %246, %c2_i64_132 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_133 = arith.constant 1 : i64
    %394 = openfhe.lwe_mul_const %392, %15, %c1_i64_133 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %395 = openfhe.lwe_add %392, %393, %394 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %396 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %397 = openfhe.eval_func %arg0, %396, %395 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %398 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_134 = arith.constant 4 : i64
    %399 = openfhe.lwe_mul_const %398, %397, %c4_i64_134 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_135 = arith.constant 2 : i64
    %400 = openfhe.lwe_mul_const %398, %391, %c2_i64_135 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_136 = arith.constant 1 : i64
    %401 = openfhe.lwe_mul_const %398, %385, %c1_i64_136 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %402 = openfhe.lwe_add %398, %399, %400 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %403 = openfhe.lwe_add %398, %402, %401 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %404 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %405 = openfhe.eval_func %arg0, %404, %403 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %406 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_137 = arith.constant 4 : i64
    %407 = openfhe.lwe_mul_const %406, %252, %c4_i64_137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_138 = arith.constant 2 : i64
    %408 = openfhe.lwe_mul_const %406, %245, %c2_i64_138 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_139 = arith.constant 1 : i64
    %409 = openfhe.lwe_mul_const %406, %264, %c1_i64_139 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %410 = openfhe.lwe_add %406, %407, %408 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %411 = openfhe.lwe_add %406, %410, %409 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %412 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %413 = openfhe.eval_func %arg0, %412, %411 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %414 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %415 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_140 = arith.constant 2 : i64
    %416 = openfhe.lwe_mul_const %415, %414, %c2_i64_140 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_141 = arith.constant 1 : i64
    %417 = openfhe.lwe_mul_const %415, %1, %c1_i64_141 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %418 = openfhe.lwe_add %415, %416, %417 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %419 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %420 = openfhe.eval_func %arg0, %419, %418 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %421 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %422 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_142 = arith.constant 4 : i64
    %423 = openfhe.lwe_mul_const %422, %420, %c4_i64_142 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_143 = arith.constant 2 : i64
    %424 = openfhe.lwe_mul_const %422, %0, %c2_i64_143 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_144 = arith.constant 1 : i64
    %425 = openfhe.lwe_mul_const %422, %421, %c1_i64_144 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %426 = openfhe.lwe_add %422, %423, %424 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %427 = openfhe.lwe_add %422, %426, %425 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %428 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %429 = openfhe.eval_func %arg0, %428, %427 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %430 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_145 = arith.constant 4 : i64
    %431 = openfhe.lwe_mul_const %430, %429, %c4_i64_145 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_146 = arith.constant 2 : i64
    %432 = openfhe.lwe_mul_const %430, %413, %c2_i64_146 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_147 = arith.constant 1 : i64
    %433 = openfhe.lwe_mul_const %430, %405, %c1_i64_147 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %434 = openfhe.lwe_add %430, %431, %432 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %435 = openfhe.lwe_add %430, %434, %433 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %436 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %437 = openfhe.eval_func %arg0, %436, %435 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %438 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_148 = arith.constant 4 : i64
    %439 = openfhe.lwe_mul_const %438, %437, %c4_i64_148 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_149 = arith.constant 2 : i64
    %440 = openfhe.lwe_mul_const %438, %379, %c2_i64_149 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_150 = arith.constant 1 : i64
    %441 = openfhe.lwe_mul_const %438, %371, %c1_i64_150 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %442 = openfhe.lwe_add %438, %439, %440 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %443 = openfhe.lwe_add %438, %442, %441 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %444 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 3, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %445 = openfhe.eval_func %arg0, %444, %443 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %446 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_151 = arith.constant 4 : i64
    %447 = openfhe.lwe_mul_const %446, %185, %c4_i64_151 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_152 = arith.constant 2 : i64
    %448 = openfhe.lwe_mul_const %446, %15, %c2_i64_152 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_153 = arith.constant 1 : i64
    %449 = openfhe.lwe_mul_const %446, %303, %c1_i64_153 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %450 = openfhe.lwe_add %446, %447, %448 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %451 = openfhe.lwe_add %446, %450, %449 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %452 = openfhe.make_lut %arg0 {values = array<i32: 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %453 = openfhe.eval_func %arg0, %452, %451 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %454 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_154 = arith.constant 2 : i64
    %455 = openfhe.lwe_mul_const %454, %8, %c2_i64_154 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_155 = arith.constant 1 : i64
    %456 = openfhe.lwe_mul_const %454, %271, %c1_i64_155 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %457 = openfhe.lwe_add %454, %455, %456 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %458 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %459 = openfhe.eval_func %arg0, %458, %457 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %460 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_156 = arith.constant 4 : i64
    %461 = openfhe.lwe_mul_const %460, %459, %c4_i64_156 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_157 = arith.constant 2 : i64
    %462 = openfhe.lwe_mul_const %460, %185, %c2_i64_157 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_158 = arith.constant 1 : i64
    %463 = openfhe.lwe_mul_const %460, %31, %c1_i64_158 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %464 = openfhe.lwe_add %460, %461, %462 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %465 = openfhe.lwe_add %460, %464, %463 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %466 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %467 = openfhe.eval_func %arg0, %466, %465 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %468 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_159 = arith.constant 2 : i64
    %469 = openfhe.lwe_mul_const %468, %467, %c2_i64_159 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_160 = arith.constant 1 : i64
    %470 = openfhe.lwe_mul_const %468, %453, %c1_i64_160 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %471 = openfhe.lwe_add %468, %469, %470 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %472 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %473 = openfhe.eval_func %arg0, %472, %471 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %474 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_161 = arith.constant 4 : i64
    %475 = openfhe.lwe_mul_const %474, %473, %c4_i64_161 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_162 = arith.constant 2 : i64
    %476 = openfhe.lwe_mul_const %474, %445, %c2_i64_162 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_163 = arith.constant 1 : i64
    %477 = openfhe.lwe_mul_const %474, %363, %c1_i64_163 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %478 = openfhe.lwe_add %474, %475, %476 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %479 = openfhe.lwe_add %474, %478, %477 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %480 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %481 = openfhe.eval_func %arg0, %480, %479 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %482 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_164 = arith.constant 2 : i64
    %483 = openfhe.lwe_mul_const %482, %311, %c2_i64_164 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_165 = arith.constant 1 : i64
    %484 = openfhe.lwe_mul_const %482, %297, %c1_i64_165 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %485 = openfhe.lwe_add %482, %483, %484 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %486 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %487 = openfhe.eval_func %arg0, %486, %485 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %488 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_166 = arith.constant 2 : i64
    %489 = openfhe.lwe_mul_const %488, %487, %c2_i64_166 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_167 = arith.constant 1 : i64
    %490 = openfhe.lwe_mul_const %488, %481, %c1_i64_167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %491 = openfhe.lwe_add %488, %489, %490 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %492 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %493 = openfhe.eval_func %arg0, %492, %491 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %494 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_168 = arith.constant 2 : i64
    %495 = openfhe.lwe_mul_const %494, %325, %c2_i64_168 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_169 = arith.constant 1 : i64
    %496 = openfhe.lwe_mul_const %494, %225, %c1_i64_169 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %497 = openfhe.lwe_add %494, %495, %496 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %498 = openfhe.make_lut %arg0 {values = array<i32: 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %499 = openfhe.eval_func %arg0, %498, %497 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %500 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_170 = arith.constant 4 : i64
    %501 = openfhe.lwe_mul_const %500, %499, %c4_i64_170 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_171 = arith.constant 2 : i64
    %502 = openfhe.lwe_mul_const %500, %493, %c2_i64_171 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_172 = arith.constant 1 : i64
    %503 = openfhe.lwe_mul_const %500, %355, %c1_i64_172 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %504 = openfhe.lwe_add %500, %501, %502 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %505 = openfhe.lwe_add %500, %504, %503 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %506 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %507 = openfhe.eval_func %arg0, %506, %505 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %508 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_173 = arith.constant 4 : i64
    %509 = openfhe.lwe_mul_const %508, %499, %c4_i64_173 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_174 = arith.constant 2 : i64
    %510 = openfhe.lwe_mul_const %508, %493, %c2_i64_174 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_175 = arith.constant 1 : i64
    %511 = openfhe.lwe_mul_const %508, %355, %c1_i64_175 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %512 = openfhe.lwe_add %508, %509, %510 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %513 = openfhe.lwe_add %508, %512, %511 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %514 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %515 = openfhe.eval_func %arg0, %514, %513 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %516 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_176 = arith.constant 4 : i64
    %517 = openfhe.lwe_mul_const %516, %481, %c4_i64_176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_177 = arith.constant 2 : i64
    %518 = openfhe.lwe_mul_const %516, %363, %c2_i64_177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_178 = arith.constant 1 : i64
    %519 = openfhe.lwe_mul_const %516, %487, %c1_i64_178 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %520 = openfhe.lwe_add %516, %517, %518 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %521 = openfhe.lwe_add %516, %520, %519 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %522 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 4, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %523 = openfhe.eval_func %arg0, %522, %521 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %524 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_179 = arith.constant 4 : i64
    %525 = openfhe.lwe_mul_const %524, %445, %c4_i64_179 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_180 = arith.constant 2 : i64
    %526 = openfhe.lwe_mul_const %524, %473, %c2_i64_180 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_181 = arith.constant 1 : i64
    %527 = openfhe.lwe_mul_const %524, %437, %c1_i64_181 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %528 = openfhe.lwe_add %524, %525, %526 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %529 = openfhe.lwe_add %524, %528, %527 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %530 = openfhe.make_lut %arg0 {values = array<i32: 0, 2, 4, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %531 = openfhe.eval_func %arg0, %530, %529 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %532 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_182 = arith.constant 4 : i64
    %533 = openfhe.lwe_mul_const %532, %0, %c4_i64_182 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_183 = arith.constant 2 : i64
    %534 = openfhe.lwe_mul_const %532, %421, %c2_i64_183 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_184 = arith.constant 1 : i64
    %535 = openfhe.lwe_mul_const %532, %420, %c1_i64_184 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %536 = openfhe.lwe_add %532, %533, %534 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %537 = openfhe.lwe_add %532, %536, %535 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %538 = openfhe.make_lut %arg0 {values = array<i32: 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %539 = openfhe.eval_func %arg0, %538, %537 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %540 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_185 = arith.constant 4 : i64
    %541 = openfhe.lwe_mul_const %540, %8, %c4_i64_185 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_186 = arith.constant 2 : i64
    %542 = openfhe.lwe_mul_const %540, %539, %c2_i64_186 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_187 = arith.constant 1 : i64
    %543 = openfhe.lwe_mul_const %540, %421, %c1_i64_187 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %544 = openfhe.lwe_add %540, %541, %542 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %545 = openfhe.lwe_add %540, %544, %543 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %546 = openfhe.make_lut %arg0 {values = array<i32: 2, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %547 = openfhe.eval_func %arg0, %546, %545 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %548 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_188 = arith.constant 4 : i64
    %549 = openfhe.lwe_mul_const %548, %185, %c4_i64_188 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_189 = arith.constant 2 : i64
    %550 = openfhe.lwe_mul_const %548, %31, %c2_i64_189 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_190 = arith.constant 1 : i64
    %551 = openfhe.lwe_mul_const %548, %459, %c1_i64_190 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %552 = openfhe.lwe_add %548, %549, %550 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %553 = openfhe.lwe_add %548, %552, %551 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %554 = openfhe.make_lut %arg0 {values = array<i32: 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %555 = openfhe.eval_func %arg0, %554, %553 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %556 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %557 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_191 = arith.constant 4 : i64
    %558 = openfhe.lwe_mul_const %557, %291, %c4_i64_191 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_192 = arith.constant 2 : i64
    %559 = openfhe.lwe_mul_const %557, %556, %c2_i64_192 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_193 = arith.constant 1 : i64
    %560 = openfhe.lwe_mul_const %557, %1, %c1_i64_193 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %561 = openfhe.lwe_add %557, %558, %559 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %562 = openfhe.lwe_add %557, %561, %560 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %563 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %564 = openfhe.eval_func %arg0, %563, %562 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %565 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_194 = arith.constant 4 : i64
    %566 = openfhe.lwe_mul_const %565, %564, %c4_i64_194 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_195 = arith.constant 2 : i64
    %567 = openfhe.lwe_mul_const %565, %555, %c2_i64_195 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_196 = arith.constant 1 : i64
    %568 = openfhe.lwe_mul_const %565, %547, %c1_i64_196 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %569 = openfhe.lwe_add %565, %566, %567 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %570 = openfhe.lwe_add %565, %569, %568 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %571 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %572 = openfhe.eval_func %arg0, %571, %570 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %573 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_197 = arith.constant 4 : i64
    %574 = openfhe.lwe_mul_const %573, %397, %c4_i64_197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_198 = arith.constant 2 : i64
    %575 = openfhe.lwe_mul_const %573, %391, %c2_i64_198 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_199 = arith.constant 1 : i64
    %576 = openfhe.lwe_mul_const %573, %385, %c1_i64_199 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %577 = openfhe.lwe_add %573, %574, %575 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %578 = openfhe.lwe_add %573, %577, %576 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %579 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %580 = openfhe.eval_func %arg0, %579, %578 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %581 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_200 = arith.constant 4 : i64
    %582 = openfhe.lwe_mul_const %581, %580, %c4_i64_200 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_201 = arith.constant 2 : i64
    %583 = openfhe.lwe_mul_const %581, %414, %c2_i64_201 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_202 = arith.constant 1 : i64
    %584 = openfhe.lwe_mul_const %581, %15, %c1_i64_202 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %585 = openfhe.lwe_add %581, %582, %583 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %586 = openfhe.lwe_add %581, %585, %584 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %587 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %588 = openfhe.eval_func %arg0, %587, %586 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %589 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %590 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_203 = arith.constant 2 : i64
    %591 = openfhe.lwe_mul_const %590, %589, %c2_i64_203 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_204 = arith.constant 1 : i64
    %592 = openfhe.lwe_mul_const %590, %0, %c1_i64_204 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %593 = openfhe.lwe_add %590, %591, %592 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %594 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %595 = openfhe.eval_func %arg0, %594, %593 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %596 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_205 = arith.constant 4 : i64
    %597 = openfhe.lwe_mul_const %596, %595, %c4_i64_205 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_206 = arith.constant 2 : i64
    %598 = openfhe.lwe_mul_const %596, %73, %c2_i64_206 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_207 = arith.constant 1 : i64
    %599 = openfhe.lwe_mul_const %596, %164, %c1_i64_207 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %600 = openfhe.lwe_add %596, %597, %598 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %601 = openfhe.lwe_add %596, %600, %599 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %602 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %603 = openfhe.eval_func %arg0, %602, %601 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %604 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_208 = arith.constant 4 : i64
    %605 = openfhe.lwe_mul_const %604, %556, %c4_i64_208 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_209 = arith.constant 2 : i64
    %606 = openfhe.lwe_mul_const %604, %271, %c2_i64_209 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_210 = arith.constant 1 : i64
    %607 = openfhe.lwe_mul_const %604, %24, %c1_i64_210 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %608 = openfhe.lwe_add %604, %605, %606 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %609 = openfhe.lwe_add %604, %608, %607 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %610 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %611 = openfhe.eval_func %arg0, %610, %609 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %612 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_211 = arith.constant 4 : i64
    %613 = openfhe.lwe_mul_const %612, %611, %c4_i64_211 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_212 = arith.constant 2 : i64
    %614 = openfhe.lwe_mul_const %612, %246, %c2_i64_212 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_213 = arith.constant 1 : i64
    %615 = openfhe.lwe_mul_const %612, %31, %c1_i64_213 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %616 = openfhe.lwe_add %612, %613, %614 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %617 = openfhe.lwe_add %612, %616, %615 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %618 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %619 = openfhe.eval_func %arg0, %618, %617 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %620 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_214 = arith.constant 4 : i64
    %621 = openfhe.lwe_mul_const %620, %619, %c4_i64_214 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_215 = arith.constant 2 : i64
    %622 = openfhe.lwe_mul_const %620, %603, %c2_i64_215 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_216 = arith.constant 1 : i64
    %623 = openfhe.lwe_mul_const %620, %588, %c1_i64_216 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %624 = openfhe.lwe_add %620, %621, %622 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %625 = openfhe.lwe_add %620, %624, %623 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %626 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %627 = openfhe.eval_func %arg0, %626, %625 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %628 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_217 = arith.constant 4 : i64
    %629 = openfhe.lwe_mul_const %628, %413, %c4_i64_217 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_218 = arith.constant 2 : i64
    %630 = openfhe.lwe_mul_const %628, %429, %c2_i64_218 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_219 = arith.constant 1 : i64
    %631 = openfhe.lwe_mul_const %628, %405, %c1_i64_219 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %632 = openfhe.lwe_add %628, %629, %630 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %633 = openfhe.lwe_add %628, %632, %631 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %634 = openfhe.make_lut %arg0 {values = array<i32: 0, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %635 = openfhe.eval_func %arg0, %634, %633 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %636 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_220 = arith.constant 4 : i64
    %637 = openfhe.lwe_mul_const %636, %635, %c4_i64_220 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_221 = arith.constant 2 : i64
    %638 = openfhe.lwe_mul_const %636, %467, %c2_i64_221 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_222 = arith.constant 1 : i64
    %639 = openfhe.lwe_mul_const %636, %453, %c1_i64_222 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %640 = openfhe.lwe_add %636, %637, %638 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %641 = openfhe.lwe_add %636, %640, %639 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %642 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %643 = openfhe.eval_func %arg0, %642, %641 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %644 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_223 = arith.constant 4 : i64
    %645 = openfhe.lwe_mul_const %644, %643, %c4_i64_223 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_224 = arith.constant 2 : i64
    %646 = openfhe.lwe_mul_const %644, %627, %c2_i64_224 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_225 = arith.constant 1 : i64
    %647 = openfhe.lwe_mul_const %644, %572, %c1_i64_225 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %648 = openfhe.lwe_add %644, %645, %646 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %649 = openfhe.lwe_add %644, %648, %647 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %650 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %651 = openfhe.eval_func %arg0, %650, %649 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %652 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_226 = arith.constant 4 : i64
    %653 = openfhe.lwe_mul_const %652, %651, %c4_i64_226 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_227 = arith.constant 2 : i64
    %654 = openfhe.lwe_mul_const %652, %531, %c2_i64_227 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_228 = arith.constant 1 : i64
    %655 = openfhe.lwe_mul_const %652, %523, %c1_i64_228 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %656 = openfhe.lwe_add %652, %653, %654 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %657 = openfhe.lwe_add %652, %656, %655 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %658 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %659 = openfhe.eval_func %arg0, %658, %657 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %660 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_229 = arith.constant 2 : i64
    %661 = openfhe.lwe_mul_const %660, %659, %c2_i64_229 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_230 = arith.constant 1 : i64
    %662 = openfhe.lwe_mul_const %660, %515, %c1_i64_230 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %663 = openfhe.lwe_add %660, %661, %662 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %664 = openfhe.make_lut %arg0 {values = array<i32: 0, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %665 = openfhe.eval_func %arg0, %664, %663 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %666 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_231 = arith.constant 4 : i64
    %667 = openfhe.lwe_mul_const %666, %107, %c4_i64_231 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_232 = arith.constant 2 : i64
    %668 = openfhe.lwe_mul_const %666, %113, %c2_i64_232 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_233 = arith.constant 1 : i64
    %669 = openfhe.lwe_mul_const %666, %127, %c1_i64_233 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %670 = openfhe.lwe_add %666, %667, %668 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %671 = openfhe.lwe_add %666, %670, %669 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %672 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 3, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %673 = openfhe.eval_func %arg0, %672, %671 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %7, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %23, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %53, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %673, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %209, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %347, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %507, %alloc[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %665, %alloc[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    return %alloc : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
  }
}

