; ModuleID = 'gemm.c'
source_filename = "gemm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_gemm(i32 %ni, i32 %nj, i32 %nk, double %alpha, double %beta, [70 x double]* %C, [80 x double]* %A, [70 x double]* %B) #0 {
entry:
  %ni.addr = alloca i32, align 4
  %nj.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %C.addr = alloca [70 x double]*, align 8
  %A.addr = alloca [80 x double]*, align 8
  %B.addr = alloca [70 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %ni, i32* %ni.addr, align 4
  store i32 %nj, i32* %nj.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  store double %alpha, double* %alpha.addr, align 8
  store double %beta, double* %beta.addr, align 8
  store [70 x double]* %C, [70 x double]** %C.addr, align 8
  store [80 x double]* %A, [80 x double]** %A.addr, align 8
  store [70 x double]* %B, [70 x double]** %B.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc32, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 60
  br i1 %cmp, label %for.body, label %for.end34

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 70
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load double, double* %beta.addr, align 8
  %3 = load [70 x double]*, [70 x double]** %C.addr, align 8
  %4 = load i32, i32* %i, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds [70 x double], [70 x double]* %3, i64 %idxprom
  %5 = load i32, i32* %j, align 4
  %idxprom4 = sext i32 %5 to i64
  %arrayidx5 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx, i64 0, i64 %idxprom4
  %6 = load double, double* %arrayidx5, align 8
  %mul = fmul double %6, %2
  store double %mul, double* %arrayidx5, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %7 = load i32, i32* %j, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  store i32 0, i32* %k, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc29, %for.end
  %8 = load i32, i32* %k, align 4
  %cmp7 = icmp slt i32 %8, 80
  br i1 %cmp7, label %for.body8, label %for.end31

for.body8:                                        ; preds = %for.cond6
  store i32 0, i32* %j, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc26, %for.body8
  %9 = load i32, i32* %j, align 4
  %cmp10 = icmp slt i32 %9, 70
  br i1 %cmp10, label %for.body11, label %for.end28

for.body11:                                       ; preds = %for.cond9
  %10 = load double, double* %alpha.addr, align 8
  %11 = load [80 x double]*, [80 x double]** %A.addr, align 8
  %12 = load i32, i32* %i, align 4
  %idxprom12 = sext i32 %12 to i64
  %arrayidx13 = getelementptr inbounds [80 x double], [80 x double]* %11, i64 %idxprom12
  %13 = load i32, i32* %k, align 4
  %idxprom14 = sext i32 %13 to i64
  %arrayidx15 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx13, i64 0, i64 %idxprom14
  %14 = load double, double* %arrayidx15, align 8
  %mul16 = fmul double %10, %14
  %15 = load [70 x double]*, [70 x double]** %B.addr, align 8
  %16 = load i32, i32* %k, align 4
  %idxprom17 = sext i32 %16 to i64
  %arrayidx18 = getelementptr inbounds [70 x double], [70 x double]* %15, i64 %idxprom17
  %17 = load i32, i32* %j, align 4
  %idxprom19 = sext i32 %17 to i64
  %arrayidx20 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx18, i64 0, i64 %idxprom19
  %18 = load double, double* %arrayidx20, align 8
  %mul21 = fmul double %mul16, %18
  %19 = load [70 x double]*, [70 x double]** %C.addr, align 8
  %20 = load i32, i32* %i, align 4
  %idxprom22 = sext i32 %20 to i64
  %arrayidx23 = getelementptr inbounds [70 x double], [70 x double]* %19, i64 %idxprom22
  %21 = load i32, i32* %j, align 4
  %idxprom24 = sext i32 %21 to i64
  %arrayidx25 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx23, i64 0, i64 %idxprom24
  %22 = load double, double* %arrayidx25, align 8
  %add = fadd double %22, %mul21
  store double %add, double* %arrayidx25, align 8
  br label %for.inc26

for.inc26:                                        ; preds = %for.body11
  %23 = load i32, i32* %j, align 4
  %inc27 = add nsw i32 %23, 1
  store i32 %inc27, i32* %j, align 4
  br label %for.cond9, !llvm.loop !4

for.end28:                                        ; preds = %for.cond9
  br label %for.inc29

for.inc29:                                        ; preds = %for.end28
  %24 = load i32, i32* %k, align 4
  %inc30 = add nsw i32 %24, 1
  store i32 %inc30, i32* %k, align 4
  br label %for.cond6, !llvm.loop !5

for.end31:                                        ; preds = %for.cond6
  br label %for.inc32

for.inc32:                                        ; preds = %for.end31
  %25 = load i32, i32* %i, align 4
  %inc33 = add nsw i32 %25, 1
  store i32 %inc33, i32* %i, align 4
  br label %for.cond, !llvm.loop !6

for.end34:                                        ; preds = %for.cond
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
