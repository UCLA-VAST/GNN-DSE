; ModuleID = 'seidel-2d.c'
source_filename = "seidel-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_seidel_2d(i32 %tsteps, i32 %n, [120 x double]* %A) #0 {
entry:
  %tsteps.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [120 x double]*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %tsteps, i32* %tsteps.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  store [120 x double]* %A, [120 x double]** %A.addr, align 8
  store i32 0, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc66, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp sle i32 %0, 39
  br i1 %cmp, label %for.body, label %for.end68

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc63, %for.body
  %1 = load i32, i32* %i, align 4
  %cmp2 = icmp sle i32 %1, 118
  br i1 %cmp2, label %for.body3, label %for.end65

for.body3:                                        ; preds = %for.cond1
  store i32 1, i32* %j, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %j, align 4
  %cmp5 = icmp sle i32 %2, 118
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %3 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %4 = load i32, i32* %i, align 4
  %sub = sub nsw i32 %4, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds [120 x double], [120 x double]* %3, i64 %idxprom
  %5 = load i32, i32* %j, align 4
  %sub7 = sub nsw i32 %5, 1
  %idxprom8 = sext i32 %sub7 to i64
  %arrayidx9 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx, i64 0, i64 %idxprom8
  %6 = load double, double* %arrayidx9, align 8
  %7 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %8 = load i32, i32* %i, align 4
  %sub10 = sub nsw i32 %8, 1
  %idxprom11 = sext i32 %sub10 to i64
  %arrayidx12 = getelementptr inbounds [120 x double], [120 x double]* %7, i64 %idxprom11
  %9 = load i32, i32* %j, align 4
  %idxprom13 = sext i32 %9 to i64
  %arrayidx14 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx12, i64 0, i64 %idxprom13
  %10 = load double, double* %arrayidx14, align 8
  %add = fadd double %6, %10
  %11 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %12 = load i32, i32* %i, align 4
  %sub15 = sub nsw i32 %12, 1
  %idxprom16 = sext i32 %sub15 to i64
  %arrayidx17 = getelementptr inbounds [120 x double], [120 x double]* %11, i64 %idxprom16
  %13 = load i32, i32* %j, align 4
  %add18 = add nsw i32 %13, 1
  %idxprom19 = sext i32 %add18 to i64
  %arrayidx20 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx17, i64 0, i64 %idxprom19
  %14 = load double, double* %arrayidx20, align 8
  %add21 = fadd double %add, %14
  %15 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %16 = load i32, i32* %i, align 4
  %idxprom22 = sext i32 %16 to i64
  %arrayidx23 = getelementptr inbounds [120 x double], [120 x double]* %15, i64 %idxprom22
  %17 = load i32, i32* %j, align 4
  %sub24 = sub nsw i32 %17, 1
  %idxprom25 = sext i32 %sub24 to i64
  %arrayidx26 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx23, i64 0, i64 %idxprom25
  %18 = load double, double* %arrayidx26, align 8
  %add27 = fadd double %add21, %18
  %19 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %20 = load i32, i32* %i, align 4
  %idxprom28 = sext i32 %20 to i64
  %arrayidx29 = getelementptr inbounds [120 x double], [120 x double]* %19, i64 %idxprom28
  %21 = load i32, i32* %j, align 4
  %idxprom30 = sext i32 %21 to i64
  %arrayidx31 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx29, i64 0, i64 %idxprom30
  %22 = load double, double* %arrayidx31, align 8
  %add32 = fadd double %add27, %22
  %23 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %24 = load i32, i32* %i, align 4
  %idxprom33 = sext i32 %24 to i64
  %arrayidx34 = getelementptr inbounds [120 x double], [120 x double]* %23, i64 %idxprom33
  %25 = load i32, i32* %j, align 4
  %add35 = add nsw i32 %25, 1
  %idxprom36 = sext i32 %add35 to i64
  %arrayidx37 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx34, i64 0, i64 %idxprom36
  %26 = load double, double* %arrayidx37, align 8
  %add38 = fadd double %add32, %26
  %27 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %28 = load i32, i32* %i, align 4
  %add39 = add nsw i32 %28, 1
  %idxprom40 = sext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds [120 x double], [120 x double]* %27, i64 %idxprom40
  %29 = load i32, i32* %j, align 4
  %sub42 = sub nsw i32 %29, 1
  %idxprom43 = sext i32 %sub42 to i64
  %arrayidx44 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx41, i64 0, i64 %idxprom43
  %30 = load double, double* %arrayidx44, align 8
  %add45 = fadd double %add38, %30
  %31 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %32 = load i32, i32* %i, align 4
  %add46 = add nsw i32 %32, 1
  %idxprom47 = sext i32 %add46 to i64
  %arrayidx48 = getelementptr inbounds [120 x double], [120 x double]* %31, i64 %idxprom47
  %33 = load i32, i32* %j, align 4
  %idxprom49 = sext i32 %33 to i64
  %arrayidx50 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx48, i64 0, i64 %idxprom49
  %34 = load double, double* %arrayidx50, align 8
  %add51 = fadd double %add45, %34
  %35 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %36 = load i32, i32* %i, align 4
  %add52 = add nsw i32 %36, 1
  %idxprom53 = sext i32 %add52 to i64
  %arrayidx54 = getelementptr inbounds [120 x double], [120 x double]* %35, i64 %idxprom53
  %37 = load i32, i32* %j, align 4
  %add55 = add nsw i32 %37, 1
  %idxprom56 = sext i32 %add55 to i64
  %arrayidx57 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx54, i64 0, i64 %idxprom56
  %38 = load double, double* %arrayidx57, align 8
  %add58 = fadd double %add51, %38
  %div = fdiv double %add58, 9.000000e+00
  %39 = load [120 x double]*, [120 x double]** %A.addr, align 8
  %40 = load i32, i32* %i, align 4
  %idxprom59 = sext i32 %40 to i64
  %arrayidx60 = getelementptr inbounds [120 x double], [120 x double]* %39, i64 %idxprom59
  %41 = load i32, i32* %j, align 4
  %idxprom61 = sext i32 %41 to i64
  %arrayidx62 = getelementptr inbounds [120 x double], [120 x double]* %arrayidx60, i64 0, i64 %idxprom61
  store double %div, double* %arrayidx62, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %42 = load i32, i32* %j, align 4
  %inc = add nsw i32 %42, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond4, !llvm.loop !2

for.end:                                          ; preds = %for.cond4
  br label %for.inc63

for.inc63:                                        ; preds = %for.end
  %43 = load i32, i32* %i, align 4
  %inc64 = add nsw i32 %43, 1
  store i32 %inc64, i32* %i, align 4
  br label %for.cond1, !llvm.loop !4

for.end65:                                        ; preds = %for.cond1
  br label %for.inc66

for.inc66:                                        ; preds = %for.end65
  %44 = load i32, i32* %t, align 4
  %inc67 = add nsw i32 %44, 1
  store i32 %inc67, i32* %t, align 4
  br label %for.cond, !llvm.loop !5

for.end68:                                        ; preds = %for.cond
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
