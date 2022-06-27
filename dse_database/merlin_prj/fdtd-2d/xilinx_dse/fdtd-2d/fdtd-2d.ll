; ModuleID = 'fdtd-2d.c'
source_filename = "fdtd-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_fdtd_2d(i32 %tmax, i32 %nx, i32 %ny, [80 x double]* %ex, [80 x double]* %ey, [80 x double]* %hz, double* %_fict_) #0 {
entry:
  %tmax.addr = alloca i32, align 4
  %nx.addr = alloca i32, align 4
  %ny.addr = alloca i32, align 4
  %ex.addr = alloca [80 x double]*, align 8
  %ey.addr = alloca [80 x double]*, align 8
  %hz.addr = alloca [80 x double]*, align 8
  %_fict_.addr = alloca double*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %tmax, i32* %tmax.addr, align 4
  store i32 %nx, i32* %nx.addr, align 4
  store i32 %ny, i32* %ny.addr, align 4
  store [80 x double]* %ex, [80 x double]** %ex.addr, align 8
  store [80 x double]* %ey, [80 x double]** %ey.addr, align 8
  store [80 x double]* %hz, [80 x double]** %hz.addr, align 8
  store double* %_fict_, double** %_fict_.addr, align 8
  store i32 0, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc111, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp slt i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end113

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 80
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %_fict_.addr, align 8
  %3 = load i32, i32* %t, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom
  %4 = load double, double* %arrayidx, align 8
  %5 = load [80 x double]*, [80 x double]** %ey.addr, align 8
  %arrayidx4 = getelementptr inbounds [80 x double], [80 x double]* %5, i64 0
  %6 = load i32, i32* %j, align 4
  %idxprom5 = sext i32 %6 to i64
  %arrayidx6 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx4, i64 0, i64 %idxprom5
  store double %4, double* %arrayidx6, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %7 = load i32, i32* %j, align 4
  %inc = add nsw i32 %7, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  store i32 1, i32* %i, align 4
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc34, %for.end
  %8 = load i32, i32* %i, align 4
  %cmp8 = icmp slt i32 %8, 60
  br i1 %cmp8, label %for.body9, label %for.end36

for.body9:                                        ; preds = %for.cond7
  store i32 0, i32* %j, align 4
  br label %for.cond10

for.cond10:                                       ; preds = %for.inc31, %for.body9
  %9 = load i32, i32* %j, align 4
  %cmp11 = icmp slt i32 %9, 80
  br i1 %cmp11, label %for.body12, label %for.end33

for.body12:                                       ; preds = %for.cond10
  %10 = load [80 x double]*, [80 x double]** %ey.addr, align 8
  %11 = load i32, i32* %i, align 4
  %idxprom13 = sext i32 %11 to i64
  %arrayidx14 = getelementptr inbounds [80 x double], [80 x double]* %10, i64 %idxprom13
  %12 = load i32, i32* %j, align 4
  %idxprom15 = sext i32 %12 to i64
  %arrayidx16 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx14, i64 0, i64 %idxprom15
  %13 = load double, double* %arrayidx16, align 8
  %14 = load [80 x double]*, [80 x double]** %hz.addr, align 8
  %15 = load i32, i32* %i, align 4
  %idxprom17 = sext i32 %15 to i64
  %arrayidx18 = getelementptr inbounds [80 x double], [80 x double]* %14, i64 %idxprom17
  %16 = load i32, i32* %j, align 4
  %idxprom19 = sext i32 %16 to i64
  %arrayidx20 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx18, i64 0, i64 %idxprom19
  %17 = load double, double* %arrayidx20, align 8
  %18 = load [80 x double]*, [80 x double]** %hz.addr, align 8
  %19 = load i32, i32* %i, align 4
  %sub = sub nsw i32 %19, 1
  %idxprom21 = sext i32 %sub to i64
  %arrayidx22 = getelementptr inbounds [80 x double], [80 x double]* %18, i64 %idxprom21
  %20 = load i32, i32* %j, align 4
  %idxprom23 = sext i32 %20 to i64
  %arrayidx24 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx22, i64 0, i64 %idxprom23
  %21 = load double, double* %arrayidx24, align 8
  %sub25 = fsub double %17, %21
  %mul = fmul double 5.000000e-01, %sub25
  %sub26 = fsub double %13, %mul
  %22 = load [80 x double]*, [80 x double]** %ey.addr, align 8
  %23 = load i32, i32* %i, align 4
  %idxprom27 = sext i32 %23 to i64
  %arrayidx28 = getelementptr inbounds [80 x double], [80 x double]* %22, i64 %idxprom27
  %24 = load i32, i32* %j, align 4
  %idxprom29 = sext i32 %24 to i64
  %arrayidx30 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx28, i64 0, i64 %idxprom29
  store double %sub26, double* %arrayidx30, align 8
  br label %for.inc31

for.inc31:                                        ; preds = %for.body12
  %25 = load i32, i32* %j, align 4
  %inc32 = add nsw i32 %25, 1
  store i32 %inc32, i32* %j, align 4
  br label %for.cond10, !llvm.loop !4

for.end33:                                        ; preds = %for.cond10
  br label %for.inc34

for.inc34:                                        ; preds = %for.end33
  %26 = load i32, i32* %i, align 4
  %inc35 = add nsw i32 %26, 1
  store i32 %inc35, i32* %i, align 4
  br label %for.cond7, !llvm.loop !5

for.end36:                                        ; preds = %for.cond7
  store i32 0, i32* %i, align 4
  br label %for.cond37

for.cond37:                                       ; preds = %for.inc66, %for.end36
  %27 = load i32, i32* %i, align 4
  %cmp38 = icmp slt i32 %27, 60
  br i1 %cmp38, label %for.body39, label %for.end68

for.body39:                                       ; preds = %for.cond37
  store i32 1, i32* %j, align 4
  br label %for.cond40

for.cond40:                                       ; preds = %for.inc63, %for.body39
  %28 = load i32, i32* %j, align 4
  %cmp41 = icmp slt i32 %28, 80
  br i1 %cmp41, label %for.body42, label %for.end65

for.body42:                                       ; preds = %for.cond40
  %29 = load [80 x double]*, [80 x double]** %ex.addr, align 8
  %30 = load i32, i32* %i, align 4
  %idxprom43 = sext i32 %30 to i64
  %arrayidx44 = getelementptr inbounds [80 x double], [80 x double]* %29, i64 %idxprom43
  %31 = load i32, i32* %j, align 4
  %idxprom45 = sext i32 %31 to i64
  %arrayidx46 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx44, i64 0, i64 %idxprom45
  %32 = load double, double* %arrayidx46, align 8
  %33 = load [80 x double]*, [80 x double]** %hz.addr, align 8
  %34 = load i32, i32* %i, align 4
  %idxprom47 = sext i32 %34 to i64
  %arrayidx48 = getelementptr inbounds [80 x double], [80 x double]* %33, i64 %idxprom47
  %35 = load i32, i32* %j, align 4
  %idxprom49 = sext i32 %35 to i64
  %arrayidx50 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx48, i64 0, i64 %idxprom49
  %36 = load double, double* %arrayidx50, align 8
  %37 = load [80 x double]*, [80 x double]** %hz.addr, align 8
  %38 = load i32, i32* %i, align 4
  %idxprom51 = sext i32 %38 to i64
  %arrayidx52 = getelementptr inbounds [80 x double], [80 x double]* %37, i64 %idxprom51
  %39 = load i32, i32* %j, align 4
  %sub53 = sub nsw i32 %39, 1
  %idxprom54 = sext i32 %sub53 to i64
  %arrayidx55 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx52, i64 0, i64 %idxprom54
  %40 = load double, double* %arrayidx55, align 8
  %sub56 = fsub double %36, %40
  %mul57 = fmul double 5.000000e-01, %sub56
  %sub58 = fsub double %32, %mul57
  %41 = load [80 x double]*, [80 x double]** %ex.addr, align 8
  %42 = load i32, i32* %i, align 4
  %idxprom59 = sext i32 %42 to i64
  %arrayidx60 = getelementptr inbounds [80 x double], [80 x double]* %41, i64 %idxprom59
  %43 = load i32, i32* %j, align 4
  %idxprom61 = sext i32 %43 to i64
  %arrayidx62 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx60, i64 0, i64 %idxprom61
  store double %sub58, double* %arrayidx62, align 8
  br label %for.inc63

for.inc63:                                        ; preds = %for.body42
  %44 = load i32, i32* %j, align 4
  %inc64 = add nsw i32 %44, 1
  store i32 %inc64, i32* %j, align 4
  br label %for.cond40, !llvm.loop !6

for.end65:                                        ; preds = %for.cond40
  br label %for.inc66

for.inc66:                                        ; preds = %for.end65
  %45 = load i32, i32* %i, align 4
  %inc67 = add nsw i32 %45, 1
  store i32 %inc67, i32* %i, align 4
  br label %for.cond37, !llvm.loop !7

for.end68:                                        ; preds = %for.cond37
  store i32 0, i32* %i, align 4
  br label %for.cond69

for.cond69:                                       ; preds = %for.inc108, %for.end68
  %46 = load i32, i32* %i, align 4
  %cmp70 = icmp slt i32 %46, 59
  br i1 %cmp70, label %for.body71, label %for.end110

for.body71:                                       ; preds = %for.cond69
  store i32 0, i32* %j, align 4
  br label %for.cond72

for.cond72:                                       ; preds = %for.inc105, %for.body71
  %47 = load i32, i32* %j, align 4
  %cmp73 = icmp slt i32 %47, 79
  br i1 %cmp73, label %for.body74, label %for.end107

for.body74:                                       ; preds = %for.cond72
  %48 = load [80 x double]*, [80 x double]** %hz.addr, align 8
  %49 = load i32, i32* %i, align 4
  %idxprom75 = sext i32 %49 to i64
  %arrayidx76 = getelementptr inbounds [80 x double], [80 x double]* %48, i64 %idxprom75
  %50 = load i32, i32* %j, align 4
  %idxprom77 = sext i32 %50 to i64
  %arrayidx78 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx76, i64 0, i64 %idxprom77
  %51 = load double, double* %arrayidx78, align 8
  %52 = load [80 x double]*, [80 x double]** %ex.addr, align 8
  %53 = load i32, i32* %i, align 4
  %idxprom79 = sext i32 %53 to i64
  %arrayidx80 = getelementptr inbounds [80 x double], [80 x double]* %52, i64 %idxprom79
  %54 = load i32, i32* %j, align 4
  %add = add nsw i32 %54, 1
  %idxprom81 = sext i32 %add to i64
  %arrayidx82 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx80, i64 0, i64 %idxprom81
  %55 = load double, double* %arrayidx82, align 8
  %56 = load [80 x double]*, [80 x double]** %ex.addr, align 8
  %57 = load i32, i32* %i, align 4
  %idxprom83 = sext i32 %57 to i64
  %arrayidx84 = getelementptr inbounds [80 x double], [80 x double]* %56, i64 %idxprom83
  %58 = load i32, i32* %j, align 4
  %idxprom85 = sext i32 %58 to i64
  %arrayidx86 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx84, i64 0, i64 %idxprom85
  %59 = load double, double* %arrayidx86, align 8
  %sub87 = fsub double %55, %59
  %60 = load [80 x double]*, [80 x double]** %ey.addr, align 8
  %61 = load i32, i32* %i, align 4
  %add88 = add nsw i32 %61, 1
  %idxprom89 = sext i32 %add88 to i64
  %arrayidx90 = getelementptr inbounds [80 x double], [80 x double]* %60, i64 %idxprom89
  %62 = load i32, i32* %j, align 4
  %idxprom91 = sext i32 %62 to i64
  %arrayidx92 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx90, i64 0, i64 %idxprom91
  %63 = load double, double* %arrayidx92, align 8
  %add93 = fadd double %sub87, %63
  %64 = load [80 x double]*, [80 x double]** %ey.addr, align 8
  %65 = load i32, i32* %i, align 4
  %idxprom94 = sext i32 %65 to i64
  %arrayidx95 = getelementptr inbounds [80 x double], [80 x double]* %64, i64 %idxprom94
  %66 = load i32, i32* %j, align 4
  %idxprom96 = sext i32 %66 to i64
  %arrayidx97 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx95, i64 0, i64 %idxprom96
  %67 = load double, double* %arrayidx97, align 8
  %sub98 = fsub double %add93, %67
  %mul99 = fmul double 0x3FE6666666666666, %sub98
  %sub100 = fsub double %51, %mul99
  %68 = load [80 x double]*, [80 x double]** %hz.addr, align 8
  %69 = load i32, i32* %i, align 4
  %idxprom101 = sext i32 %69 to i64
  %arrayidx102 = getelementptr inbounds [80 x double], [80 x double]* %68, i64 %idxprom101
  %70 = load i32, i32* %j, align 4
  %idxprom103 = sext i32 %70 to i64
  %arrayidx104 = getelementptr inbounds [80 x double], [80 x double]* %arrayidx102, i64 0, i64 %idxprom103
  store double %sub100, double* %arrayidx104, align 8
  br label %for.inc105

for.inc105:                                       ; preds = %for.body74
  %71 = load i32, i32* %j, align 4
  %inc106 = add nsw i32 %71, 1
  store i32 %inc106, i32* %j, align 4
  br label %for.cond72, !llvm.loop !8

for.end107:                                       ; preds = %for.cond72
  br label %for.inc108

for.inc108:                                       ; preds = %for.end107
  %72 = load i32, i32* %i, align 4
  %inc109 = add nsw i32 %72, 1
  store i32 %inc109, i32* %i, align 4
  br label %for.cond69, !llvm.loop !9

for.end110:                                       ; preds = %for.cond69
  br label %for.inc111

for.inc111:                                       ; preds = %for.end110
  %73 = load i32, i32* %t, align 4
  %inc112 = add nsw i32 %73, 1
  store i32 %inc112, i32* %t, align 4
  br label %for.cond, !llvm.loop !10

for.end113:                                       ; preds = %for.cond
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
