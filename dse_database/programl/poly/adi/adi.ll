; ModuleID = 'adi.c'
source_filename = "adi.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_adi(i32 %tsteps, i32 %n, [60 x double]* %u, [60 x double]* %v, [60 x double]* %p, [60 x double]* %q) #0 {
entry:
  %tsteps.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %u.addr = alloca [60 x double]*, align 8
  %v.addr = alloca [60 x double]*, align 8
  %p.addr = alloca [60 x double]*, align 8
  %q.addr = alloca [60 x double]*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %DX = alloca double, align 8
  %DY = alloca double, align 8
  %DT = alloca double, align 8
  %B1 = alloca double, align 8
  %B2 = alloca double, align 8
  %mul1 = alloca double, align 8
  %mul2 = alloca double, align 8
  %a = alloca double, align 8
  %b = alloca double, align 8
  %c = alloca double, align 8
  %d = alloca double, align 8
  %e = alloca double, align 8
  %f = alloca double, align 8
  %_in_j_0 = alloca i32, align 4
  %_in_j = alloca i32, align 4
  store i32 %tsteps, i32* %tsteps.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  store [60 x double]* %u, [60 x double]** %u.addr, align 8
  store [60 x double]* %v, [60 x double]** %v.addr, align 8
  store [60 x double]* %p, [60 x double]** %p.addr, align 8
  store [60 x double]* %q, [60 x double]** %q.addr, align 8
  store double 0x3F91111111111111, double* %DX, align 8
  store double 0x3F91111111111111, double* %DY, align 8
  store double 2.500000e-02, double* %DT, align 8
  store double 2.000000e+00, double* %B1, align 8
  store double 1.000000e+00, double* %B2, align 8
  %0 = load double, double* %B1, align 8
  %1 = load double, double* %DT, align 8
  %mul = fmul double %0, %1
  %2 = load double, double* %DX, align 8
  %3 = load double, double* %DX, align 8
  %mul3 = fmul double %2, %3
  %div = fdiv double %mul, %mul3
  store double %div, double* %mul1, align 8
  %4 = load double, double* %B2, align 8
  %5 = load double, double* %DT, align 8
  %mul4 = fmul double %4, %5
  %6 = load double, double* %DY, align 8
  %7 = load double, double* %DY, align 8
  %mul5 = fmul double %6, %7
  %div6 = fdiv double %mul4, %mul5
  store double %div6, double* %mul2, align 8
  %8 = load double, double* %mul1, align 8
  %fneg = fneg double %8
  %div7 = fdiv double %fneg, 2.000000e+00
  store double %div7, double* %a, align 8
  %9 = load double, double* %mul1, align 8
  %add = fadd double 1.000000e+00, %9
  store double %add, double* %b, align 8
  %10 = load double, double* %a, align 8
  store double %10, double* %c, align 8
  %11 = load double, double* %mul2, align 8
  %fneg8 = fneg double %11
  %div9 = fdiv double %fneg8, 2.000000e+00
  store double %div9, double* %d, align 8
  %12 = load double, double* %mul2, align 8
  %add10 = fadd double 1.000000e+00, %12
  store double %add10, double* %e, align 8
  %13 = load double, double* %d, align 8
  store double %13, double* %f, align 8
  store i32 1, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc221, %entry
  %14 = load i32, i32* %t, align 4
  %cmp = icmp sle i32 %14, 40
  br i1 %cmp, label %for.body, label %for.end223

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc110, %for.body
  %15 = load i32, i32* %i, align 4
  %cmp12 = icmp slt i32 %15, 59
  br i1 %cmp12, label %for.body13, label %for.end112

for.body13:                                       ; preds = %for.cond11
  %16 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %arrayidx = getelementptr inbounds [60 x double], [60 x double]* %16, i64 0
  %17 = load i32, i32* %i, align 4
  %idxprom = sext i32 %17 to i64
  %arrayidx14 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx, i64 0, i64 %idxprom
  store double 1.000000e+00, double* %arrayidx14, align 8
  %18 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %19 = load i32, i32* %i, align 4
  %idxprom15 = sext i32 %19 to i64
  %arrayidx16 = getelementptr inbounds [60 x double], [60 x double]* %18, i64 %idxprom15
  %arrayidx17 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx16, i64 0, i64 0
  store double 0.000000e+00, double* %arrayidx17, align 8
  %20 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %arrayidx18 = getelementptr inbounds [60 x double], [60 x double]* %20, i64 0
  %21 = load i32, i32* %i, align 4
  %idxprom19 = sext i32 %21 to i64
  %arrayidx20 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx18, i64 0, i64 %idxprom19
  %22 = load double, double* %arrayidx20, align 8
  %23 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %24 = load i32, i32* %i, align 4
  %idxprom21 = sext i32 %24 to i64
  %arrayidx22 = getelementptr inbounds [60 x double], [60 x double]* %23, i64 %idxprom21
  %arrayidx23 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx22, i64 0, i64 0
  store double %22, double* %arrayidx23, align 8
  store i32 1, i32* %j, align 4
  br label %for.cond24

for.cond24:                                       ; preds = %for.inc, %for.body13
  %25 = load i32, i32* %j, align 4
  %cmp25 = icmp slt i32 %25, 59
  br i1 %cmp25, label %for.body26, label %for.end

for.body26:                                       ; preds = %for.cond24
  %26 = load double, double* %c, align 8
  %fneg27 = fneg double %26
  %27 = load double, double* %a, align 8
  %28 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %29 = load i32, i32* %i, align 4
  %idxprom28 = sext i32 %29 to i64
  %arrayidx29 = getelementptr inbounds [60 x double], [60 x double]* %28, i64 %idxprom28
  %30 = load i32, i32* %j, align 4
  %sub = sub nsw i32 %30, 1
  %idxprom30 = sext i32 %sub to i64
  %arrayidx31 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx29, i64 0, i64 %idxprom30
  %31 = load double, double* %arrayidx31, align 8
  %mul32 = fmul double %27, %31
  %32 = load double, double* %b, align 8
  %add33 = fadd double %mul32, %32
  %div34 = fdiv double %fneg27, %add33
  %33 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %34 = load i32, i32* %i, align 4
  %idxprom35 = sext i32 %34 to i64
  %arrayidx36 = getelementptr inbounds [60 x double], [60 x double]* %33, i64 %idxprom35
  %35 = load i32, i32* %j, align 4
  %idxprom37 = sext i32 %35 to i64
  %arrayidx38 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx36, i64 0, i64 %idxprom37
  store double %div34, double* %arrayidx38, align 8
  %36 = load double, double* %d, align 8
  %fneg39 = fneg double %36
  %37 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %38 = load i32, i32* %j, align 4
  %idxprom40 = sext i32 %38 to i64
  %arrayidx41 = getelementptr inbounds [60 x double], [60 x double]* %37, i64 %idxprom40
  %39 = load i32, i32* %i, align 4
  %sub42 = sub nsw i32 %39, 1
  %idxprom43 = sext i32 %sub42 to i64
  %arrayidx44 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx41, i64 0, i64 %idxprom43
  %40 = load double, double* %arrayidx44, align 8
  %mul45 = fmul double %fneg39, %40
  %41 = load double, double* %d, align 8
  %mul46 = fmul double 2.000000e+00, %41
  %add47 = fadd double 1.000000e+00, %mul46
  %42 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %43 = load i32, i32* %j, align 4
  %idxprom48 = sext i32 %43 to i64
  %arrayidx49 = getelementptr inbounds [60 x double], [60 x double]* %42, i64 %idxprom48
  %44 = load i32, i32* %i, align 4
  %idxprom50 = sext i32 %44 to i64
  %arrayidx51 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx49, i64 0, i64 %idxprom50
  %45 = load double, double* %arrayidx51, align 8
  %mul52 = fmul double %add47, %45
  %add53 = fadd double %mul45, %mul52
  %46 = load double, double* %f, align 8
  %47 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %48 = load i32, i32* %j, align 4
  %idxprom54 = sext i32 %48 to i64
  %arrayidx55 = getelementptr inbounds [60 x double], [60 x double]* %47, i64 %idxprom54
  %49 = load i32, i32* %i, align 4
  %add56 = add nsw i32 %49, 1
  %idxprom57 = sext i32 %add56 to i64
  %arrayidx58 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx55, i64 0, i64 %idxprom57
  %50 = load double, double* %arrayidx58, align 8
  %mul59 = fmul double %46, %50
  %sub60 = fsub double %add53, %mul59
  %51 = load double, double* %a, align 8
  %52 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %53 = load i32, i32* %i, align 4
  %idxprom61 = sext i32 %53 to i64
  %arrayidx62 = getelementptr inbounds [60 x double], [60 x double]* %52, i64 %idxprom61
  %54 = load i32, i32* %j, align 4
  %sub63 = sub nsw i32 %54, 1
  %idxprom64 = sext i32 %sub63 to i64
  %arrayidx65 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx62, i64 0, i64 %idxprom64
  %55 = load double, double* %arrayidx65, align 8
  %mul66 = fmul double %51, %55
  %sub67 = fsub double %sub60, %mul66
  %56 = load double, double* %a, align 8
  %57 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %58 = load i32, i32* %i, align 4
  %idxprom68 = sext i32 %58 to i64
  %arrayidx69 = getelementptr inbounds [60 x double], [60 x double]* %57, i64 %idxprom68
  %59 = load i32, i32* %j, align 4
  %sub70 = sub nsw i32 %59, 1
  %idxprom71 = sext i32 %sub70 to i64
  %arrayidx72 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx69, i64 0, i64 %idxprom71
  %60 = load double, double* %arrayidx72, align 8
  %mul73 = fmul double %56, %60
  %61 = load double, double* %b, align 8
  %add74 = fadd double %mul73, %61
  %div75 = fdiv double %sub67, %add74
  %62 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %63 = load i32, i32* %i, align 4
  %idxprom76 = sext i32 %63 to i64
  %arrayidx77 = getelementptr inbounds [60 x double], [60 x double]* %62, i64 %idxprom76
  %64 = load i32, i32* %j, align 4
  %idxprom78 = sext i32 %64 to i64
  %arrayidx79 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx77, i64 0, i64 %idxprom78
  store double %div75, double* %arrayidx79, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body26
  %65 = load i32, i32* %j, align 4
  %inc = add nsw i32 %65, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond24, !llvm.loop !2

for.end:                                          ; preds = %for.cond24
  %66 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %arrayidx80 = getelementptr inbounds [60 x double], [60 x double]* %66, i64 59
  %67 = load i32, i32* %i, align 4
  %idxprom81 = sext i32 %67 to i64
  %arrayidx82 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx80, i64 0, i64 %idxprom81
  store double 1.000000e+00, double* %arrayidx82, align 8
  store i32 0, i32* %j, align 4
  br label %for.cond83

for.cond83:                                       ; preds = %for.inc107, %for.end
  %68 = load i32, i32* %j, align 4
  %cmp84 = icmp sle i32 %68, 57
  br i1 %cmp84, label %for.body85, label %for.end109

for.body85:                                       ; preds = %for.cond83
  %69 = load i32, i32* %j, align 4
  %mul86 = mul nsw i32 -1, %69
  %add87 = add nsw i32 58, %mul86
  store i32 %add87, i32* %_in_j_0, align 4
  %70 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %71 = load i32, i32* %i, align 4
  %idxprom88 = sext i32 %71 to i64
  %arrayidx89 = getelementptr inbounds [60 x double], [60 x double]* %70, i64 %idxprom88
  %72 = load i32, i32* %_in_j_0, align 4
  %idxprom90 = sext i32 %72 to i64
  %arrayidx91 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx89, i64 0, i64 %idxprom90
  %73 = load double, double* %arrayidx91, align 8
  %74 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %75 = load i32, i32* %_in_j_0, align 4
  %add92 = add nsw i32 %75, 1
  %idxprom93 = sext i32 %add92 to i64
  %arrayidx94 = getelementptr inbounds [60 x double], [60 x double]* %74, i64 %idxprom93
  %76 = load i32, i32* %i, align 4
  %idxprom95 = sext i32 %76 to i64
  %arrayidx96 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx94, i64 0, i64 %idxprom95
  %77 = load double, double* %arrayidx96, align 8
  %mul97 = fmul double %73, %77
  %78 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %79 = load i32, i32* %i, align 4
  %idxprom98 = sext i32 %79 to i64
  %arrayidx99 = getelementptr inbounds [60 x double], [60 x double]* %78, i64 %idxprom98
  %80 = load i32, i32* %_in_j_0, align 4
  %idxprom100 = sext i32 %80 to i64
  %arrayidx101 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx99, i64 0, i64 %idxprom100
  %81 = load double, double* %arrayidx101, align 8
  %add102 = fadd double %mul97, %81
  %82 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %83 = load i32, i32* %_in_j_0, align 4
  %idxprom103 = sext i32 %83 to i64
  %arrayidx104 = getelementptr inbounds [60 x double], [60 x double]* %82, i64 %idxprom103
  %84 = load i32, i32* %i, align 4
  %idxprom105 = sext i32 %84 to i64
  %arrayidx106 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx104, i64 0, i64 %idxprom105
  store double %add102, double* %arrayidx106, align 8
  br label %for.inc107

for.inc107:                                       ; preds = %for.body85
  %85 = load i32, i32* %j, align 4
  %inc108 = add nsw i32 %85, 1
  store i32 %inc108, i32* %j, align 4
  br label %for.cond83, !llvm.loop !4

for.end109:                                       ; preds = %for.cond83
  store i32 0, i32* %j, align 4
  br label %for.inc110

for.inc110:                                       ; preds = %for.end109
  %86 = load i32, i32* %i, align 4
  %inc111 = add nsw i32 %86, 1
  store i32 %inc111, i32* %i, align 4
  br label %for.cond11, !llvm.loop !5

for.end112:                                       ; preds = %for.cond11
  store i32 1, i32* %i, align 4
  br label %for.cond113

for.cond113:                                      ; preds = %for.inc218, %for.end112
  %87 = load i32, i32* %i, align 4
  %cmp114 = icmp slt i32 %87, 59
  br i1 %cmp114, label %for.body115, label %for.end220

for.body115:                                      ; preds = %for.cond113
  %88 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %89 = load i32, i32* %i, align 4
  %idxprom116 = sext i32 %89 to i64
  %arrayidx117 = getelementptr inbounds [60 x double], [60 x double]* %88, i64 %idxprom116
  %arrayidx118 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx117, i64 0, i64 0
  store double 1.000000e+00, double* %arrayidx118, align 8
  %90 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %91 = load i32, i32* %i, align 4
  %idxprom119 = sext i32 %91 to i64
  %arrayidx120 = getelementptr inbounds [60 x double], [60 x double]* %90, i64 %idxprom119
  %arrayidx121 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx120, i64 0, i64 0
  store double 0.000000e+00, double* %arrayidx121, align 8
  %92 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %93 = load i32, i32* %i, align 4
  %idxprom122 = sext i32 %93 to i64
  %arrayidx123 = getelementptr inbounds [60 x double], [60 x double]* %92, i64 %idxprom122
  %arrayidx124 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx123, i64 0, i64 0
  %94 = load double, double* %arrayidx124, align 8
  %95 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %96 = load i32, i32* %i, align 4
  %idxprom125 = sext i32 %96 to i64
  %arrayidx126 = getelementptr inbounds [60 x double], [60 x double]* %95, i64 %idxprom125
  %arrayidx127 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx126, i64 0, i64 0
  store double %94, double* %arrayidx127, align 8
  store i32 1, i32* %j, align 4
  br label %for.cond128

for.cond128:                                      ; preds = %for.inc185, %for.body115
  %97 = load i32, i32* %j, align 4
  %cmp129 = icmp slt i32 %97, 59
  br i1 %cmp129, label %for.body130, label %for.end187

for.body130:                                      ; preds = %for.cond128
  %98 = load double, double* %f, align 8
  %fneg131 = fneg double %98
  %99 = load double, double* %d, align 8
  %100 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %101 = load i32, i32* %i, align 4
  %idxprom132 = sext i32 %101 to i64
  %arrayidx133 = getelementptr inbounds [60 x double], [60 x double]* %100, i64 %idxprom132
  %102 = load i32, i32* %j, align 4
  %sub134 = sub nsw i32 %102, 1
  %idxprom135 = sext i32 %sub134 to i64
  %arrayidx136 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx133, i64 0, i64 %idxprom135
  %103 = load double, double* %arrayidx136, align 8
  %mul137 = fmul double %99, %103
  %104 = load double, double* %e, align 8
  %add138 = fadd double %mul137, %104
  %div139 = fdiv double %fneg131, %add138
  %105 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %106 = load i32, i32* %i, align 4
  %idxprom140 = sext i32 %106 to i64
  %arrayidx141 = getelementptr inbounds [60 x double], [60 x double]* %105, i64 %idxprom140
  %107 = load i32, i32* %j, align 4
  %idxprom142 = sext i32 %107 to i64
  %arrayidx143 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx141, i64 0, i64 %idxprom142
  store double %div139, double* %arrayidx143, align 8
  %108 = load double, double* %a, align 8
  %fneg144 = fneg double %108
  %109 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %110 = load i32, i32* %i, align 4
  %sub145 = sub nsw i32 %110, 1
  %idxprom146 = sext i32 %sub145 to i64
  %arrayidx147 = getelementptr inbounds [60 x double], [60 x double]* %109, i64 %idxprom146
  %111 = load i32, i32* %j, align 4
  %idxprom148 = sext i32 %111 to i64
  %arrayidx149 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx147, i64 0, i64 %idxprom148
  %112 = load double, double* %arrayidx149, align 8
  %mul150 = fmul double %fneg144, %112
  %113 = load double, double* %a, align 8
  %mul151 = fmul double 2.000000e+00, %113
  %add152 = fadd double 1.000000e+00, %mul151
  %114 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %115 = load i32, i32* %i, align 4
  %idxprom153 = sext i32 %115 to i64
  %arrayidx154 = getelementptr inbounds [60 x double], [60 x double]* %114, i64 %idxprom153
  %116 = load i32, i32* %j, align 4
  %idxprom155 = sext i32 %116 to i64
  %arrayidx156 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx154, i64 0, i64 %idxprom155
  %117 = load double, double* %arrayidx156, align 8
  %mul157 = fmul double %add152, %117
  %add158 = fadd double %mul150, %mul157
  %118 = load double, double* %c, align 8
  %119 = load [60 x double]*, [60 x double]** %v.addr, align 8
  %120 = load i32, i32* %i, align 4
  %add159 = add nsw i32 %120, 1
  %idxprom160 = sext i32 %add159 to i64
  %arrayidx161 = getelementptr inbounds [60 x double], [60 x double]* %119, i64 %idxprom160
  %121 = load i32, i32* %j, align 4
  %idxprom162 = sext i32 %121 to i64
  %arrayidx163 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx161, i64 0, i64 %idxprom162
  %122 = load double, double* %arrayidx163, align 8
  %mul164 = fmul double %118, %122
  %sub165 = fsub double %add158, %mul164
  %123 = load double, double* %d, align 8
  %124 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %125 = load i32, i32* %i, align 4
  %idxprom166 = sext i32 %125 to i64
  %arrayidx167 = getelementptr inbounds [60 x double], [60 x double]* %124, i64 %idxprom166
  %126 = load i32, i32* %j, align 4
  %sub168 = sub nsw i32 %126, 1
  %idxprom169 = sext i32 %sub168 to i64
  %arrayidx170 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx167, i64 0, i64 %idxprom169
  %127 = load double, double* %arrayidx170, align 8
  %mul171 = fmul double %123, %127
  %sub172 = fsub double %sub165, %mul171
  %128 = load double, double* %d, align 8
  %129 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %130 = load i32, i32* %i, align 4
  %idxprom173 = sext i32 %130 to i64
  %arrayidx174 = getelementptr inbounds [60 x double], [60 x double]* %129, i64 %idxprom173
  %131 = load i32, i32* %j, align 4
  %sub175 = sub nsw i32 %131, 1
  %idxprom176 = sext i32 %sub175 to i64
  %arrayidx177 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx174, i64 0, i64 %idxprom176
  %132 = load double, double* %arrayidx177, align 8
  %mul178 = fmul double %128, %132
  %133 = load double, double* %e, align 8
  %add179 = fadd double %mul178, %133
  %div180 = fdiv double %sub172, %add179
  %134 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %135 = load i32, i32* %i, align 4
  %idxprom181 = sext i32 %135 to i64
  %arrayidx182 = getelementptr inbounds [60 x double], [60 x double]* %134, i64 %idxprom181
  %136 = load i32, i32* %j, align 4
  %idxprom183 = sext i32 %136 to i64
  %arrayidx184 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx182, i64 0, i64 %idxprom183
  store double %div180, double* %arrayidx184, align 8
  br label %for.inc185

for.inc185:                                       ; preds = %for.body130
  %137 = load i32, i32* %j, align 4
  %inc186 = add nsw i32 %137, 1
  store i32 %inc186, i32* %j, align 4
  br label %for.cond128, !llvm.loop !6

for.end187:                                       ; preds = %for.cond128
  %138 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %139 = load i32, i32* %i, align 4
  %idxprom188 = sext i32 %139 to i64
  %arrayidx189 = getelementptr inbounds [60 x double], [60 x double]* %138, i64 %idxprom188
  %arrayidx190 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx189, i64 0, i64 59
  store double 1.000000e+00, double* %arrayidx190, align 8
  store i32 0, i32* %j, align 4
  br label %for.cond191

for.cond191:                                      ; preds = %for.inc215, %for.end187
  %140 = load i32, i32* %j, align 4
  %cmp192 = icmp sle i32 %140, 57
  br i1 %cmp192, label %for.body193, label %for.end217

for.body193:                                      ; preds = %for.cond191
  %141 = load i32, i32* %j, align 4
  %mul194 = mul nsw i32 -1, %141
  %add195 = add nsw i32 58, %mul194
  store i32 %add195, i32* %_in_j, align 4
  %142 = load [60 x double]*, [60 x double]** %p.addr, align 8
  %143 = load i32, i32* %i, align 4
  %idxprom196 = sext i32 %143 to i64
  %arrayidx197 = getelementptr inbounds [60 x double], [60 x double]* %142, i64 %idxprom196
  %144 = load i32, i32* %_in_j, align 4
  %idxprom198 = sext i32 %144 to i64
  %arrayidx199 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx197, i64 0, i64 %idxprom198
  %145 = load double, double* %arrayidx199, align 8
  %146 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %147 = load i32, i32* %i, align 4
  %idxprom200 = sext i32 %147 to i64
  %arrayidx201 = getelementptr inbounds [60 x double], [60 x double]* %146, i64 %idxprom200
  %148 = load i32, i32* %_in_j, align 4
  %add202 = add nsw i32 %148, 1
  %idxprom203 = sext i32 %add202 to i64
  %arrayidx204 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx201, i64 0, i64 %idxprom203
  %149 = load double, double* %arrayidx204, align 8
  %mul205 = fmul double %145, %149
  %150 = load [60 x double]*, [60 x double]** %q.addr, align 8
  %151 = load i32, i32* %i, align 4
  %idxprom206 = sext i32 %151 to i64
  %arrayidx207 = getelementptr inbounds [60 x double], [60 x double]* %150, i64 %idxprom206
  %152 = load i32, i32* %_in_j, align 4
  %idxprom208 = sext i32 %152 to i64
  %arrayidx209 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx207, i64 0, i64 %idxprom208
  %153 = load double, double* %arrayidx209, align 8
  %add210 = fadd double %mul205, %153
  %154 = load [60 x double]*, [60 x double]** %u.addr, align 8
  %155 = load i32, i32* %i, align 4
  %idxprom211 = sext i32 %155 to i64
  %arrayidx212 = getelementptr inbounds [60 x double], [60 x double]* %154, i64 %idxprom211
  %156 = load i32, i32* %_in_j, align 4
  %idxprom213 = sext i32 %156 to i64
  %arrayidx214 = getelementptr inbounds [60 x double], [60 x double]* %arrayidx212, i64 0, i64 %idxprom213
  store double %add210, double* %arrayidx214, align 8
  br label %for.inc215

for.inc215:                                       ; preds = %for.body193
  %157 = load i32, i32* %j, align 4
  %inc216 = add nsw i32 %157, 1
  store i32 %inc216, i32* %j, align 4
  br label %for.cond191, !llvm.loop !7

for.end217:                                       ; preds = %for.cond191
  store i32 0, i32* %j, align 4
  br label %for.inc218

for.inc218:                                       ; preds = %for.end217
  %158 = load i32, i32* %i, align 4
  %inc219 = add nsw i32 %158, 1
  store i32 %inc219, i32* %i, align 4
  br label %for.cond113, !llvm.loop !8

for.end220:                                       ; preds = %for.cond113
  br label %for.inc221

for.inc221:                                       ; preds = %for.end220
  %159 = load i32, i32* %t, align 4
  %inc222 = add nsw i32 %159, 1
  store i32 %inc222, i32* %t, align 4
  br label %for.cond, !llvm.loop !9

for.end223:                                       ; preds = %for.cond
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
