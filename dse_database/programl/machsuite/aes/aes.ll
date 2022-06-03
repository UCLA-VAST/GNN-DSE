; ModuleID = '/home/atefehSZ/MachSuite/original_files/MachSuite/aes/xilinx_dse/aes/aes.c'
source_filename = "/home/atefehSZ/MachSuite/original_files/MachSuite/aes/xilinx_dse/aes/aes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.aes256_context = type { [32 x i8], [32 x i8], [32 x i8] }

@sbox = dso_local constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @aes256_encrypt_ecb(%struct.aes256_context* %ctx, i8* %k, i8* %buf) #0 {
entry:
  %ctx.addr = alloca %struct.aes256_context*, align 8
  %k.addr = alloca i8*, align 8
  %buf.addr = alloca i8*, align 8
  %rcon = alloca i8, align 1
  %i = alloca i8, align 1
  %_s_i_0 = alloca i32, align 4
  %_s_i = alloca i32, align 4
  store %struct.aes256_context* %ctx, %struct.aes256_context** %ctx.addr, align 8
  store i8* %k, i8** %k.addr, align 8
  store i8* %buf, i8** %buf.addr, align 8
  store i8 1, i8* %rcon, align 1
  br label %ecb1

ecb1:                                             ; preds = %entry
  store i32 0, i32* %_s_i_0, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %ecb1
  %0 = load i32, i32* %_s_i_0, align 4
  %cmp = icmp sle i32 %0, 31
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i8*, i8** %k.addr, align 8
  %2 = load i32, i32* %_s_i_0, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom
  %3 = load i8, i8* %arrayidx, align 1
  %4 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %deckey = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %4, i32 0, i32 2
  %5 = load i32, i32* %_s_i_0, align 4
  %idxprom1 = sext i32 %5 to i64
  %arrayidx2 = getelementptr inbounds [32 x i8], [32 x i8]* %deckey, i64 0, i64 %idxprom1
  store i8 %3, i8* %arrayidx2, align 1
  %6 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %enckey = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %6, i32 0, i32 1
  %7 = load i32, i32* %_s_i_0, align 4
  %idxprom3 = sext i32 %7 to i64
  %arrayidx4 = getelementptr inbounds [32 x i8], [32 x i8]* %enckey, i64 0, i64 %idxprom3
  store i8 %3, i8* %arrayidx4, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %_s_i_0, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %_s_i_0, align 4
  br label %for.cond, !llvm.loop !2

for.end:                                          ; preds = %for.cond
  %9 = load i32, i32* %_s_i_0, align 4
  %conv = trunc i32 %9 to i8
  store i8 %conv, i8* %i, align 1
  br label %ecb2

ecb2:                                             ; preds = %for.end
  store i8 8, i8* %i, align 1
  br label %for.cond5

for.cond5:                                        ; preds = %for.body6, %ecb2
  %10 = load i8, i8* %i, align 1
  %dec = add i8 %10, -1
  store i8 %dec, i8* %i, align 1
  %tobool = icmp ne i8 %dec, 0
  br i1 %tobool, label %for.body6, label %for.end8

for.body6:                                        ; preds = %for.cond5
  %11 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %deckey7 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %11, i32 0, i32 2
  %arraydecay = getelementptr inbounds [32 x i8], [32 x i8]* %deckey7, i64 0, i64 0
  call void @aes_expandEncKey_1(i8* %arraydecay, i8* %rcon)
  br label %for.cond5, !llvm.loop !4

for.end8:                                         ; preds = %for.cond5
  %12 = load i8*, i8** %buf.addr, align 8
  %13 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %enckey9 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %13, i32 0, i32 1
  %arraydecay10 = getelementptr inbounds [32 x i8], [32 x i8]* %enckey9, i64 0, i64 0
  %14 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %key = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %14, i32 0, i32 0
  %arraydecay11 = getelementptr inbounds [32 x i8], [32 x i8]* %key, i64 0, i64 0
  call void @aes_addRoundKey_cpy_1(i8* %12, i8* %arraydecay10, i8* %arraydecay11)
  store i8 1, i8* %rcon, align 1
  br label %ecb3

ecb3:                                             ; preds = %for.end8
  store i32 1, i32* %_s_i, align 4
  br label %for.cond12

for.cond12:                                       ; preds = %for.inc23, %ecb3
  %15 = load i32, i32* %_s_i, align 4
  %cmp13 = icmp sle i32 %15, 13
  br i1 %cmp13, label %for.body15, label %for.end25

for.body15:                                       ; preds = %for.cond12
  %16 = load i8*, i8** %buf.addr, align 8
  call void @aes_subBytes_1(i8* %16)
  %17 = load i8*, i8** %buf.addr, align 8
  call void @aes_shiftRows_1(i8* %17)
  %18 = load i8*, i8** %buf.addr, align 8
  call void @aes_mixColumns_1(i8* %18)
  %19 = load i32, i32* %_s_i, align 4
  %and = and i32 %19, 1
  %tobool16 = icmp ne i32 %and, 0
  br i1 %tobool16, label %if.then, label %if.else

if.then:                                          ; preds = %for.body15
  %20 = load i8*, i8** %buf.addr, align 8
  %21 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %key17 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %21, i32 0, i32 0
  %arrayidx18 = getelementptr inbounds [32 x i8], [32 x i8]* %key17, i64 0, i64 16
  call void @aes_addRoundKey_1(i8* %20, i8* %arrayidx18)
  br label %if.end

if.else:                                          ; preds = %for.body15
  %22 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %key19 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %22, i32 0, i32 0
  %arraydecay20 = getelementptr inbounds [32 x i8], [32 x i8]* %key19, i64 0, i64 0
  call void @aes_expandEncKey_1(i8* %arraydecay20, i8* %rcon)
  %23 = load i8*, i8** %buf.addr, align 8
  %24 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %key21 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %24, i32 0, i32 0
  %arraydecay22 = getelementptr inbounds [32 x i8], [32 x i8]* %key21, i64 0, i64 0
  call void @aes_addRoundKey_1(i8* %23, i8* %arraydecay22)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc23

for.inc23:                                        ; preds = %if.end
  %25 = load i32, i32* %_s_i, align 4
  %inc24 = add nsw i32 %25, 1
  store i32 %inc24, i32* %_s_i, align 4
  br label %for.cond12, !llvm.loop !5

for.end25:                                        ; preds = %for.cond12
  %26 = load i32, i32* %_s_i, align 4
  %conv26 = trunc i32 %26 to i8
  store i8 %conv26, i8* %i, align 1
  %27 = load i8*, i8** %buf.addr, align 8
  call void @aes_subBytes_1(i8* %27)
  %28 = load i8*, i8** %buf.addr, align 8
  call void @aes_shiftRows_1(i8* %28)
  %29 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %key27 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %29, i32 0, i32 0
  %arraydecay28 = getelementptr inbounds [32 x i8], [32 x i8]* %key27, i64 0, i64 0
  call void @aes_expandEncKey_1(i8* %arraydecay28, i8* %rcon)
  %30 = load i8*, i8** %buf.addr, align 8
  %31 = load %struct.aes256_context*, %struct.aes256_context** %ctx.addr, align 8
  %key29 = getelementptr inbounds %struct.aes256_context, %struct.aes256_context* %31, i32 0, i32 0
  %arraydecay30 = getelementptr inbounds [32 x i8], [32 x i8]* %key29, i64 0, i64 0
  call void @aes_addRoundKey_1(i8* %30, i8* %arraydecay30)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_expandEncKey_1(i8* %k, i8* %rc) #0 {
entry:
  %k.addr = alloca i8*, align 8
  %rc.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %k, i8** %k.addr, align 8
  store i8* %rc, i8** %rc.addr, align 8
  %0 = load i8*, i8** %k.addr, align 8
  %arrayidx = getelementptr inbounds i8, i8* %0, i64 29
  %1 = load i8, i8* %arrayidx, align 1
  %idxprom = zext i8 %1 to i64
  %arrayidx1 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom
  %2 = load i8, i8* %arrayidx1, align 1
  %conv = zext i8 %2 to i32
  %3 = load i8*, i8** %rc.addr, align 8
  %4 = load i8, i8* %3, align 1
  %conv2 = zext i8 %4 to i32
  %xor = xor i32 %conv, %conv2
  %5 = load i8*, i8** %k.addr, align 8
  %arrayidx3 = getelementptr inbounds i8, i8* %5, i64 0
  %6 = load i8, i8* %arrayidx3, align 1
  %conv4 = zext i8 %6 to i32
  %xor5 = xor i32 %conv4, %xor
  %conv6 = trunc i32 %xor5 to i8
  store i8 %conv6, i8* %arrayidx3, align 1
  %7 = load i8*, i8** %k.addr, align 8
  %arrayidx7 = getelementptr inbounds i8, i8* %7, i64 30
  %8 = load i8, i8* %arrayidx7, align 1
  %idxprom8 = zext i8 %8 to i64
  %arrayidx9 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom8
  %9 = load i8, i8* %arrayidx9, align 1
  %conv10 = zext i8 %9 to i32
  %10 = load i8*, i8** %k.addr, align 8
  %arrayidx11 = getelementptr inbounds i8, i8* %10, i64 1
  %11 = load i8, i8* %arrayidx11, align 1
  %conv12 = zext i8 %11 to i32
  %xor13 = xor i32 %conv12, %conv10
  %conv14 = trunc i32 %xor13 to i8
  store i8 %conv14, i8* %arrayidx11, align 1
  %12 = load i8*, i8** %k.addr, align 8
  %arrayidx15 = getelementptr inbounds i8, i8* %12, i64 31
  %13 = load i8, i8* %arrayidx15, align 1
  %idxprom16 = zext i8 %13 to i64
  %arrayidx17 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom16
  %14 = load i8, i8* %arrayidx17, align 1
  %conv18 = zext i8 %14 to i32
  %15 = load i8*, i8** %k.addr, align 8
  %arrayidx19 = getelementptr inbounds i8, i8* %15, i64 2
  %16 = load i8, i8* %arrayidx19, align 1
  %conv20 = zext i8 %16 to i32
  %xor21 = xor i32 %conv20, %conv18
  %conv22 = trunc i32 %xor21 to i8
  store i8 %conv22, i8* %arrayidx19, align 1
  %17 = load i8*, i8** %k.addr, align 8
  %arrayidx23 = getelementptr inbounds i8, i8* %17, i64 28
  %18 = load i8, i8* %arrayidx23, align 1
  %idxprom24 = zext i8 %18 to i64
  %arrayidx25 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom24
  %19 = load i8, i8* %arrayidx25, align 1
  %conv26 = zext i8 %19 to i32
  %20 = load i8*, i8** %k.addr, align 8
  %arrayidx27 = getelementptr inbounds i8, i8* %20, i64 3
  %21 = load i8, i8* %arrayidx27, align 1
  %conv28 = zext i8 %21 to i32
  %xor29 = xor i32 %conv28, %conv26
  %conv30 = trunc i32 %xor29 to i8
  store i8 %conv30, i8* %arrayidx27, align 1
  %22 = load i8*, i8** %rc.addr, align 8
  %23 = load i8, i8* %22, align 1
  %conv31 = zext i8 %23 to i32
  %shl = shl i32 %conv31, 1
  %24 = load i8*, i8** %rc.addr, align 8
  %25 = load i8, i8* %24, align 1
  %conv32 = zext i8 %25 to i32
  %shr = ashr i32 %conv32, 7
  %and = and i32 %shr, 1
  %mul = mul nsw i32 %and, 27
  %xor33 = xor i32 %shl, %mul
  %conv34 = trunc i32 %xor33 to i8
  %26 = load i8*, i8** %rc.addr, align 8
  store i8 %conv34, i8* %26, align 1
  br label %exp1

exp1:                                             ; preds = %entry
  store i8 4, i8* %i, align 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %exp1
  %27 = load i8, i8* %i, align 1
  %conv35 = zext i8 %27 to i32
  %cmp = icmp slt i32 %conv35, 16
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %28 = load i8*, i8** %k.addr, align 8
  %29 = load i8, i8* %i, align 1
  %conv37 = zext i8 %29 to i32
  %sub = sub nsw i32 %conv37, 4
  %idxprom38 = sext i32 %sub to i64
  %arrayidx39 = getelementptr inbounds i8, i8* %28, i64 %idxprom38
  %30 = load i8, i8* %arrayidx39, align 1
  %conv40 = zext i8 %30 to i32
  %31 = load i8*, i8** %k.addr, align 8
  %32 = load i8, i8* %i, align 1
  %idxprom41 = zext i8 %32 to i64
  %arrayidx42 = getelementptr inbounds i8, i8* %31, i64 %idxprom41
  %33 = load i8, i8* %arrayidx42, align 1
  %conv43 = zext i8 %33 to i32
  %xor44 = xor i32 %conv43, %conv40
  %conv45 = trunc i32 %xor44 to i8
  store i8 %conv45, i8* %arrayidx42, align 1
  %34 = load i8*, i8** %k.addr, align 8
  %35 = load i8, i8* %i, align 1
  %conv46 = zext i8 %35 to i32
  %sub47 = sub nsw i32 %conv46, 3
  %idxprom48 = sext i32 %sub47 to i64
  %arrayidx49 = getelementptr inbounds i8, i8* %34, i64 %idxprom48
  %36 = load i8, i8* %arrayidx49, align 1
  %conv50 = zext i8 %36 to i32
  %37 = load i8*, i8** %k.addr, align 8
  %38 = load i8, i8* %i, align 1
  %conv51 = zext i8 %38 to i32
  %add = add nsw i32 %conv51, 1
  %idxprom52 = sext i32 %add to i64
  %arrayidx53 = getelementptr inbounds i8, i8* %37, i64 %idxprom52
  %39 = load i8, i8* %arrayidx53, align 1
  %conv54 = zext i8 %39 to i32
  %xor55 = xor i32 %conv54, %conv50
  %conv56 = trunc i32 %xor55 to i8
  store i8 %conv56, i8* %arrayidx53, align 1
  %40 = load i8*, i8** %k.addr, align 8
  %41 = load i8, i8* %i, align 1
  %conv57 = zext i8 %41 to i32
  %sub58 = sub nsw i32 %conv57, 2
  %idxprom59 = sext i32 %sub58 to i64
  %arrayidx60 = getelementptr inbounds i8, i8* %40, i64 %idxprom59
  %42 = load i8, i8* %arrayidx60, align 1
  %conv61 = zext i8 %42 to i32
  %43 = load i8*, i8** %k.addr, align 8
  %44 = load i8, i8* %i, align 1
  %conv62 = zext i8 %44 to i32
  %add63 = add nsw i32 %conv62, 2
  %idxprom64 = sext i32 %add63 to i64
  %arrayidx65 = getelementptr inbounds i8, i8* %43, i64 %idxprom64
  %45 = load i8, i8* %arrayidx65, align 1
  %conv66 = zext i8 %45 to i32
  %xor67 = xor i32 %conv66, %conv61
  %conv68 = trunc i32 %xor67 to i8
  store i8 %conv68, i8* %arrayidx65, align 1
  %46 = load i8*, i8** %k.addr, align 8
  %47 = load i8, i8* %i, align 1
  %conv69 = zext i8 %47 to i32
  %sub70 = sub nsw i32 %conv69, 1
  %idxprom71 = sext i32 %sub70 to i64
  %arrayidx72 = getelementptr inbounds i8, i8* %46, i64 %idxprom71
  %48 = load i8, i8* %arrayidx72, align 1
  %conv73 = zext i8 %48 to i32
  %49 = load i8*, i8** %k.addr, align 8
  %50 = load i8, i8* %i, align 1
  %conv74 = zext i8 %50 to i32
  %add75 = add nsw i32 %conv74, 3
  %idxprom76 = sext i32 %add75 to i64
  %arrayidx77 = getelementptr inbounds i8, i8* %49, i64 %idxprom76
  %51 = load i8, i8* %arrayidx77, align 1
  %conv78 = zext i8 %51 to i32
  %xor79 = xor i32 %conv78, %conv73
  %conv80 = trunc i32 %xor79 to i8
  store i8 %conv80, i8* %arrayidx77, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %52 = load i8, i8* %i, align 1
  %conv81 = zext i8 %52 to i32
  %add82 = add nsw i32 %conv81, 4
  %conv83 = trunc i32 %add82 to i8
  store i8 %conv83, i8* %i, align 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  %53 = load i8*, i8** %k.addr, align 8
  %arrayidx84 = getelementptr inbounds i8, i8* %53, i64 12
  %54 = load i8, i8* %arrayidx84, align 1
  %idxprom85 = zext i8 %54 to i64
  %arrayidx86 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom85
  %55 = load i8, i8* %arrayidx86, align 1
  %conv87 = zext i8 %55 to i32
  %56 = load i8*, i8** %k.addr, align 8
  %arrayidx88 = getelementptr inbounds i8, i8* %56, i64 16
  %57 = load i8, i8* %arrayidx88, align 1
  %conv89 = zext i8 %57 to i32
  %xor90 = xor i32 %conv89, %conv87
  %conv91 = trunc i32 %xor90 to i8
  store i8 %conv91, i8* %arrayidx88, align 1
  %58 = load i8*, i8** %k.addr, align 8
  %arrayidx92 = getelementptr inbounds i8, i8* %58, i64 13
  %59 = load i8, i8* %arrayidx92, align 1
  %idxprom93 = zext i8 %59 to i64
  %arrayidx94 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom93
  %60 = load i8, i8* %arrayidx94, align 1
  %conv95 = zext i8 %60 to i32
  %61 = load i8*, i8** %k.addr, align 8
  %arrayidx96 = getelementptr inbounds i8, i8* %61, i64 17
  %62 = load i8, i8* %arrayidx96, align 1
  %conv97 = zext i8 %62 to i32
  %xor98 = xor i32 %conv97, %conv95
  %conv99 = trunc i32 %xor98 to i8
  store i8 %conv99, i8* %arrayidx96, align 1
  %63 = load i8*, i8** %k.addr, align 8
  %arrayidx100 = getelementptr inbounds i8, i8* %63, i64 14
  %64 = load i8, i8* %arrayidx100, align 1
  %idxprom101 = zext i8 %64 to i64
  %arrayidx102 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom101
  %65 = load i8, i8* %arrayidx102, align 1
  %conv103 = zext i8 %65 to i32
  %66 = load i8*, i8** %k.addr, align 8
  %arrayidx104 = getelementptr inbounds i8, i8* %66, i64 18
  %67 = load i8, i8* %arrayidx104, align 1
  %conv105 = zext i8 %67 to i32
  %xor106 = xor i32 %conv105, %conv103
  %conv107 = trunc i32 %xor106 to i8
  store i8 %conv107, i8* %arrayidx104, align 1
  %68 = load i8*, i8** %k.addr, align 8
  %arrayidx108 = getelementptr inbounds i8, i8* %68, i64 15
  %69 = load i8, i8* %arrayidx108, align 1
  %idxprom109 = zext i8 %69 to i64
  %arrayidx110 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom109
  %70 = load i8, i8* %arrayidx110, align 1
  %conv111 = zext i8 %70 to i32
  %71 = load i8*, i8** %k.addr, align 8
  %arrayidx112 = getelementptr inbounds i8, i8* %71, i64 19
  %72 = load i8, i8* %arrayidx112, align 1
  %conv113 = zext i8 %72 to i32
  %xor114 = xor i32 %conv113, %conv111
  %conv115 = trunc i32 %xor114 to i8
  store i8 %conv115, i8* %arrayidx112, align 1
  br label %exp2

exp2:                                             ; preds = %for.end
  store i8 20, i8* %i, align 1
  br label %for.cond116

for.cond116:                                      ; preds = %for.inc167, %exp2
  %73 = load i8, i8* %i, align 1
  %conv117 = zext i8 %73 to i32
  %cmp118 = icmp slt i32 %conv117, 32
  br i1 %cmp118, label %for.body120, label %for.end171

for.body120:                                      ; preds = %for.cond116
  %74 = load i8*, i8** %k.addr, align 8
  %75 = load i8, i8* %i, align 1
  %conv121 = zext i8 %75 to i32
  %sub122 = sub nsw i32 %conv121, 4
  %idxprom123 = sext i32 %sub122 to i64
  %arrayidx124 = getelementptr inbounds i8, i8* %74, i64 %idxprom123
  %76 = load i8, i8* %arrayidx124, align 1
  %conv125 = zext i8 %76 to i32
  %77 = load i8*, i8** %k.addr, align 8
  %78 = load i8, i8* %i, align 1
  %idxprom126 = zext i8 %78 to i64
  %arrayidx127 = getelementptr inbounds i8, i8* %77, i64 %idxprom126
  %79 = load i8, i8* %arrayidx127, align 1
  %conv128 = zext i8 %79 to i32
  %xor129 = xor i32 %conv128, %conv125
  %conv130 = trunc i32 %xor129 to i8
  store i8 %conv130, i8* %arrayidx127, align 1
  %80 = load i8*, i8** %k.addr, align 8
  %81 = load i8, i8* %i, align 1
  %conv131 = zext i8 %81 to i32
  %sub132 = sub nsw i32 %conv131, 3
  %idxprom133 = sext i32 %sub132 to i64
  %arrayidx134 = getelementptr inbounds i8, i8* %80, i64 %idxprom133
  %82 = load i8, i8* %arrayidx134, align 1
  %conv135 = zext i8 %82 to i32
  %83 = load i8*, i8** %k.addr, align 8
  %84 = load i8, i8* %i, align 1
  %conv136 = zext i8 %84 to i32
  %add137 = add nsw i32 %conv136, 1
  %idxprom138 = sext i32 %add137 to i64
  %arrayidx139 = getelementptr inbounds i8, i8* %83, i64 %idxprom138
  %85 = load i8, i8* %arrayidx139, align 1
  %conv140 = zext i8 %85 to i32
  %xor141 = xor i32 %conv140, %conv135
  %conv142 = trunc i32 %xor141 to i8
  store i8 %conv142, i8* %arrayidx139, align 1
  %86 = load i8*, i8** %k.addr, align 8
  %87 = load i8, i8* %i, align 1
  %conv143 = zext i8 %87 to i32
  %sub144 = sub nsw i32 %conv143, 2
  %idxprom145 = sext i32 %sub144 to i64
  %arrayidx146 = getelementptr inbounds i8, i8* %86, i64 %idxprom145
  %88 = load i8, i8* %arrayidx146, align 1
  %conv147 = zext i8 %88 to i32
  %89 = load i8*, i8** %k.addr, align 8
  %90 = load i8, i8* %i, align 1
  %conv148 = zext i8 %90 to i32
  %add149 = add nsw i32 %conv148, 2
  %idxprom150 = sext i32 %add149 to i64
  %arrayidx151 = getelementptr inbounds i8, i8* %89, i64 %idxprom150
  %91 = load i8, i8* %arrayidx151, align 1
  %conv152 = zext i8 %91 to i32
  %xor153 = xor i32 %conv152, %conv147
  %conv154 = trunc i32 %xor153 to i8
  store i8 %conv154, i8* %arrayidx151, align 1
  %92 = load i8*, i8** %k.addr, align 8
  %93 = load i8, i8* %i, align 1
  %conv155 = zext i8 %93 to i32
  %sub156 = sub nsw i32 %conv155, 1
  %idxprom157 = sext i32 %sub156 to i64
  %arrayidx158 = getelementptr inbounds i8, i8* %92, i64 %idxprom157
  %94 = load i8, i8* %arrayidx158, align 1
  %conv159 = zext i8 %94 to i32
  %95 = load i8*, i8** %k.addr, align 8
  %96 = load i8, i8* %i, align 1
  %conv160 = zext i8 %96 to i32
  %add161 = add nsw i32 %conv160, 3
  %idxprom162 = sext i32 %add161 to i64
  %arrayidx163 = getelementptr inbounds i8, i8* %95, i64 %idxprom162
  %97 = load i8, i8* %arrayidx163, align 1
  %conv164 = zext i8 %97 to i32
  %xor165 = xor i32 %conv164, %conv159
  %conv166 = trunc i32 %xor165 to i8
  store i8 %conv166, i8* %arrayidx163, align 1
  br label %for.inc167

for.inc167:                                       ; preds = %for.body120
  %98 = load i8, i8* %i, align 1
  %conv168 = zext i8 %98 to i32
  %add169 = add nsw i32 %conv168, 4
  %conv170 = trunc i32 %add169 to i8
  store i8 %conv170, i8* %i, align 1
  br label %for.cond116, !llvm.loop !7

for.end171:                                       ; preds = %for.cond116
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_addRoundKey_cpy_1(i8* %buf, i8* %key, i8* %cpk) #0 {
entry:
  %buf.addr = alloca i8*, align 8
  %key.addr = alloca i8*, align 8
  %cpk.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  store i8* %key, i8** %key.addr, align 8
  store i8* %cpk, i8** %cpk.addr, align 8
  store i8 16, i8* %i, align 1
  br label %cpkey

cpkey:                                            ; preds = %entry
  br label %while.cond

while.cond:                                       ; preds = %while.body, %cpkey
  %0 = load i8, i8* %i, align 1
  %dec = add i8 %0, -1
  store i8 %dec, i8* %i, align 1
  %tobool = icmp ne i8 %0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i8*, i8** %key.addr, align 8
  %2 = load i8, i8* %i, align 1
  %idxprom = zext i8 %2 to i64
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom
  %3 = load i8, i8* %arrayidx, align 1
  %4 = load i8*, i8** %cpk.addr, align 8
  %5 = load i8, i8* %i, align 1
  %idxprom1 = zext i8 %5 to i64
  %arrayidx2 = getelementptr inbounds i8, i8* %4, i64 %idxprom1
  store i8 %3, i8* %arrayidx2, align 1
  %conv = zext i8 %3 to i32
  %6 = load i8*, i8** %buf.addr, align 8
  %7 = load i8, i8* %i, align 1
  %idxprom3 = zext i8 %7 to i64
  %arrayidx4 = getelementptr inbounds i8, i8* %6, i64 %idxprom3
  %8 = load i8, i8* %arrayidx4, align 1
  %conv5 = zext i8 %8 to i32
  %xor = xor i32 %conv5, %conv
  %conv6 = trunc i32 %xor to i8
  store i8 %conv6, i8* %arrayidx4, align 1
  %9 = load i8*, i8** %key.addr, align 8
  %10 = load i8, i8* %i, align 1
  %conv7 = zext i8 %10 to i32
  %add = add nsw i32 16, %conv7
  %idxprom8 = sext i32 %add to i64
  %arrayidx9 = getelementptr inbounds i8, i8* %9, i64 %idxprom8
  %11 = load i8, i8* %arrayidx9, align 1
  %12 = load i8*, i8** %cpk.addr, align 8
  %13 = load i8, i8* %i, align 1
  %conv10 = zext i8 %13 to i32
  %add11 = add nsw i32 16, %conv10
  %idxprom12 = sext i32 %add11 to i64
  %arrayidx13 = getelementptr inbounds i8, i8* %12, i64 %idxprom12
  store i8 %11, i8* %arrayidx13, align 1
  br label %while.cond, !llvm.loop !8

while.end:                                        ; preds = %while.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_subBytes_1(i8* %buf) #0 {
entry:
  %buf.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  store i8 16, i8* %i, align 1
  br label %sub

sub:                                              ; preds = %entry
  br label %while.cond

while.cond:                                       ; preds = %while.body, %sub
  %0 = load i8, i8* %i, align 1
  %dec = add i8 %0, -1
  store i8 %dec, i8* %i, align 1
  %tobool = icmp ne i8 %0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i8*, i8** %buf.addr, align 8
  %2 = load i8, i8* %i, align 1
  %idxprom = zext i8 %2 to i64
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom
  %3 = load i8, i8* %arrayidx, align 1
  %idxprom1 = zext i8 %3 to i64
  %arrayidx2 = getelementptr inbounds [256 x i8], [256 x i8]* @sbox, i64 0, i64 %idxprom1
  %4 = load i8, i8* %arrayidx2, align 1
  %5 = load i8*, i8** %buf.addr, align 8
  %6 = load i8, i8* %i, align 1
  %idxprom3 = zext i8 %6 to i64
  %arrayidx4 = getelementptr inbounds i8, i8* %5, i64 %idxprom3
  store i8 %4, i8* %arrayidx4, align 1
  br label %while.cond, !llvm.loop !9

while.end:                                        ; preds = %while.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_shiftRows_1(i8* %buf) #0 {
entry:
  %buf.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  %j = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  %0 = load i8*, i8** %buf.addr, align 8
  %arrayidx = getelementptr inbounds i8, i8* %0, i64 1
  %1 = load i8, i8* %arrayidx, align 1
  store i8 %1, i8* %i, align 1
  %2 = load i8*, i8** %buf.addr, align 8
  %arrayidx1 = getelementptr inbounds i8, i8* %2, i64 5
  %3 = load i8, i8* %arrayidx1, align 1
  %4 = load i8*, i8** %buf.addr, align 8
  %arrayidx2 = getelementptr inbounds i8, i8* %4, i64 1
  store i8 %3, i8* %arrayidx2, align 1
  %5 = load i8*, i8** %buf.addr, align 8
  %arrayidx3 = getelementptr inbounds i8, i8* %5, i64 9
  %6 = load i8, i8* %arrayidx3, align 1
  %7 = load i8*, i8** %buf.addr, align 8
  %arrayidx4 = getelementptr inbounds i8, i8* %7, i64 5
  store i8 %6, i8* %arrayidx4, align 1
  %8 = load i8*, i8** %buf.addr, align 8
  %arrayidx5 = getelementptr inbounds i8, i8* %8, i64 13
  %9 = load i8, i8* %arrayidx5, align 1
  %10 = load i8*, i8** %buf.addr, align 8
  %arrayidx6 = getelementptr inbounds i8, i8* %10, i64 9
  store i8 %9, i8* %arrayidx6, align 1
  %11 = load i8, i8* %i, align 1
  %12 = load i8*, i8** %buf.addr, align 8
  %arrayidx7 = getelementptr inbounds i8, i8* %12, i64 13
  store i8 %11, i8* %arrayidx7, align 1
  %13 = load i8*, i8** %buf.addr, align 8
  %arrayidx8 = getelementptr inbounds i8, i8* %13, i64 10
  %14 = load i8, i8* %arrayidx8, align 1
  store i8 %14, i8* %i, align 1
  %15 = load i8*, i8** %buf.addr, align 8
  %arrayidx9 = getelementptr inbounds i8, i8* %15, i64 2
  %16 = load i8, i8* %arrayidx9, align 1
  %17 = load i8*, i8** %buf.addr, align 8
  %arrayidx10 = getelementptr inbounds i8, i8* %17, i64 10
  store i8 %16, i8* %arrayidx10, align 1
  %18 = load i8, i8* %i, align 1
  %19 = load i8*, i8** %buf.addr, align 8
  %arrayidx11 = getelementptr inbounds i8, i8* %19, i64 2
  store i8 %18, i8* %arrayidx11, align 1
  %20 = load i8*, i8** %buf.addr, align 8
  %arrayidx12 = getelementptr inbounds i8, i8* %20, i64 3
  %21 = load i8, i8* %arrayidx12, align 1
  store i8 %21, i8* %j, align 1
  %22 = load i8*, i8** %buf.addr, align 8
  %arrayidx13 = getelementptr inbounds i8, i8* %22, i64 15
  %23 = load i8, i8* %arrayidx13, align 1
  %24 = load i8*, i8** %buf.addr, align 8
  %arrayidx14 = getelementptr inbounds i8, i8* %24, i64 3
  store i8 %23, i8* %arrayidx14, align 1
  %25 = load i8*, i8** %buf.addr, align 8
  %arrayidx15 = getelementptr inbounds i8, i8* %25, i64 11
  %26 = load i8, i8* %arrayidx15, align 1
  %27 = load i8*, i8** %buf.addr, align 8
  %arrayidx16 = getelementptr inbounds i8, i8* %27, i64 15
  store i8 %26, i8* %arrayidx16, align 1
  %28 = load i8*, i8** %buf.addr, align 8
  %arrayidx17 = getelementptr inbounds i8, i8* %28, i64 7
  %29 = load i8, i8* %arrayidx17, align 1
  %30 = load i8*, i8** %buf.addr, align 8
  %arrayidx18 = getelementptr inbounds i8, i8* %30, i64 11
  store i8 %29, i8* %arrayidx18, align 1
  %31 = load i8, i8* %j, align 1
  %32 = load i8*, i8** %buf.addr, align 8
  %arrayidx19 = getelementptr inbounds i8, i8* %32, i64 7
  store i8 %31, i8* %arrayidx19, align 1
  %33 = load i8*, i8** %buf.addr, align 8
  %arrayidx20 = getelementptr inbounds i8, i8* %33, i64 14
  %34 = load i8, i8* %arrayidx20, align 1
  store i8 %34, i8* %j, align 1
  %35 = load i8*, i8** %buf.addr, align 8
  %arrayidx21 = getelementptr inbounds i8, i8* %35, i64 6
  %36 = load i8, i8* %arrayidx21, align 1
  %37 = load i8*, i8** %buf.addr, align 8
  %arrayidx22 = getelementptr inbounds i8, i8* %37, i64 14
  store i8 %36, i8* %arrayidx22, align 1
  %38 = load i8, i8* %j, align 1
  %39 = load i8*, i8** %buf.addr, align 8
  %arrayidx23 = getelementptr inbounds i8, i8* %39, i64 6
  store i8 %38, i8* %arrayidx23, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_mixColumns_1(i8* %buf) #0 {
entry:
  %buf.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  %a = alloca i8, align 1
  %b = alloca i8, align 1
  %c = alloca i8, align 1
  %d = alloca i8, align 1
  %e = alloca i8, align 1
  %_s_i = alloca i32, align 4
  %_in_s_i = alloca i32, align 4
  store i8* %buf, i8** %buf.addr, align 8
  br label %mix

mix:                                              ; preds = %entry
  store i32 0, i32* %_s_i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %mix
  %0 = load i32, i32* %_s_i, align 4
  %cmp = icmp sle i32 %0, 3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %_s_i, align 4
  %conv = sext i32 %1 to i64
  %mul = mul nsw i64 4, %conv
  %add = add nsw i64 0, %mul
  %conv1 = trunc i64 %add to i32
  store i32 %conv1, i32* %_in_s_i, align 4
  %2 = load i8*, i8** %buf.addr, align 8
  %3 = load i32, i32* %_in_s_i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds i8, i8* %2, i64 %idxprom
  %4 = load i8, i8* %arrayidx, align 1
  store i8 %4, i8* %a, align 1
  %5 = load i8*, i8** %buf.addr, align 8
  %6 = load i32, i32* %_in_s_i, align 4
  %add2 = add nsw i32 %6, 1
  %idxprom3 = sext i32 %add2 to i64
  %arrayidx4 = getelementptr inbounds i8, i8* %5, i64 %idxprom3
  %7 = load i8, i8* %arrayidx4, align 1
  store i8 %7, i8* %b, align 1
  %8 = load i8*, i8** %buf.addr, align 8
  %9 = load i32, i32* %_in_s_i, align 4
  %add5 = add nsw i32 %9, 2
  %idxprom6 = sext i32 %add5 to i64
  %arrayidx7 = getelementptr inbounds i8, i8* %8, i64 %idxprom6
  %10 = load i8, i8* %arrayidx7, align 1
  store i8 %10, i8* %c, align 1
  %11 = load i8*, i8** %buf.addr, align 8
  %12 = load i32, i32* %_in_s_i, align 4
  %add8 = add nsw i32 %12, 3
  %idxprom9 = sext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds i8, i8* %11, i64 %idxprom9
  %13 = load i8, i8* %arrayidx10, align 1
  store i8 %13, i8* %d, align 1
  %14 = load i8, i8* %a, align 1
  %conv11 = zext i8 %14 to i32
  %15 = load i8, i8* %b, align 1
  %conv12 = zext i8 %15 to i32
  %xor = xor i32 %conv11, %conv12
  %16 = load i8, i8* %c, align 1
  %conv13 = zext i8 %16 to i32
  %xor14 = xor i32 %xor, %conv13
  %17 = load i8, i8* %d, align 1
  %conv15 = zext i8 %17 to i32
  %xor16 = xor i32 %xor14, %conv15
  %conv17 = trunc i32 %xor16 to i8
  store i8 %conv17, i8* %e, align 1
  %18 = load i8, i8* %e, align 1
  %conv18 = zext i8 %18 to i32
  %19 = load i8, i8* %a, align 1
  %conv19 = zext i8 %19 to i32
  %20 = load i8, i8* %b, align 1
  %conv20 = zext i8 %20 to i32
  %xor21 = xor i32 %conv19, %conv20
  %conv22 = trunc i32 %xor21 to i8
  %call = call zeroext i8 @rj_xtime_1(i8 zeroext %conv22)
  %conv23 = zext i8 %call to i32
  %xor24 = xor i32 %conv18, %conv23
  %21 = load i8*, i8** %buf.addr, align 8
  %22 = load i32, i32* %_in_s_i, align 4
  %idxprom25 = sext i32 %22 to i64
  %arrayidx26 = getelementptr inbounds i8, i8* %21, i64 %idxprom25
  %23 = load i8, i8* %arrayidx26, align 1
  %conv27 = zext i8 %23 to i32
  %xor28 = xor i32 %conv27, %xor24
  %conv29 = trunc i32 %xor28 to i8
  store i8 %conv29, i8* %arrayidx26, align 1
  %24 = load i8, i8* %e, align 1
  %conv30 = zext i8 %24 to i32
  %25 = load i8, i8* %b, align 1
  %conv31 = zext i8 %25 to i32
  %26 = load i8, i8* %c, align 1
  %conv32 = zext i8 %26 to i32
  %xor33 = xor i32 %conv31, %conv32
  %conv34 = trunc i32 %xor33 to i8
  %call35 = call zeroext i8 @rj_xtime_1(i8 zeroext %conv34)
  %conv36 = zext i8 %call35 to i32
  %xor37 = xor i32 %conv30, %conv36
  %27 = load i8*, i8** %buf.addr, align 8
  %28 = load i32, i32* %_in_s_i, align 4
  %add38 = add nsw i32 %28, 1
  %idxprom39 = sext i32 %add38 to i64
  %arrayidx40 = getelementptr inbounds i8, i8* %27, i64 %idxprom39
  %29 = load i8, i8* %arrayidx40, align 1
  %conv41 = zext i8 %29 to i32
  %xor42 = xor i32 %conv41, %xor37
  %conv43 = trunc i32 %xor42 to i8
  store i8 %conv43, i8* %arrayidx40, align 1
  %30 = load i8, i8* %e, align 1
  %conv44 = zext i8 %30 to i32
  %31 = load i8, i8* %c, align 1
  %conv45 = zext i8 %31 to i32
  %32 = load i8, i8* %d, align 1
  %conv46 = zext i8 %32 to i32
  %xor47 = xor i32 %conv45, %conv46
  %conv48 = trunc i32 %xor47 to i8
  %call49 = call zeroext i8 @rj_xtime_1(i8 zeroext %conv48)
  %conv50 = zext i8 %call49 to i32
  %xor51 = xor i32 %conv44, %conv50
  %33 = load i8*, i8** %buf.addr, align 8
  %34 = load i32, i32* %_in_s_i, align 4
  %add52 = add nsw i32 %34, 2
  %idxprom53 = sext i32 %add52 to i64
  %arrayidx54 = getelementptr inbounds i8, i8* %33, i64 %idxprom53
  %35 = load i8, i8* %arrayidx54, align 1
  %conv55 = zext i8 %35 to i32
  %xor56 = xor i32 %conv55, %xor51
  %conv57 = trunc i32 %xor56 to i8
  store i8 %conv57, i8* %arrayidx54, align 1
  %36 = load i8, i8* %e, align 1
  %conv58 = zext i8 %36 to i32
  %37 = load i8, i8* %d, align 1
  %conv59 = zext i8 %37 to i32
  %38 = load i8, i8* %a, align 1
  %conv60 = zext i8 %38 to i32
  %xor61 = xor i32 %conv59, %conv60
  %conv62 = trunc i32 %xor61 to i8
  %call63 = call zeroext i8 @rj_xtime_1(i8 zeroext %conv62)
  %conv64 = zext i8 %call63 to i32
  %xor65 = xor i32 %conv58, %conv64
  %39 = load i8*, i8** %buf.addr, align 8
  %40 = load i32, i32* %_in_s_i, align 4
  %add66 = add nsw i32 %40, 3
  %idxprom67 = sext i32 %add66 to i64
  %arrayidx68 = getelementptr inbounds i8, i8* %39, i64 %idxprom67
  %41 = load i8, i8* %arrayidx68, align 1
  %conv69 = zext i8 %41 to i32
  %xor70 = xor i32 %conv69, %xor65
  %conv71 = trunc i32 %xor70 to i8
  store i8 %conv71, i8* %arrayidx68, align 1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %42 = load i32, i32* %_s_i, align 4
  %inc = add nsw i32 %42, 1
  store i32 %inc, i32* %_s_i, align 4
  br label %for.cond, !llvm.loop !10

for.end:                                          ; preds = %for.cond
  store i32 16, i32* %_s_i, align 4
  %43 = load i32, i32* %_s_i, align 4
  %conv72 = trunc i32 %43 to i8
  store i8 %conv72, i8* %i, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @aes_addRoundKey_1(i8* %buf, i8* %key) #0 {
entry:
  %buf.addr = alloca i8*, align 8
  %key.addr = alloca i8*, align 8
  %i = alloca i8, align 1
  store i8* %buf, i8** %buf.addr, align 8
  store i8* %key, i8** %key.addr, align 8
  store i8 16, i8* %i, align 1
  br label %addkey

addkey:                                           ; preds = %entry
  br label %while.cond

while.cond:                                       ; preds = %while.body, %addkey
  %0 = load i8, i8* %i, align 1
  %dec = add i8 %0, -1
  store i8 %dec, i8* %i, align 1
  %tobool = icmp ne i8 %0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i8*, i8** %key.addr, align 8
  %2 = load i8, i8* %i, align 1
  %idxprom = zext i8 %2 to i64
  %arrayidx = getelementptr inbounds i8, i8* %1, i64 %idxprom
  %3 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %3 to i32
  %4 = load i8*, i8** %buf.addr, align 8
  %5 = load i8, i8* %i, align 1
  %idxprom1 = zext i8 %5 to i64
  %arrayidx2 = getelementptr inbounds i8, i8* %4, i64 %idxprom1
  %6 = load i8, i8* %arrayidx2, align 1
  %conv3 = zext i8 %6 to i32
  %xor = xor i32 %conv3, %conv
  %conv4 = trunc i32 %xor to i8
  store i8 %conv4, i8* %arrayidx2, align 1
  br label %while.cond, !llvm.loop !11

while.end:                                        ; preds = %while.cond
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i8 @rj_xtime_1(i8 zeroext %x) #0 {
entry:
  %x.addr = alloca i8, align 1
  store i8 %x, i8* %x.addr, align 1
  %0 = load i8, i8* %x.addr, align 1
  %conv = zext i8 %0 to i32
  %and = and i32 %conv, 128
  %tobool = icmp ne i32 %and, 0
  br i1 %tobool, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i8, i8* %x.addr, align 1
  %conv1 = zext i8 %1 to i32
  %shl = shl i32 %conv1, 1
  %xor = xor i32 %shl, 27
  br label %cond.end

cond.false:                                       ; preds = %entry
  %2 = load i8, i8* %x.addr, align 1
  %conv2 = zext i8 %2 to i32
  %shl3 = shl i32 %conv2, 1
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %xor, %cond.true ], [ %shl3, %cond.false ]
  %conv4 = trunc i32 %cond to i8
  ret i8 %conv4
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
