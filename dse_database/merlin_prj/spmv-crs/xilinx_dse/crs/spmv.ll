; ModuleID = '/home/atefehSZ/MachSuite/original_files/MachSuite/spmv/xilinx_dse_crs/crs/spmv.c'
source_filename = "/home/atefehSZ/MachSuite/original_files/MachSuite/spmv/xilinx_dse_crs/crs/spmv.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @spmv(double* %val, i32* %cols, i32* %rowDelimiters, double* %vec, double* %out) #0 {
entry:
  %val.addr = alloca double*, align 8
  %cols.addr = alloca i32*, align 8
  %rowDelimiters.addr = alloca i32*, align 8
  %vec.addr = alloca double*, align 8
  %out.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %sum = alloca double, align 8
  %Si = alloca double, align 8
  %tmp_begin = alloca i32, align 4
  %tmp_end = alloca i32, align 4
  store double* %val, double** %val.addr, align 8
  store i32* %cols, i32** %cols.addr, align 8
  store i32* %rowDelimiters, i32** %rowDelimiters.addr, align 8
  store double* %vec, double** %vec.addr, align 8
  store double* %out, double** %out.addr, align 8
  br label %spmv_1

spmv_1:                                           ; preds = %entry
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc15, %spmv_1
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 494
  br i1 %cmp, label %for.body, label %for.end17

for.body:                                         ; preds = %for.cond
  store double 0.000000e+00, double* %sum, align 8
  store double 0.000000e+00, double* %Si, align 8
  %1 = load i32*, i32** %rowDelimiters.addr, align 8
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i32, i32* %1, i64 %idxprom
  %3 = load i32, i32* %arrayidx, align 4
  store i32 %3, i32* %tmp_begin, align 4
  %4 = load i32*, i32** %rowDelimiters.addr, align 8
  %5 = load i32, i32* %i, align 4
  %add = add nsw i32 %5, 1
  %idxprom1 = sext i32 %add to i64
  %arrayidx2 = getelementptr inbounds i32, i32* %4, i64 %idxprom1
  %6 = load i32, i32* %arrayidx2, align 4
  store i32 %6, i32* %tmp_end, align 4
  br label %spmv_2

spmv_2:                                           ; preds = %for.body
  %7 = load i32, i32* %tmp_begin, align 4
  store i32 %7, i32* %j, align 4
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc, %spmv_2
  %8 = load i32, i32* %j, align 4
  %9 = load i32, i32* %tmp_end, align 4
  %cmp4 = icmp slt i32 %8, %9
  br i1 %cmp4, label %for.body5, label %for.end

for.body5:                                        ; preds = %for.cond3
  %10 = load double*, double** %val.addr, align 8
  %11 = load i32, i32* %j, align 4
  %idxprom6 = sext i32 %11 to i64
  %arrayidx7 = getelementptr inbounds double, double* %10, i64 %idxprom6
  %12 = load double, double* %arrayidx7, align 8
  %13 = load double*, double** %vec.addr, align 8
  %14 = load i32*, i32** %cols.addr, align 8
  %15 = load i32, i32* %j, align 4
  %idxprom8 = sext i32 %15 to i64
  %arrayidx9 = getelementptr inbounds i32, i32* %14, i64 %idxprom8
  %16 = load i32, i32* %arrayidx9, align 4
  %idxprom10 = sext i32 %16 to i64
  %arrayidx11 = getelementptr inbounds double, double* %13, i64 %idxprom10
  %17 = load double, double* %arrayidx11, align 8
  %mul = fmul double %12, %17
  store double %mul, double* %Si, align 8
  %18 = load double, double* %sum, align 8
  %19 = load double, double* %Si, align 8
  %add12 = fadd double %18, %19
  store double %add12, double* %sum, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body5
  %20 = load i32, i32* %j, align 4
  %inc = add nsw i32 %20, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond3, !llvm.loop !2

for.end:                                          ; preds = %for.cond3
  %21 = load double, double* %sum, align 8
  %22 = load double*, double** %out.addr, align 8
  %23 = load i32, i32* %i, align 4
  %idxprom13 = sext i32 %23 to i64
  %arrayidx14 = getelementptr inbounds double, double* %22, i64 %idxprom13
  store double %21, double* %arrayidx14, align 8
  br label %for.inc15

for.inc15:                                        ; preds = %for.end
  %24 = load i32, i32* %i, align 4
  %inc16 = add nsw i32 %24, 1
  store i32 %inc16, i32* %i, align 4
  br label %for.cond, !llvm.loop !4

for.end17:                                        ; preds = %for.cond
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
