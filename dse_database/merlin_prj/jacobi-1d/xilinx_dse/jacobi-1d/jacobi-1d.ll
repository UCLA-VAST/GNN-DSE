; ModuleID = 'jacobi-1d.c'
source_filename = "jacobi-1d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_jacobi_1d(i32 %tsteps, i32 %n, double* %A, double* %B) #0 {
entry:
  %tsteps.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca double*, align 8
  %B.addr = alloca double*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %tsteps, i32* %tsteps.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  store double* %A, double** %A.addr, align 8
  store double* %B, double** %B.addr, align 8
  store i32 0, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc31, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp slt i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end33

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %i, align 4
  %cmp2 = icmp slt i32 %1, 119
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %A.addr, align 8
  %3 = load i32, i32* %i, align 4
  %sub = sub nsw i32 %3, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom
  %4 = load double, double* %arrayidx, align 8
  %5 = load double*, double** %A.addr, align 8
  %6 = load i32, i32* %i, align 4
  %idxprom4 = sext i32 %6 to i64
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4
  %7 = load double, double* %arrayidx5, align 8
  %add = fadd double %4, %7
  %8 = load double*, double** %A.addr, align 8
  %9 = load i32, i32* %i, align 4
  %add6 = add nsw i32 %9, 1
  %idxprom7 = sext i32 %add6 to i64
  %arrayidx8 = getelementptr inbounds double, double* %8, i64 %idxprom7
  %10 = load double, double* %arrayidx8, align 8
  %add9 = fadd double %add, %10
  %mul = fmul double 3.333300e-01, %add9
  %11 = load double*, double** %B.addr, align 8
  %12 = load i32, i32* %i, align 4
  %idxprom10 = sext i32 %12 to i64
  %arrayidx11 = getelementptr inbounds double, double* %11, i64 %idxprom10
  store double %mul, double* %arrayidx11, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %13 = load i32, i32* %i, align 4
  %inc = add nsw i32 %13, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  store i32 1, i32* %i, align 4
  br label %for.cond12

for.cond12:                                       ; preds = %for.inc28, %for.end
  %14 = load i32, i32* %i, align 4
  %cmp13 = icmp slt i32 %14, 119
  br i1 %cmp13, label %for.body14, label %for.end30

for.body14:                                       ; preds = %for.cond12
  %15 = load double*, double** %B.addr, align 8
  %16 = load i32, i32* %i, align 4
  %sub15 = sub nsw i32 %16, 1
  %idxprom16 = sext i32 %sub15 to i64
  %arrayidx17 = getelementptr inbounds double, double* %15, i64 %idxprom16
  %17 = load double, double* %arrayidx17, align 8
  %18 = load double*, double** %B.addr, align 8
  %19 = load i32, i32* %i, align 4
  %idxprom18 = sext i32 %19 to i64
  %arrayidx19 = getelementptr inbounds double, double* %18, i64 %idxprom18
  %20 = load double, double* %arrayidx19, align 8
  %add20 = fadd double %17, %20
  %21 = load double*, double** %B.addr, align 8
  %22 = load i32, i32* %i, align 4
  %add21 = add nsw i32 %22, 1
  %idxprom22 = sext i32 %add21 to i64
  %arrayidx23 = getelementptr inbounds double, double* %21, i64 %idxprom22
  %23 = load double, double* %arrayidx23, align 8
  %add24 = fadd double %add20, %23
  %mul25 = fmul double 3.333300e-01, %add24
  %24 = load double*, double** %A.addr, align 8
  %25 = load i32, i32* %i, align 4
  %idxprom26 = sext i32 %25 to i64
  %arrayidx27 = getelementptr inbounds double, double* %24, i64 %idxprom26
  store double %mul25, double* %arrayidx27, align 8
  br label %for.inc28

for.inc28:                                        ; preds = %for.body14
  %26 = load i32, i32* %i, align 4
  %inc29 = add nsw i32 %26, 1
  store i32 %inc29, i32* %i, align 4
  br label %for.cond12, !llvm.loop !4

for.end30:                                        ; preds = %for.cond12
  br label %for.inc31

for.inc31:                                        ; preds = %for.end30
  %27 = load i32, i32* %t, align 4
  %inc32 = add nsw i32 %27, 1
  store i32 %inc32, i32* %t, align 4
  br label %for.cond, !llvm.loop !5

for.end33:                                        ; preds = %for.cond
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
