; ModuleID = 'heat-3d.c'
source_filename = "heat-3d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_heat_3d(i32 %tsteps, i32 %n, [20 x [20 x double]]* %A, [20 x [20 x double]]* %B) #0 {
entry:
  %tsteps.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %A.addr = alloca [20 x [20 x double]]*, align 8
  %B.addr = alloca [20 x [20 x double]]*, align 8
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %tsteps, i32* %tsteps.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  store [20 x [20 x double]]* %A, [20 x [20 x double]]** %A.addr, align 8
  store [20 x [20 x double]]* %B, [20 x [20 x double]]** %B.addr, align 8
  store i32 1, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc203, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp sle i32 %0, 40
  br i1 %cmp, label %for.body, label %for.end205

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc95, %for.body
  %1 = load i32, i32* %i, align 4
  %cmp2 = icmp slt i32 %1, 19
  br i1 %cmp2, label %for.body3, label %for.end97

for.body3:                                        ; preds = %for.cond1
  store i32 1, i32* %j, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc92, %for.body3
  %2 = load i32, i32* %j, align 4
  %cmp5 = icmp slt i32 %2, 19
  br i1 %cmp5, label %for.body6, label %for.end94

for.body6:                                        ; preds = %for.cond4
  store i32 1, i32* %k, align 4
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc, %for.body6
  %3 = load i32, i32* %k, align 4
  %cmp8 = icmp slt i32 %3, 19
  br i1 %cmp8, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond7
  %4 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %5 = load i32, i32* %i, align 4
  %add = add nsw i32 %5, 1
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %4, i64 %idxprom
  %6 = load i32, i32* %j, align 4
  %idxprom10 = sext i32 %6 to i64
  %arrayidx11 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx, i64 0, i64 %idxprom10
  %7 = load i32, i32* %k, align 4
  %idxprom12 = sext i32 %7 to i64
  %arrayidx13 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx11, i64 0, i64 %idxprom12
  %8 = load double, double* %arrayidx13, align 8
  %9 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %10 = load i32, i32* %i, align 4
  %idxprom14 = sext i32 %10 to i64
  %arrayidx15 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %9, i64 %idxprom14
  %11 = load i32, i32* %j, align 4
  %idxprom16 = sext i32 %11 to i64
  %arrayidx17 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx15, i64 0, i64 %idxprom16
  %12 = load i32, i32* %k, align 4
  %idxprom18 = sext i32 %12 to i64
  %arrayidx19 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx17, i64 0, i64 %idxprom18
  %13 = load double, double* %arrayidx19, align 8
  %mul = fmul double 2.000000e+00, %13
  %sub = fsub double %8, %mul
  %14 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %15 = load i32, i32* %i, align 4
  %sub20 = sub nsw i32 %15, 1
  %idxprom21 = sext i32 %sub20 to i64
  %arrayidx22 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %14, i64 %idxprom21
  %16 = load i32, i32* %j, align 4
  %idxprom23 = sext i32 %16 to i64
  %arrayidx24 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx22, i64 0, i64 %idxprom23
  %17 = load i32, i32* %k, align 4
  %idxprom25 = sext i32 %17 to i64
  %arrayidx26 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx24, i64 0, i64 %idxprom25
  %18 = load double, double* %arrayidx26, align 8
  %add27 = fadd double %sub, %18
  %mul28 = fmul double 1.250000e-01, %add27
  %19 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %20 = load i32, i32* %i, align 4
  %idxprom29 = sext i32 %20 to i64
  %arrayidx30 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %19, i64 %idxprom29
  %21 = load i32, i32* %j, align 4
  %add31 = add nsw i32 %21, 1
  %idxprom32 = sext i32 %add31 to i64
  %arrayidx33 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx30, i64 0, i64 %idxprom32
  %22 = load i32, i32* %k, align 4
  %idxprom34 = sext i32 %22 to i64
  %arrayidx35 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx33, i64 0, i64 %idxprom34
  %23 = load double, double* %arrayidx35, align 8
  %24 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %25 = load i32, i32* %i, align 4
  %idxprom36 = sext i32 %25 to i64
  %arrayidx37 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %24, i64 %idxprom36
  %26 = load i32, i32* %j, align 4
  %idxprom38 = sext i32 %26 to i64
  %arrayidx39 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx37, i64 0, i64 %idxprom38
  %27 = load i32, i32* %k, align 4
  %idxprom40 = sext i32 %27 to i64
  %arrayidx41 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx39, i64 0, i64 %idxprom40
  %28 = load double, double* %arrayidx41, align 8
  %mul42 = fmul double 2.000000e+00, %28
  %sub43 = fsub double %23, %mul42
  %29 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %30 = load i32, i32* %i, align 4
  %idxprom44 = sext i32 %30 to i64
  %arrayidx45 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %29, i64 %idxprom44
  %31 = load i32, i32* %j, align 4
  %sub46 = sub nsw i32 %31, 1
  %idxprom47 = sext i32 %sub46 to i64
  %arrayidx48 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx45, i64 0, i64 %idxprom47
  %32 = load i32, i32* %k, align 4
  %idxprom49 = sext i32 %32 to i64
  %arrayidx50 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx48, i64 0, i64 %idxprom49
  %33 = load double, double* %arrayidx50, align 8
  %add51 = fadd double %sub43, %33
  %mul52 = fmul double 1.250000e-01, %add51
  %add53 = fadd double %mul28, %mul52
  %34 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %35 = load i32, i32* %i, align 4
  %idxprom54 = sext i32 %35 to i64
  %arrayidx55 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %34, i64 %idxprom54
  %36 = load i32, i32* %j, align 4
  %idxprom56 = sext i32 %36 to i64
  %arrayidx57 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx55, i64 0, i64 %idxprom56
  %37 = load i32, i32* %k, align 4
  %add58 = add nsw i32 %37, 1
  %idxprom59 = sext i32 %add58 to i64
  %arrayidx60 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx57, i64 0, i64 %idxprom59
  %38 = load double, double* %arrayidx60, align 8
  %39 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %40 = load i32, i32* %i, align 4
  %idxprom61 = sext i32 %40 to i64
  %arrayidx62 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %39, i64 %idxprom61
  %41 = load i32, i32* %j, align 4
  %idxprom63 = sext i32 %41 to i64
  %arrayidx64 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx62, i64 0, i64 %idxprom63
  %42 = load i32, i32* %k, align 4
  %idxprom65 = sext i32 %42 to i64
  %arrayidx66 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx64, i64 0, i64 %idxprom65
  %43 = load double, double* %arrayidx66, align 8
  %mul67 = fmul double 2.000000e+00, %43
  %sub68 = fsub double %38, %mul67
  %44 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %45 = load i32, i32* %i, align 4
  %idxprom69 = sext i32 %45 to i64
  %arrayidx70 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %44, i64 %idxprom69
  %46 = load i32, i32* %j, align 4
  %idxprom71 = sext i32 %46 to i64
  %arrayidx72 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx70, i64 0, i64 %idxprom71
  %47 = load i32, i32* %k, align 4
  %sub73 = sub nsw i32 %47, 1
  %idxprom74 = sext i32 %sub73 to i64
  %arrayidx75 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx72, i64 0, i64 %idxprom74
  %48 = load double, double* %arrayidx75, align 8
  %add76 = fadd double %sub68, %48
  %mul77 = fmul double 1.250000e-01, %add76
  %add78 = fadd double %add53, %mul77
  %49 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %50 = load i32, i32* %i, align 4
  %idxprom79 = sext i32 %50 to i64
  %arrayidx80 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %49, i64 %idxprom79
  %51 = load i32, i32* %j, align 4
  %idxprom81 = sext i32 %51 to i64
  %arrayidx82 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx80, i64 0, i64 %idxprom81
  %52 = load i32, i32* %k, align 4
  %idxprom83 = sext i32 %52 to i64
  %arrayidx84 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx82, i64 0, i64 %idxprom83
  %53 = load double, double* %arrayidx84, align 8
  %add85 = fadd double %add78, %53
  %54 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %55 = load i32, i32* %i, align 4
  %idxprom86 = sext i32 %55 to i64
  %arrayidx87 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %54, i64 %idxprom86
  %56 = load i32, i32* %j, align 4
  %idxprom88 = sext i32 %56 to i64
  %arrayidx89 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx87, i64 0, i64 %idxprom88
  %57 = load i32, i32* %k, align 4
  %idxprom90 = sext i32 %57 to i64
  %arrayidx91 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx89, i64 0, i64 %idxprom90
  store double %add85, double* %arrayidx91, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body9
  %58 = load i32, i32* %k, align 4
  %inc = add nsw i32 %58, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond7, !llvm.loop !2

for.end:                                          ; preds = %for.cond7
  br label %for.inc92

for.inc92:                                        ; preds = %for.end
  %59 = load i32, i32* %j, align 4
  %inc93 = add nsw i32 %59, 1
  store i32 %inc93, i32* %j, align 4
  br label %for.cond4, !llvm.loop !4

for.end94:                                        ; preds = %for.cond4
  br label %for.inc95

for.inc95:                                        ; preds = %for.end94
  %60 = load i32, i32* %i, align 4
  %inc96 = add nsw i32 %60, 1
  store i32 %inc96, i32* %i, align 4
  br label %for.cond1, !llvm.loop !5

for.end97:                                        ; preds = %for.cond1
  store i32 1, i32* %i, align 4
  br label %for.cond98

for.cond98:                                       ; preds = %for.inc200, %for.end97
  %61 = load i32, i32* %i, align 4
  %cmp99 = icmp slt i32 %61, 19
  br i1 %cmp99, label %for.body100, label %for.end202

for.body100:                                      ; preds = %for.cond98
  store i32 1, i32* %j, align 4
  br label %for.cond101

for.cond101:                                      ; preds = %for.inc197, %for.body100
  %62 = load i32, i32* %j, align 4
  %cmp102 = icmp slt i32 %62, 19
  br i1 %cmp102, label %for.body103, label %for.end199

for.body103:                                      ; preds = %for.cond101
  store i32 1, i32* %k, align 4
  br label %for.cond104

for.cond104:                                      ; preds = %for.inc194, %for.body103
  %63 = load i32, i32* %k, align 4
  %cmp105 = icmp slt i32 %63, 19
  br i1 %cmp105, label %for.body106, label %for.end196

for.body106:                                      ; preds = %for.cond104
  %64 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %65 = load i32, i32* %i, align 4
  %add107 = add nsw i32 %65, 1
  %idxprom108 = sext i32 %add107 to i64
  %arrayidx109 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %64, i64 %idxprom108
  %66 = load i32, i32* %j, align 4
  %idxprom110 = sext i32 %66 to i64
  %arrayidx111 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx109, i64 0, i64 %idxprom110
  %67 = load i32, i32* %k, align 4
  %idxprom112 = sext i32 %67 to i64
  %arrayidx113 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx111, i64 0, i64 %idxprom112
  %68 = load double, double* %arrayidx113, align 8
  %69 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %70 = load i32, i32* %i, align 4
  %idxprom114 = sext i32 %70 to i64
  %arrayidx115 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %69, i64 %idxprom114
  %71 = load i32, i32* %j, align 4
  %idxprom116 = sext i32 %71 to i64
  %arrayidx117 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx115, i64 0, i64 %idxprom116
  %72 = load i32, i32* %k, align 4
  %idxprom118 = sext i32 %72 to i64
  %arrayidx119 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx117, i64 0, i64 %idxprom118
  %73 = load double, double* %arrayidx119, align 8
  %mul120 = fmul double 2.000000e+00, %73
  %sub121 = fsub double %68, %mul120
  %74 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %75 = load i32, i32* %i, align 4
  %sub122 = sub nsw i32 %75, 1
  %idxprom123 = sext i32 %sub122 to i64
  %arrayidx124 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %74, i64 %idxprom123
  %76 = load i32, i32* %j, align 4
  %idxprom125 = sext i32 %76 to i64
  %arrayidx126 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx124, i64 0, i64 %idxprom125
  %77 = load i32, i32* %k, align 4
  %idxprom127 = sext i32 %77 to i64
  %arrayidx128 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx126, i64 0, i64 %idxprom127
  %78 = load double, double* %arrayidx128, align 8
  %add129 = fadd double %sub121, %78
  %mul130 = fmul double 1.250000e-01, %add129
  %79 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %80 = load i32, i32* %i, align 4
  %idxprom131 = sext i32 %80 to i64
  %arrayidx132 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %79, i64 %idxprom131
  %81 = load i32, i32* %j, align 4
  %add133 = add nsw i32 %81, 1
  %idxprom134 = sext i32 %add133 to i64
  %arrayidx135 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx132, i64 0, i64 %idxprom134
  %82 = load i32, i32* %k, align 4
  %idxprom136 = sext i32 %82 to i64
  %arrayidx137 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx135, i64 0, i64 %idxprom136
  %83 = load double, double* %arrayidx137, align 8
  %84 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %85 = load i32, i32* %i, align 4
  %idxprom138 = sext i32 %85 to i64
  %arrayidx139 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %84, i64 %idxprom138
  %86 = load i32, i32* %j, align 4
  %idxprom140 = sext i32 %86 to i64
  %arrayidx141 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx139, i64 0, i64 %idxprom140
  %87 = load i32, i32* %k, align 4
  %idxprom142 = sext i32 %87 to i64
  %arrayidx143 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx141, i64 0, i64 %idxprom142
  %88 = load double, double* %arrayidx143, align 8
  %mul144 = fmul double 2.000000e+00, %88
  %sub145 = fsub double %83, %mul144
  %89 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %90 = load i32, i32* %i, align 4
  %idxprom146 = sext i32 %90 to i64
  %arrayidx147 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %89, i64 %idxprom146
  %91 = load i32, i32* %j, align 4
  %sub148 = sub nsw i32 %91, 1
  %idxprom149 = sext i32 %sub148 to i64
  %arrayidx150 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx147, i64 0, i64 %idxprom149
  %92 = load i32, i32* %k, align 4
  %idxprom151 = sext i32 %92 to i64
  %arrayidx152 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx150, i64 0, i64 %idxprom151
  %93 = load double, double* %arrayidx152, align 8
  %add153 = fadd double %sub145, %93
  %mul154 = fmul double 1.250000e-01, %add153
  %add155 = fadd double %mul130, %mul154
  %94 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %95 = load i32, i32* %i, align 4
  %idxprom156 = sext i32 %95 to i64
  %arrayidx157 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %94, i64 %idxprom156
  %96 = load i32, i32* %j, align 4
  %idxprom158 = sext i32 %96 to i64
  %arrayidx159 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx157, i64 0, i64 %idxprom158
  %97 = load i32, i32* %k, align 4
  %add160 = add nsw i32 %97, 1
  %idxprom161 = sext i32 %add160 to i64
  %arrayidx162 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx159, i64 0, i64 %idxprom161
  %98 = load double, double* %arrayidx162, align 8
  %99 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %100 = load i32, i32* %i, align 4
  %idxprom163 = sext i32 %100 to i64
  %arrayidx164 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %99, i64 %idxprom163
  %101 = load i32, i32* %j, align 4
  %idxprom165 = sext i32 %101 to i64
  %arrayidx166 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx164, i64 0, i64 %idxprom165
  %102 = load i32, i32* %k, align 4
  %idxprom167 = sext i32 %102 to i64
  %arrayidx168 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx166, i64 0, i64 %idxprom167
  %103 = load double, double* %arrayidx168, align 8
  %mul169 = fmul double 2.000000e+00, %103
  %sub170 = fsub double %98, %mul169
  %104 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %105 = load i32, i32* %i, align 4
  %idxprom171 = sext i32 %105 to i64
  %arrayidx172 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %104, i64 %idxprom171
  %106 = load i32, i32* %j, align 4
  %idxprom173 = sext i32 %106 to i64
  %arrayidx174 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx172, i64 0, i64 %idxprom173
  %107 = load i32, i32* %k, align 4
  %sub175 = sub nsw i32 %107, 1
  %idxprom176 = sext i32 %sub175 to i64
  %arrayidx177 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx174, i64 0, i64 %idxprom176
  %108 = load double, double* %arrayidx177, align 8
  %add178 = fadd double %sub170, %108
  %mul179 = fmul double 1.250000e-01, %add178
  %add180 = fadd double %add155, %mul179
  %109 = load [20 x [20 x double]]*, [20 x [20 x double]]** %B.addr, align 8
  %110 = load i32, i32* %i, align 4
  %idxprom181 = sext i32 %110 to i64
  %arrayidx182 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %109, i64 %idxprom181
  %111 = load i32, i32* %j, align 4
  %idxprom183 = sext i32 %111 to i64
  %arrayidx184 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx182, i64 0, i64 %idxprom183
  %112 = load i32, i32* %k, align 4
  %idxprom185 = sext i32 %112 to i64
  %arrayidx186 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx184, i64 0, i64 %idxprom185
  %113 = load double, double* %arrayidx186, align 8
  %add187 = fadd double %add180, %113
  %114 = load [20 x [20 x double]]*, [20 x [20 x double]]** %A.addr, align 8
  %115 = load i32, i32* %i, align 4
  %idxprom188 = sext i32 %115 to i64
  %arrayidx189 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %114, i64 %idxprom188
  %116 = load i32, i32* %j, align 4
  %idxprom190 = sext i32 %116 to i64
  %arrayidx191 = getelementptr inbounds [20 x [20 x double]], [20 x [20 x double]]* %arrayidx189, i64 0, i64 %idxprom190
  %117 = load i32, i32* %k, align 4
  %idxprom192 = sext i32 %117 to i64
  %arrayidx193 = getelementptr inbounds [20 x double], [20 x double]* %arrayidx191, i64 0, i64 %idxprom192
  store double %add187, double* %arrayidx193, align 8
  br label %for.inc194

for.inc194:                                       ; preds = %for.body106
  %118 = load i32, i32* %k, align 4
  %inc195 = add nsw i32 %118, 1
  store i32 %inc195, i32* %k, align 4
  br label %for.cond104, !llvm.loop !6

for.end196:                                       ; preds = %for.cond104
  br label %for.inc197

for.inc197:                                       ; preds = %for.end196
  %119 = load i32, i32* %j, align 4
  %inc198 = add nsw i32 %119, 1
  store i32 %inc198, i32* %j, align 4
  br label %for.cond101, !llvm.loop !7

for.end199:                                       ; preds = %for.cond101
  br label %for.inc200

for.inc200:                                       ; preds = %for.end199
  %120 = load i32, i32* %i, align 4
  %inc201 = add nsw i32 %120, 1
  store i32 %inc201, i32* %i, align 4
  br label %for.cond98, !llvm.loop !8

for.end202:                                       ; preds = %for.cond98
  br label %for.inc203

for.inc203:                                       ; preds = %for.end202
  %121 = load i32, i32* %t, align 4
  %inc204 = add nsw i32 %121, 1
  store i32 %inc204, i32* %t, align 4
  br label %for.cond, !llvm.loop !9

for.end205:                                       ; preds = %for.cond
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
