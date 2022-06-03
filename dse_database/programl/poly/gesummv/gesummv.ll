; ModuleID = 'gesummv.c'
source_filename = "gesummv.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_gesummv(i32 %n, double %alpha, double %beta, [90 x double]* %A, [90 x double]* %B, double* %tmp, double* %x, double* %y) #0 {
entry:
  %n.addr = alloca i32, align 4
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %A.addr = alloca [90 x double]*, align 8
  %B.addr = alloca [90 x double]*, align 8
  %tmp.addr = alloca double*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  store double %alpha, double* %alpha.addr, align 8
  store double %beta, double* %beta.addr, align 8
  store [90 x double]* %A, [90 x double]** %A.addr, align 8
  store [90 x double]* %B, [90 x double]** %B.addr, align 8
  store double* %tmp, double** %tmp.addr, align 8
  store double* %x, double** %x.addr, align 8
  store double* %y, double** %y.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc37, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 90
  br i1 %cmp, label %for.body, label %for.end39

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %tmp.addr, align 8
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom
  store double 0.000000e+00, double* %arrayidx, align 8
  %3 = load double*, double** %y.addr, align 8
  %4 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %4 to i64
  %arrayidx2 = getelementptr inbounds double, double* %3, i64 %idxprom1
  store double 0.000000e+00, double* %arrayidx2, align 8
  store i32 0, i32* %j, align 4
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc, %for.body
  %5 = load i32, i32* %j, align 4
  %cmp4 = icmp slt i32 %5, 90
  br i1 %cmp4, label %for.body5, label %for.end

for.body5:                                        ; preds = %for.cond3
  %6 = load [90 x double]*, [90 x double]** %A.addr, align 8
  %7 = load i32, i32* %i, align 4
  %idxprom6 = sext i32 %7 to i64
  %arrayidx7 = getelementptr inbounds [90 x double], [90 x double]* %6, i64 %idxprom6
  %8 = load i32, i32* %j, align 4
  %idxprom8 = sext i32 %8 to i64
  %arrayidx9 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx7, i64 0, i64 %idxprom8
  %9 = load double, double* %arrayidx9, align 8
  %10 = load double*, double** %x.addr, align 8
  %11 = load i32, i32* %j, align 4
  %idxprom10 = sext i32 %11 to i64
  %arrayidx11 = getelementptr inbounds double, double* %10, i64 %idxprom10
  %12 = load double, double* %arrayidx11, align 8
  %mul = fmul double %9, %12
  %13 = load double*, double** %tmp.addr, align 8
  %14 = load i32, i32* %i, align 4
  %idxprom12 = sext i32 %14 to i64
  %arrayidx13 = getelementptr inbounds double, double* %13, i64 %idxprom12
  %15 = load double, double* %arrayidx13, align 8
  %add = fadd double %mul, %15
  %16 = load double*, double** %tmp.addr, align 8
  %17 = load i32, i32* %i, align 4
  %idxprom14 = sext i32 %17 to i64
  %arrayidx15 = getelementptr inbounds double, double* %16, i64 %idxprom14
  store double %add, double* %arrayidx15, align 8
  %18 = load [90 x double]*, [90 x double]** %B.addr, align 8
  %19 = load i32, i32* %i, align 4
  %idxprom16 = sext i32 %19 to i64
  %arrayidx17 = getelementptr inbounds [90 x double], [90 x double]* %18, i64 %idxprom16
  %20 = load i32, i32* %j, align 4
  %idxprom18 = sext i32 %20 to i64
  %arrayidx19 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx17, i64 0, i64 %idxprom18
  %21 = load double, double* %arrayidx19, align 8
  %22 = load double*, double** %x.addr, align 8
  %23 = load i32, i32* %j, align 4
  %idxprom20 = sext i32 %23 to i64
  %arrayidx21 = getelementptr inbounds double, double* %22, i64 %idxprom20
  %24 = load double, double* %arrayidx21, align 8
  %mul22 = fmul double %21, %24
  %25 = load double*, double** %y.addr, align 8
  %26 = load i32, i32* %i, align 4
  %idxprom23 = sext i32 %26 to i64
  %arrayidx24 = getelementptr inbounds double, double* %25, i64 %idxprom23
  %27 = load double, double* %arrayidx24, align 8
  %add25 = fadd double %mul22, %27
  %28 = load double*, double** %y.addr, align 8
  %29 = load i32, i32* %i, align 4
  %idxprom26 = sext i32 %29 to i64
  %arrayidx27 = getelementptr inbounds double, double* %28, i64 %idxprom26
  store double %add25, double* %arrayidx27, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body5
  %30 = load i32, i32* %j, align 4
  %inc = add nsw i32 %30, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond3, !llvm.loop !2

for.end:                                          ; preds = %for.cond3
  %31 = load double, double* %alpha.addr, align 8
  %32 = load double*, double** %tmp.addr, align 8
  %33 = load i32, i32* %i, align 4
  %idxprom28 = sext i32 %33 to i64
  %arrayidx29 = getelementptr inbounds double, double* %32, i64 %idxprom28
  %34 = load double, double* %arrayidx29, align 8
  %mul30 = fmul double %31, %34
  %35 = load double, double* %beta.addr, align 8
  %36 = load double*, double** %y.addr, align 8
  %37 = load i32, i32* %i, align 4
  %idxprom31 = sext i32 %37 to i64
  %arrayidx32 = getelementptr inbounds double, double* %36, i64 %idxprom31
  %38 = load double, double* %arrayidx32, align 8
  %mul33 = fmul double %35, %38
  %add34 = fadd double %mul30, %mul33
  %39 = load double*, double** %y.addr, align 8
  %40 = load i32, i32* %i, align 4
  %idxprom35 = sext i32 %40 to i64
  %arrayidx36 = getelementptr inbounds double, double* %39, i64 %idxprom35
  store double %add34, double* %arrayidx36, align 8
  br label %for.inc37

for.inc37:                                        ; preds = %for.end
  %41 = load i32, i32* %i, align 4
  %inc38 = add nsw i32 %41, 1
  store i32 %inc38, i32* %i, align 4
  br label %for.cond, !llvm.loop !4

for.end39:                                        ; preds = %for.cond
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
