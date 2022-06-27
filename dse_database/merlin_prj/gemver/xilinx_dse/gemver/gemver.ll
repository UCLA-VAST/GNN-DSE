; ModuleID = 'gemver.c'
source_filename = "gemver.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_gemver(i32 %n, double %alpha, double %beta, [120 x double]* %A, double* %u1, double* %v1, double* %u2, double* %v2, double* %w, double* %x, double* %y, double* %z) #0 {
entry:
  %n.addr = alloca i32, align 4
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %A.addr = alloca [120 x double]*, align 8
  %u1.addr = alloca double*, align 8
  %v1.addr = alloca double*, align 8
  %u2.addr = alloca double*, align 8
  %v2.addr = alloca double*, align 8
  %w.addr = alloca double*, align 8
  %x.addr = alloca double*, align 8
  %y.addr = alloca double*, align 8
  %z.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  store double %alpha, double* %alpha.addr, align 8
  store double %beta, double* %beta.addr, align 8
  store [120 x double]* %A, [120 x double]** %A.addr, align 8
  store double* %u1, double** %u1.addr, align 8
  store double* %v1, double** %v1.addr, align 8
  store double* %u2, double** %u2.addr, align 8
  store double* %v2, double** %v2.addr, align 8
  store double* %w, double** %w.addr, align 8
  store double* %x, double** %x.addr, align 8
  store double* %y, double** %y.addr, align 8
  store double* %z, double** %z.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc16, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 120
  br i1 %cmp, label %for.body, label %for.end18

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 120
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %u1.addr, align 8
  %3 = load i32, i32* %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom
  %4 = load double, double* %arrayidx, align 8
  %5 = load double*, double** %v1.addr, align 8
  %6 = load i32, i32* %j, align 4
  %idxprom4 = sext i32 %6 to i64
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4
  %7 = load double, double* %arrayidx5, align 8
  %mul = fmul double %4, %7
  %8 = load double*, double** %u2.addr, align 8
  %9 = load i32, i32* %i, align 4
  %idxprom6 = sext i32 %9 to i64
  %arrayidx7 = getelementptr inbounds double, double* %8, i64 %idxprom6
  %10 = load double, double* %arrayidx7, align 8
  %11 = load double*, double** %v2.addr, align 8
  %12 = load i32, i32* %j, align 4
  %idxprom8 = sext i32 %12 to i64
  %arrayidx9 = getelementptr inbounds double, double* %11, i64 %idxprom8
  %13 = load double, double* %arrayidx9, align 8
  %mul10 = fmul double %10, %13
  %add = fadd double %mul, %mul10
  %14 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %15 = load i32, i32* %i, align 4
  %idxprom11 = sext i32 %15 to i64
  %arrayidx12 = getelementptr inbounds [120 x double], [120 x double]* %14, i64 %idxprom11
  %16 = load i32, i32* %j, align 4
  %idxprom13 = sext i32 %16 to i64
  %arrayidx14 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx12, i64 0, i64 %idxprom13
  %17 = load double, double* %arrayidx14, align 8
  %add15 = fadd double %17, %add
  store double %add15, double* %arrayidx14, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %18 = load i32, i32* %j, align 4
  %inc = add nsw i32 %18, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %19 = load i32, i32* %i, align 4
  %inc17 = add nsw i32 %19, 1
  store i32 %inc17, i32* %i, align 4
  br label %for.cond, !llvm.loop !4

for.end18:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond19

for.cond19:                                       ; preds = %for.inc39, %for.end18
  %20 = load i32, i32* %i, align 4
  %cmp20 = icmp slt i32 %20, 120
  br i1 %cmp20, label %for.body21, label %for.end41

for.body21:                                       ; preds = %for.cond19
  store i32 0, i32* %j, align 4
  br label %for.cond22

for.cond22:                                       ; preds = %for.inc36, %for.body21
  %21 = load i32, i32* %j, align 4
  %cmp23 = icmp slt i32 %21, 120
  br i1 %cmp23, label %for.body24, label %for.end38

for.body24:                                       ; preds = %for.cond22
  %22 = load double, double* %beta.addr, align 8
  %23 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %24 = load i32, i32* %j, align 4
  %idxprom25 = sext i32 %24 to i64
  %arrayidx26 = getelementptr inbounds [120 x double], [120 x double]* %23, i64 %idxprom25
  %25 = load i32, i32* %i, align 4
  %idxprom27 = sext i32 %25 to i64
  %arrayidx28 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx26, i64 0, i64 %idxprom27
  %26 = load double, double* %arrayidx28, align 8
  %mul29 = fmul double %22, %26
  %27 = load double*, double** %y.addr, align 8
  %28 = load i32, i32* %j, align 4
  %idxprom30 = sext i32 %28 to i64
  %arrayidx31 = getelementptr inbounds double, double* %27, i64 %idxprom30
  %29 = load double, double* %arrayidx31, align 8
  %mul32 = fmul double %mul29, %29
  %30 = load double*, double** %x.addr, align 8
  %31 = load i32, i32* %i, align 4
  %idxprom33 = sext i32 %31 to i64
  %arrayidx34 = getelementptr inbounds double, double* %30, i64 %idxprom33
  %32 = load double, double* %arrayidx34, align 8
  %add35 = fadd double %32, %mul32
  store double %add35, double* %arrayidx34, align 8
  br label %for.inc36

for.inc36:                                        ; preds = %for.body24
  %33 = load i32, i32* %j, align 4
  %inc37 = add nsw i32 %33, 1
  store i32 %inc37, i32* %j, align 4
  br label %for.cond22, !llvm.loop !5

for.end38:                                        ; preds = %for.cond22
  br label %for.inc39

for.inc39:                                        ; preds = %for.end38
  %34 = load i32, i32* %i, align 4
  %inc40 = add nsw i32 %34, 1
  store i32 %inc40, i32* %i, align 4
  br label %for.cond19, !llvm.loop !6

for.end41:                                        ; preds = %for.cond19
  store i32 0, i32* %i, align 4
  br label %for.cond42

for.cond42:                                       ; preds = %for.inc50, %for.end41
  %35 = load i32, i32* %i, align 4
  %cmp43 = icmp slt i32 %35, 120
  br i1 %cmp43, label %for.body44, label %for.end52

for.body44:                                       ; preds = %for.cond42
  %36 = load double*, double** %z.addr, align 8
  %37 = load i32, i32* %i, align 4
  %idxprom45 = sext i32 %37 to i64
  %arrayidx46 = getelementptr inbounds double, double* %36, i64 %idxprom45
  %38 = load double, double* %arrayidx46, align 8
  %39 = load double*, double** %x.addr, align 8
  %40 = load i32, i32* %i, align 4
  %idxprom47 = sext i32 %40 to i64
  %arrayidx48 = getelementptr inbounds double, double* %39, i64 %idxprom47
  %41 = load double, double* %arrayidx48, align 8
  %add49 = fadd double %41, %38
  store double %add49, double* %arrayidx48, align 8
  br label %for.inc50

for.inc50:                                        ; preds = %for.body44
  %42 = load i32, i32* %i, align 4
  %inc51 = add nsw i32 %42, 1
  store i32 %inc51, i32* %i, align 4
  br label %for.cond42, !llvm.loop !7

for.end52:                                        ; preds = %for.cond42
  store i32 0, i32* %i, align 4
  br label %for.cond53

for.cond53:                                       ; preds = %for.inc73, %for.end52
  %43 = load i32, i32* %i, align 4
  %cmp54 = icmp slt i32 %43, 120
  br i1 %cmp54, label %for.body55, label %for.end75

for.body55:                                       ; preds = %for.cond53
  store i32 0, i32* %j, align 4
  br label %for.cond56

for.cond56:                                       ; preds = %for.inc70, %for.body55
  %44 = load i32, i32* %j, align 4
  %cmp57 = icmp slt i32 %44, 120
  br i1 %cmp57, label %for.body58, label %for.end72

for.body58:                                       ; preds = %for.cond56
  %45 = load double, double* %alpha.addr, align 8
  %46 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %47 = load i32, i32* %i, align 4
  %idxprom59 = sext i32 %47 to i64
  %arrayidx60 = getelementptr inbounds [120 x double], [120 x double]* %46, i64 %idxprom59
  %48 = load i32, i32* %j, align 4
  %idxprom61 = sext i32 %48 to i64
  %arrayidx62 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx60, i64 0, i64 %idxprom61
  %49 = load double, double* %arrayidx62, align 8
  %mul63 = fmul double %45, %49
  %50 = load double*, double** %x.addr, align 8
  %51 = load i32, i32* %j, align 4
  %idxprom64 = sext i32 %51 to i64
  %arrayidx65 = getelementptr inbounds double, double* %50, i64 %idxprom64
  %52 = load double, double* %arrayidx65, align 8
  %mul66 = fmul double %mul63, %52
  %53 = load double*, double** %w.addr, align 8
  %54 = load i32, i32* %i, align 4
  %idxprom67 = sext i32 %54 to i64
  %arrayidx68 = getelementptr inbounds double, double* %53, i64 %idxprom67
  %55 = load double, double* %arrayidx68, align 8
  %add69 = fadd double %55, %mul66
  store double %add69, double* %arrayidx68, align 8
  br label %for.inc70

for.inc70:                                        ; preds = %for.body58
  %56 = load i32, i32* %j, align 4
  %inc71 = add nsw i32 %56, 1
  store i32 %inc71, i32* %j, align 4
  br label %for.cond56, !llvm.loop !8

for.end72:                                        ; preds = %for.cond56
  br label %for.inc73

for.inc73:                                        ; preds = %for.end72
  %57 = load i32, i32* %i, align 4
  %inc74 = add nsw i32 %57, 1
  store i32 %inc74, i32* %i, align 4
  br label %for.cond53, !llvm.loop !9

for.end75:                                        ; preds = %for.cond53
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
!8 = distinct !{!8, !3}
!9 = distinct !{!9, !3}
