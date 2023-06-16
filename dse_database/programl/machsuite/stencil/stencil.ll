; ModuleID = 'stencil.c'
source_filename = "stencil.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @stencil(i32* %orig, i32* %sol, i32* %filter) #0 {
entry:
  %orig.addr = alloca i32*, align 8
  %sol.addr = alloca i32*, align 8
  %filter.addr = alloca i32*, align 8
  %r = alloca i32, align 4
  %c = alloca i32, align 4
  %k1 = alloca i32, align 4
  %k2 = alloca i32, align 4
  %temp = alloca i32, align 4
  %mul = alloca i32, align 4
  store i32* %orig, i32** %orig.addr, align 8
  store i32* %sol, i32** %sol.addr, align 8
  store i32* %filter, i32** %filter.addr, align 8
  br label %stencil_label1

stencil_label1:                                   ; preds = %entry
  store i32 0, i32* %r, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc29, %stencil_label1
  %0 = load i32, i32* %r, align 4
  %cmp = icmp slt i32 %0, 126
  br i1 %cmp, label %for.body, label %for.end31

for.body:                                         ; preds = %for.cond
  br label %stencil_label2

stencil_label2:                                   ; preds = %for.body
  store i32 0, i32* %c, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc26, %stencil_label2
  %1 = load i32, i32* %c, align 4
  %cmp2 = icmp slt i32 %1, 62
  br i1 %cmp2, label %for.body3, label %for.end28

for.body3:                                        ; preds = %for.cond1
  store i32 0, i32* %temp, align 4
  br label %stencil_label3

stencil_label3:                                   ; preds = %for.body3
  store i32 0, i32* %k1, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc19, %stencil_label3
  %2 = load i32, i32* %k1, align 4
  %cmp5 = icmp slt i32 %2, 3
  br i1 %cmp5, label %for.body6, label %for.end21

for.body6:                                        ; preds = %for.cond4
  br label %stencil_label4

stencil_label4:                                   ; preds = %for.body6
  store i32 0, i32* %k2, align 4
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc, %stencil_label4
  %3 = load i32, i32* %k2, align 4
  %cmp8 = icmp slt i32 %3, 3
  br i1 %cmp8, label %for.body9, label %for.end

for.body9:                                        ; preds = %for.cond7
  %4 = load i32*, i32** %filter.addr, align 8
  %5 = load i32, i32* %k1, align 4
  %mul10 = mul nsw i32 %5, 3
  %6 = load i32, i32* %k2, align 4
  %add = add nsw i32 %mul10, %6
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32, i32* %4, i64 %idxprom
  %7 = load i32, i32* %arrayidx, align 4
  %8 = load i32*, i32** %orig.addr, align 8
  %9 = load i32, i32* %r, align 4
  %10 = load i32, i32* %k1, align 4
  %add11 = add nsw i32 %9, %10
  %mul12 = mul nsw i32 %add11, 64
  %11 = load i32, i32* %c, align 4
  %add13 = add nsw i32 %mul12, %11
  %12 = load i32, i32* %k2, align 4
  %add14 = add nsw i32 %add13, %12
  %idxprom15 = sext i32 %add14 to i64
  %arrayidx16 = getelementptr inbounds i32, i32* %8, i64 %idxprom15
  %13 = load i32, i32* %arrayidx16, align 4
  %mul17 = mul nsw i32 %7, %13
  store i32 %mul17, i32* %mul, align 4
  %14 = load i32, i32* %mul, align 4
  %15 = load i32, i32* %temp, align 4
  %add18 = add nsw i32 %15, %14
  store i32 %add18, i32* %temp, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body9
  %16 = load i32, i32* %k2, align 4
  %inc = add nsw i32 %16, 1
  store i32 %inc, i32* %k2, align 4
  br label %for.cond7, !llvm.loop !2

for.end:                                          ; preds = %for.cond7
  br label %for.inc19

for.inc19:                                        ; preds = %for.end
  %17 = load i32, i32* %k1, align 4
  %inc20 = add nsw i32 %17, 1
  store i32 %inc20, i32* %k1, align 4
  br label %for.cond4, !llvm.loop !4

for.end21:                                        ; preds = %for.cond4
  %18 = load i32, i32* %temp, align 4
  %19 = load i32*, i32** %sol.addr, align 8
  %20 = load i32, i32* %r, align 4
  %mul22 = mul nsw i32 %20, 64
  %21 = load i32, i32* %c, align 4
  %add23 = add nsw i32 %mul22, %21
  %idxprom24 = sext i32 %add23 to i64
  %arrayidx25 = getelementptr inbounds i32, i32* %19, i64 %idxprom24
  store i32 %18, i32* %arrayidx25, align 4
  br label %for.inc26

for.inc26:                                        ; preds = %for.end21
  %22 = load i32, i32* %c, align 4
  %inc27 = add nsw i32 %22, 1
  store i32 %inc27, i32* %c, align 4
  br label %for.cond1, !llvm.loop !5

for.end28:                                        ; preds = %for.cond1
  br label %for.inc29

for.inc29:                                        ; preds = %for.end28
  %23 = load i32, i32* %r, align 4
  %inc30 = add nsw i32 %23, 1
  store i32 %inc30, i32* %r, align 4
  br label %for.cond, !llvm.loop !6

for.end31:                                        ; preds = %for.cond
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
