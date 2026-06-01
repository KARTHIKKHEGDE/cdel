; ModuleID = '/home/karthik/llvm-project/pass/test/test25.c'
source_filename = "/home/karthik/llvm-project/pass/test/test25.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.RingBuffer = type { [64 x i32], i32, i32, i32 }
%struct.StackVM = type { [128 x i32], i32 }

@.str = private unnamed_addr constant [8 x i8] c"VM> %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"Ring buffer sum: %d\0A\00", align 1
@__const.main.program = private unnamed_addr constant [13 x i32] [i32 0, i32 3, i32 0, i32 4, i32 1, i32 0, i32 10, i32 0, i32 2, i32 2, i32 3, i32 6, i32 7], align 16
@.str.2 = private unnamed_addr constant [21 x i8] c"Set bits in 255: %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [22 x i8] c"Set bits in 1023: %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [22 x i8] c"Is 64 power of 2: %s\0A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"YES\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"NO\00", align 1
@.str.7 = private unnamed_addr constant [22 x i8] c"Is 65 power of 2: %s\0A\00", align 1
@.str.8 = private unnamed_addr constant [14 x i8] c"Hello, World!\00", align 1
@.str.9 = private unnamed_addr constant [14 x i8] c"Hello, World?\00", align 1
@.str.10 = private unnamed_addr constant [21 x i8] c"Checksum '%s': %08X\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rbInit(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.RingBuffer, ptr %3, i32 0, i32 3
  store i32 0, ptr %4, align 4
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.RingBuffer, ptr %5, i32 0, i32 2
  store i32 0, ptr %6, align 4
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.RingBuffer, ptr %7, i32 0, i32 1
  store i32 0, ptr %8, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @rbEmpty(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.RingBuffer, ptr %3, i32 0, i32 3
  %5 = load i32, ptr %4, align 4
  %6 = icmp eq i32 %5, 0
  %7 = zext i1 %6 to i32
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @rbFull(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.RingBuffer, ptr %3, i32 0, i32 3
  %5 = load i32, ptr %4, align 4
  %6 = icmp eq i32 %5, 64
  %7 = zext i1 %6 to i32
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @rbPush(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  %6 = load ptr, ptr %4, align 8
  %7 = call i32 @rbFull(ptr noundef %6)
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  store i32 0, ptr %3, align 4
  br label %30

10:                                               ; preds = %2
  %11 = load i32, ptr %5, align 4
  %12 = load ptr, ptr %4, align 8
  %13 = getelementptr inbounds %struct.RingBuffer, ptr %12, i32 0, i32 0
  %14 = load ptr, ptr %4, align 8
  %15 = getelementptr inbounds %struct.RingBuffer, ptr %14, i32 0, i32 2
  %16 = load i32, ptr %15, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [64 x i32], ptr %13, i64 0, i64 %17
  store i32 %11, ptr %18, align 4
  %19 = load ptr, ptr %4, align 8
  %20 = getelementptr inbounds %struct.RingBuffer, ptr %19, i32 0, i32 2
  %21 = load i32, ptr %20, align 4
  %22 = add nsw i32 %21, 1
  %23 = srem i32 %22, 64
  %24 = load ptr, ptr %4, align 8
  %25 = getelementptr inbounds %struct.RingBuffer, ptr %24, i32 0, i32 2
  store i32 %23, ptr %25, align 4
  %26 = load ptr, ptr %4, align 8
  %27 = getelementptr inbounds %struct.RingBuffer, ptr %26, i32 0, i32 3
  %28 = load i32, ptr %27, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %27, align 4
  store i32 1, ptr %3, align 4
  br label %30

30:                                               ; preds = %10, %9
  %31 = load i32, ptr %3, align 4
  ret i32 %31
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @rbPop(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %4, align 8
  %7 = call i32 @rbEmpty(ptr noundef %6)
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  store i32 0, ptr %3, align 4
  br label %31

10:                                               ; preds = %2
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds %struct.RingBuffer, ptr %11, i32 0, i32 0
  %13 = load ptr, ptr %4, align 8
  %14 = getelementptr inbounds %struct.RingBuffer, ptr %13, i32 0, i32 1
  %15 = load i32, ptr %14, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [64 x i32], ptr %12, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = load ptr, ptr %5, align 8
  store i32 %18, ptr %19, align 4
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds %struct.RingBuffer, ptr %20, i32 0, i32 1
  %22 = load i32, ptr %21, align 4
  %23 = add nsw i32 %22, 1
  %24 = srem i32 %23, 64
  %25 = load ptr, ptr %4, align 8
  %26 = getelementptr inbounds %struct.RingBuffer, ptr %25, i32 0, i32 1
  store i32 %24, ptr %26, align 4
  %27 = load ptr, ptr %4, align 8
  %28 = getelementptr inbounds %struct.RingBuffer, ptr %27, i32 0, i32 3
  %29 = load i32, ptr %28, align 4
  %30 = add nsw i32 %29, -1
  store i32 %30, ptr %28, align 4
  store i32 1, ptr %3, align 4
  br label %31

31:                                               ; preds = %10, %9
  %32 = load i32, ptr %3, align 4
  ret i32 %32
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vmInit(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.StackVM, ptr %3, i32 0, i32 1
  store i32 -1, ptr %4, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vmPush(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.StackVM, ptr %6, i32 0, i32 0
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.StackVM, ptr %8, i32 0, i32 1
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [128 x i32], ptr %7, i64 0, i64 %12
  store i32 %5, ptr %13, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @vmPop(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.StackVM, ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.StackVM, ptr %5, i32 0, i32 1
  %7 = load i32, ptr %6, align 4
  %8 = add nsw i32 %7, -1
  store i32 %8, ptr %6, align 4
  %9 = sext i32 %7 to i64
  %10 = getelementptr inbounds [128 x i32], ptr %4, i64 0, i64 %9
  %11 = load i32, ptr %10, align 4
  ret i32 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vmExecute(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %17

17:                                               ; preds = %89, %3
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %6, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %92

21:                                               ; preds = %17
  %22 = load ptr, ptr %5, align 8
  %23 = load i32, ptr %7, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32, ptr %22, i64 %24
  %26 = load i32, ptr %25, align 4
  switch i32 %26, label %89 [
    i32 0, label %27
    i32 1, label %35
    i32 2, label %44
    i32 3, label %53
    i32 4, label %62
    i32 5, label %69
    i32 6, label %78
    i32 7, label %88
  ]

27:                                               ; preds = %21
  %28 = load ptr, ptr %4, align 8
  %29 = load ptr, ptr %5, align 8
  %30 = load i32, ptr %7, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %7, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds i32, ptr %29, i64 %32
  %34 = load i32, ptr %33, align 4
  call void @vmPush(ptr noundef %28, i32 noundef %34)
  br label %89

35:                                               ; preds = %21
  %36 = load ptr, ptr %4, align 8
  %37 = call i32 @vmPop(ptr noundef %36)
  store i32 %37, ptr %8, align 4
  %38 = load ptr, ptr %4, align 8
  %39 = call i32 @vmPop(ptr noundef %38)
  store i32 %39, ptr %9, align 4
  %40 = load ptr, ptr %4, align 8
  %41 = load i32, ptr %9, align 4
  %42 = load i32, ptr %8, align 4
  %43 = add nsw i32 %41, %42
  call void @vmPush(ptr noundef %40, i32 noundef %43)
  br label %89

44:                                               ; preds = %21
  %45 = load ptr, ptr %4, align 8
  %46 = call i32 @vmPop(ptr noundef %45)
  store i32 %46, ptr %10, align 4
  %47 = load ptr, ptr %4, align 8
  %48 = call i32 @vmPop(ptr noundef %47)
  store i32 %48, ptr %11, align 4
  %49 = load ptr, ptr %4, align 8
  %50 = load i32, ptr %11, align 4
  %51 = load i32, ptr %10, align 4
  %52 = sub nsw i32 %50, %51
  call void @vmPush(ptr noundef %49, i32 noundef %52)
  br label %89

53:                                               ; preds = %21
  %54 = load ptr, ptr %4, align 8
  %55 = call i32 @vmPop(ptr noundef %54)
  store i32 %55, ptr %12, align 4
  %56 = load ptr, ptr %4, align 8
  %57 = call i32 @vmPop(ptr noundef %56)
  store i32 %57, ptr %13, align 4
  %58 = load ptr, ptr %4, align 8
  %59 = load i32, ptr %13, align 4
  %60 = load i32, ptr %12, align 4
  %61 = mul nsw i32 %59, %60
  call void @vmPush(ptr noundef %58, i32 noundef %61)
  br label %89

62:                                               ; preds = %21
  %63 = load ptr, ptr %4, align 8
  %64 = call i32 @vmPop(ptr noundef %63)
  store i32 %64, ptr %14, align 4
  %65 = load ptr, ptr %4, align 8
  %66 = load i32, ptr %14, align 4
  call void @vmPush(ptr noundef %65, i32 noundef %66)
  %67 = load ptr, ptr %4, align 8
  %68 = load i32, ptr %14, align 4
  call void @vmPush(ptr noundef %67, i32 noundef %68)
  br label %89

69:                                               ; preds = %21
  %70 = load ptr, ptr %4, align 8
  %71 = call i32 @vmPop(ptr noundef %70)
  store i32 %71, ptr %15, align 4
  %72 = load ptr, ptr %4, align 8
  %73 = call i32 @vmPop(ptr noundef %72)
  store i32 %73, ptr %16, align 4
  %74 = load ptr, ptr %4, align 8
  %75 = load i32, ptr %15, align 4
  call void @vmPush(ptr noundef %74, i32 noundef %75)
  %76 = load ptr, ptr %4, align 8
  %77 = load i32, ptr %16, align 4
  call void @vmPush(ptr noundef %76, i32 noundef %77)
  br label %89

78:                                               ; preds = %21
  %79 = load ptr, ptr %4, align 8
  %80 = getelementptr inbounds %struct.StackVM, ptr %79, i32 0, i32 0
  %81 = load ptr, ptr %4, align 8
  %82 = getelementptr inbounds %struct.StackVM, ptr %81, i32 0, i32 1
  %83 = load i32, ptr %82, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [128 x i32], ptr %80, i64 0, i64 %84
  %86 = load i32, ptr %85, align 4
  %87 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %86)
  br label %89

88:                                               ; preds = %21
  br label %92

89:                                               ; preds = %21, %78, %69, %62, %53, %44, %35, %27
  %90 = load i32, ptr %7, align 4
  %91 = add nsw i32 %90, 1
  store i32 %91, ptr %7, align 4
  br label %17, !llvm.loop !6

92:                                               ; preds = %88, %17
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @countSetBits(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  br label %4

4:                                                ; preds = %7, %1
  %5 = load i32, ptr %2, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %14

7:                                                ; preds = %4
  %8 = load i32, ptr %2, align 4
  %9 = and i32 %8, 1
  %10 = load i32, ptr %3, align 4
  %11 = add i32 %10, %9
  store i32 %11, ptr %3, align 4
  %12 = load i32, ptr %2, align 4
  %13 = lshr i32 %12, 1
  store i32 %13, ptr %2, align 4
  br label %4, !llvm.loop !8

14:                                               ; preds = %4
  %15 = load i32, ptr %3, align 4
  ret i32 %15
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @isPowerOfTwo(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %12

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = sub i32 %7, 1
  %9 = and i32 %6, %8
  %10 = icmp ne i32 %9, 0
  %11 = xor i1 %10, true
  br label %12

12:                                               ; preds = %5, %1
  %13 = phi i1 [ false, %1 ], [ %11, %5 ]
  %14 = zext i1 %13 to i32
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @reverseBits(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %16, %1
  %6 = load i32, ptr %4, align 4
  %7 = icmp slt i32 %6, 32
  br i1 %7, label %8, label %19

8:                                                ; preds = %5
  %9 = load i32, ptr %3, align 4
  %10 = shl i32 %9, 1
  %11 = load i32, ptr %2, align 4
  %12 = and i32 %11, 1
  %13 = or i32 %10, %12
  store i32 %13, ptr %3, align 4
  %14 = load i32, ptr %2, align 4
  %15 = lshr i32 %14, 1
  store i32 %15, ptr %2, align 4
  br label %16

16:                                               ; preds = %8
  %17 = load i32, ptr %4, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr %4, align 4
  br label %5, !llvm.loop !9

19:                                               ; preds = %5
  %20 = load i32, ptr %3, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @simpleChecksum(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 -1, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %8

8:                                                ; preds = %40, %2
  %9 = load i32, ptr %6, align 4
  %10 = load i32, ptr %4, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %43

12:                                               ; preds = %8
  %13 = load ptr, ptr %3, align 8
  %14 = load i32, ptr %6, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i8, ptr %13, i64 %15
  %17 = load i8, ptr %16, align 1
  %18 = zext i8 %17 to i32
  %19 = load i32, ptr %5, align 4
  %20 = xor i32 %19, %18
  store i32 %20, ptr %5, align 4
  store i32 0, ptr %7, align 4
  br label %21

21:                                               ; preds = %36, %12
  %22 = load i32, ptr %7, align 4
  %23 = icmp slt i32 %22, 8
  br i1 %23, label %24, label %39

24:                                               ; preds = %21
  %25 = load i32, ptr %5, align 4
  %26 = and i32 %25, 1
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %32

28:                                               ; preds = %24
  %29 = load i32, ptr %5, align 4
  %30 = lshr i32 %29, 1
  %31 = xor i32 %30, -306674912
  store i32 %31, ptr %5, align 4
  br label %35

32:                                               ; preds = %24
  %33 = load i32, ptr %5, align 4
  %34 = lshr i32 %33, 1
  store i32 %34, ptr %5, align 4
  br label %35

35:                                               ; preds = %32, %28
  br label %36

36:                                               ; preds = %35
  %37 = load i32, ptr %7, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %7, align 4
  br label %21, !llvm.loop !10

39:                                               ; preds = %21
  br label %40

40:                                               ; preds = %39
  %41 = load i32, ptr %6, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %6, align 4
  br label %8, !llvm.loop !11

43:                                               ; preds = %8
  %44 = load i32, ptr %5, align 4
  %45 = xor i32 %44, -1
  ret i32 %45
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.RingBuffer, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %struct.StackVM, align 4
  %7 = alloca [13 x i32], align 16
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  call void @rbInit(ptr noundef %2)
  store i32 0, ptr %3, align 4
  br label %10

10:                                               ; preds = %17, %0
  %11 = load i32, ptr %3, align 4
  %12 = icmp slt i32 %11, 50
  br i1 %12, label %13, label %20

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = mul nsw i32 %14, 7
  %16 = call i32 @rbPush(ptr noundef %2, i32 noundef %15)
  br label %17

17:                                               ; preds = %13
  %18 = load i32, ptr %3, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %3, align 4
  br label %10, !llvm.loop !12

20:                                               ; preds = %10
  store i32 0, ptr %4, align 4
  br label %21

21:                                               ; preds = %24, %20
  %22 = call i32 @rbPop(ptr noundef %2, ptr noundef %5)
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %28

24:                                               ; preds = %21
  %25 = load i32, ptr %5, align 4
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, %25
  store i32 %27, ptr %4, align 4
  br label %21, !llvm.loop !13

28:                                               ; preds = %21
  %29 = load i32, ptr %4, align 4
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %29)
  call void @vmInit(ptr noundef %6)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %7, ptr align 16 @__const.main.program, i64 52, i1 false)
  %31 = getelementptr inbounds [13 x i32], ptr %7, i64 0, i64 0
  call void @vmExecute(ptr noundef %6, ptr noundef %31, i32 noundef 13)
  %32 = call i32 @countSetBits(i32 noundef 255)
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %32)
  %34 = call i32 @countSetBits(i32 noundef 1023)
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %34)
  %36 = call i32 @isPowerOfTwo(i32 noundef 64)
  %37 = icmp ne i32 %36, 0
  %38 = zext i1 %37 to i64
  %39 = select i1 %37, ptr @.str.5, ptr @.str.6
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, ptr noundef %39)
  %41 = call i32 @isPowerOfTwo(i32 noundef 65)
  %42 = icmp ne i32 %41, 0
  %43 = zext i1 %42 to i64
  %44 = select i1 %42, ptr @.str.5, ptr @.str.6
  %45 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, ptr noundef %44)
  store ptr @.str.8, ptr %8, align 8
  store ptr @.str.9, ptr %9, align 8
  %46 = load ptr, ptr %8, align 8
  %47 = load ptr, ptr %8, align 8
  %48 = load ptr, ptr %8, align 8
  %49 = call i64 @strlen(ptr noundef %48) #4
  %50 = trunc i64 %49 to i32
  %51 = call i32 @simpleChecksum(ptr noundef %47, i32 noundef %50)
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, ptr noundef %46, i32 noundef %51)
  %53 = load ptr, ptr %9, align 8
  %54 = load ptr, ptr %9, align 8
  %55 = load ptr, ptr %9, align 8
  %56 = call i64 @strlen(ptr noundef %55) #4
  %57 = trunc i64 %56 to i32
  %58 = call i32 @simpleChecksum(ptr noundef %54, i32 noundef %57)
  %59 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, ptr noundef %53, i32 noundef %58)
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nounwind willreturn memory(read)
declare i64 @strlen(ptr noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind willreturn memory(read) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 17.0.6 (9ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
