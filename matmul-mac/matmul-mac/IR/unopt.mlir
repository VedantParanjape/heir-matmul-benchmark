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
    %2 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64 = arith.constant 2 : i64
    %3 = openfhe.lwe_mul_const %2, %0, %c2_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64 = arith.constant 1 : i64
    %4 = openfhe.lwe_mul_const %2, %1, %c1_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %5 = openfhe.lwe_add %2, %3, %4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %6 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %7 = openfhe.eval_func %arg0, %6, %5 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %8 = memref.load %arg2[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %9 = memref.load %arg1[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %10 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64 = arith.constant 4 : i64
    %11 = openfhe.lwe_mul_const %10, %7, %c4_i64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_0 = arith.constant 2 : i64
    %12 = openfhe.lwe_mul_const %10, %8, %c2_i64_0 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_1 = arith.constant 1 : i64
    %13 = openfhe.lwe_mul_const %10, %9, %c1_i64_1 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %14 = openfhe.lwe_add %10, %11, %12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %15 = openfhe.lwe_add %10, %14, %13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %16 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %17 = openfhe.eval_func %arg0, %16, %15 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %18 = memref.load %arg3[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %19 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_2 = arith.constant 4 : i64
    %20 = openfhe.lwe_mul_const %19, %18, %c4_i64_2 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_3 = arith.constant 2 : i64
    %21 = openfhe.lwe_mul_const %19, %0, %c2_i64_3 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_4 = arith.constant 1 : i64
    %22 = openfhe.lwe_mul_const %19, %9, %c1_i64_4 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %23 = openfhe.lwe_add %19, %20, %21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %24 = openfhe.lwe_add %19, %23, %22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %25 = openfhe.make_lut %arg0 {values = array<i32: 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %26 = openfhe.eval_func %arg0, %25, %24 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %27 = memref.load %arg3[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %28 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_5 = arith.constant 4 : i64
    %29 = openfhe.lwe_mul_const %28, %27, %c4_i64_5 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_6 = arith.constant 2 : i64
    %30 = openfhe.lwe_mul_const %28, %26, %c2_i64_6 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_7 = arith.constant 1 : i64
    %31 = openfhe.lwe_mul_const %28, %17, %c1_i64_7 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %32 = openfhe.lwe_add %28, %29, %30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %33 = openfhe.lwe_add %28, %32, %31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %34 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %35 = openfhe.eval_func %arg0, %34, %33 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %36 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_8 = arith.constant 4 : i64
    %37 = openfhe.lwe_mul_const %36, %27, %c4_i64_8 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_9 = arith.constant 2 : i64
    %38 = openfhe.lwe_mul_const %36, %26, %c2_i64_9 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_10 = arith.constant 1 : i64
    %39 = openfhe.lwe_mul_const %36, %17, %c1_i64_10 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %40 = openfhe.lwe_add %36, %37, %38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %41 = openfhe.lwe_add %36, %40, %39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %42 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %43 = openfhe.eval_func %arg0, %42, %41 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %44 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_11 = arith.constant 4 : i64
    %45 = openfhe.lwe_mul_const %44, %8, %c4_i64_11 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_12 = arith.constant 2 : i64
    %46 = openfhe.lwe_mul_const %44, %9, %c2_i64_12 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_13 = arith.constant 1 : i64
    %47 = openfhe.lwe_mul_const %44, %7, %c1_i64_13 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %48 = openfhe.lwe_add %44, %45, %46 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %49 = openfhe.lwe_add %44, %48, %47 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %50 = openfhe.make_lut %arg0 {values = array<i32: 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %51 = openfhe.eval_func %arg0, %50, %49 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %52 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_14 = arith.constant 2 : i64
    %53 = openfhe.lwe_mul_const %52, %1, %c2_i64_14 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_15 = arith.constant 1 : i64
    %54 = openfhe.lwe_mul_const %52, %8, %c1_i64_15 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %55 = openfhe.lwe_add %52, %53, %54 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %56 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %57 = openfhe.eval_func %arg0, %56, %55 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %58 = memref.load %arg2[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %59 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_16 = arith.constant 2 : i64
    %60 = openfhe.lwe_mul_const %59, %58, %c2_i64_16 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_17 = arith.constant 1 : i64
    %61 = openfhe.lwe_mul_const %59, %9, %c1_i64_17 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %62 = openfhe.lwe_add %59, %60, %61 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %63 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %64 = openfhe.eval_func %arg0, %63, %62 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %65 = memref.load %arg1[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %66 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_18 = arith.constant 2 : i64
    %67 = openfhe.lwe_mul_const %66, %0, %c2_i64_18 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_19 = arith.constant 1 : i64
    %68 = openfhe.lwe_mul_const %66, %65, %c1_i64_19 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %69 = openfhe.lwe_add %66, %67, %68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %70 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %71 = openfhe.eval_func %arg0, %70, %69 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %72 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_20 = arith.constant 4 : i64
    %73 = openfhe.lwe_mul_const %72, %71, %c4_i64_20 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_21 = arith.constant 2 : i64
    %74 = openfhe.lwe_mul_const %72, %64, %c2_i64_21 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_22 = arith.constant 1 : i64
    %75 = openfhe.lwe_mul_const %72, %57, %c1_i64_22 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %76 = openfhe.lwe_add %72, %73, %74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %77 = openfhe.lwe_add %72, %76, %75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %78 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %79 = openfhe.eval_func %arg0, %78, %77 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %80 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_23 = arith.constant 2 : i64
    %81 = openfhe.lwe_mul_const %80, %79, %c2_i64_23 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_24 = arith.constant 1 : i64
    %82 = openfhe.lwe_mul_const %80, %51, %c1_i64_24 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %83 = openfhe.lwe_add %80, %81, %82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %84 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %85 = openfhe.eval_func %arg0, %84, %83 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %86 = memref.load %arg3[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %87 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_25 = arith.constant 4 : i64
    %88 = openfhe.lwe_mul_const %87, %86, %c4_i64_25 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_26 = arith.constant 2 : i64
    %89 = openfhe.lwe_mul_const %87, %85, %c2_i64_26 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_27 = arith.constant 1 : i64
    %90 = openfhe.lwe_mul_const %87, %43, %c1_i64_27 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %91 = openfhe.lwe_add %87, %88, %89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %92 = openfhe.lwe_add %87, %91, %90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %93 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %94 = openfhe.eval_func %arg0, %93, %92 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %95 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_28 = arith.constant 4 : i64
    %96 = openfhe.lwe_mul_const %95, %86, %c4_i64_28 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_29 = arith.constant 2 : i64
    %97 = openfhe.lwe_mul_const %95, %85, %c2_i64_29 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_30 = arith.constant 1 : i64
    %98 = openfhe.lwe_mul_const %95, %43, %c1_i64_30 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %99 = openfhe.lwe_add %95, %96, %97 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %100 = openfhe.lwe_add %95, %99, %98 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %101 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %102 = openfhe.eval_func %arg0, %101, %100 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %103 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_31 = arith.constant 2 : i64
    %104 = openfhe.lwe_mul_const %103, %79, %c2_i64_31 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_32 = arith.constant 1 : i64
    %105 = openfhe.lwe_mul_const %103, %51, %c1_i64_32 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %106 = openfhe.lwe_add %103, %104, %105 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %107 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %108 = openfhe.eval_func %arg0, %107, %106 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %109 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_33 = arith.constant 4 : i64
    %110 = openfhe.lwe_mul_const %109, %71, %c4_i64_33 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_34 = arith.constant 2 : i64
    %111 = openfhe.lwe_mul_const %109, %64, %c2_i64_34 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_35 = arith.constant 1 : i64
    %112 = openfhe.lwe_mul_const %109, %57, %c1_i64_35 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %113 = openfhe.lwe_add %109, %110, %111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %114 = openfhe.lwe_add %109, %113, %112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %115 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %116 = openfhe.eval_func %arg0, %115, %114 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %117 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_36 = arith.constant 2 : i64
    %118 = openfhe.lwe_mul_const %117, %65, %c2_i64_36 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_37 = arith.constant 1 : i64
    %119 = openfhe.lwe_mul_const %117, %8, %c1_i64_37 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %120 = openfhe.lwe_add %117, %118, %119 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %121 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %122 = openfhe.eval_func %arg0, %121, %120 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %123 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_38 = arith.constant 2 : i64
    %124 = openfhe.lwe_mul_const %123, %58, %c2_i64_38 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_39 = arith.constant 1 : i64
    %125 = openfhe.lwe_mul_const %123, %1, %c1_i64_39 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %126 = openfhe.lwe_add %123, %124, %125 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %127 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %128 = openfhe.eval_func %arg0, %127, %126 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %129 = memref.load %arg1[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %130 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_40 = arith.constant 2 : i64
    %131 = openfhe.lwe_mul_const %130, %0, %c2_i64_40 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_41 = arith.constant 1 : i64
    %132 = openfhe.lwe_mul_const %130, %129, %c1_i64_41 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %133 = openfhe.lwe_add %130, %131, %132 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %134 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %135 = openfhe.eval_func %arg0, %134, %133 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %136 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_42 = arith.constant 4 : i64
    %137 = openfhe.lwe_mul_const %136, %135, %c4_i64_42 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_43 = arith.constant 2 : i64
    %138 = openfhe.lwe_mul_const %136, %128, %c2_i64_43 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_44 = arith.constant 1 : i64
    %139 = openfhe.lwe_mul_const %136, %122, %c1_i64_44 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %140 = openfhe.lwe_add %136, %137, %138 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %141 = openfhe.lwe_add %136, %140, %139 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %142 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %143 = openfhe.eval_func %arg0, %142, %141 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %144 = memref.load %arg2[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %145 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_45 = arith.constant 2 : i64
    %146 = openfhe.lwe_mul_const %145, %144, %c2_i64_45 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_46 = arith.constant 1 : i64
    %147 = openfhe.lwe_mul_const %145, %9, %c1_i64_46 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %148 = openfhe.lwe_add %145, %146, %147 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %149 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %150 = openfhe.eval_func %arg0, %149, %148 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %151 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_47 = arith.constant 4 : i64
    %152 = openfhe.lwe_mul_const %151, %150, %c4_i64_47 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_48 = arith.constant 2 : i64
    %153 = openfhe.lwe_mul_const %151, %143, %c2_i64_48 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_49 = arith.constant 1 : i64
    %154 = openfhe.lwe_mul_const %151, %116, %c1_i64_49 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %155 = openfhe.lwe_add %151, %152, %153 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %156 = openfhe.lwe_add %151, %155, %154 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %157 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %158 = openfhe.eval_func %arg0, %157, %156 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %159 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_50 = arith.constant 2 : i64
    %160 = openfhe.lwe_mul_const %159, %158, %c2_i64_50 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_51 = arith.constant 1 : i64
    %161 = openfhe.lwe_mul_const %159, %108, %c1_i64_51 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %162 = openfhe.lwe_add %159, %160, %161 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %163 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %164 = openfhe.eval_func %arg0, %163, %162 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %165 = memref.load %arg3[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %166 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_52 = arith.constant 4 : i64
    %167 = openfhe.lwe_mul_const %166, %165, %c4_i64_52 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_53 = arith.constant 2 : i64
    %168 = openfhe.lwe_mul_const %166, %164, %c2_i64_53 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_54 = arith.constant 1 : i64
    %169 = openfhe.lwe_mul_const %166, %102, %c1_i64_54 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %170 = openfhe.lwe_add %166, %167, %168 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %171 = openfhe.lwe_add %166, %170, %169 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %172 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %173 = openfhe.eval_func %arg0, %172, %171 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %174 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_55 = arith.constant 4 : i64
    %175 = openfhe.lwe_mul_const %174, %165, %c4_i64_55 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_56 = arith.constant 2 : i64
    %176 = openfhe.lwe_mul_const %174, %164, %c2_i64_56 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_57 = arith.constant 1 : i64
    %177 = openfhe.lwe_mul_const %174, %102, %c1_i64_57 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %178 = openfhe.lwe_add %174, %175, %176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %179 = openfhe.lwe_add %174, %178, %177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %180 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %181 = openfhe.eval_func %arg0, %180, %179 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %182 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_58 = arith.constant 2 : i64
    %183 = openfhe.lwe_mul_const %182, %158, %c2_i64_58 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_59 = arith.constant 1 : i64
    %184 = openfhe.lwe_mul_const %182, %108, %c1_i64_59 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %185 = openfhe.lwe_add %182, %183, %184 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %186 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %187 = openfhe.eval_func %arg0, %186, %185 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %188 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_60 = arith.constant 4 : i64
    %189 = openfhe.lwe_mul_const %188, %150, %c4_i64_60 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_61 = arith.constant 2 : i64
    %190 = openfhe.lwe_mul_const %188, %143, %c2_i64_61 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_62 = arith.constant 1 : i64
    %191 = openfhe.lwe_mul_const %188, %116, %c1_i64_62 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %192 = openfhe.lwe_add %188, %189, %190 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %193 = openfhe.lwe_add %188, %192, %191 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %194 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %195 = openfhe.eval_func %arg0, %194, %193 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %196 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_63 = arith.constant 4 : i64
    %197 = openfhe.lwe_mul_const %196, %135, %c4_i64_63 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_64 = arith.constant 2 : i64
    %198 = openfhe.lwe_mul_const %196, %128, %c2_i64_64 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_65 = arith.constant 1 : i64
    %199 = openfhe.lwe_mul_const %196, %122, %c1_i64_65 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %200 = openfhe.lwe_add %196, %197, %198 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %201 = openfhe.lwe_add %196, %200, %199 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %202 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %203 = openfhe.eval_func %arg0, %202, %201 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %204 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_66 = arith.constant 2 : i64
    %205 = openfhe.lwe_mul_const %204, %129, %c2_i64_66 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_67 = arith.constant 1 : i64
    %206 = openfhe.lwe_mul_const %204, %8, %c1_i64_67 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %207 = openfhe.lwe_add %204, %205, %206 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %208 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %209 = openfhe.eval_func %arg0, %208, %207 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %210 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_68 = arith.constant 2 : i64
    %211 = openfhe.lwe_mul_const %210, %58, %c2_i64_68 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_69 = arith.constant 1 : i64
    %212 = openfhe.lwe_mul_const %210, %65, %c1_i64_69 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %213 = openfhe.lwe_add %210, %211, %212 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %214 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %215 = openfhe.eval_func %arg0, %214, %213 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %216 = memref.load %arg1[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %217 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_70 = arith.constant 2 : i64
    %218 = openfhe.lwe_mul_const %217, %0, %c2_i64_70 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_71 = arith.constant 1 : i64
    %219 = openfhe.lwe_mul_const %217, %216, %c1_i64_71 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %220 = openfhe.lwe_add %217, %218, %219 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %221 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %222 = openfhe.eval_func %arg0, %221, %220 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %223 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_72 = arith.constant 4 : i64
    %224 = openfhe.lwe_mul_const %223, %222, %c4_i64_72 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_73 = arith.constant 2 : i64
    %225 = openfhe.lwe_mul_const %223, %215, %c2_i64_73 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_74 = arith.constant 1 : i64
    %226 = openfhe.lwe_mul_const %223, %209, %c1_i64_74 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %227 = openfhe.lwe_add %223, %224, %225 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %228 = openfhe.lwe_add %223, %227, %226 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %229 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %230 = openfhe.eval_func %arg0, %229, %228 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %231 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_75 = arith.constant 2 : i64
    %232 = openfhe.lwe_mul_const %231, %144, %c2_i64_75 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_76 = arith.constant 1 : i64
    %233 = openfhe.lwe_mul_const %231, %1, %c1_i64_76 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %234 = openfhe.lwe_add %231, %232, %233 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %235 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %236 = openfhe.eval_func %arg0, %235, %234 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %237 = memref.load %arg2[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %238 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_77 = arith.constant 4 : i64
    %239 = openfhe.lwe_mul_const %238, %236, %c4_i64_77 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_78 = arith.constant 2 : i64
    %240 = openfhe.lwe_mul_const %238, %237, %c2_i64_78 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_79 = arith.constant 1 : i64
    %241 = openfhe.lwe_mul_const %238, %9, %c1_i64_79 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %242 = openfhe.lwe_add %238, %239, %240 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %243 = openfhe.lwe_add %238, %242, %241 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %244 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %245 = openfhe.eval_func %arg0, %244, %243 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %246 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_80 = arith.constant 4 : i64
    %247 = openfhe.lwe_mul_const %246, %245, %c4_i64_80 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_81 = arith.constant 2 : i64
    %248 = openfhe.lwe_mul_const %246, %230, %c2_i64_81 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_82 = arith.constant 1 : i64
    %249 = openfhe.lwe_mul_const %246, %203, %c1_i64_82 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %250 = openfhe.lwe_add %246, %247, %248 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %251 = openfhe.lwe_add %246, %250, %249 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %252 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %253 = openfhe.eval_func %arg0, %252, %251 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %254 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_83 = arith.constant 2 : i64
    %255 = openfhe.lwe_mul_const %254, %253, %c2_i64_83 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_84 = arith.constant 1 : i64
    %256 = openfhe.lwe_mul_const %254, %195, %c1_i64_84 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %257 = openfhe.lwe_add %254, %255, %256 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %258 = openfhe.make_lut %arg0 {values = array<i32: 0, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %259 = openfhe.eval_func %arg0, %258, %257 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %260 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_85 = arith.constant 2 : i64
    %261 = openfhe.lwe_mul_const %260, %259, %c2_i64_85 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_86 = arith.constant 1 : i64
    %262 = openfhe.lwe_mul_const %260, %187, %c1_i64_86 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %263 = openfhe.lwe_add %260, %261, %262 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %264 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %265 = openfhe.eval_func %arg0, %264, %263 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %266 = memref.load %arg3[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %267 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_87 = arith.constant 4 : i64
    %268 = openfhe.lwe_mul_const %267, %266, %c4_i64_87 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_88 = arith.constant 2 : i64
    %269 = openfhe.lwe_mul_const %267, %265, %c2_i64_88 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_89 = arith.constant 1 : i64
    %270 = openfhe.lwe_mul_const %267, %181, %c1_i64_89 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %271 = openfhe.lwe_add %267, %268, %269 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %272 = openfhe.lwe_add %267, %271, %270 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %273 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %274 = openfhe.eval_func %arg0, %273, %272 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %275 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_90 = arith.constant 4 : i64
    %276 = openfhe.lwe_mul_const %275, %266, %c4_i64_90 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_91 = arith.constant 2 : i64
    %277 = openfhe.lwe_mul_const %275, %265, %c2_i64_91 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_92 = arith.constant 1 : i64
    %278 = openfhe.lwe_mul_const %275, %181, %c1_i64_92 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %279 = openfhe.lwe_add %275, %276, %277 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %280 = openfhe.lwe_add %275, %279, %278 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %281 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %282 = openfhe.eval_func %arg0, %281, %280 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %283 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_93 = arith.constant 2 : i64
    %284 = openfhe.lwe_mul_const %283, %259, %c2_i64_93 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_94 = arith.constant 1 : i64
    %285 = openfhe.lwe_mul_const %283, %187, %c1_i64_94 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %286 = openfhe.lwe_add %283, %284, %285 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %287 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %288 = openfhe.eval_func %arg0, %287, %286 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %289 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_95 = arith.constant 2 : i64
    %290 = openfhe.lwe_mul_const %289, %253, %c2_i64_95 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_96 = arith.constant 1 : i64
    %291 = openfhe.lwe_mul_const %289, %195, %c1_i64_96 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %292 = openfhe.lwe_add %289, %290, %291 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %293 = openfhe.make_lut %arg0 {values = array<i32: 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %294 = openfhe.eval_func %arg0, %293, %292 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %295 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_97 = arith.constant 4 : i64
    %296 = openfhe.lwe_mul_const %295, %245, %c4_i64_97 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_98 = arith.constant 2 : i64
    %297 = openfhe.lwe_mul_const %295, %230, %c2_i64_98 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_99 = arith.constant 1 : i64
    %298 = openfhe.lwe_mul_const %295, %203, %c1_i64_99 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %299 = openfhe.lwe_add %295, %296, %297 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %300 = openfhe.lwe_add %295, %299, %298 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %301 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %302 = openfhe.eval_func %arg0, %301, %300 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %303 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_100 = arith.constant 4 : i64
    %304 = openfhe.lwe_mul_const %303, %222, %c4_i64_100 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_101 = arith.constant 2 : i64
    %305 = openfhe.lwe_mul_const %303, %215, %c2_i64_101 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_102 = arith.constant 1 : i64
    %306 = openfhe.lwe_mul_const %303, %209, %c1_i64_102 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %307 = openfhe.lwe_add %303, %304, %305 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %308 = openfhe.lwe_add %303, %307, %306 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %309 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %310 = openfhe.eval_func %arg0, %309, %308 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %311 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_103 = arith.constant 2 : i64
    %312 = openfhe.lwe_mul_const %311, %216, %c2_i64_103 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_104 = arith.constant 1 : i64
    %313 = openfhe.lwe_mul_const %311, %8, %c1_i64_104 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %314 = openfhe.lwe_add %311, %312, %313 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %315 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %316 = openfhe.eval_func %arg0, %315, %314 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %317 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_105 = arith.constant 2 : i64
    %318 = openfhe.lwe_mul_const %317, %58, %c2_i64_105 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_106 = arith.constant 1 : i64
    %319 = openfhe.lwe_mul_const %317, %129, %c1_i64_106 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %320 = openfhe.lwe_add %317, %318, %319 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %321 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %322 = openfhe.eval_func %arg0, %321, %320 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %323 = memref.load %arg1[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %324 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_107 = arith.constant 2 : i64
    %325 = openfhe.lwe_mul_const %324, %0, %c2_i64_107 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_108 = arith.constant 1 : i64
    %326 = openfhe.lwe_mul_const %324, %323, %c1_i64_108 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %327 = openfhe.lwe_add %324, %325, %326 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %328 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %329 = openfhe.eval_func %arg0, %328, %327 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %330 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_109 = arith.constant 4 : i64
    %331 = openfhe.lwe_mul_const %330, %329, %c4_i64_109 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_110 = arith.constant 2 : i64
    %332 = openfhe.lwe_mul_const %330, %322, %c2_i64_110 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_111 = arith.constant 1 : i64
    %333 = openfhe.lwe_mul_const %330, %316, %c1_i64_111 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %334 = openfhe.lwe_add %330, %331, %332 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %335 = openfhe.lwe_add %330, %334, %333 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %336 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %337 = openfhe.eval_func %arg0, %336, %335 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %338 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_112 = arith.constant 2 : i64
    %339 = openfhe.lwe_mul_const %338, %237, %c2_i64_112 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_113 = arith.constant 1 : i64
    %340 = openfhe.lwe_mul_const %338, %1, %c1_i64_113 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %341 = openfhe.lwe_add %338, %339, %340 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %342 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %343 = openfhe.eval_func %arg0, %342, %341 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %344 = memref.load %arg2[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %345 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_114 = arith.constant 2 : i64
    %346 = openfhe.lwe_mul_const %345, %344, %c2_i64_114 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_115 = arith.constant 1 : i64
    %347 = openfhe.lwe_mul_const %345, %9, %c1_i64_115 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %348 = openfhe.lwe_add %345, %346, %347 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %349 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %350 = openfhe.eval_func %arg0, %349, %348 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %351 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_116 = arith.constant 2 : i64
    %352 = openfhe.lwe_mul_const %351, %144, %c2_i64_116 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_117 = arith.constant 1 : i64
    %353 = openfhe.lwe_mul_const %351, %65, %c1_i64_117 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %354 = openfhe.lwe_add %351, %352, %353 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %355 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %356 = openfhe.eval_func %arg0, %355, %354 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %357 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_118 = arith.constant 4 : i64
    %358 = openfhe.lwe_mul_const %357, %356, %c4_i64_118 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_119 = arith.constant 2 : i64
    %359 = openfhe.lwe_mul_const %357, %350, %c2_i64_119 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_120 = arith.constant 1 : i64
    %360 = openfhe.lwe_mul_const %357, %343, %c1_i64_120 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %361 = openfhe.lwe_add %357, %358, %359 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %362 = openfhe.lwe_add %357, %361, %360 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %363 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %364 = openfhe.eval_func %arg0, %363, %362 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %365 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_121 = arith.constant 4 : i64
    %366 = openfhe.lwe_mul_const %365, %364, %c4_i64_121 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_122 = arith.constant 2 : i64
    %367 = openfhe.lwe_mul_const %365, %337, %c2_i64_122 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_123 = arith.constant 1 : i64
    %368 = openfhe.lwe_mul_const %365, %310, %c1_i64_123 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %369 = openfhe.lwe_add %365, %366, %367 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %370 = openfhe.lwe_add %365, %369, %368 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %371 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %372 = openfhe.eval_func %arg0, %371, %370 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %373 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_124 = arith.constant 2 : i64
    %374 = openfhe.lwe_mul_const %373, %343, %c2_i64_124 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_125 = arith.constant 1 : i64
    %375 = openfhe.lwe_mul_const %373, %150, %c1_i64_125 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %376 = openfhe.lwe_add %373, %374, %375 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %377 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %378 = openfhe.eval_func %arg0, %377, %376 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %379 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_126 = arith.constant 4 : i64
    %380 = openfhe.lwe_mul_const %379, %378, %c4_i64_126 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_127 = arith.constant 2 : i64
    %381 = openfhe.lwe_mul_const %379, %372, %c2_i64_127 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_128 = arith.constant 1 : i64
    %382 = openfhe.lwe_mul_const %379, %302, %c1_i64_128 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %383 = openfhe.lwe_add %379, %380, %381 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %384 = openfhe.lwe_add %379, %383, %382 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %385 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %386 = openfhe.eval_func %arg0, %385, %384 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %387 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_129 = arith.constant 2 : i64
    %388 = openfhe.lwe_mul_const %387, %386, %c2_i64_129 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_130 = arith.constant 1 : i64
    %389 = openfhe.lwe_mul_const %387, %294, %c1_i64_130 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %390 = openfhe.lwe_add %387, %388, %389 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %391 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %392 = openfhe.eval_func %arg0, %391, %390 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %393 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_131 = arith.constant 2 : i64
    %394 = openfhe.lwe_mul_const %393, %392, %c2_i64_131 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_132 = arith.constant 1 : i64
    %395 = openfhe.lwe_mul_const %393, %288, %c1_i64_132 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %396 = openfhe.lwe_add %393, %394, %395 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %397 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %398 = openfhe.eval_func %arg0, %397, %396 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %399 = memref.load %arg3[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %400 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_133 = arith.constant 4 : i64
    %401 = openfhe.lwe_mul_const %400, %399, %c4_i64_133 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_134 = arith.constant 2 : i64
    %402 = openfhe.lwe_mul_const %400, %398, %c2_i64_134 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_135 = arith.constant 1 : i64
    %403 = openfhe.lwe_mul_const %400, %282, %c1_i64_135 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %404 = openfhe.lwe_add %400, %401, %402 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %405 = openfhe.lwe_add %400, %404, %403 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %406 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %407 = openfhe.eval_func %arg0, %406, %405 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %408 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_136 = arith.constant 4 : i64
    %409 = openfhe.lwe_mul_const %408, %399, %c4_i64_136 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_137 = arith.constant 2 : i64
    %410 = openfhe.lwe_mul_const %408, %398, %c2_i64_137 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_138 = arith.constant 1 : i64
    %411 = openfhe.lwe_mul_const %408, %282, %c1_i64_138 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %412 = openfhe.lwe_add %408, %409, %410 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %413 = openfhe.lwe_add %408, %412, %411 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %414 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %415 = openfhe.eval_func %arg0, %414, %413 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %416 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_139 = arith.constant 2 : i64
    %417 = openfhe.lwe_mul_const %416, %392, %c2_i64_139 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_140 = arith.constant 1 : i64
    %418 = openfhe.lwe_mul_const %416, %288, %c1_i64_140 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %419 = openfhe.lwe_add %416, %417, %418 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %420 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %421 = openfhe.eval_func %arg0, %420, %419 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %422 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_141 = arith.constant 2 : i64
    %423 = openfhe.lwe_mul_const %422, %386, %c2_i64_141 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_142 = arith.constant 1 : i64
    %424 = openfhe.lwe_mul_const %422, %294, %c1_i64_142 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %425 = openfhe.lwe_add %422, %423, %424 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %426 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %427 = openfhe.eval_func %arg0, %426, %425 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %428 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_143 = arith.constant 4 : i64
    %429 = openfhe.lwe_mul_const %428, %378, %c4_i64_143 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_144 = arith.constant 2 : i64
    %430 = openfhe.lwe_mul_const %428, %372, %c2_i64_144 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_145 = arith.constant 1 : i64
    %431 = openfhe.lwe_mul_const %428, %302, %c1_i64_145 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %432 = openfhe.lwe_add %428, %429, %430 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %433 = openfhe.lwe_add %428, %432, %431 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %434 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %435 = openfhe.eval_func %arg0, %434, %433 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %436 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_146 = arith.constant 4 : i64
    %437 = openfhe.lwe_mul_const %436, %364, %c4_i64_146 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_147 = arith.constant 2 : i64
    %438 = openfhe.lwe_mul_const %436, %337, %c2_i64_147 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_148 = arith.constant 1 : i64
    %439 = openfhe.lwe_mul_const %436, %310, %c1_i64_148 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %440 = openfhe.lwe_add %436, %437, %438 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %441 = openfhe.lwe_add %436, %440, %439 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %442 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %443 = openfhe.eval_func %arg0, %442, %441 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %444 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_149 = arith.constant 4 : i64
    %445 = openfhe.lwe_mul_const %444, %329, %c4_i64_149 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_150 = arith.constant 2 : i64
    %446 = openfhe.lwe_mul_const %444, %322, %c2_i64_150 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_151 = arith.constant 1 : i64
    %447 = openfhe.lwe_mul_const %444, %316, %c1_i64_151 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %448 = openfhe.lwe_add %444, %445, %446 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %449 = openfhe.lwe_add %444, %448, %447 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %450 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %451 = openfhe.eval_func %arg0, %450, %449 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %452 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_152 = arith.constant 2 : i64
    %453 = openfhe.lwe_mul_const %452, %323, %c2_i64_152 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_153 = arith.constant 1 : i64
    %454 = openfhe.lwe_mul_const %452, %8, %c1_i64_153 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %455 = openfhe.lwe_add %452, %453, %454 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %456 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %457 = openfhe.eval_func %arg0, %456, %455 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %458 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_154 = arith.constant 2 : i64
    %459 = openfhe.lwe_mul_const %458, %58, %c2_i64_154 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_155 = arith.constant 1 : i64
    %460 = openfhe.lwe_mul_const %458, %216, %c1_i64_155 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %461 = openfhe.lwe_add %458, %459, %460 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %462 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %463 = openfhe.eval_func %arg0, %462, %461 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %464 = memref.load %arg1[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %465 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_156 = arith.constant 2 : i64
    %466 = openfhe.lwe_mul_const %465, %0, %c2_i64_156 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_157 = arith.constant 1 : i64
    %467 = openfhe.lwe_mul_const %465, %464, %c1_i64_157 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %468 = openfhe.lwe_add %465, %466, %467 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %469 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %470 = openfhe.eval_func %arg0, %469, %468 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %471 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_158 = arith.constant 4 : i64
    %472 = openfhe.lwe_mul_const %471, %470, %c4_i64_158 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_159 = arith.constant 2 : i64
    %473 = openfhe.lwe_mul_const %471, %463, %c2_i64_159 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_160 = arith.constant 1 : i64
    %474 = openfhe.lwe_mul_const %471, %457, %c1_i64_160 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %475 = openfhe.lwe_add %471, %472, %473 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %476 = openfhe.lwe_add %471, %475, %474 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %477 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %478 = openfhe.eval_func %arg0, %477, %476 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %479 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_161 = arith.constant 2 : i64
    %480 = openfhe.lwe_mul_const %479, %237, %c2_i64_161 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_162 = arith.constant 1 : i64
    %481 = openfhe.lwe_mul_const %479, %65, %c1_i64_162 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %482 = openfhe.lwe_add %479, %480, %481 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %483 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %484 = openfhe.eval_func %arg0, %483, %482 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %485 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_163 = arith.constant 2 : i64
    %486 = openfhe.lwe_mul_const %485, %344, %c2_i64_163 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_164 = arith.constant 1 : i64
    %487 = openfhe.lwe_mul_const %485, %1, %c1_i64_164 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %488 = openfhe.lwe_add %485, %486, %487 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %489 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %490 = openfhe.eval_func %arg0, %489, %488 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %491 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_165 = arith.constant 2 : i64
    %492 = openfhe.lwe_mul_const %491, %144, %c2_i64_165 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_166 = arith.constant 1 : i64
    %493 = openfhe.lwe_mul_const %491, %129, %c1_i64_166 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %494 = openfhe.lwe_add %491, %492, %493 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %495 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %496 = openfhe.eval_func %arg0, %495, %494 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %497 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_167 = arith.constant 4 : i64
    %498 = openfhe.lwe_mul_const %497, %496, %c4_i64_167 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_168 = arith.constant 2 : i64
    %499 = openfhe.lwe_mul_const %497, %490, %c2_i64_168 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_169 = arith.constant 1 : i64
    %500 = openfhe.lwe_mul_const %497, %484, %c1_i64_169 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %501 = openfhe.lwe_add %497, %498, %499 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %502 = openfhe.lwe_add %497, %501, %500 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %503 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %504 = openfhe.eval_func %arg0, %503, %502 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %505 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_170 = arith.constant 4 : i64
    %506 = openfhe.lwe_mul_const %505, %504, %c4_i64_170 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_171 = arith.constant 2 : i64
    %507 = openfhe.lwe_mul_const %505, %478, %c2_i64_171 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_172 = arith.constant 1 : i64
    %508 = openfhe.lwe_mul_const %505, %451, %c1_i64_172 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %509 = openfhe.lwe_add %505, %506, %507 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %510 = openfhe.lwe_add %505, %509, %508 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %511 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %512 = openfhe.eval_func %arg0, %511, %510 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %513 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_173 = arith.constant 4 : i64
    %514 = openfhe.lwe_mul_const %513, %356, %c4_i64_173 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_174 = arith.constant 2 : i64
    %515 = openfhe.lwe_mul_const %513, %350, %c2_i64_174 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_175 = arith.constant 1 : i64
    %516 = openfhe.lwe_mul_const %513, %343, %c1_i64_175 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %517 = openfhe.lwe_add %513, %514, %515 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %518 = openfhe.lwe_add %513, %517, %516 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %519 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %520 = openfhe.eval_func %arg0, %519, %518 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %521 = memref.load %arg2[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %522 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_176 = arith.constant 4 : i64
    %523 = openfhe.lwe_mul_const %522, %520, %c4_i64_176 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_177 = arith.constant 2 : i64
    %524 = openfhe.lwe_mul_const %522, %521, %c2_i64_177 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_178 = arith.constant 1 : i64
    %525 = openfhe.lwe_mul_const %522, %9, %c1_i64_178 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %526 = openfhe.lwe_add %522, %523, %524 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %527 = openfhe.lwe_add %522, %526, %525 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %528 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %529 = openfhe.eval_func %arg0, %528, %527 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %530 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_179 = arith.constant 4 : i64
    %531 = openfhe.lwe_mul_const %530, %529, %c4_i64_179 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_180 = arith.constant 2 : i64
    %532 = openfhe.lwe_mul_const %530, %512, %c2_i64_180 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_181 = arith.constant 1 : i64
    %533 = openfhe.lwe_mul_const %530, %443, %c1_i64_181 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %534 = openfhe.lwe_add %530, %531, %532 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %535 = openfhe.lwe_add %530, %534, %533 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %536 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %537 = openfhe.eval_func %arg0, %536, %535 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %538 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_182 = arith.constant 2 : i64
    %539 = openfhe.lwe_mul_const %538, %537, %c2_i64_182 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_183 = arith.constant 1 : i64
    %540 = openfhe.lwe_mul_const %538, %435, %c1_i64_183 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %541 = openfhe.lwe_add %538, %539, %540 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %542 = openfhe.make_lut %arg0 {values = array<i32: 0, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %543 = openfhe.eval_func %arg0, %542, %541 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %544 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_184 = arith.constant 4 : i64
    %545 = openfhe.lwe_mul_const %544, %543, %c4_i64_184 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_185 = arith.constant 2 : i64
    %546 = openfhe.lwe_mul_const %544, %427, %c2_i64_185 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_186 = arith.constant 1 : i64
    %547 = openfhe.lwe_mul_const %544, %421, %c1_i64_186 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %548 = openfhe.lwe_add %544, %545, %546 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %549 = openfhe.lwe_add %544, %548, %547 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %550 = openfhe.make_lut %arg0 {values = array<i32: 1, 2, 4, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %551 = openfhe.eval_func %arg0, %550, %549 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %552 = memref.load %arg3[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %553 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_187 = arith.constant 4 : i64
    %554 = openfhe.lwe_mul_const %553, %552, %c4_i64_187 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_188 = arith.constant 2 : i64
    %555 = openfhe.lwe_mul_const %553, %551, %c2_i64_188 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_189 = arith.constant 1 : i64
    %556 = openfhe.lwe_mul_const %553, %415, %c1_i64_189 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %557 = openfhe.lwe_add %553, %554, %555 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %558 = openfhe.lwe_add %553, %557, %556 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %559 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %560 = openfhe.eval_func %arg0, %559, %558 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %561 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_190 = arith.constant 4 : i64
    %562 = openfhe.lwe_mul_const %561, %552, %c4_i64_190 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_191 = arith.constant 2 : i64
    %563 = openfhe.lwe_mul_const %561, %551, %c2_i64_191 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_192 = arith.constant 1 : i64
    %564 = openfhe.lwe_mul_const %561, %415, %c1_i64_192 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %565 = openfhe.lwe_add %561, %562, %563 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %566 = openfhe.lwe_add %561, %565, %564 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %567 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %568 = openfhe.eval_func %arg0, %567, %566 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %569 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_193 = arith.constant 4 : i64
    %570 = openfhe.lwe_mul_const %569, %543, %c4_i64_193 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_194 = arith.constant 2 : i64
    %571 = openfhe.lwe_mul_const %569, %427, %c2_i64_194 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_195 = arith.constant 1 : i64
    %572 = openfhe.lwe_mul_const %569, %421, %c1_i64_195 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %573 = openfhe.lwe_add %569, %570, %571 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %574 = openfhe.lwe_add %569, %573, %572 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %575 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %576 = openfhe.eval_func %arg0, %575, %574 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %577 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_196 = arith.constant 2 : i64
    %578 = openfhe.lwe_mul_const %577, %521, %c2_i64_196 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_197 = arith.constant 1 : i64
    %579 = openfhe.lwe_mul_const %577, %1, %c1_i64_197 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %580 = openfhe.lwe_add %577, %578, %579 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %581 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %582 = openfhe.eval_func %arg0, %581, %580 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %583 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_198 = arith.constant 4 : i64
    %584 = openfhe.lwe_mul_const %583, %582, %c4_i64_198 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_199 = arith.constant 2 : i64
    %585 = openfhe.lwe_mul_const %583, %344, %c2_i64_199 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_200 = arith.constant 1 : i64
    %586 = openfhe.lwe_mul_const %583, %65, %c1_i64_200 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %587 = openfhe.lwe_add %583, %584, %585 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %588 = openfhe.lwe_add %583, %587, %586 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %589 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %590 = openfhe.eval_func %arg0, %589, %588 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %591 = memref.load %arg2[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %592 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_201 = arith.constant 4 : i64
    %593 = openfhe.lwe_mul_const %592, %590, %c4_i64_201 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_202 = arith.constant 2 : i64
    %594 = openfhe.lwe_mul_const %592, %591, %c2_i64_202 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_203 = arith.constant 1 : i64
    %595 = openfhe.lwe_mul_const %592, %9, %c1_i64_203 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %596 = openfhe.lwe_add %592, %593, %594 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %597 = openfhe.lwe_add %592, %596, %595 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %598 = openfhe.make_lut %arg0 {values = array<i32: 2, 4, 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %599 = openfhe.eval_func %arg0, %598, %597 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %600 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_204 = arith.constant 2 : i64
    %601 = openfhe.lwe_mul_const %600, %144, %c2_i64_204 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_205 = arith.constant 1 : i64
    %602 = openfhe.lwe_mul_const %600, %216, %c1_i64_205 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %603 = openfhe.lwe_add %600, %601, %602 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %604 = openfhe.make_lut %arg0 {values = array<i32: 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %605 = openfhe.eval_func %arg0, %604, %603 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %606 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_206 = arith.constant 4 : i64
    %607 = openfhe.lwe_mul_const %606, %605, %c4_i64_206 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_207 = arith.constant 2 : i64
    %608 = openfhe.lwe_mul_const %606, %58, %c2_i64_207 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_208 = arith.constant 1 : i64
    %609 = openfhe.lwe_mul_const %606, %323, %c1_i64_208 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %610 = openfhe.lwe_add %606, %607, %608 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %611 = openfhe.lwe_add %606, %610, %609 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %612 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %613 = openfhe.eval_func %arg0, %612, %611 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %614 = memref.load %arg1[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %615 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_209 = arith.constant 4 : i64
    %616 = openfhe.lwe_mul_const %615, %591, %c4_i64_209 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_210 = arith.constant 2 : i64
    %617 = openfhe.lwe_mul_const %615, %614, %c2_i64_210 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_211 = arith.constant 1 : i64
    %618 = openfhe.lwe_mul_const %615, %0, %c1_i64_211 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %619 = openfhe.lwe_add %615, %616, %617 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %620 = openfhe.lwe_add %615, %619, %618 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %621 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %622 = openfhe.eval_func %arg0, %621, %620 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %623 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_212 = arith.constant 4 : i64
    %624 = openfhe.lwe_mul_const %623, %622, %c4_i64_212 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_213 = arith.constant 2 : i64
    %625 = openfhe.lwe_mul_const %623, %464, %c2_i64_213 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_214 = arith.constant 1 : i64
    %626 = openfhe.lwe_mul_const %623, %8, %c1_i64_214 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %627 = openfhe.lwe_add %623, %624, %625 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %628 = openfhe.lwe_add %623, %627, %626 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %629 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %630 = openfhe.eval_func %arg0, %629, %628 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %631 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_215 = arith.constant 4 : i64
    %632 = openfhe.lwe_mul_const %631, %630, %c4_i64_215 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_216 = arith.constant 2 : i64
    %633 = openfhe.lwe_mul_const %631, %613, %c2_i64_216 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_217 = arith.constant 1 : i64
    %634 = openfhe.lwe_mul_const %631, %599, %c1_i64_217 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %635 = openfhe.lwe_add %631, %632, %633 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %636 = openfhe.lwe_add %631, %635, %634 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %637 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %638 = openfhe.eval_func %arg0, %637, %636 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %639 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_218 = arith.constant 4 : i64
    %640 = openfhe.lwe_mul_const %639, %521, %c4_i64_218 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_219 = arith.constant 2 : i64
    %641 = openfhe.lwe_mul_const %639, %9, %c2_i64_219 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_220 = arith.constant 1 : i64
    %642 = openfhe.lwe_mul_const %639, %520, %c1_i64_220 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %643 = openfhe.lwe_add %639, %640, %641 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %644 = openfhe.lwe_add %639, %643, %642 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %645 = openfhe.make_lut %arg0 {values = array<i32: 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %646 = openfhe.eval_func %arg0, %645, %644 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %647 = memref.load %arg3[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    %648 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_221 = arith.constant 2 : i64
    %649 = openfhe.lwe_mul_const %648, %647, %c2_i64_221 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_222 = arith.constant 1 : i64
    %650 = openfhe.lwe_mul_const %648, %646, %c1_i64_222 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %651 = openfhe.lwe_add %648, %649, %650 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %652 = openfhe.make_lut %arg0 {values = array<i32: 0, 3>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %653 = openfhe.eval_func %arg0, %652, %651 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %654 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_223 = arith.constant 4 : i64
    %655 = openfhe.lwe_mul_const %654, %470, %c4_i64_223 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_224 = arith.constant 2 : i64
    %656 = openfhe.lwe_mul_const %654, %463, %c2_i64_224 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_225 = arith.constant 1 : i64
    %657 = openfhe.lwe_mul_const %654, %457, %c1_i64_225 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %658 = openfhe.lwe_add %654, %655, %656 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %659 = openfhe.lwe_add %654, %658, %657 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %660 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %661 = openfhe.eval_func %arg0, %660, %659 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %662 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_226 = arith.constant 4 : i64
    %663 = openfhe.lwe_mul_const %662, %661, %c4_i64_226 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_227 = arith.constant 2 : i64
    %664 = openfhe.lwe_mul_const %662, %237, %c2_i64_227 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_228 = arith.constant 1 : i64
    %665 = openfhe.lwe_mul_const %662, %129, %c1_i64_228 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %666 = openfhe.lwe_add %662, %663, %664 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %667 = openfhe.lwe_add %662, %666, %665 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %668 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %669 = openfhe.eval_func %arg0, %668, %667 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %670 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_229 = arith.constant 4 : i64
    %671 = openfhe.lwe_mul_const %670, %669, %c4_i64_229 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_230 = arith.constant 2 : i64
    %672 = openfhe.lwe_mul_const %670, %653, %c2_i64_230 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_231 = arith.constant 1 : i64
    %673 = openfhe.lwe_mul_const %670, %638, %c1_i64_231 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %674 = openfhe.lwe_add %670, %671, %672 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %675 = openfhe.lwe_add %670, %674, %673 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %676 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %677 = openfhe.eval_func %arg0, %676, %675 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %678 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_232 = arith.constant 4 : i64
    %679 = openfhe.lwe_mul_const %678, %529, %c4_i64_232 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_233 = arith.constant 2 : i64
    %680 = openfhe.lwe_mul_const %678, %512, %c2_i64_233 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_234 = arith.constant 1 : i64
    %681 = openfhe.lwe_mul_const %678, %443, %c1_i64_234 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %682 = openfhe.lwe_add %678, %679, %680 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %683 = openfhe.lwe_add %678, %682, %681 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %684 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %685 = openfhe.eval_func %arg0, %684, %683 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %686 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_235 = arith.constant 4 : i64
    %687 = openfhe.lwe_mul_const %686, %685, %c4_i64_235 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_236 = arith.constant 2 : i64
    %688 = openfhe.lwe_mul_const %686, %537, %c2_i64_236 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_237 = arith.constant 1 : i64
    %689 = openfhe.lwe_mul_const %686, %435, %c1_i64_237 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %690 = openfhe.lwe_add %686, %687, %688 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %691 = openfhe.lwe_add %686, %690, %689 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %692 = openfhe.make_lut %arg0 {values = array<i32: 2, 4, 5, 7>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %693 = openfhe.eval_func %arg0, %692, %691 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %694 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_238 = arith.constant 4 : i64
    %695 = openfhe.lwe_mul_const %694, %504, %c4_i64_238 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_239 = arith.constant 2 : i64
    %696 = openfhe.lwe_mul_const %694, %478, %c2_i64_239 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_240 = arith.constant 1 : i64
    %697 = openfhe.lwe_mul_const %694, %451, %c1_i64_240 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %698 = openfhe.lwe_add %694, %695, %696 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %699 = openfhe.lwe_add %694, %698, %697 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %700 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 3, 5>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %701 = openfhe.eval_func %arg0, %700, %699 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %702 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_241 = arith.constant 4 : i64
    %703 = openfhe.lwe_mul_const %702, %496, %c4_i64_241 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_242 = arith.constant 2 : i64
    %704 = openfhe.lwe_mul_const %702, %490, %c2_i64_242 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_243 = arith.constant 1 : i64
    %705 = openfhe.lwe_mul_const %702, %484, %c1_i64_243 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %706 = openfhe.lwe_add %702, %703, %704 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %707 = openfhe.lwe_add %702, %706, %705 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %708 = openfhe.make_lut %arg0 {values = array<i32: 0, 1, 2, 4>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %709 = openfhe.eval_func %arg0, %708, %707 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %710 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c2_i64_244 = arith.constant 2 : i64
    %711 = openfhe.lwe_mul_const %710, %709, %c2_i64_244 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_245 = arith.constant 1 : i64
    %712 = openfhe.lwe_mul_const %710, %701, %c1_i64_245 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %713 = openfhe.lwe_add %710, %711, %712 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %714 = openfhe.make_lut %arg0 {values = array<i32: 1, 2>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %715 = openfhe.eval_func %arg0, %714, %713 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %716 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_246 = arith.constant 4 : i64
    %717 = openfhe.lwe_mul_const %716, %715, %c4_i64_246 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_247 = arith.constant 2 : i64
    %718 = openfhe.lwe_mul_const %716, %693, %c2_i64_247 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_248 = arith.constant 1 : i64
    %719 = openfhe.lwe_mul_const %716, %677, %c1_i64_248 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %720 = openfhe.lwe_add %716, %717, %718 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %721 = openfhe.lwe_add %716, %720, %719 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %722 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %723 = openfhe.eval_func %arg0, %722, %721 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %724 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_249 = arith.constant 4 : i64
    %725 = openfhe.lwe_mul_const %724, %723, %c4_i64_249 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_250 = arith.constant 2 : i64
    %726 = openfhe.lwe_mul_const %724, %576, %c2_i64_250 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_251 = arith.constant 1 : i64
    %727 = openfhe.lwe_mul_const %724, %568, %c1_i64_251 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %728 = openfhe.lwe_add %724, %725, %726 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %729 = openfhe.lwe_add %724, %728, %727 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %730 = openfhe.make_lut %arg0 {values = array<i32: 0, 3, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %731 = openfhe.eval_func %arg0, %730, %729 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %732 = openfhe.get_lwe_scheme %arg0 : (!openfhe.binfhe_context) -> !openfhe.lwe_scheme
    %c4_i64_252 = arith.constant 4 : i64
    %733 = openfhe.lwe_mul_const %732, %18, %c4_i64_252 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c2_i64_253 = arith.constant 2 : i64
    %734 = openfhe.lwe_mul_const %732, %0, %c2_i64_253 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %c1_i64_254 = arith.constant 1 : i64
    %735 = openfhe.lwe_mul_const %732, %9, %c1_i64_254 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, i64) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %736 = openfhe.lwe_add %732, %733, %734 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %737 = openfhe.lwe_add %732, %736, %735 : (!openfhe.lwe_scheme, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %738 = openfhe.make_lut %arg0 {values = array<i32: 3, 4, 5, 6>} : (!openfhe.binfhe_context) -> !openfhe.lookup_table
    %739 = openfhe.eval_func %arg0, %738, %737 : (!openfhe.binfhe_context, !openfhe.lookup_table, !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>) -> !lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>
    %alloc = memref.alloc() : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %739, %alloc[%c0] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %35, %alloc[%c1] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %94, %alloc[%c2] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %173, %alloc[%c3] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %274, %alloc[%c4] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %407, %alloc[%c5] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %560, %alloc[%c6] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    memref.store %731, %alloc[%c7] : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
    return %alloc : memref<8x!lwe.lwe_ciphertext<encoding = #lwe.unspecified_bit_field_encoding<cleartext_bitwidth = 3>>>
  }
}

