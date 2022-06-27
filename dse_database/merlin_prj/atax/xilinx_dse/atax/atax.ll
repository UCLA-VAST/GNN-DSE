; ModuleID = '/home/atefehSZ/polybench-c-4.2.1-beta/linear-algebra/kernels/atax_dse/xilinx_dse/atax/atax.c'
source_filename = "/home/atefehSZ/polybench-c-4.2.1-beta/linear-algebra/kernels/atax_dse/xilinx_dse/atax/atax.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_atax(i32 %m, i32 %n, [124 x double]* %A, double* %x, double* %y, double* %tmp) #0 {
entry:
  %m.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [124 x double]*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %tmp.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %m, i32* %m.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  store [124 x double]* %A, [124 x double]** %A.addr, align 8
  store double* %x, double** %x.addr, align 8
  store double* %y, double** %y.addr, align 8
  store double* %tmp, double** %tmp.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 124
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %y.addr, align 8
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom
  store double 0.000000e+00, double* %arrayidx, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond, !llvm.loop !2

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc36, %for.end
  %4 = load i32, i32* %i, align 4
  %cmp2 = icmp slt i32 %4, 116
  br i1 %cmp2, label %for.body3, label %for.end38

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %tmp.addr, align 8
  %6 = load i32, i32* %i, align 4
  %idxprom4 = sext i32 %6 to i64
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4
  store double 0.000000e+00, double* %arrayidx5, align 8
  store i32 0, i32* %j, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc17, %for.body3
  %7 = load i32, i32* %j, align 4
  %cmp7 = icmp slt i32 %7, 124
  br i1 %cmp7, label %for.body8, label %for.end19

for.body8:                                        ; preds = %for.cond6
  %8 = load [124 x double]*, [124 x double]** %A.addr, align 8
  %9 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %9 to i64
  %arrayidx10 = getelementptr inbounds [124 x double], [124 x double]* %8, i64 %idxprom9
  %10 = load i32, i32* %j, align 4
  %idxprom11 = sext i32 %10 to i64
  %arrayidx12 = getelementptr inbounds [124 x double], [124 x double]* %arrayidx10, i64 0, i64 %idxprom11
  %11 = load double, double* %arrayidx12, align 8
  %12 = load double*, double** %x.addr, align 8
  %13 = load i32, i32* %j, align 4
  %idxprom13 = sext i32 %13 to i64
  %arrayidx14 = getelementptr inbounds double, double* %12, i64 %idxprom13
  %14 = load double, double* %arrayidx14, align 8
  %mul = fmul double %11, %14
  %15 = load double*, double** %tmp.addr, align 8
  %16 = load i32, i32* %i, align 4
  %idxprom15 = sext i32 %16 to i64
  %arrayidx16 = getelementptr inbounds double, double* %15, i64 %idxprom15
  %17 = load double, double* %arrayidx16, align 8
  %add = fadd double %17, %mul
  store double %add, double* %arrayidx16, align 8
  br label %for.inc17

for.inc17:                                        ; preds = %for.body8
  %18 = load i32, i32* %j, align 4
  %inc18 = add nsw i32 %18, 1
  store i32 %inc18, i32* %j, align 4
  br label %for.cond6, !llvm.loop !4

for.end19:                                        ; preds = %for.cond6
  store i32 0, i32* %j, align 4
  br label %for.cond20

for.cond20:                                       ; preds = %for.inc33, %for.end19
  %19 = load i32, i32* %j, align 4
  %cmp21 = icmp slt i32 %19, 124
  br i1 %cmp21, label %for.body22, label %for.end35

for.body22:                                       ; preds = %for.cond20
  %20 = load [124 x double]*, [124 x double]** %A.addr, align 8
  %21 = load i32, i32* %i, align 4
  %idxprom23 = sext i32 %21 to i64
  %arrayidx24 = getelementptr inbounds [124 x double], [124 x double]* %20, i64 %idxprom23
  %22 = load i32, i32* %j, align 4
  %idxprom25 = sext i32 %22 to i64
  %arrayidx26 = getelementptr inbounds [124 x double], [124 x double]* %arrayidx24, i64 0, i64 %idxprom25
  %23 = load double, double* %arrayidx26, align 8
  %24 = load double*, double** %tmp.addr, align 8
  %25 = load i32, i32* %i, align 4
  %idxprom27 = sext i32 %25 to i64
  %arrayidx28 = getelementptr inbounds double, double* %24, i64 %idxprom27
  %26 = load double, double* %arrayidx28, align 8
  %mul29 = fmul double %23, %26
  %27 = load double*, double** %y.addr, align 8
  %28 = load i32, i32* %j, align 4
  %idxprom30 = sext i32 %28 to i64
  %arrayidx31 = getelementptr inbounds double, double* %27, i64 %idxprom30
  %29 = load double, double* %arrayidx31, align 8
  %add32 = fadd double %29, %mul29
  store double %add32, double* %arrayidx31, align 8
  br label %for.inc33

for.inc33:                                        ; preds = %for.body22
  %30 = load i32, i32* %j, align 4
  %inc34 = add nsw i32 %30, 1
  store i32 %inc34, i32* %j, align 4
  br label %for.cond20, !llvm.loop !5

for.end35:                                        ; preds = %for.cond20
  br label %for.inc36

for.inc36:                                        ; preds = %for.end35
  %31 = load i32, i32* %i, align 4
  %inc37 = add nsw i32 %31, 1
  store i32 %inc37, i32* %i, align 4
  br label %for.cond1, !llvm.loop !6

for.end38:                                        ; preds = %for.cond1
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
