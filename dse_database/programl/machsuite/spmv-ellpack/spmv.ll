; ModuleID = '/home/atefehSZ/MachSuite/original_files/MachSuite/spmv/xilinx_dse_ellpack/ellpack/spmv.c'
source_filename = "/home/atefehSZ/MachSuite/original_files/MachSuite/spmv/xilinx_dse_ellpack/ellpack/spmv.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ellpack(double* %nzval, i32* %cols, double* %vec, double* %out) #0 {
entry:
  %nzval.addr = alloca double*, align 8
  %cols.addr = alloca i32*, align 8
  %vec.addr = alloca double*, align 8
  %out.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %Si = alloca double, align 8
  %sum = alloca double, align 8
  store double* %nzval, double** %nzval.addr, align 8
  store i32* %cols, i32** %cols.addr, align 8
  store double* %vec, double** %vec.addr, align 8
  store double* %out, double** %out.addr, align 8
  br label %ellpack_1

ellpack_1:                                        ; preds = %entry
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc16, %ellpack_1
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 494
  br i1 %cmp, label %for.body, label %for.end18

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %out.addr, align 8
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom
  %3 = load double, double* %arrayidx, align 8
  store double %3, double* %sum, align 8
  br label %ellpack_2

ellpack_2:                                        ; preds = %for.body
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %ellpack_2
  %4 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %4, 10
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %5 = load double*, double** %nzval.addr, align 8
  %6 = load i32, i32* %j, align 4
  %7 = load i32, i32* %i, align 4
  %mul = mul nsw i32 %7, 10
  %add = add nsw i32 %6, %mul
  %idxprom4 = sext i32 %add to i64
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4
  %8 = load double, double* %arrayidx5, align 8
  %9 = load double*, double** %vec.addr, align 8
  %10 = load i32*, i32** %cols.addr, align 8
  %11 = load i32, i32* %j, align 4
  %12 = load i32, i32* %i, align 4
  %mul6 = mul nsw i32 %12, 10
  %add7 = add nsw i32 %11, %mul6
  %idxprom8 = sext i32 %add7 to i64
  %arrayidx9 = getelementptr inbounds i32, i32* %10, i64 %idxprom8
  %13 = load i32, i32* %arrayidx9, align 4
  %idxprom10 = sext i32 %13 to i64
  %arrayidx11 = getelementptr inbounds double, double* %9, i64 %idxprom10
  %14 = load double, double* %arrayidx11, align 8
  %mul12 = fmul double %8, %14
  store double %mul12, double* %Si, align 8
  %15 = load double, double* %Si, align 8
  %16 = load double, double* %sum, align 8
  %add13 = fadd double %16, %15
  store double %add13, double* %sum, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %17 = load i32, i32* %j, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  %18 = load double, double* %sum, align 8
  %19 = load double*, double** %out.addr, align 8
  %20 = load i32, i32* %i, align 4
  %idxprom14 = sext i32 %20 to i64
  %arrayidx15 = getelementptr inbounds double, double* %19, i64 %idxprom14
  store double %18, double* %arrayidx15, align 8
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %21 = load i32, i32* %i, align 4
  %inc17 = add nsw i32 %21, 1
  store i32 %inc17, i32* %i, align 4
  br label %for.cond, !llvm.loop !4

for.end18:                                        ; preds = %for.cond
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
