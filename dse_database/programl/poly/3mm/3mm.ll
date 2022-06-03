; ModuleID = '3mm.c'
source_filename = "3mm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_3mm(i32 %ni, i32 %nj, i32 %nk, i32 %nl, i32 %nm, [50 x double]* %E, [60 x double]* %A, [50 x double]* %B, [70 x double]* %F, [80 x double]* %C, [70 x double]* %D, [70 x double]* %G) #0 {
entry:
  %ni.addr = alloca i32, align 4
  %nj.addr = alloca i32, align 4
  %nk.addr = alloca i32, align 4
  %nl.addr = alloca i32, align 4
  %nm.addr = alloca i32, align 4
  %E.addr = alloca [50 x double]*, align 8
  %A.addr = alloca [60 x double]*, align 8
  %B.addr = alloca [50 x double]*, align 8
  %F.addr = alloca [70 x double]*, align 8
  %C.addr = alloca [80 x double]*, align 8
  %D.addr = alloca [70 x double]*, align 8
  %G.addr = alloca [70 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %ni, i32* %ni.addr, align 4
  store i32 %nj, i32* %nj.addr, align 4
  store i32 %nk, i32* %nk.addr, align 4
  store i32 %nl, i32* %nl.addr, align 4
  store i32 %nm, i32* %nm.addr, align 4
  store [50 x double]* %E, [50 x double]** %E.addr, align 8
  store [60 x double]* %A, [60 x double]** %A.addr, align 8
  store [50 x double]* %B, [50 x double]** %B.addr, align 8
  store [70 x double]* %F, [70 x double]** %F.addr, align 8
  store [80 x double]* %C, [80 x double]** %C.addr, align 8
  store [70 x double]* %D, [70 x double]** %D.addr, align 8
  store [70 x double]* %G, [70 x double]** %G.addr, align 8
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc24, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end26

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc21, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 50
  br i1 %cmp2, label %for.body3, label %for.end23

for.body3:                                        ; preds = %for.cond1
  %2 = load [50 x double]*, [50 x double]** %E.addr, align 8
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
  %cmp7 = icmp slt i32 %5, 60
  br i1 %cmp7, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond6
  %6 = load [60 x double]*, [60 x double]** %A.addr, align 8
  %7 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %7 to i64
  %arrayidx10 = getelementptr inbounds [60 x double], [60 x double]* %6, i64 %idxprom9
  %8 = load i32, i32* %k, align 4
  %idxprom11 = sext i32 %8 to i64
  %arrayidx12 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx10, i64 0, i64 %idxprom11
  %9 = load double, double* %arrayidx12, align 8
  %10 = load [50 x double]*, [50 x double]** %B.addr, align 8
  %11 = load i32, i32* %k, align 4
  %idxprom13 = sext i32 %11 to i64
  %arrayidx14 = getelementptr inbounds [50 x double], [50 x double]* %10, i64 %idxprom13
  %12 = load i32, i32* %j, align 4
  %idxprom15 = sext i32 %12 to i64
  %arrayidx16 = getelementptr inbounds [50 x double], [50 x double]* %arrayidx14, i64 0, i64 %idxprom15
  %13 = load double, double* %arrayidx16, align 8
  %mul = fmul double %9, %13
  %14 = load [50 x double]*, [50 x double]** %E.addr, align 8
  %15 = load i32, i32* %i, align 4
  %idxprom17 = sext i32 %15 to i64
  %arrayidx18 = getelementptr inbounds [50 x double], [50 x double]* %14, i64 %idxprom17
  %16 = load i32, i32* %j, align 4
  %idxprom19 = sext i32 %16 to i64
  %arrayidx20 = getelementptr inbounds [50 x double], [50 x double]* %arrayidx18, i64 0, i64 %idxprom19
  %17 = load double, double* %arrayidx20, align 8
  %add = fadd double %17, %mul
  store double %add, double* %arrayidx20, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %18 = load i32, i32* %k, align 4
  %inc = add nsw i32 %18, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond6, !llvm.loop !2

for.end:                                          ; preds = %for.cond6
  br label %for.inc21

for.inc21:                                        ; preds = %for.end
  %19 = load i32, i32* %j, align 4
  %inc22 = add nsw i32 %19, 1
  store i32 %inc22, i32* %j, align 4
  br label %for.cond1, !llvm.loop !4

for.end23:                                        ; preds = %for.cond1
  br label %for.inc24

for.inc24:                                        ; preds = %for.end23
  %20 = load i32, i32* %i, align 4
  %inc25 = add nsw i32 %20, 1
  store i32 %inc25, i32* %i, align 4
  br label %for.cond, !llvm.loop !5

for.end26:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond27

for.cond27:                                       ; preds = %for.inc60, %for.end26
  %21 = load i32, i32* %i, align 4
  %cmp28 = icmp slt i32 %21, 50
  br i1 %cmp28, label %for.body29, label %for.end62

for.body29:                                       ; preds = %for.cond27
  store i32 0, i32* %j, align 4
  br label %for.cond30

for.cond30:                                       ; preds = %for.inc57, %for.body29
  %22 = load i32, i32* %j, align 4
  %cmp31 = icmp slt i32 %22, 70
  br i1 %cmp31, label %for.body32, label %for.end59

for.body32:                                       ; preds = %for.cond30
  %23 = load [70 x double]*, [70 x double]** %F.addr, align 8
  %24 = load i32, i32* %i, align 4
  %idxprom33 = sext i32 %24 to i64
  %arrayidx34 = getelementptr inbounds [70 x double], [70 x double]* %23, i64 %idxprom33
  %25 = load i32, i32* %j, align 4
  %idxprom35 = sext i32 %25 to i64
  %arrayidx36 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx34, i64 0, i64 %idxprom35
  store double 0.000000e+00, double* %arrayidx36, align 8
  store i32 0, i32* %k, align 4
  br label %for.cond37

for.cond37:                                       ; preds = %for.inc54, %for.body32
  %26 = load i32, i32* %k, align 4
  %cmp38 = icmp slt i32 %26, 80
  br i1 %cmp38, label %for.body39, label %for.end56

for.body39:                                       ; preds = %for.cond37
  %27 = load [80 x double]*, [80 x double]** %C.addr, align 8
  %28 = load i32, i32* %i, align 4
  %idxprom40 = sext i32 %28 to i64
  %arrayidx41 = getelementptr inbounds [80 x double], [80 x double]* %27, i64 %idxprom40
  %29 = load i32, i32* %k, align 4
  %idxprom42 = sext i32 %29 to i64
  %arrayidx43 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx41, i64 0, i64 %idxprom42
  %30 = load double, double* %arrayidx43, align 8
  %31 = load [70 x double]*, [70 x double]** %D.addr, align 8
  %32 = load i32, i32* %k, align 4
  %idxprom44 = sext i32 %32 to i64
  %arrayidx45 = getelementptr inbounds [70 x double], [70 x double]* %31, i64 %idxprom44
  %33 = load i32, i32* %j, align 4
  %idxprom46 = sext i32 %33 to i64
  %arrayidx47 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx45, i64 0, i64 %idxprom46
  %34 = load double, double* %arrayidx47, align 8
  %mul48 = fmul double %30, %34
  %35 = load [70 x double]*, [70 x double]** %F.addr, align 8
  %36 = load i32, i32* %i, align 4
  %idxprom49 = sext i32 %36 to i64
  %arrayidx50 = getelementptr inbounds [70 x double], [70 x double]* %35, i64 %idxprom49
  %37 = load i32, i32* %j, align 4
  %idxprom51 = sext i32 %37 to i64
  %arrayidx52 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx50, i64 0, i64 %idxprom51
  %38 = load double, double* %arrayidx52, align 8
  %add53 = fadd double %38, %mul48
  store double %add53, double* %arrayidx52, align 8
  br label %for.inc54

for.inc54:                                        ; preds = %for.body39
  %39 = load i32, i32* %k, align 4
  %inc55 = add nsw i32 %39, 1
  store i32 %inc55, i32* %k, align 4
  br label %for.cond37, !llvm.loop !6

for.end56:                                        ; preds = %for.cond37
  br label %for.inc57

for.inc57:                                        ; preds = %for.end56
  %40 = load i32, i32* %j, align 4
  %inc58 = add nsw i32 %40, 1
  store i32 %inc58, i32* %j, align 4
  br label %for.cond30, !llvm.loop !7

for.end59:                                        ; preds = %for.cond30
  br label %for.inc60

for.inc60:                                        ; preds = %for.end59
  %41 = load i32, i32* %i, align 4
  %inc61 = add nsw i32 %41, 1
  store i32 %inc61, i32* %i, align 4
  br label %for.cond27, !llvm.loop !8

for.end62:                                        ; preds = %for.cond27
  store i32 0, i32* %i, align 4
  br label %for.cond63

for.cond63:                                       ; preds = %for.inc96, %for.end62
  %42 = load i32, i32* %i, align 4
  %cmp64 = icmp slt i32 %42, 40
  br i1 %cmp64, label %for.body65, label %for.end98

for.body65:                                       ; preds = %for.cond63
  store i32 0, i32* %j, align 4
  br label %for.cond66

for.cond66:                                       ; preds = %for.inc93, %for.body65
  %43 = load i32, i32* %j, align 4
  %cmp67 = icmp slt i32 %43, 70
  br i1 %cmp67, label %for.body68, label %for.end95

for.body68:                                       ; preds = %for.cond66
  %44 = load [70 x double]*, [70 x double]** %G.addr, align 8
  %45 = load i32, i32* %i, align 4
  %idxprom69 = sext i32 %45 to i64
  %arrayidx70 = getelementptr inbounds [70 x double], [70 x double]* %44, i64 %idxprom69
  %46 = load i32, i32* %j, align 4
  %idxprom71 = sext i32 %46 to i64
  %arrayidx72 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx70, i64 0, i64 %idxprom71
  store double 0.000000e+00, double* %arrayidx72, align 8
  store i32 0, i32* %k, align 4
  br label %for.cond73

for.cond73:                                       ; preds = %for.inc90, %for.body68
  %47 = load i32, i32* %k, align 4
  %cmp74 = icmp slt i32 %47, 50
  br i1 %cmp74, label %for.body75, label %for.end92

for.body75:                                       ; preds = %for.cond73
  %48 = load [50 x double]*, [50 x double]** %E.addr, align 8
  %49 = load i32, i32* %i, align 4
  %idxprom76 = sext i32 %49 to i64
  %arrayidx77 = getelementptr inbounds [50 x double], [50 x double]* %48, i64 %idxprom76
  %50 = load i32, i32* %k, align 4
  %idxprom78 = sext i32 %50 to i64
  %arrayidx79 = getelementptr inbounds [50 x double], [50 x double]* %arrayidx77, i64 0, i64 %idxprom78
  %51 = load double, double* %arrayidx79, align 8
  %52 = load [70 x double]*, [70 x double]** %F.addr, align 8
  %53 = load i32, i32* %k, align 4
  %idxprom80 = sext i32 %53 to i64
  %arrayidx81 = getelementptr inbounds [70 x double], [70 x double]* %52, i64 %idxprom80
  %54 = load i32, i32* %j, align 4
  %idxprom82 = sext i32 %54 to i64
  %arrayidx83 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx81, i64 0, i64 %idxprom82
  %55 = load double, double* %arrayidx83, align 8
  %mul84 = fmul double %51, %55
  %56 = load [70 x double]*, [70 x double]** %G.addr, align 8
  %57 = load i32, i32* %i, align 4
  %idxprom85 = sext i32 %57 to i64
  %arrayidx86 = getelementptr inbounds [70 x double], [70 x double]* %56, i64 %idxprom85
  %58 = load i32, i32* %j, align 4
  %idxprom87 = sext i32 %58 to i64
  %arrayidx88 = getelementptr inbounds [70 x double], [70 x double]* %arrayidx86, i64 0, i64 %idxprom87
  %59 = load double, double* %arrayidx88, align 8
  %add89 = fadd double %59, %mul84
  store double %add89, double* %arrayidx88, align 8
  br label %for.inc90

for.inc90:                                        ; preds = %for.body75
  %60 = load i32, i32* %k, align 4
  %inc91 = add nsw i32 %60, 1
  store i32 %inc91, i32* %k, align 4
  br label %for.cond73, !llvm.loop !9

for.end92:                                        ; preds = %for.cond73
  br label %for.inc93

for.inc93:                                        ; preds = %for.end92
  %61 = load i32, i32* %j, align 4
  %inc94 = add nsw i32 %61, 1
  store i32 %inc94, i32* %j, align 4
  br label %for.cond66, !llvm.loop !10

for.end95:                                        ; preds = %for.cond66
  br label %for.inc96

for.inc96:                                        ; preds = %for.end95
  %62 = load i32, i32* %i, align 4
  %inc97 = add nsw i32 %62, 1
  store i32 %inc97, i32* %i, align 4
  br label %for.cond63, !llvm.loop !11

for.end98:                                        ; preds = %for.cond63
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
!10 = distinct !{!10, !3}
!11 = distinct !{!11, !3}
