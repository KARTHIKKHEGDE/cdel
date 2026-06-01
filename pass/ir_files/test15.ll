; ModuleID = '/home/karthik/llvm-project/pass/test/test15.c'
source_filename = "/home/karthik/llvm-project/pass/test/test15.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [20 x i8] c"Trace of C:   %lld\0A\00", align 1
@.str.1 = private unnamed_addr constant [20 x i8] c"Trace of T:   %lld\0A\00", align 1
@.str.2 = private unnamed_addr constant [24 x i8] c"Trace of 2*(C+T): %lld\0A\00", align 1
@__const.main.small = private unnamed_addr constant [3 x [3 x i32]] [[3 x i32] [i32 1, i32 2, i32 3], [3 x i32] [i32 4, i32 5, i32 6], [3 x i32] [i32 7, i32 8, i32 9]], align 16
@.str.3 = private unnamed_addr constant [13 x i8] c"Det 3x3: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matMultiply(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %10

10:                                               ; preds = %63, %3
  %11 = load i32, ptr %7, align 4
  %12 = icmp slt i32 %11, 30
  br i1 %12, label %13, label %66

13:                                               ; preds = %10
  store i32 0, ptr %8, align 4
  br label %14

14:                                               ; preds = %59, %13
  %15 = load i32, ptr %8, align 4
  %16 = icmp slt i32 %15, 30
  br i1 %16, label %17, label %62

17:                                               ; preds = %14
  %18 = load ptr, ptr %6, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [30 x i32], ptr %18, i64 %20
  %22 = load i32, ptr %8, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [30 x i32], ptr %21, i64 0, i64 %23
  store i32 0, ptr %24, align 4
  store i32 0, ptr %9, align 4
  br label %25

25:                                               ; preds = %55, %17
  %26 = load i32, ptr %9, align 4
  %27 = icmp slt i32 %26, 30
  br i1 %27, label %28, label %58

28:                                               ; preds = %25
  %29 = load ptr, ptr %4, align 8
  %30 = load i32, ptr %7, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds [30 x i32], ptr %29, i64 %31
  %33 = load i32, ptr %9, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [30 x i32], ptr %32, i64 0, i64 %34
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr %5, align 8
  %38 = load i32, ptr %9, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [30 x i32], ptr %37, i64 %39
  %41 = load i32, ptr %8, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [30 x i32], ptr %40, i64 0, i64 %42
  %44 = load i32, ptr %43, align 4
  %45 = mul nsw i32 %36, %44
  %46 = load ptr, ptr %6, align 8
  %47 = load i32, ptr %7, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [30 x i32], ptr %46, i64 %48
  %50 = load i32, ptr %8, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [30 x i32], ptr %49, i64 0, i64 %51
  %53 = load i32, ptr %52, align 4
  %54 = add nsw i32 %53, %45
  store i32 %54, ptr %52, align 4
  br label %55

55:                                               ; preds = %28
  %56 = load i32, ptr %9, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %9, align 4
  br label %25, !llvm.loop !6

58:                                               ; preds = %25
  br label %59

59:                                               ; preds = %58
  %60 = load i32, ptr %8, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %8, align 4
  br label %14, !llvm.loop !8

62:                                               ; preds = %14
  br label %63

63:                                               ; preds = %62
  %64 = load i32, ptr %7, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %7, align 4
  br label %10, !llvm.loop !9

66:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matTranspose(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %34, %2
  %8 = load i32, ptr %5, align 4
  %9 = icmp slt i32 %8, 30
  br i1 %9, label %10, label %37

10:                                               ; preds = %7
  store i32 0, ptr %6, align 4
  br label %11

11:                                               ; preds = %30, %10
  %12 = load i32, ptr %6, align 4
  %13 = icmp slt i32 %12, 30
  br i1 %13, label %14, label %33

14:                                               ; preds = %11
  %15 = load ptr, ptr %3, align 8
  %16 = load i32, ptr %6, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [30 x i32], ptr %15, i64 %17
  %19 = load i32, ptr %5, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [30 x i32], ptr %18, i64 0, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = load ptr, ptr %4, align 8
  %24 = load i32, ptr %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [30 x i32], ptr %23, i64 %25
  %27 = load i32, ptr %6, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [30 x i32], ptr %26, i64 0, i64 %28
  store i32 %22, ptr %29, align 4
  br label %30

30:                                               ; preds = %14
  %31 = load i32, ptr %6, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %6, align 4
  br label %11, !llvm.loop !10

33:                                               ; preds = %11
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %5, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %5, align 4
  br label %7, !llvm.loop !11

37:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @matTrace(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i64 0, ptr %3, align 8
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %20, %1
  %6 = load i32, ptr %4, align 4
  %7 = icmp slt i32 %6, 30
  br i1 %7, label %8, label %23

8:                                                ; preds = %5
  %9 = load ptr, ptr %2, align 8
  %10 = load i32, ptr %4, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [30 x i32], ptr %9, i64 %11
  %13 = load i32, ptr %4, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [30 x i32], ptr %12, i64 0, i64 %14
  %16 = load i32, ptr %15, align 4
  %17 = sext i32 %16 to i64
  %18 = load i64, ptr %3, align 8
  %19 = add nsw i64 %18, %17
  store i64 %19, ptr %3, align 8
  br label %20

20:                                               ; preds = %8
  %21 = load i32, ptr %4, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %4, align 4
  br label %5, !llvm.loop !12

23:                                               ; preds = %5
  %24 = load i64, ptr %3, align 8
  ret i64 %24
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @det3x3(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds [3 x i32], ptr %3, i64 0
  %5 = getelementptr inbounds [3 x i32], ptr %4, i64 0, i64 0
  %6 = load i32, ptr %5, align 4
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds [3 x i32], ptr %7, i64 1
  %9 = getelementptr inbounds [3 x i32], ptr %8, i64 0, i64 1
  %10 = load i32, ptr %9, align 4
  %11 = load ptr, ptr %2, align 8
  %12 = getelementptr inbounds [3 x i32], ptr %11, i64 2
  %13 = getelementptr inbounds [3 x i32], ptr %12, i64 0, i64 2
  %14 = load i32, ptr %13, align 4
  %15 = mul nsw i32 %10, %14
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds [3 x i32], ptr %16, i64 1
  %18 = getelementptr inbounds [3 x i32], ptr %17, i64 0, i64 2
  %19 = load i32, ptr %18, align 4
  %20 = load ptr, ptr %2, align 8
  %21 = getelementptr inbounds [3 x i32], ptr %20, i64 2
  %22 = getelementptr inbounds [3 x i32], ptr %21, i64 0, i64 1
  %23 = load i32, ptr %22, align 4
  %24 = mul nsw i32 %19, %23
  %25 = sub nsw i32 %15, %24
  %26 = mul nsw i32 %6, %25
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds [3 x i32], ptr %27, i64 0
  %29 = getelementptr inbounds [3 x i32], ptr %28, i64 0, i64 1
  %30 = load i32, ptr %29, align 4
  %31 = load ptr, ptr %2, align 8
  %32 = getelementptr inbounds [3 x i32], ptr %31, i64 1
  %33 = getelementptr inbounds [3 x i32], ptr %32, i64 0, i64 0
  %34 = load i32, ptr %33, align 4
  %35 = load ptr, ptr %2, align 8
  %36 = getelementptr inbounds [3 x i32], ptr %35, i64 2
  %37 = getelementptr inbounds [3 x i32], ptr %36, i64 0, i64 2
  %38 = load i32, ptr %37, align 4
  %39 = mul nsw i32 %34, %38
  %40 = load ptr, ptr %2, align 8
  %41 = getelementptr inbounds [3 x i32], ptr %40, i64 1
  %42 = getelementptr inbounds [3 x i32], ptr %41, i64 0, i64 2
  %43 = load i32, ptr %42, align 4
  %44 = load ptr, ptr %2, align 8
  %45 = getelementptr inbounds [3 x i32], ptr %44, i64 2
  %46 = getelementptr inbounds [3 x i32], ptr %45, i64 0, i64 0
  %47 = load i32, ptr %46, align 4
  %48 = mul nsw i32 %43, %47
  %49 = sub nsw i32 %39, %48
  %50 = mul nsw i32 %30, %49
  %51 = sub nsw i32 %26, %50
  %52 = load ptr, ptr %2, align 8
  %53 = getelementptr inbounds [3 x i32], ptr %52, i64 0
  %54 = getelementptr inbounds [3 x i32], ptr %53, i64 0, i64 2
  %55 = load i32, ptr %54, align 4
  %56 = load ptr, ptr %2, align 8
  %57 = getelementptr inbounds [3 x i32], ptr %56, i64 1
  %58 = getelementptr inbounds [3 x i32], ptr %57, i64 0, i64 0
  %59 = load i32, ptr %58, align 4
  %60 = load ptr, ptr %2, align 8
  %61 = getelementptr inbounds [3 x i32], ptr %60, i64 2
  %62 = getelementptr inbounds [3 x i32], ptr %61, i64 0, i64 1
  %63 = load i32, ptr %62, align 4
  %64 = mul nsw i32 %59, %63
  %65 = load ptr, ptr %2, align 8
  %66 = getelementptr inbounds [3 x i32], ptr %65, i64 1
  %67 = getelementptr inbounds [3 x i32], ptr %66, i64 0, i64 1
  %68 = load i32, ptr %67, align 4
  %69 = load ptr, ptr %2, align 8
  %70 = getelementptr inbounds [3 x i32], ptr %69, i64 2
  %71 = getelementptr inbounds [3 x i32], ptr %70, i64 0, i64 0
  %72 = load i32, ptr %71, align 4
  %73 = mul nsw i32 %68, %72
  %74 = sub nsw i32 %64, %73
  %75 = mul nsw i32 %55, %74
  %76 = add nsw i32 %51, %75
  ret i32 %76
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matAdd(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %9

9:                                                ; preds = %45, %3
  %10 = load i32, ptr %7, align 4
  %11 = icmp slt i32 %10, 30
  br i1 %11, label %12, label %48

12:                                               ; preds = %9
  store i32 0, ptr %8, align 4
  br label %13

13:                                               ; preds = %41, %12
  %14 = load i32, ptr %8, align 4
  %15 = icmp slt i32 %14, 30
  br i1 %15, label %16, label %44

16:                                               ; preds = %13
  %17 = load ptr, ptr %4, align 8
  %18 = load i32, ptr %7, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [30 x i32], ptr %17, i64 %19
  %21 = load i32, ptr %8, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [30 x i32], ptr %20, i64 0, i64 %22
  %24 = load i32, ptr %23, align 4
  %25 = load ptr, ptr %5, align 8
  %26 = load i32, ptr %7, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [30 x i32], ptr %25, i64 %27
  %29 = load i32, ptr %8, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [30 x i32], ptr %28, i64 0, i64 %30
  %32 = load i32, ptr %31, align 4
  %33 = add nsw i32 %24, %32
  %34 = load ptr, ptr %6, align 8
  %35 = load i32, ptr %7, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [30 x i32], ptr %34, i64 %36
  %38 = load i32, ptr %8, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [30 x i32], ptr %37, i64 0, i64 %39
  store i32 %33, ptr %40, align 4
  br label %41

41:                                               ; preds = %16
  %42 = load i32, ptr %8, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %8, align 4
  br label %13, !llvm.loop !13

44:                                               ; preds = %13
  br label %45

45:                                               ; preds = %44
  %46 = load i32, ptr %7, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr %7, align 4
  br label %9, !llvm.loop !14

48:                                               ; preds = %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matScale(ptr noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %9

9:                                                ; preds = %38, %3
  %10 = load i32, ptr %7, align 4
  %11 = icmp slt i32 %10, 30
  br i1 %11, label %12, label %41

12:                                               ; preds = %9
  store i32 0, ptr %8, align 4
  br label %13

13:                                               ; preds = %34, %12
  %14 = load i32, ptr %8, align 4
  %15 = icmp slt i32 %14, 30
  br i1 %15, label %16, label %37

16:                                               ; preds = %13
  %17 = load ptr, ptr %4, align 8
  %18 = load i32, ptr %7, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [30 x i32], ptr %17, i64 %19
  %21 = load i32, ptr %8, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [30 x i32], ptr %20, i64 0, i64 %22
  %24 = load i32, ptr %23, align 4
  %25 = load i32, ptr %5, align 4
  %26 = mul nsw i32 %24, %25
  %27 = load ptr, ptr %6, align 8
  %28 = load i32, ptr %7, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds [30 x i32], ptr %27, i64 %29
  %31 = load i32, ptr %8, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [30 x i32], ptr %30, i64 0, i64 %32
  store i32 %26, ptr %33, align 4
  br label %34

34:                                               ; preds = %16
  %35 = load i32, ptr %8, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %8, align 4
  br label %13, !llvm.loop !15

37:                                               ; preds = %13
  br label %38

38:                                               ; preds = %37
  %39 = load i32, ptr %7, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %7, align 4
  br label %9, !llvm.loop !16

41:                                               ; preds = %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [30 x [30 x i32]], align 16
  %3 = alloca [30 x [30 x i32]], align 16
  %4 = alloca [30 x [30 x i32]], align 16
  %5 = alloca [30 x [30 x i32]], align 16
  %6 = alloca [30 x [30 x i32]], align 16
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca [3 x [3 x i32]], align 16
  store i32 0, ptr %1, align 4
  store i32 0, ptr %7, align 4
  br label %10

10:                                               ; preds = %43, %0
  %11 = load i32, ptr %7, align 4
  %12 = icmp slt i32 %11, 30
  br i1 %12, label %13, label %46

13:                                               ; preds = %10
  store i32 0, ptr %8, align 4
  br label %14

14:                                               ; preds = %39, %13
  %15 = load i32, ptr %8, align 4
  %16 = icmp slt i32 %15, 30
  br i1 %16, label %17, label %42

17:                                               ; preds = %14
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %8, align 4
  %20 = add nsw i32 %18, %19
  %21 = srem i32 %20, 7
  %22 = load i32, ptr %7, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [30 x [30 x i32]], ptr %2, i64 0, i64 %23
  %25 = load i32, ptr %8, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [30 x i32], ptr %24, i64 0, i64 %26
  store i32 %21, ptr %27, align 4
  %28 = load i32, ptr %7, align 4
  %29 = load i32, ptr %8, align 4
  %30 = mul nsw i32 %28, %29
  %31 = add nsw i32 %30, 1
  %32 = srem i32 %31, 11
  %33 = load i32, ptr %7, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [30 x [30 x i32]], ptr %3, i64 0, i64 %34
  %36 = load i32, ptr %8, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [30 x i32], ptr %35, i64 0, i64 %37
  store i32 %32, ptr %38, align 4
  br label %39

39:                                               ; preds = %17
  %40 = load i32, ptr %8, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, ptr %8, align 4
  br label %14, !llvm.loop !17

42:                                               ; preds = %14
  br label %43

43:                                               ; preds = %42
  %44 = load i32, ptr %7, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %7, align 4
  br label %10, !llvm.loop !18

46:                                               ; preds = %10
  %47 = getelementptr inbounds [30 x [30 x i32]], ptr %2, i64 0, i64 0
  %48 = getelementptr inbounds [30 x [30 x i32]], ptr %3, i64 0, i64 0
  %49 = getelementptr inbounds [30 x [30 x i32]], ptr %4, i64 0, i64 0
  call void @matMultiply(ptr noundef %47, ptr noundef %48, ptr noundef %49)
  %50 = getelementptr inbounds [30 x [30 x i32]], ptr %4, i64 0, i64 0
  %51 = getelementptr inbounds [30 x [30 x i32]], ptr %5, i64 0, i64 0
  call void @matTranspose(ptr noundef %50, ptr noundef %51)
  %52 = getelementptr inbounds [30 x [30 x i32]], ptr %4, i64 0, i64 0
  %53 = getelementptr inbounds [30 x [30 x i32]], ptr %5, i64 0, i64 0
  %54 = getelementptr inbounds [30 x [30 x i32]], ptr %6, i64 0, i64 0
  call void @matAdd(ptr noundef %52, ptr noundef %53, ptr noundef %54)
  %55 = getelementptr inbounds [30 x [30 x i32]], ptr %6, i64 0, i64 0
  %56 = getelementptr inbounds [30 x [30 x i32]], ptr %6, i64 0, i64 0
  call void @matScale(ptr noundef %55, i32 noundef 2, ptr noundef %56)
  %57 = getelementptr inbounds [30 x [30 x i32]], ptr %4, i64 0, i64 0
  %58 = call i64 @matTrace(ptr noundef %57)
  %59 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %58)
  %60 = getelementptr inbounds [30 x [30 x i32]], ptr %5, i64 0, i64 0
  %61 = call i64 @matTrace(ptr noundef %60)
  %62 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %61)
  %63 = getelementptr inbounds [30 x [30 x i32]], ptr %6, i64 0, i64 0
  %64 = call i64 @matTrace(ptr noundef %63)
  %65 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %64)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %9, ptr align 16 @__const.main.small, i64 36, i1 false)
  %66 = getelementptr inbounds [3 x [3 x i32]], ptr %9, i64 0, i64 0
  %67 = call i32 @det3x3(ptr noundef %66)
  %68 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %67)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

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
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
