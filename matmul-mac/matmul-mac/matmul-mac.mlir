!val = i8
!ctxt = !secret.secret<!val>

module {
    func.func @mac8(%x: !ctxt, %y: !ctxt, %z: !ctxt) -> !ctxt {
        %prod = secret.generic ins(%x, %y, %z: !ctxt, !ctxt, !ctxt) {
            ^bb0(%X: !val, %Y: !val, %Z: !val):
                %0 = arith.muli %X, %Y : !val
                %1 = arith.addi %0, %Z : !val
                secret.yield %1 : !val
        } -> (!ctxt)
        return %prod : !ctxt
    }
}