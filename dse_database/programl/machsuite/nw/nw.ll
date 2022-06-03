; ModuleID = '/home/atefehSZ/MachSuite/original_files/MachSuite/nw/xilinx_dse/nw/nw.c'
source_filename = "/home/atefehSZ/MachSuite/original_files/MachSuite/nw/xilinx_dse/nw/nw.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @needwun(i8* %SEQA, i8* %SEQB, i8* %alignedA, i8* %alignedB, i32* %M, i8* %ptr) #0 {
entry:
  %SEQA.addr = alloca i8*, align 8
  %SEQB.addr = alloca i8*, align 8
  %alignedA.addr = alloca i8*, align 8
  %alignedB.addr = alloca i8*, align 8
  %M.addr = alloca i32*, align 8
  %ptr.addr = alloca i8*, align 8
  %score = alloca i32, align 4
  %up_left = alloca i32, align 4
  %up = alloca i32, align 4
  %left = alloca i32, align 4
  %max = alloca i32, align 4
  %row = alloca i32, align 4
  %row_up = alloca i32, align 4
  %r = alloca i32, align 4
  %a_idx = alloca i32, align 4
  %b_idx = alloca i32, align 4
  %a_str_idx = alloca i32, align 4
  %b_str_idx = alloca i32, align 4
  store i8* %SEQA, i8** %SEQA.addr, align 8
  store i8* %SEQB, i8** %SEQB.addr, align 8
  store i8* %alignedA, i8** %alignedA.addr, align 8
  store i8* %alignedB, i8** %alignedB.addr, align 8
  store i32* %M, i32** %M.addr, align 8
  store i8* %ptr, i8** %ptr.addr, align 8
  br label %init_row

init_row:                                         ; preds = %entry
  store i32 0, i32* %a_idx, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %init_row
  %0 = load i32, i32* %a_idx, align 4
  %cmp = icmp slt i32 %0, 129
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %a_idx, align 4
  %mul = mul nsw i32 %1, -1
  %2 = load i32*, i32** %M.addr, align 8
  %3 = load i32, i32* %a_idx, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 %idxprom
  store i32 %mul, i32* %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %a_idx, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, i32* %a_idx, align 4
  br label %for.cond, !llvm.loop !2

for.end:                                          ; preds = %for.cond
  br label %init_col

init_col:                                         ; preds = %for.end
  store i32 0, i32* %b_idx, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc8, %init_col
  %5 = load i32, i32* %b_idx, align 4
  %cmp2 = icmp slt i32 %5, 129
  br i1 %cmp2, label %for.body3, label %for.end10

for.body3:                                        ; preds = %for.cond1
  %6 = load i32, i32* %b_idx, align 4
  %mul4 = mul nsw i32 %6, -1
  %7 = load i32*, i32** %M.addr, align 8
  %8 = load i32, i32* %b_idx, align 4
  %mul5 = mul nsw i32 %8, 129
  %idxprom6 = sext i32 %mul5 to i64
  %arrayidx7 = getelementptr inbounds i32, i32* %7, i64 %idxprom6
  store i32 %mul4, i32* %arrayidx7, align 4
  br label %for.inc8

for.inc8:                                         ; preds = %for.body3
  %9 = load i32, i32* %b_idx, align 4
  %inc9 = add nsw i32 %9, 1
  store i32 %inc9, i32* %b_idx, align 4
  br label %for.cond1, !llvm.loop !4

for.end10:                                        ; preds = %for.cond1
  br label %fill_out

fill_out:                                         ; preds = %for.end10
  store i32 1, i32* %b_idx, align 4
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc80, %fill_out
  %10 = load i32, i32* %b_idx, align 4
  %cmp12 = icmp slt i32 %10, 129
  br i1 %cmp12, label %for.body13, label %for.end82

for.body13:                                       ; preds = %for.cond11
  br label %fill_in

fill_in:                                          ; preds = %for.body13
  store i32 1, i32* %a_idx, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc77, %fill_in
  %11 = load i32, i32* %a_idx, align 4
  %cmp15 = icmp slt i32 %11, 129
  br i1 %cmp15, label %for.body16, label %for.end79

for.body16:                                       ; preds = %for.cond14
  %12 = load i8*, i8** %SEQA.addr, align 8
  %13 = load i32, i32* %a_idx, align 4
  %sub = sub nsw i32 %13, 1
  %idxprom17 = sext i32 %sub to i64
  %arrayidx18 = getelementptr inbounds i8, i8* %12, i64 %idxprom17
  %14 = load i8, i8* %arrayidx18, align 1
  %conv = sext i8 %14 to i32
  %15 = load i8*, i8** %SEQB.addr, align 8
  %16 = load i32, i32* %b_idx, align 4
  %sub19 = sub nsw i32 %16, 1
  %idxprom20 = sext i32 %sub19 to i64
  %arrayidx21 = getelementptr inbounds i8, i8* %15, i64 %idxprom20
  %17 = load i8, i8* %arrayidx21, align 1
  %conv22 = sext i8 %17 to i32
  %cmp23 = icmp eq i32 %conv, %conv22
  br i1 %cmp23, label %if.then, label %if.else

if.then:                                          ; preds = %for.body16
  store i32 1, i32* %score, align 4
  br label %if.end

if.else:                                          ; preds = %for.body16
  store i32 -1, i32* %score, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %18 = load i32, i32* %b_idx, align 4
  %sub25 = sub nsw i32 %18, 1
  %mul26 = mul nsw i32 %sub25, 129
  store i32 %mul26, i32* %row_up, align 4
  %19 = load i32, i32* %b_idx, align 4
  %mul27 = mul nsw i32 %19, 129
  store i32 %mul27, i32* %row, align 4
  %20 = load i32*, i32** %M.addr, align 8
  %21 = load i32, i32* %row_up, align 4
  %22 = load i32, i32* %a_idx, align 4
  %sub28 = sub nsw i32 %22, 1
  %add = add nsw i32 %21, %sub28
  %idxprom29 = sext i32 %add to i64
  %arrayidx30 = getelementptr inbounds i32, i32* %20, i64 %idxprom29
  %23 = load i32, i32* %arrayidx30, align 4
  %24 = load i32, i32* %score, align 4
  %add31 = add nsw i32 %23, %24
  store i32 %add31, i32* %up_left, align 4
  %25 = load i32*, i32** %M.addr, align 8
  %26 = load i32, i32* %row_up, align 4
  %27 = load i32, i32* %a_idx, align 4
  %add32 = add nsw i32 %26, %27
  %idxprom33 = sext i32 %add32 to i64
  %arrayidx34 = getelementptr inbounds i32, i32* %25, i64 %idxprom33
  %28 = load i32, i32* %arrayidx34, align 4
  %add35 = add nsw i32 %28, -1
  store i32 %add35, i32* %up, align 4
  %29 = load i32*, i32** %M.addr, align 8
  %30 = load i32, i32* %row, align 4
  %31 = load i32, i32* %a_idx, align 4
  %sub36 = sub nsw i32 %31, 1
  %add37 = add nsw i32 %30, %sub36
  %idxprom38 = sext i32 %add37 to i64
  %arrayidx39 = getelementptr inbounds i32, i32* %29, i64 %idxprom38
  %32 = load i32, i32* %arrayidx39, align 4
  %add40 = add nsw i32 %32, -1
  store i32 %add40, i32* %left, align 4
  %33 = load i32, i32* %up_left, align 4
  %34 = load i32, i32* %up, align 4
  %35 = load i32, i32* %left, align 4
  %cmp41 = icmp sgt i32 %34, %35
  br i1 %cmp41, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end
  %36 = load i32, i32* %up, align 4
  br label %cond.end

cond.false:                                       ; preds = %if.end
  %37 = load i32, i32* %left, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %36, %cond.true ], [ %37, %cond.false ]
  %cmp43 = icmp sgt i32 %33, %cond
  br i1 %cmp43, label %cond.true45, label %cond.false46

cond.true45:                                      ; preds = %cond.end
  %38 = load i32, i32* %up_left, align 4
  br label %cond.end53

cond.false46:                                     ; preds = %cond.end
  %39 = load i32, i32* %up, align 4
  %40 = load i32, i32* %left, align 4
  %cmp47 = icmp sgt i32 %39, %40
  br i1 %cmp47, label %cond.true49, label %cond.false50

cond.true49:                                      ; preds = %cond.false46
  %41 = load i32, i32* %up, align 4
  br label %cond.end51

cond.false50:                                     ; preds = %cond.false46
  %42 = load i32, i32* %left, align 4
  br label %cond.end51

cond.end51:                                       ; preds = %cond.false50, %cond.true49
  %cond52 = phi i32 [ %41, %cond.true49 ], [ %42, %cond.false50 ]
  br label %cond.end53

cond.end53:                                       ; preds = %cond.end51, %cond.true45
  %cond54 = phi i32 [ %38, %cond.true45 ], [ %cond52, %cond.end51 ]
  store i32 %cond54, i32* %max, align 4
  %43 = load i32, i32* %max, align 4
  %44 = load i32*, i32** %M.addr, align 8
  %45 = load i32, i32* %row, align 4
  %46 = load i32, i32* %a_idx, align 4
  %add55 = add nsw i32 %45, %46
  %idxprom56 = sext i32 %add55 to i64
  %arrayidx57 = getelementptr inbounds i32, i32* %44, i64 %idxprom56
  store i32 %43, i32* %arrayidx57, align 4
  %47 = load i32, i32* %max, align 4
  %48 = load i32, i32* %left, align 4
  %cmp58 = icmp eq i32 %47, %48
  br i1 %cmp58, label %if.then60, label %if.else64

if.then60:                                        ; preds = %cond.end53
  %49 = load i8*, i8** %ptr.addr, align 8
  %50 = load i32, i32* %row, align 4
  %51 = load i32, i32* %a_idx, align 4
  %add61 = add nsw i32 %50, %51
  %idxprom62 = sext i32 %add61 to i64
  %arrayidx63 = getelementptr inbounds i8, i8* %49, i64 %idxprom62
  store i8 60, i8* %arrayidx63, align 1
  br label %if.end76

if.else64:                                        ; preds = %cond.end53
  %52 = load i32, i32* %max, align 4
  %53 = load i32, i32* %up, align 4
  %cmp65 = icmp eq i32 %52, %53
  br i1 %cmp65, label %if.then67, label %if.else71

if.then67:                                        ; preds = %if.else64
  %54 = load i8*, i8** %ptr.addr, align 8
  %55 = load i32, i32* %row, align 4
  %56 = load i32, i32* %a_idx, align 4
  %add68 = add nsw i32 %55, %56
  %idxprom69 = sext i32 %add68 to i64
  %arrayidx70 = getelementptr inbounds i8, i8* %54, i64 %idxprom69
  store i8 94, i8* %arrayidx70, align 1
  br label %if.end75

if.else71:                                        ; preds = %if.else64
  %57 = load i8*, i8** %ptr.addr, align 8
  %58 = load i32, i32* %row, align 4
  %59 = load i32, i32* %a_idx, align 4
  %add72 = add nsw i32 %58, %59
  %idxprom73 = sext i32 %add72 to i64
  %arrayidx74 = getelementptr inbounds i8, i8* %57, i64 %idxprom73
  store i8 92, i8* %arrayidx74, align 1
  br label %if.end75

if.end75:                                         ; preds = %if.else71, %if.then67
  br label %if.end76

if.end76:                                         ; preds = %if.end75, %if.then60
  br label %for.inc77

for.inc77:                                        ; preds = %if.end76
  %60 = load i32, i32* %a_idx, align 4
  %inc78 = add nsw i32 %60, 1
  store i32 %inc78, i32* %a_idx, align 4
  br label %for.cond14, !llvm.loop !5

for.end79:                                        ; preds = %for.cond14
  br label %for.inc80

for.inc80:                                        ; preds = %for.end79
  %61 = load i32, i32* %b_idx, align 4
  %inc81 = add nsw i32 %61, 1
  store i32 %inc81, i32* %b_idx, align 4
  br label %for.cond11, !llvm.loop !6

for.end82:                                        ; preds = %for.cond11
  store i32 128, i32* %a_idx, align 4
  store i32 128, i32* %b_idx, align 4
  store i32 0, i32* %a_str_idx, align 4
  store i32 0, i32* %b_str_idx, align 4
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
