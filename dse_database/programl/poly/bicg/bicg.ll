; ModuleID = 'bicg.c'
source_filename = "bicg.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_bicg(i32 %m, i32 %n, [116 x double]* %A, double* %s, double* %q, double* %p, double* %r) #0 {
entry:
  %m.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [116 x double]*, align 8
  %s.addr = alloca double*, align 8
  %q.addr = alloca double*, align 8
  %p.addr = alloca double*, align 8
  %r.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %m, i32* %m.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  store [116 x double]* %A, [116 x double]** %A.addr, align 8
  store double* %s, double** %s.addr, align 8
  store double* %q, double** %q.addr, align 8
  store double* %p, double** %p.addr, align 8
  store double* %r, double** %r.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 116
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %s.addr, align 8
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

for.cond1:                                        ; preds = %for.inc30, %for.end
  %4 = load i32, i32* %i, align 4
  %cmp2 = icmp slt i32 %4, 124
  br i1 %cmp2, label %for.body3, label %for.end32

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %q.addr, align 8
  %6 = load i32, i32* %i, align 4
  %idxprom4 = sext i32 %6 to i64
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4
  store double 0.000000e+00, double* %arrayidx5, align 8
  store i32 0, i32* %j, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc27, %for.body3
  %7 = load i32, i32* %j, align 4
  %cmp7 = icmp slt i32 %7, 116
  br i1 %cmp7, label %for.body8, label %for.end29

for.body8:                                        ; preds = %for.cond6
  %8 = load double*, double** %r.addr, align 8
  %9 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %9 to i64
  %arrayidx10 = getelementptr inbounds double, double* %8, i64 %idxprom9
  %10 = load double, double* %arrayidx10, align 8
  %11 = load [116 x double]*, [116 x double]** %A.addr, align 8
  %12 = load i32, i32* %i, align 4
  %idxprom11 = sext i32 %12 to i64
  %arrayidx12 = getelementptr inbounds [116 x double], [116 x double]* %11, i64 %idxprom11
  %13 = load i32, i32* %j, align 4
  %idxprom13 = sext i32 %13 to i64
  %arrayidx14 = getelementptr inbounds [116 x double], [116 x double]* %arrayidx12, i64 0, i64 %idxprom13
  %14 = load double, double* %arrayidx14, align 8
  %mul = fmul double %10, %14
  %15 = load double*, double** %s.addr, align 8
  %16 = load i32, i32* %j, align 4
  %idxprom15 = sext i32 %16 to i64
  %arrayidx16 = getelementptr inbounds double, double* %15, i64 %idxprom15
  %17 = load double, double* %arrayidx16, align 8
  %add = fadd double %17, %mul
  store double %add, double* %arrayidx16, align 8
  %18 = load [116 x double]*, [116 x double]** %A.addr, align 8
  %19 = load i32, i32* %i, align 4
  %idxprom17 = sext i32 %19 to i64
  %arrayidx18 = getelementptr inbounds [116 x double], [116 x double]* %18, i64 %idxprom17
  %20 = load i32, i32* %j, align 4
  %idxprom19 = sext i32 %20 to i64
  %arrayidx20 = getelementptr inbounds [116 x double], [116 x double]* %arrayidx18, i64 0, i64 %idxprom19
  %21 = load double, double* %arrayidx20, align 8
  %22 = load double*, double** %p.addr, align 8
  %23 = load i32, i32* %j, align 4
  %idxprom21 = sext i32 %23 to i64
  %arrayidx22 = getelementptr inbounds double, double* %22, i64 %idxprom21
  %24 = load double, double* %arrayidx22, align 8
  %mul23 = fmul double %21, %24
  %25 = load double*, double** %q.addr, align 8
  %26 = load i32, i32* %i, align 4
  %idxprom24 = sext i32 %26 to i64
  %arrayidx25 = getelementptr inbounds double, double* %25, i64 %idxprom24
  %27 = load double, double* %arrayidx25, align 8
  %add26 = fadd double %27, %mul23
  store double %add26, double* %arrayidx25, align 8
  br label %for.inc27

for.inc27:                                        ; preds = %for.body8
  %28 = load i32, i32* %j, align 4
  %inc28 = add nsw i32 %28, 1
  store i32 %inc28, i32* %j, align 4
  br label %for.cond6, !llvm.loop !4

for.end29:                                        ; preds = %for.cond6
  br label %for.inc30

for.inc30:                                        ; preds = %for.end29
  %29 = load i32, i32* %i, align 4
  %inc31 = add nsw i32 %29, 1
  store i32 %inc31, i32* %i, align 4
  br label %for.cond1, !llvm.loop !5

for.end32:                                        ; preds = %for.cond1
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
