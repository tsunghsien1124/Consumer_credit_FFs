# ------ Root Finding Methods -----




"""
    brent(f, a, b; args=(), atol=2e-12, rtol=4*eps(), maxiter=100)

1D root finding using Brent's method.  Based off the brentq implementation in scipy.

**Arguments**
- `f`: scalar function, that optionally takes additional arguments
- `a`::Float, b::Float`: bracketing interval for a root - sign changes sign between: (f(a) * f(b) < 0)
- `args::Tuple`: tuple of additional arguments to pass to f
- `atol::Float`: absolute tolerance (positive) for root
- `rtol::Float`: relative tolerance for root
- `maxiter::Int`: maximum number of iterations allowed

**Returns**
- `xstar::Float`: a root of f
- `info::Tuple`: A named tuple containing:
    - `iter::Int`: number of iterations
    - 'fcalls::Int`: number of function calls
    - 'flag::String`: a convergence/error message.
"""
function brent(f, a, b; args=(), atol=2e-12, rtol=4*eps(), maxiter=100)

    xpre = a; xcur = b
    # xblk = 0.0; fblk = 0.0; spre = 0.0; scur = 0.0
    error_num = "INPROGRESS"

    fpre = f(xpre, args...)
    fcur = f(xcur, args...)
    xblk = zero(fpre); fblk = zero(fpre); spre = zero(fpre); scur = zero(fpre)
    funcalls = 2
    iterations = 0
    
    if fpre*fcur > 0
        error_num = "SIGNERR"
        return 0.0, (iter=iterations, fcalls=funcalls, flag=error_num)
    end
    if fpre == zero(fpre)
        error_num = "CONVERGED"
        return xpre, (iter=iterations, fcalls=funcalls, flag=error_num)
    end
    if fcur == zero(fcur)
        error_num = "CONVERGED"
        return xcur, (iter=iterations, fcalls=funcalls, flag=error_num)
    end

    for i = 1:maxiter
        iterations += 1
        if fpre*fcur < 0
            xblk = xpre
            fblk = fpre
            spre = scur = xcur - xpre
        end
        if abs(fblk) < abs(fcur)
            xpre = xcur
            xcur = xblk
            xblk = xpre

            fpre = fcur
            fcur = fblk
            fblk = fpre
        end

        delta = (atol + rtol*abs(xcur))/2
        sbis = (xblk - xcur)/2
        if fcur == zero(fcur) || abs(sbis) < delta
            error_num = "CONVERGED"
            return xcur, (iter=iterations, fcalls=funcalls, flag=error_num)
        end

        if abs(spre) > delta && abs(fcur) < abs(fpre)
            if xpre == xblk
                # interpolate
                stry = -fcur*(xcur - xpre)/(fcur - fpre)
            else
                # extrapolate
                dpre = (fpre - fcur)/(xpre - xcur)
                dblk = (fblk - fcur)/(xblk - xcur)
                stry = -fcur*(fblk*dblk - fpre*dpre)/(dblk*dpre*(fblk - fpre))
            end
            if 2*abs(stry) < min(abs(spre), 3*abs(sbis) - delta)
                # good short step
                spre = scur
                scur = stry
            else
                # bisect
                spre = sbis
                scur = sbis
            end
        else 
            # bisect
            spre = sbis
            scur = sbis
        end

        xpre = xcur; fpre = fcur
        if abs(scur) > delta
            xcur += scur
        else
            xcur += (sbis > 0 ? delta : -delta)
        end

        fcur = f(xcur, args...)
        funcalls += 1
    end
    error_num = "CONVERR"
    return xcur, (iter=iterations, fcalls=funcalls, flag=error_num)
end

# TODO AN: replace w/ newer Brent method and automatic bracketing?

