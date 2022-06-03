; ModuleID = 'jacobi-2d.c'
source_filename = "jacobi-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_jacobi_2d(i32 %tsteps, i32 %n, [90 x double]* %A, [90 x double]* %B) #0 {
entry:
  %tsteps.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [90 x double]*, align 8
  %B.addr = alloca [90 x double]*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %tsteps, i32* %tsteps.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  store [90 x double]* %A, [90 x double]** %A.addr, align 8
  store [90 x double]* %B, [90 x double]** %B.addr, align 8
  store i32 0, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc83, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp slt i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end85

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc35, %for.body
  %1 = load i32, i32* %i, align 4
  %cmp2 = icmp slt i32 %1, 89
  br i1 %cmp2, label %for.body3, label %for.end37

for.body3:                                        ; preds = %for.cond1
  store i32 1, i32* %j, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %j, align 4
  %cmp5 = icmp slt i32 %2, 89
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %3 = load [90 x double]*, [90 x double]** %A.addr, align 8
  %4 = load i32, i32* %i, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds [90 x double], [90 x double]* %3, i64 %idxprom
  %5 = load i32, i32* %j, align 4
  %idxprom7 = sext i32 %5 to i64
  %arrayidx8 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx, i64 0, i64 %idxprom7
  %6 = load double, double* %arrayidx8, align 8
  %7 = load [90 x double]*, [90 x double]** %A.addr, align 8
  %8 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %8 to i64
  %arrayidx10 = getelementptr inbounds [90 x double], [90 x double]* %7, i64 %idxprom9
  %9 = load i32, i32* %j, align 4
  %sub = sub nsw i32 %9, 1
  %idxprom11 = sext i32 %sub to i64
  %arrayidx12 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx10, i64 0, i64 %idxprom11
  %10 = load double, double* %arrayidx12, align 8
  %add = fadd double %6, %10
  %11 = load [90 x double]*, [90 x double]** %A.addr, align 8
  %12 = load i32, i32* %i, align 4
  %idxprom13 = sext i32 %12 to i64
  %arrayidx14 = getelementptr inbounds [90 x double], [90 x double]* %11, i64 %idxprom13
  %13 = load i32, i32* %j, align 4
  %add15 = add nsw i32 1, %13
  %idxprom16 = sext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx14, i64 0, i64 %idxprom16
  %14 = load double, double* %arrayidx17, align 8
  %add18 = fadd double %add, %14
  %15 = load [90 x double]*, [90 x double]** %A.addr, align 8
  %16 = load i32, i32* %i, align 4
  %add19 = add nsw i32 1, %16
  %idxprom20 = sext i32 %add19 to i64
  %arrayidx21 = getelementptr inbounds [90 x double], [90 x double]* %15, i64 %idxprom20
  %17 = load i32, i32* %j, align 4
  %idxprom22 = sext i32 %17 to i64
  %arrayidx23 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx21, i64 0, i64 %idxprom22
  %18 = load double, double* %arrayidx23, align 8
  %add24 = fadd double %add18, %18
  %19 = load [90 x double]*, [90 x double]** %A.addr, align 8
  %20 = load i32, i32* %i, align 4
  %sub25 = sub nsw i32 %20, 1
  %idxprom26 = sext i32 %sub25 to i64
  %arrayidx27 = getelementptr inbounds [90 x double], [90 x double]* %19, i64 %idxprom26
  %21 = load i32, i32* %j, align 4
  %idxprom28 = sext i32 %21 to i64
  %arrayidx29 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx27, i64 0, i64 %idxprom28
  %22 = load double, double* %arrayidx29, align 8
  %add30 = fadd double %add24, %22
  %mul = fmul double 2.000000e-01, %add30
  %23 = load [90 x double]*, [90 x double]** %B.addr, align 8
  %24 = load i32, i32* %i, align 4
  %idxprom31 = sext i32 %24 to i64
  %arrayidx32 = getelementptr inbounds [90 x double], [90 x double]* %23, i64 %idxprom31
  %25 = load i32, i32* %j, align 4
  %idxprom33 = sext i32 %25 to i64
  %arrayidx34 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx32, i64 0, i64 %idxprom33
  store double %mul, double* %arrayidx34, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %26 = load i32, i32* %j, align 4
  %inc = add nsw i32 %26, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond4, !llvm.loop !2

for.end:                                          ; preds = %for.cond4
  br label %for.inc35

for.inc35:                                        ; preds = %for.end
  %27 = load i32, i32* %i, align 4
  %inc36 = add nsw i32 %27, 1
  store i32 %inc36, i32* %i, align 4
  br label %for.cond1, !llvm.loop !4

for.end37:                                        ; preds = %for.cond1
  store i32 1, i32* %i, align 4
  br label %for.cond38

for.cond38:                                       ; preds = %for.inc80, %for.end37
  %28 = load i32, i32* %i, align 4
  %cmp39 = icmp slt i32 %28, 89
  br i1 %cmp39, label %for.body40, label %for.end82

for.body40:                                       ; preds = %for.cond38
  store i32 1, i32* %j, align 4
  br label %for.cond41

for.cond41:                                       ; preds = %for.inc77, %for.body40
  %29 = load i32, i32* %j, align 4
  %cmp42 = icmp slt i32 %29, 89
  br i1 %cmp42, label %for.body43, label %for.end79

for.body43:                                       ; preds = %for.cond41
  %30 = load [90 x double]*, [90 x double]** %B.addr, align 8
  %31 = load i32, i32* %i, align 4
  %idxprom44 = sext i32 %31 to i64
  %arrayidx45 = getelementptr inbounds [90 x double], [90 x double]* %30, i64 %idxprom44
  %32 = load i32, i32* %j, align 4
  %idxprom46 = sext i32 %32 to i64
  %arrayidx47 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx45, i64 0, i64 %idxprom46
  %33 = load double, double* %arrayidx47, align 8
  %34 = load [90 x double]*, [90 x double]** %B.addr, align 8
  %35 = load i32, i32* %i, align 4
  %idxprom48 = sext i32 %35 to i64
  %arrayidx49 = getelementptr inbounds [90 x double], [90 x double]* %34, i64 %idxprom48
  %36 = load i32, i32* %j, align 4
  %sub50 = sub nsw i32 %36, 1
  %idxprom51 = sext i32 %sub50 to i64
  %arrayidx52 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx49, i64 0, i64 %idxprom51
  %37 = load double, double* %arrayidx52, align 8
  %add53 = fadd double %33, %37
  %38 = load [90 x double]*, [90 x double]** %B.addr, align 8
  %39 = load i32, i32* %i, align 4
  %idxprom54 = sext i32 %39 to i64
  %arrayidx55 = getelementptr inbounds [90 x double], [90 x double]* %38, i64 %idxprom54
  %40 = load i32, i32* %j, align 4
  %add56 = add nsw i32 1, %40
  %idxprom57 = sext i32 %add56 to i64
  %arrayidx58 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx55, i64 0, i64 %idxprom57
  %41 = load double, double* %arrayidx58, align 8
  %add59 = fadd double %add53, %41
  %42 = load [90 x double]*, [90 x double]** %B.addr, align 8
  %43 = load i32, i32* %i, align 4
  %add60 = add nsw i32 1, %43
  %idxprom61 = sext i32 %add60 to i64
  %arrayidx62 = getelementptr inbounds [90 x double], [90 x double]* %42, i64 %idxprom61
  %44 = load i32, i32* %j, align 4
  %idxprom63 = sext i32 %44 to i64
  %arrayidx64 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx62, i64 0, i64 %idxprom63
  %45 = load double, double* %arrayidx64, align 8
  %add65 = fadd double %add59, %45
  %46 = load [90 x double]*, [90 x double]** %B.addr, align 8
  %47 = load i32, i32* %i, align 4
  %sub66 = sub nsw i32 %47, 1
  %idxprom67 = sext i32 %sub66 to i64
  %arrayidx68 = getelementptr inbounds [90 x double], [90 x double]* %46, i64 %idxprom67
  %48 = load i32, i32* %j, align 4
  %idxprom69 = sext i32 %48 to i64
  %arrayidx70 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx68, i64 0, i64 %idxprom69
  %49 = load double, double* %arrayidx70, align 8
  %add71 = fadd double %add65, %49
  %mul72 = fmul double 2.000000e-01, %add71
  %50 = load [90 x double]*, [90 x double]** %A.addr, align 8
  %51 = load i32, i32* %i, align 4
  %idxprom73 = sext i32 %51 to i64
  %arrayidx74 = getelementptr inbounds [90 x double], [90 x double]* %50, i64 %idxprom73
  %52 = load i32, i32* %j, align 4
  %idxprom75 = sext i32 %52 to i64
  %arrayidx76 = getelementptr inbounds [90 x double], [90 x double]* %arrayidx74, i64 0, i64 %idxprom75
  store double %mul72, double* %arrayidx76, align 8
  br label %for.inc77

for.inc77:                                        ; preds = %for.body43
  %53 = load i32, i32* %j, align 4
  %inc78 = add nsw i32 %53, 1
  store i32 %inc78, i32* %j, align 4
  br label %for.cond41, !llvm.loop !5

for.end79:                                        ; preds = %for.cond41
  br label %for.inc80

for.inc80:                                        ; preds = %for.end79
  %54 = load i32, i32* %i, align 4
  %inc81 = add nsw i32 %54, 1
  store i32 %inc81, i32* %i, align 4
  br label %for.cond38, !llvm.loop !6

for.end82:                                        ; preds = %for.cond38
  br label %for.inc83

for.inc83:                                        ; preds = %for.end82
  %55 = load i32, i32* %t, align 4
  %inc84 = add nsw i32 %55, 1
  store i32 %inc84, i32* %t, align 4
  br label %for.cond, !llvm.loop !7

for.end85:                                        ; preds = %for.cond
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
