; ModuleID = 'md.c'
source_filename = "md.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @md_kernel(double* %force_x, double* %force_y, double* %force_z, double* %position_x, double* %position_y, double* %position_z, i32* %NL) #0 {
entry:
  %force_x.addr = alloca double*, align 8
  %force_y.addr = alloca double*, align 8
  %force_z.addr = alloca double*, align 8
  %position_x.addr = alloca double*, align 8
  %position_y.addr = alloca double*, align 8
  %position_z.addr = alloca double*, align 8
  %NL.addr = alloca i32*, align 8
  %delx = alloca double, align 8
  %dely = alloca double, align 8
  %delz = alloca double, align 8
  %r2inv = alloca double, align 8
  %r6inv = alloca double, align 8
  %potential = alloca double, align 8
  %force = alloca double, align 8
  %j_x = alloca double, align 8
  %j_y = alloca double, align 8
  %j_z = alloca double, align 8
  %i_x = alloca double, align 8
  %i_y = alloca double, align 8
  %i_z = alloca double, align 8
  %fx = alloca double, align 8
  %fy = alloca double, align 8
  %fz = alloca double, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %jidx = alloca i32, align 4
  store double* %force_x, double** %force_x.addr, align 8
  store double* %force_y, double** %force_y.addr, align 8
  store double* %force_z, double** %force_z.addr, align 8
  store double* %position_x, double** %position_x.addr, align 8
  store double* %position_y, double** %position_y.addr, align 8
  store double* %position_z, double** %position_z.addr, align 8
  store i32* %NL, i32** %NL.addr, align 8
  br label %loop_i

loop_i:                                           ; preds = %entry
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc41, %loop_i
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 256
  br i1 %cmp, label %for.body, label %for.end43

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %position_x.addr, align 8
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom
  %3 = load double, double* %arrayidx, align 8
  store double %3, double* %i_x, align 8
  %4 = load double*, double** %position_y.addr, align 8
  %5 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %5 to i64
  %arrayidx2 = getelementptr inbounds double, double* %4, i64 %idxprom1
  %6 = load double, double* %arrayidx2, align 8
  store double %6, double* %i_y, align 8
  %7 = load double*, double** %position_z.addr, align 8
  %8 = load i32, i32* %i, align 4
  %idxprom3 = sext i32 %8 to i64
  %arrayidx4 = getelementptr inbounds double, double* %7, i64 %idxprom3
  %9 = load double, double* %arrayidx4, align 8
  store double %9, double* %i_z, align 8
  store double 0.000000e+00, double* %fx, align 8
  store double 0.000000e+00, double* %fy, align 8
  store double 0.000000e+00, double* %fz, align 8
  br label %loop_j

loop_j:                                           ; preds = %for.body
  store i32 0, i32* %j, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %loop_j
  %10 = load i32, i32* %j, align 4
  %cmp6 = icmp slt i32 %10, 16
  br i1 %cmp6, label %for.body7, label %for.end

for.body7:                                        ; preds = %for.cond5
  %11 = load i32*, i32** %NL.addr, align 8
  %12 = load i32, i32* %i, align 4
  %mul = mul nsw i32 %12, 16
  %13 = load i32, i32* %j, align 4
  %add = add nsw i32 %mul, %13
  %idxprom8 = sext i32 %add to i64
  %arrayidx9 = getelementptr inbounds i32, i32* %11, i64 %idxprom8
  %14 = load i32, i32* %arrayidx9, align 4
  store i32 %14, i32* %jidx, align 4
  %15 = load double*, double** %position_x.addr, align 8
  %16 = load i32, i32* %jidx, align 4
  %idxprom10 = sext i32 %16 to i64
  %arrayidx11 = getelementptr inbounds double, double* %15, i64 %idxprom10
  %17 = load double, double* %arrayidx11, align 8
  store double %17, double* %j_x, align 8
  %18 = load double*, double** %position_y.addr, align 8
  %19 = load i32, i32* %jidx, align 4
  %idxprom12 = sext i32 %19 to i64
  %arrayidx13 = getelementptr inbounds double, double* %18, i64 %idxprom12
  %20 = load double, double* %arrayidx13, align 8
  store double %20, double* %j_y, align 8
  %21 = load double*, double** %position_z.addr, align 8
  %22 = load i32, i32* %jidx, align 4
  %idxprom14 = sext i32 %22 to i64
  %arrayidx15 = getelementptr inbounds double, double* %21, i64 %idxprom14
  %23 = load double, double* %arrayidx15, align 8
  store double %23, double* %j_z, align 8
  %24 = load double, double* %i_x, align 8
  %25 = load double, double* %j_x, align 8
  %sub = fsub double %24, %25
  store double %sub, double* %delx, align 8
  %26 = load double, double* %i_y, align 8
  %27 = load double, double* %j_y, align 8
  %sub16 = fsub double %26, %27
  store double %sub16, double* %dely, align 8
  %28 = load double, double* %i_z, align 8
  %29 = load double, double* %j_z, align 8
  %sub17 = fsub double %28, %29
  store double %sub17, double* %delz, align 8
  %30 = load double, double* %delx, align 8
  %31 = load double, double* %delx, align 8
  %mul18 = fmul double %30, %31
  %32 = load double, double* %dely, align 8
  %33 = load double, double* %dely, align 8
  %mul19 = fmul double %32, %33
  %add20 = fadd double %mul18, %mul19
  %34 = load double, double* %delz, align 8
  %35 = load double, double* %delz, align 8
  %mul21 = fmul double %34, %35
  %add22 = fadd double %add20, %mul21
  %div = fdiv double 1.000000e+00, %add22
  store double %div, double* %r2inv, align 8
  %36 = load double, double* %r2inv, align 8
  %37 = load double, double* %r2inv, align 8
  %mul23 = fmul double %36, %37
  %38 = load double, double* %r2inv, align 8
  %mul24 = fmul double %mul23, %38
  store double %mul24, double* %r6inv, align 8
  %39 = load double, double* %r6inv, align 8
  %40 = load double, double* %r6inv, align 8
  %mul25 = fmul double 1.500000e+00, %40
  %sub26 = fsub double %mul25, 2.000000e+00
  %mul27 = fmul double %39, %sub26
  store double %mul27, double* %potential, align 8
  %41 = load double, double* %r2inv, align 8
  %42 = load double, double* %potential, align 8
  %mul28 = fmul double %41, %42
  store double %mul28, double* %force, align 8
  %43 = load double, double* %delx, align 8
  %44 = load double, double* %force, align 8
  %mul29 = fmul double %43, %44
  %45 = load double, double* %fx, align 8
  %add30 = fadd double %45, %mul29
  store double %add30, double* %fx, align 8
  %46 = load double, double* %dely, align 8
  %47 = load double, double* %force, align 8
  %mul31 = fmul double %46, %47
  %48 = load double, double* %fy, align 8
  %add32 = fadd double %48, %mul31
  store double %add32, double* %fy, align 8
  %49 = load double, double* %delz, align 8
  %50 = load double, double* %force, align 8
  %mul33 = fmul double %49, %50
  %51 = load double, double* %fz, align 8
  %add34 = fadd double %51, %mul33
  store double %add34, double* %fz, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body7
  %52 = load i32, i32* %j, align 4
  %inc = add nsw i32 %52, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond5, !llvm.loop !2

for.end:                                          ; preds = %for.cond5
  %53 = load double, double* %fx, align 8
  %54 = load double*, double** %force_x.addr, align 8
  %55 = load i32, i32* %i, align 4
  %idxprom35 = sext i32 %55 to i64
  %arrayidx36 = getelementptr inbounds double, double* %54, i64 %idxprom35
  store double %53, double* %arrayidx36, align 8
  %56 = load double, double* %fy, align 8
  %57 = load double*, double** %force_y.addr, align 8
  %58 = load i32, i32* %i, align 4
  %idxprom37 = sext i32 %58 to i64
  %arrayidx38 = getelementptr inbounds double, double* %57, i64 %idxprom37
  store double %56, double* %arrayidx38, align 8
  %59 = load double, double* %fz, align 8
  %60 = load double*, double** %force_z.addr, align 8
  %61 = load i32, i32* %i, align 4
  %idxprom39 = sext i32 %61 to i64
  %arrayidx40 = getelementptr inbounds double, double* %60, i64 %idxprom39
  store double %59, double* %arrayidx40, align 8
  br label %for.inc41

for.inc41:                                        ; preds = %for.end
  %62 = load i32, i32* %i, align 4
  %inc42 = add nsw i32 %62, 1
  store i32 %inc42, i32* %i, align 4
  br label %for.cond, !llvm.loop !4

for.end43:                                        ; preds = %for.cond
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
