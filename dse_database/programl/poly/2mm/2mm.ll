; ModuleID = '/home/atefehSZ/polybench-c-4.2.1-beta/linear-algebra/kernels/2mm_dse/xilinx_dse/2mm/2mm.c'
source_filename = "/home/atefehSZ/polybench-c-4.2.1-beta/linear-algebra/kernels/2mm_dse/xilinx_dse/2mm/2mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_2mm(i32 %ni, i32 %nj, i32 %nk, i32 %nl, double %alpha, double %beta, [50 x double]* %tmp, [70 x double]* %A, [50 x double]* %B, [80 x double]* %C, [80 x double]* %D) #0 {
entry:
  %ni.addr = alloca i32, align 4
  %nj.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %nl.addr = alloca i32, align 4
  %alpha.addr = alloca double, align 8
  %beta.addr = alloca double, align 8
  %tmp.addr = alloca [50 x double]*, align 8
  %A.addr = alloca [70 x double]*, align 8
  %B.addr = alloca [50 x double]*, align 8
  %C.addr = alloca [80 x double]*, align 8
  %D.addr = alloca [80 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %ni, i32* %ni.addr, align 4
  store i32 %nj, i32* %nj.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  store i32 %nl, i32* %nl.addr, align 4
  store double %alpha, double* %alpha.addr, align 8
  store double %beta, double* %beta.addr, align 8
  store [50 x double]* %tmp, [50 x double]** %tmp.addr, align 8
  store [70 x double]* %A, [70 x double]** %A.addr, align 8
  store [50 x double]* %B, [50 x double]** %B.addr, align 8
  store [80 x double]* %C, [80 x double]** %C.addr, align 8
  store [80 x double]* %D, [80 x double]** %D.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc25, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end27

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc22, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 50
  br i1 %cmp2, label %for.body3, label %for.end24

for.body3:                                        ; preds = %for.cond1
  %2 = load [50 x double]*, [50 x double]** %tmp.addr, align 8
  %3 = load i32, i32* %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds [50 x double], [50 x double]* %2, i64 %idxprom
  %4 = load i32, i32* %j, align 4
  %idxprom4 = sext i32 %4 to i64
  %arrayidx5 = getelementptr inbounds [50 x double], [50 x double]* %arrayidx, i64 0, i64 %idxprom4
  store double 0.000000e+00, double* %arrayidx5, align 8
  store i32 0, i32* %k, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc, %for.body3
  %5 = load i32, i32* %k, align 4
  %cmp7 = icmp slt i32 %5, 70
  br i1 %cmp7, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond6
  %6 = load double, double* %alpha.addr, align 8
  %7 = load [70 x double]*, [70 x double]** %A.addr, align 8
  %8 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %8 to i64
  %arrayidx10 = getelementptr inbounds [70 x double], [70 x double]* %7, i64 %idxprom9
  %9 = load i32, i32* %k, align 4
  %idxprom11 = sext i32 %9 to i64
  %arrayidx12 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx10, i64 0, i64 %idxprom11
  %10 = load double, double* %arrayidx12, align 8
  %mul = fmul double %6, %10
  %11 = load [50 x double]*, [50 x double]** %B.addr, align 8
  %12 = load i32, i32* %k, align 4
  %idxprom13 = sext i32 %12 to i64
  %arrayidx14 = getelementptr inbounds [50 x double], [50 x double]* %11, i64 %idxprom13
  %13 = load i32, i32* %j, align 4
  %idxprom15 = sext i32 %13 to i64
  %arrayidx16 = getelementptr inbounds [50 x double], [50 x double]* %arrayidx14, i64 0, i64 %idxprom15
  %14 = load double, double* %arrayidx16, align 8
  %mul17 = fmul double %mul, %14
  %15 = load [50 x double]*, [50 x double]** %tmp.addr, align 8
  %16 = load i32, i32* %i, align 4
  %idxprom18 = sext i32 %16 to i64
  %arrayidx19 = getelementptr inbounds [50 x double], [50 x double]* %15, i64 %idxprom18
  %17 = load i32, i32* %j, align 4
  %idxprom20 = sext i32 %17 to i64
  %arrayidx21 = getelementptr inbounds [50 x double], [50 x double]* %arrayidx19, i64 0, i64 %idxprom20
  %18 = load double, double* %arrayidx21, align 8
  %add = fadd double %18, %mul17
  store double %add, double* %arrayidx21, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %19 = load i32, i32* %k, align 4
  %inc = add nsw i32 %19, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond6, !llvm.loop !2

for.end:                                          ; preds = %for.cond6
  br label %for.inc22

for.inc22:                                        ; preds = %for.end
  %20 = load i32, i32* %j, align 4
  %inc23 = add nsw i32 %20, 1
  store i32 %inc23, i32* %j, align 4
  br label %for.cond1, !llvm.loop !4

for.end24:                                        ; preds = %for.cond1
  br label %for.inc25

for.inc25:                                        ; preds = %for.end24
  %21 = load i32, i32* %i, align 4
  %inc26 = add nsw i32 %21, 1
  store i32 %inc26, i32* %i, align 4
  br label %for.cond, !llvm.loop !5

for.end27:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc62, %for.end27
  %22 = load i32, i32* %i, align 4
  %cmp29 = icmp slt i32 %22, 40
  br i1 %cmp29, label %for.body30, label %for.end64

for.body30:                                       ; preds = %for.cond28
  store i32 0, i32* %j, align 4
  br label %for.cond31

for.cond31:                                       ; preds = %for.inc59, %for.body30
  %23 = load i32, i32* %j, align 4
  %cmp32 = icmp slt i32 %23, 80
  br i1 %cmp32, label %for.body33, label %for.end61

for.body33:                                       ; preds = %for.cond31
  %24 = load double, double* %beta.addr, align 8
  %25 = load [80 x double]*, [80 x double]** %D.addr, align 8
  %26 = load i32, i32* %i, align 4
  %idxprom34 = sext i32 %26 to i64
  %arrayidx35 = getelementptr inbounds [80 x double], [80 x double]* %25, i64 %idxprom34
  %27 = load i32, i32* %j, align 4
  %idxprom36 = sext i32 %27 to i64
  %arrayidx37 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx35, i64 0, i64 %idxprom36
  %28 = load double, double* %arrayidx37, align 8
  %mul38 = fmul double %28, %24
  store double %mul38, double* %arrayidx37, align 8
  store i32 0, i32* %k, align 4
  br label %for.cond39

for.cond39:                                       ; preds = %for.inc56, %for.body33
  %29 = load i32, i32* %k, align 4
  %cmp40 = icmp slt i32 %29, 50
  br i1 %cmp40, label %for.body41, label %for.end58

for.body41:                                       ; preds = %for.cond39
  %30 = load [50 x double]*, [50 x double]** %tmp.addr, align 8
  %31 = load i32, i32* %i, align 4
  %idxprom42 = sext i32 %31 to i64
  %arrayidx43 = getelementptr inbounds [50 x double], [50 x double]* %30, i64 %idxprom42
  %32 = load i32, i32* %k, align 4
  %idxprom44 = sext i32 %32 to i64
  %arrayidx45 = getelementptr inbounds [50 x double], [50 x double]* %arrayidx43, i64 0, i64 %idxprom44
  %33 = load double, double* %arrayidx45, align 8
  %34 = load [80 x double]*, [80 x double]** %C.addr, align 8
  %35 = load i32, i32* %k, align 4
  %idxprom46 = sext i32 %35 to i64
  %arrayidx47 = getelementptr inbounds [80 x double], [80 x double]* %34, i64 %idxprom46
  %36 = load i32, i32* %j, align 4
  %idxprom48 = sext i32 %36 to i64
  %arrayidx49 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx47, i64 0, i64 %idxprom48
  %37 = load double, double* %arrayidx49, align 8
  %mul50 = fmul double %33, %37
  %38 = load [80 x double]*, [80 x double]** %D.addr, align 8
  %39 = load i32, i32* %i, align 4
  %idxprom51 = sext i32 %39 to i64
  %arrayidx52 = getelementptr inbounds [80 x double], [80 x double]* %38, i64 %idxprom51
  %40 = load i32, i32* %j, align 4
  %idxprom53 = sext i32 %40 to i64
  %arrayidx54 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx52, i64 0, i64 %idxprom53
  %41 = load double, double* %arrayidx54, align 8
  %add55 = fadd double %41, %mul50
  store double %add55, double* %arrayidx54, align 8
  br label %for.inc56

for.inc56:                                        ; preds = %for.body41
  %42 = load i32, i32* %k, align 4
  %inc57 = add nsw i32 %42, 1
  store i32 %inc57, i32* %k, align 4
  br label %for.cond39, !llvm.loop !6

for.end58:                                        ; preds = %for.cond39
  br label %for.inc59

for.inc59:                                        ; preds = %for.end58
  %43 = load i32, i32* %j, align 4
  %inc60 = add nsw i32 %43, 1
  store i32 %inc60, i32* %j, align 4
  br label %for.cond31, !llvm.loop !7

for.end61:                                        ; preds = %for.cond31
  br label %for.inc62

for.inc62:                                        ; preds = %for.end61
  %44 = load i32, i32* %i, align 4
  %inc63 = add nsw i32 %44, 1
  store i32 %inc63, i32* %i, align 4
  br label %for.cond28, !llvm.loop !8

for.end64:                                        ; preds = %for.cond28
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
