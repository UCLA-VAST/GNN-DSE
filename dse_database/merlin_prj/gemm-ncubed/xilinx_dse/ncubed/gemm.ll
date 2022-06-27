; ModuleID = 'gemm.c'
source_filename = "gemm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @gemm(double* %m1, double* %m2, double* %prod) #0 {
entry:
  %m1.addr = alloca double*, align 8
  %m2.addr = alloca double*, align 8
  %prod.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %k_col = alloca i32, align 4
  %i_col = alloca i32, align 4
  %mult = alloca double, align 8
  %sum = alloca double, align 8
  store double* %m1, double** %m1.addr, align 8
  store double* %m2, double** %m2.addr, align 8
  store double* %prod, double** %prod.addr, align 8
  br label %outer

outer:                                            ; preds = %entry
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc19, %outer
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 64
  br i1 %cmp, label %for.body, label %for.end21

for.body:                                         ; preds = %for.cond
  br label %middle

middle:                                           ; preds = %for.body
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc16, %middle
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 64
  br i1 %cmp2, label %for.body3, label %for.end18

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %i, align 4
  %mul = mul nsw i32 %2, 64
  store i32 %mul, i32* %i_col, align 4
  store double 0.000000e+00, double* %sum, align 8
  br label %inner

inner:                                            ; preds = %for.body3
  store i32 0, i32* %k, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %inner
  %3 = load i32, i32* %k, align 4
  %cmp5 = icmp slt i32 %3, 64
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %4 = load i32, i32* %k, align 4
  %mul7 = mul nsw i32 %4, 64
  store i32 %mul7, i32* %k_col, align 4
  %5 = load double*, double** %m1.addr, align 8
  %6 = load i32, i32* %i_col, align 4
  %7 = load i32, i32* %k, align 4
  %add = add nsw i32 %6, %7
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds double, double* %5, i64 %idxprom
  %8 = load double, double* %arrayidx, align 8
  %9 = load double*, double** %m2.addr, align 8
  %10 = load i32, i32* %k_col, align 4
  %11 = load i32, i32* %j, align 4
  %add8 = add nsw i32 %10, %11
  %idxprom9 = sext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds double, double* %9, i64 %idxprom9
  %12 = load double, double* %arrayidx10, align 8
  %mul11 = fmul double %8, %12
  store double %mul11, double* %mult, align 8
  %13 = load double, double* %mult, align 8
  %14 = load double, double* %sum, align 8
  %add12 = fadd double %14, %13
  store double %add12, double* %sum, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %15 = load i32, i32* %k, align 4
  %inc = add nsw i32 %15, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond4, !llvm.loop !2

for.end:                                          ; preds = %for.cond4
  %16 = load double, double* %sum, align 8
  %17 = load double*, double** %prod.addr, align 8
  %18 = load i32, i32* %i_col, align 4
  %19 = load i32, i32* %j, align 4
  %add13 = add nsw i32 %18, %19
  %idxprom14 = sext i32 %add13 to i64
  %arrayidx15 = getelementptr inbounds double, double* %17, i64 %idxprom14
  store double %16, double* %arrayidx15, align 8
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %20 = load i32, i32* %j, align 4
  %inc17 = add nsw i32 %20, 1
  store i32 %inc17, i32* %j, align 4
  br label %for.cond1, !llvm.loop !4

for.end18:                                        ; preds = %for.cond1
  br label %for.inc19

for.inc19:                                        ; preds = %for.end18
  %21 = load i32, i32* %i, align 4
  %inc20 = add nsw i32 %21, 1
  store i32 %inc20, i32* %i, align 4
  br label %for.cond, !llvm.loop !5

for.end21:                                        ; preds = %for.cond
  ret void
}

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project 1d6f08e61d9771baf5381198ac5d306f6cbcd302)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
!5 = distinct !{!5, !3}
