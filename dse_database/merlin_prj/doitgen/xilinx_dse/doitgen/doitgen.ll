; ModuleID = 'doitgen.c'
source_filename = "doitgen.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_doitgen(i32 %nr, i32 %nq, i32 %np, [20 x [30 x double]]* %A, [30 x double]* %C4, double* %sum) #0 {
entry:
  %nr.addr = alloca i32, align 4
  %nq.addr = alloca i32, align 4
  %np.addr = alloca i32, align 4
  %A.addr = alloca [20 x [30 x double]]*, align 8
  %C4.addr = alloca [30 x double]*, align 8
  %sum.addr = alloca double*, align 8
  %r = alloca i32, align 4
  %q = alloca i32, align 4
  %p = alloca i32, align 4
  %s = alloca i32, align 4
  store i32 %nr, i32* %nr.addr, align 4
  store i32 %nq, i32* %nq.addr, align 4
  store i32 %np, i32* %np.addr, align 4
  store [20 x [30 x double]]* %A, [20 x [30 x double]]** %A.addr, align 8
  store [30 x double]* %C4, [30 x double]** %C4.addr, align 8
  store double* %sum, double** %sum.addr, align 8
  store i32 0, i32* %r, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc42, %entry
  %0 = load i32, i32* %r, align 4
  %cmp = icmp slt i32 %0, 25
  br i1 %cmp, label %for.body, label %for.end44

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %q, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc39, %for.body
  %1 = load i32, i32* %q, align 4
  %cmp2 = icmp slt i32 %1, 20
  br i1 %cmp2, label %for.body3, label %for.end41

for.body3:                                        ; preds = %for.cond1
  store i32 0, i32* %p, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc22, %for.body3
  %2 = load i32, i32* %p, align 4
  %cmp5 = icmp slt i32 %2, 30
  br i1 %cmp5, label %for.body6, label %for.end24

for.body6:                                        ; preds = %for.cond4
  %3 = load double*, double** %sum.addr, align 8
  %4 = load i32, i32* %p, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds double, double* %3, i64 %idxprom
  store double 0.000000e+00, double* %arrayidx, align 8
  store i32 0, i32* %s, align 4
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc, %for.body6
  %5 = load i32, i32* %s, align 4
  %cmp8 = icmp slt i32 %5, 30
  br i1 %cmp8, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond7
  %6 = load [20 x [30 x double]]*, [20 x [30 x double]]** %A.addr, align 8
  %7 = load i32, i32* %r, align 4
  %idxprom10 = sext i32 %7 to i64
  %arrayidx11 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %6, i64 %idxprom10
  %8 = load i32, i32* %q, align 4
  %idxprom12 = sext i32 %8 to i64
  %arrayidx13 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %arrayidx11, i64 0, i64 %idxprom12
  %9 = load i32, i32* %s, align 4
  %idxprom14 = sext i32 %9 to i64
  %arrayidx15 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx13, i64 0, i64 %idxprom14
  %10 = load double, double* %arrayidx15, align 8
  %11 = load [30 x double]*, [30 x double]** %C4.addr, align 8
  %12 = load i32, i32* %s, align 4
  %idxprom16 = sext i32 %12 to i64
  %arrayidx17 = getelementptr inbounds [30 x double], [30 x double]* %11, i64 %idxprom16
  %13 = load i32, i32* %p, align 4
  %idxprom18 = sext i32 %13 to i64
  %arrayidx19 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx17, i64 0, i64 %idxprom18
  %14 = load double, double* %arrayidx19, align 8
  %mul = fmul double %10, %14
  %15 = load double*, double** %sum.addr, align 8
  %16 = load i32, i32* %p, align 4
  %idxprom20 = sext i32 %16 to i64
  %arrayidx21 = getelementptr inbounds double, double* %15, i64 %idxprom20
  %17 = load double, double* %arrayidx21, align 8
  %add = fadd double %17, %mul
  store double %add, double* %arrayidx21, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body9
  %18 = load i32, i32* %s, align 4
  %inc = add nsw i32 %18, 1
  store i32 %inc, i32* %s, align 4
  br label %for.cond7, !llvm.loop !2

for.end:                                          ; preds = %for.cond7
  br label %for.inc22

for.inc22:                                        ; preds = %for.end
  %19 = load i32, i32* %p, align 4
  %inc23 = add nsw i32 %19, 1
  store i32 %inc23, i32* %p, align 4
  br label %for.cond4, !llvm.loop !4

for.end24:                                        ; preds = %for.cond4
  store i32 0, i32* %p, align 4
  br label %for.cond25

for.cond25:                                       ; preds = %for.inc36, %for.end24
  %20 = load i32, i32* %p, align 4
  %cmp26 = icmp slt i32 %20, 30
  br i1 %cmp26, label %for.body27, label %for.end38

for.body27:                                       ; preds = %for.cond25
  %21 = load double*, double** %sum.addr, align 8
  %22 = load i32, i32* %p, align 4
  %idxprom28 = sext i32 %22 to i64
  %arrayidx29 = getelementptr inbounds double, double* %21, i64 %idxprom28
  %23 = load double, double* %arrayidx29, align 8
  %24 = load [20 x [30 x double]]*, [20 x [30 x double]]** %A.addr, align 8
  %25 = load i32, i32* %r, align 4
  %idxprom30 = sext i32 %25 to i64
  %arrayidx31 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %24, i64 %idxprom30
  %26 = load i32, i32* %q, align 4
  %idxprom32 = sext i32 %26 to i64
  %arrayidx33 = getelementptr inbounds [20 x [30 x double]], [20 x [30 x double]]* %arrayidx31, i64 0, i64 %idxprom32
  %27 = load i32, i32* %p, align 4
  %idxprom34 = sext i32 %27 to i64
  %arrayidx35 = getelementptr inbounds [30 x double], [30 x double]* %arrayidx33, i64 0, i64 %idxprom34
  store double %23, double* %arrayidx35, align 8
  br label %for.inc36

for.inc36:                                        ; preds = %for.body27
  %28 = load i32, i32* %p, align 4
  %inc37 = add nsw i32 %28, 1
  store i32 %inc37, i32* %p, align 4
  br label %for.cond25, !llvm.loop !5

for.end38:                                        ; preds = %for.cond25
  br label %for.inc39

for.inc39:                                        ; preds = %for.end38
  %29 = load i32, i32* %q, align 4
  %inc40 = add nsw i32 %29, 1
  store i32 %inc40, i32* %q, align 4
  br label %for.cond1, !llvm.loop !6

for.end41:                                        ; preds = %for.cond1
  br label %for.inc42

for.inc42:                                        ; preds = %for.end41
  %30 = load i32, i32* %r, align 4
  %inc43 = add nsw i32 %30, 1
  store i32 %inc43, i32* %r, align 4
  br label %for.cond, !llvm.loop !7

for.end44:                                        ; preds = %for.cond
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
