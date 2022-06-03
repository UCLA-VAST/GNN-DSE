; ModuleID = 'gemm.c'
source_filename = "gemm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @bbgemm(double* %m1, double* %m2, double* %prod) #0 {
entry:
  %m1.addr = alloca double*, align 8
  %m2.addr = alloca double*, align 8
  %prod.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %k = alloca i32, align 4
  %j = alloca i32, align 4
  %jj = alloca i32, align 4
  %kk = alloca i32, align 4
  %i_row = alloca i32, align 4
  %k_row = alloca i32, align 4
  %temp_x = alloca double, align 8
  %mul = alloca double, align 8
  %_in_jj = alloca i32, align 4
  %_in_kk = alloca i32, align 4
  store double* %m1, double** %m1.addr, align 8
  store double* %m2, double** %m2.addr, align 8
  store double* %prod, double** %prod.addr, align 8
  br label %loopjj

loopjj:                                           ; preds = %entry
  store i32 0, i32* %jj, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc47, %loopjj
  %0 = load i32, i32* %jj, align 4
  %cmp = icmp sle i32 %0, 7
  br i1 %cmp, label %for.body, label %for.end49

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %jj, align 4
  %conv = sext i32 %1 to i64
  %mul1 = mul nsw i64 8, %conv
  %add = add nsw i64 0, %mul1
  %conv2 = trunc i64 %add to i32
  store i32 %conv2, i32* %_in_jj, align 4
  br label %loopkk

loopkk:                                           ; preds = %for.body
  store i32 0, i32* %kk, align 4
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc44, %loopkk
  %2 = load i32, i32* %kk, align 4
  %cmp4 = icmp sle i32 %2, 7
  br i1 %cmp4, label %for.body6, label %for.end46

for.body6:                                        ; preds = %for.cond3
  %3 = load i32, i32* %kk, align 4
  %conv7 = sext i32 %3 to i64
  %mul8 = mul nsw i64 8, %conv7
  %add9 = add nsw i64 0, %mul8
  %conv10 = trunc i64 %add9 to i32
  store i32 %conv10, i32* %_in_kk, align 4
  br label %loopi

loopi:                                            ; preds = %for.body6
  store i32 0, i32* %i, align 4
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc41, %loopi
  %4 = load i32, i32* %i, align 4
  %cmp12 = icmp slt i32 %4, 64
  br i1 %cmp12, label %for.body14, label %for.end43

for.body14:                                       ; preds = %for.cond11
  br label %loopk

loopk:                                            ; preds = %for.body14
  store i32 0, i32* %k, align 4
  br label %for.cond15

for.cond15:                                       ; preds = %for.inc38, %loopk
  %5 = load i32, i32* %k, align 4
  %cmp16 = icmp slt i32 %5, 8
  br i1 %cmp16, label %for.body18, label %for.end40

for.body18:                                       ; preds = %for.cond15
  %6 = load i32, i32* %i, align 4
  %mul19 = mul nsw i32 %6, 64
  store i32 %mul19, i32* %i_row, align 4
  %7 = load i32, i32* %k, align 4
  %8 = load i32, i32* %_in_kk, align 4
  %add20 = add nsw i32 %7, %8
  %mul21 = mul nsw i32 %add20, 64
  store i32 %mul21, i32* %k_row, align 4
  %9 = load double*, double** %m1.addr, align 8
  %10 = load i32, i32* %i_row, align 4
  %11 = load i32, i32* %k, align 4
  %add22 = add nsw i32 %10, %11
  %12 = load i32, i32* %_in_kk, align 4
  %add23 = add nsw i32 %add22, %12
  %idxprom = sext i32 %add23 to i64
  %arrayidx = getelementptr inbounds double, double* %9, i64 %idxprom
  %13 = load double, double* %arrayidx, align 8
  store double %13, double* %temp_x, align 8
  br label %loopj

loopj:                                            ; preds = %for.body18
  store i32 0, i32* %j, align 4
  br label %for.cond24

for.cond24:                                       ; preds = %for.inc, %loopj
  %14 = load i32, i32* %j, align 4
  %cmp25 = icmp slt i32 %14, 8
  br i1 %cmp25, label %for.body27, label %for.end

for.body27:                                       ; preds = %for.cond24
  %15 = load double, double* %temp_x, align 8
  %16 = load double*, double** %m2.addr, align 8
  %17 = load i32, i32* %k_row, align 4
  %18 = load i32, i32* %j, align 4
  %add28 = add nsw i32 %17, %18
  %19 = load i32, i32* %_in_jj, align 4
  %add29 = add nsw i32 %add28, %19
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds double, double* %16, i64 %idxprom30
  %20 = load double, double* %arrayidx31, align 8
  %mul32 = fmul double %15, %20
  store double %mul32, double* %mul, align 8
  %21 = load double, double* %mul, align 8
  %22 = load double*, double** %prod.addr, align 8
  %23 = load i32, i32* %i_row, align 4
  %24 = load i32, i32* %j, align 4
  %add33 = add nsw i32 %23, %24
  %25 = load i32, i32* %_in_jj, align 4
  %add34 = add nsw i32 %add33, %25
  %idxprom35 = sext i32 %add34 to i64
  %arrayidx36 = getelementptr inbounds double, double* %22, i64 %idxprom35
  %26 = load double, double* %arrayidx36, align 8
  %add37 = fadd double %26, %21
  store double %add37, double* %arrayidx36, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body27
  %27 = load i32, i32* %j, align 4
  %inc = add nsw i32 %27, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond24, !llvm.loop !2

for.end:                                          ; preds = %for.cond24
  br label %for.inc38

for.inc38:                                        ; preds = %for.end
  %28 = load i32, i32* %k, align 4
  %inc39 = add nsw i32 %28, 1
  store i32 %inc39, i32* %k, align 4
  br label %for.cond15, !llvm.loop !4

for.end40:                                        ; preds = %for.cond15
  br label %for.inc41

for.inc41:                                        ; preds = %for.end40
  %29 = load i32, i32* %i, align 4
  %inc42 = add nsw i32 %29, 1
  store i32 %inc42, i32* %i, align 4
  br label %for.cond11, !llvm.loop !5

for.end43:                                        ; preds = %for.cond11
  br label %for.inc44

for.inc44:                                        ; preds = %for.end43
  %30 = load i32, i32* %kk, align 4
  %inc45 = add nsw i32 %30, 1
  store i32 %inc45, i32* %kk, align 4
  br label %for.cond3, !llvm.loop !6

for.end46:                                        ; preds = %for.cond3
  store i32 64, i32* %kk, align 4
  br label %for.inc47

for.inc47:                                        ; preds = %for.end46
  %31 = load i32, i32* %jj, align 4
  %inc48 = add nsw i32 %31, 1
  store i32 %inc48, i32* %jj, align 4
  br label %for.cond, !llvm.loop !7

for.end49:                                        ; preds = %for.cond
  store i32 64, i32* %jj, align 4
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
!6 = distinct !{!6, !3}
!7 = distinct !{!7, !3}
