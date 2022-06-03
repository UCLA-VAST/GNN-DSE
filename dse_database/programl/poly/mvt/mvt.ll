; ModuleID = '/home/atefehSZ/polybench-c-4.2.1-beta/linear-algebra/kernels/mvt_dse/xilinx_dse/mvt/mvt.c'
source_filename = "/home/atefehSZ/polybench-c-4.2.1-beta/linear-algebra/kernels/mvt_dse/xilinx_dse/mvt/mvt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_mvt(double* %x1, double* %x2, double* %y_1, double* %y_2, [120 x double]* %A) #0 {
entry:
  %x1.addr = alloca double*, align 8
  %x2.addr = alloca double*, align 8
  %y_1.addr = alloca double*, align 8
  %y_2.addr = alloca double*, align 8
  %A.addr = alloca [120 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %x1, double** %x1.addr, align 8
  store double* %x2, double** %x2.addr, align 8
  store double* %y_1, double** %y_1.addr, align 8
  store double* %y_2, double** %y_2.addr, align 8
  store [120 x double]* %A, [120 x double]** %A.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc10, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 120
  br i1 %cmp, label %for.body, label %for.end12

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 120
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %3 = load i32, i32* %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds [120 x double], [120 x double]* %2, i64 %idxprom
  %4 = load i32, i32* %j, align 4
  %idxprom4 = sext i32 %4 to i64
  %arrayidx5 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx, i64 0, i64 %idxprom4
  %5 = load double, double* %arrayidx5, align 8
  %6 = load double*, double** %y_1.addr, align 8
  %7 = load i32, i32* %j, align 4
  %idxprom6 = sext i32 %7 to i64
  %arrayidx7 = getelementptr inbounds double, double* %6, i64 %idxprom6
  %8 = load double, double* %arrayidx7, align 8
  %mul = fmul double %5, %8
  %9 = load double*, double** %x1.addr, align 8
  %10 = load i32, i32* %i, align 4
  %idxprom8 = sext i32 %10 to i64
  %arrayidx9 = getelementptr inbounds double, double* %9, i64 %idxprom8
  %11 = load double, double* %arrayidx9, align 8
  %add = fadd double %11, %mul
  store double %add, double* %arrayidx9, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %12 = load i32, i32* %j, align 4
  %inc = add nsw i32 %12, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  br label %for.inc10

for.inc10:                                        ; preds = %for.end
  %13 = load i32, i32* %i, align 4
  %inc11 = add nsw i32 %13, 1
  store i32 %inc11, i32* %i, align 4
  br label %for.cond, !llvm.loop !4

for.end12:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc32, %for.end12
  %14 = load i32, i32* %i, align 4
  %cmp14 = icmp slt i32 %14, 120
  br i1 %cmp14, label %for.body15, label %for.end34

for.body15:                                       ; preds = %for.cond13
  store i32 0, i32* %j, align 4
  br label %for.cond16

for.cond16:                                       ; preds = %for.inc29, %for.body15
  %15 = load i32, i32* %j, align 4
  %cmp17 = icmp slt i32 %15, 120
  br i1 %cmp17, label %for.body18, label %for.end31

for.body18:                                       ; preds = %for.cond16
  %16 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %17 = load i32, i32* %j, align 4
  %idxprom19 = sext i32 %17 to i64
  %arrayidx20 = getelementptr inbounds [120 x double], [120 x double]* %16, i64 %idxprom19
  %18 = load i32, i32* %i, align 4
  %idxprom21 = sext i32 %18 to i64
  %arrayidx22 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx20, i64 0, i64 %idxprom21
  %19 = load double, double* %arrayidx22, align 8
  %20 = load double*, double** %y_2.addr, align 8
  %21 = load i32, i32* %j, align 4
  %idxprom23 = sext i32 %21 to i64
  %arrayidx24 = getelementptr inbounds double, double* %20, i64 %idxprom23
  %22 = load double, double* %arrayidx24, align 8
  %mul25 = fmul double %19, %22
  %23 = load double*, double** %x2.addr, align 8
  %24 = load i32, i32* %i, align 4
  %idxprom26 = sext i32 %24 to i64
  %arrayidx27 = getelementptr inbounds double, double* %23, i64 %idxprom26
  %25 = load double, double* %arrayidx27, align 8
  %add28 = fadd double %25, %mul25
  store double %add28, double* %arrayidx27, align 8
  br label %for.inc29

for.inc29:                                        ; preds = %for.body18
  %26 = load i32, i32* %j, align 4
  %inc30 = add nsw i32 %26, 1
  store i32 %inc30, i32* %j, align 4
  br label %for.cond16, !llvm.loop !5

for.end31:                                        ; preds = %for.cond16
  br label %for.inc32

for.inc32:                                        ; preds = %for.end31
  %27 = load i32, i32* %i, align 4
  %inc33 = add nsw i32 %27, 1
  store i32 %inc33, i32* %i, align 4
  br label %for.cond13, !llvm.loop !6

for.end34:                                        ; preds = %for.cond13
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
