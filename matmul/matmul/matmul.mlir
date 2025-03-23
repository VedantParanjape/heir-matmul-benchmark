!val = i8
!ctxt = !secret.secret<!val>

module {
    func.func @add8(%x: !ctxt, %y: !ctxt) -> !ctxt {
        %prod = secret.generic ins(%x, %y: !ctxt, !ctxt) {
            ^bb0(%X: !val, %Y: !val):
                %0 = arith.addi %X, %Y : !val
                secret.yield %0 : !val
        } -> (!ctxt)
        return %prod : !ctxt
    }

    func.func @mul8(%x: !ctxt, %y: !ctxt) -> !ctxt {
        %prod = secret.generic ins(%x, %y: !ctxt, !ctxt) {
            ^bb0(%X: !val, %Y: !val):
                %0 = arith.muli %X, %Y : !val
                secret.yield %0 : !val
        } -> (!ctxt)
        return %prod : !ctxt
    }
}