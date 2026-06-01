; ModuleID = '/home/karthik/llvm-project/pass/test/test21.c'
source_filename = "/home/karthik/llvm-project/pass/test/test21.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"%d%c\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"Hello World\00", align 1
@.str.2 = private unnamed_addr constant [14 x i8] c"Reversed: %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [24 x i8] c"racecar palindrome: %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"racecar\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"YES\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"NO\00", align 1
@.str.7 = private unnamed_addr constant [22 x i8] c"hello palindrome: %s\0A\00", align 1
@.str.8 = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.9 = private unnamed_addr constant [38 x i8] c"Word count 'The quick brown fox': %d\0A\00", align 1
@.str.10 = private unnamed_addr constant [44 x i8] c"The quick brown fox jumps over the lazy dog\00", align 1
@.str.11 = private unnamed_addr constant [13 x i8] c"AttackAtDawn\00", align 1
@.str.12 = private unnamed_addr constant [20 x i8] c"Caesar encrypt: %s\0A\00", align 1
@.str.13 = private unnamed_addr constant [20 x i8] c"Caesar decrypt: %s\0A\00", align 1
@.str.14 = private unnamed_addr constant [17 x i8] c"aaabbbccddddeeee\00", align 1
@.str.15 = private unnamed_addr constant [16 x i8] c"RLE encode: %s\0A\00", align 1
@.str.16 = private unnamed_addr constant [22 x i8] c"Atoi('  -42abc'): %d\0A\00", align 1
@.str.17 = private unnamed_addr constant [9 x i8] c"  -42abc\00", align 1
@.str.18 = private unnamed_addr constant [19 x i8] c"Atoi('12345'): %d\0A\00", align 1
@.str.19 = private unnamed_addr constant [6 x i8] c"12345\00", align 1
@.str.20 = private unnamed_addr constant [32 x i8] c"Compare 'Hello' vs 'hello': %d\0A\00", align 1
@.str.21 = private unnamed_addr constant [6 x i8] c"Hello\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reverseStr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8, align 1
  store ptr %0, ptr %2, align 8
  %6 = load ptr, ptr %2, align 8
  %7 = call i64 @strlen(ptr noundef %6) #5
  %8 = trunc i64 %7 to i32
  store i32 %8, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %9

9:                                                ; preds = %40, %1
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr %3, align 4
  %12 = sdiv i32 %11, 2
  %13 = icmp slt i32 %10, %12
  br i1 %13, label %14, label %43

14:                                               ; preds = %9
  %15 = load ptr, ptr %2, align 8
  %16 = load i32, ptr %4, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i8, ptr %15, i64 %17
  %19 = load i8, ptr %18, align 1
  store i8 %19, ptr %5, align 1
  %20 = load ptr, ptr %2, align 8
  %21 = load i32, ptr %3, align 4
  %22 = sub nsw i32 %21, 1
  %23 = load i32, ptr %4, align 4
  %24 = sub nsw i32 %22, %23
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i8, ptr %20, i64 %25
  %27 = load i8, ptr %26, align 1
  %28 = load ptr, ptr %2, align 8
  %29 = load i32, ptr %4, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds i8, ptr %28, i64 %30
  store i8 %27, ptr %31, align 1
  %32 = load i8, ptr %5, align 1
  %33 = load ptr, ptr %2, align 8
  %34 = load i32, ptr %3, align 4
  %35 = sub nsw i32 %34, 1
  %36 = load i32, ptr %4, align 4
  %37 = sub nsw i32 %35, %36
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds i8, ptr %33, i64 %38
  store i8 %32, ptr %39, align 1
  br label %40

40:                                               ; preds = %14
  %41 = load i32, ptr %4, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr %4, align 4
  br label %9, !llvm.loop !6

43:                                               ; preds = %9
  ret void
}

; Function Attrs: nounwind willreturn memory(read)
declare i64 @strlen(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @isPalindrome(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = call i64 @strlen(ptr noundef %6) #5
  %8 = trunc i64 %7 to i32
  store i32 %8, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %9

9:                                                ; preds = %35, %1
  %10 = load i32, ptr %5, align 4
  %11 = load i32, ptr %4, align 4
  %12 = sdiv i32 %11, 2
  %13 = icmp slt i32 %10, %12
  br i1 %13, label %14, label %38

14:                                               ; preds = %9
  %15 = load ptr, ptr %3, align 8
  %16 = load i32, ptr %5, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i8, ptr %15, i64 %17
  %19 = load i8, ptr %18, align 1
  %20 = sext i8 %19 to i32
  %21 = call i32 @tolower(i32 noundef %20) #5
  %22 = load ptr, ptr %3, align 8
  %23 = load i32, ptr %4, align 4
  %24 = sub nsw i32 %23, 1
  %25 = load i32, ptr %5, align 4
  %26 = sub nsw i32 %24, %25
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds i8, ptr %22, i64 %27
  %29 = load i8, ptr %28, align 1
  %30 = sext i8 %29 to i32
  %31 = call i32 @tolower(i32 noundef %30) #5
  %32 = icmp ne i32 %21, %31
  br i1 %32, label %33, label %34

33:                                               ; preds = %14
  store i32 0, ptr %2, align 4
  br label %39

34:                                               ; preds = %14
  br label %35

35:                                               ; preds = %34
  %36 = load i32, ptr %5, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %5, align 4
  br label %9, !llvm.loop !8

38:                                               ; preds = %9
  store i32 1, ptr %2, align 4
  br label %39

39:                                               ; preds = %38, %33
  %40 = load i32, ptr %2, align 4
  ret i32 %40
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @tolower(i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @wordCount(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %29, %1
  %6 = load ptr, ptr %2, align 8
  %7 = load i8, ptr %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %32

9:                                                ; preds = %5
  %10 = call ptr @__ctype_b_loc() #6
  %11 = load ptr, ptr %10, align 8
  %12 = load ptr, ptr %2, align 8
  %13 = load i8, ptr %12, align 1
  %14 = sext i8 %13 to i32
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i16, ptr %11, i64 %15
  %17 = load i16, ptr %16, align 2
  %18 = zext i16 %17 to i32
  %19 = and i32 %18, 8192
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %21, label %22

21:                                               ; preds = %9
  store i32 0, ptr %4, align 4
  br label %29

22:                                               ; preds = %9
  %23 = load i32, ptr %4, align 4
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %28, label %25

25:                                               ; preds = %22
  store i32 1, ptr %4, align 4
  %26 = load i32, ptr %3, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %3, align 4
  br label %28

28:                                               ; preds = %25, %22
  br label %29

29:                                               ; preds = %28, %21
  %30 = load ptr, ptr %2, align 8
  %31 = getelementptr inbounds i8, ptr %30, i32 1
  store ptr %31, ptr %2, align 8
  br label %5, !llvm.loop !9

32:                                               ; preds = %5
  %33 = load i32, ptr %3, align 4
  ret i32 %33
}

; Function Attrs: nounwind willreturn memory(none)
declare ptr @__ctype_b_loc() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @caesarEncrypt(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %79, %2
  %7 = load ptr, ptr %3, align 8
  %8 = load i32, ptr %5, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds i8, ptr %7, i64 %9
  %11 = load i8, ptr %10, align 1
  %12 = icmp ne i8 %11, 0
  br i1 %12, label %13, label %82

13:                                               ; preds = %6
  %14 = call ptr @__ctype_b_loc() #6
  %15 = load ptr, ptr %14, align 8
  %16 = load ptr, ptr %3, align 8
  %17 = load i32, ptr %5, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i8, ptr %16, i64 %18
  %20 = load i8, ptr %19, align 1
  %21 = sext i8 %20 to i32
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds i16, ptr %15, i64 %22
  %24 = load i16, ptr %23, align 2
  %25 = zext i16 %24 to i32
  %26 = and i32 %25, 256
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %45

28:                                               ; preds = %13
  %29 = load ptr, ptr %3, align 8
  %30 = load i32, ptr %5, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds i8, ptr %29, i64 %31
  %33 = load i8, ptr %32, align 1
  %34 = sext i8 %33 to i32
  %35 = sub nsw i32 %34, 65
  %36 = load i32, ptr %4, align 4
  %37 = add nsw i32 %35, %36
  %38 = srem i32 %37, 26
  %39 = add nsw i32 65, %38
  %40 = trunc i32 %39 to i8
  %41 = load ptr, ptr %3, align 8
  %42 = load i32, ptr %5, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds i8, ptr %41, i64 %43
  store i8 %40, ptr %44, align 1
  br label %78

45:                                               ; preds = %13
  %46 = call ptr @__ctype_b_loc() #6
  %47 = load ptr, ptr %46, align 8
  %48 = load ptr, ptr %3, align 8
  %49 = load i32, ptr %5, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds i8, ptr %48, i64 %50
  %52 = load i8, ptr %51, align 1
  %53 = sext i8 %52 to i32
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds i16, ptr %47, i64 %54
  %56 = load i16, ptr %55, align 2
  %57 = zext i16 %56 to i32
  %58 = and i32 %57, 512
  %59 = icmp ne i32 %58, 0
  br i1 %59, label %60, label %77

60:                                               ; preds = %45
  %61 = load ptr, ptr %3, align 8
  %62 = load i32, ptr %5, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds i8, ptr %61, i64 %63
  %65 = load i8, ptr %64, align 1
  %66 = sext i8 %65 to i32
  %67 = sub nsw i32 %66, 97
  %68 = load i32, ptr %4, align 4
  %69 = add nsw i32 %67, %68
  %70 = srem i32 %69, 26
  %71 = add nsw i32 97, %70
  %72 = trunc i32 %71 to i8
  %73 = load ptr, ptr %3, align 8
  %74 = load i32, ptr %5, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds i8, ptr %73, i64 %75
  store i8 %72, ptr %76, align 1
  br label %77

77:                                               ; preds = %60, %45
  br label %78

78:                                               ; preds = %77, %28
  br label %79

79:                                               ; preds = %78
  %80 = load i32, ptr %5, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, ptr %5, align 4
  br label %6, !llvm.loop !10

82:                                               ; preds = %6
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @caesarDecrypt(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = load i32, ptr %4, align 4
  %7 = sub nsw i32 26, %6
  call void @caesarEncrypt(ptr noundef %5, i32 noundef %7)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @rleEncode(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i8, align 1
  %9 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  %10 = load ptr, ptr %3, align 8
  %11 = call i64 @strlen(ptr noundef %10) #5
  %12 = trunc i64 %11 to i32
  store i32 %12, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %13

13:                                               ; preds = %67, %2
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %6, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %71

17:                                               ; preds = %13
  %18 = load ptr, ptr %3, align 8
  %19 = load i32, ptr %7, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i8, ptr %18, i64 %20
  %22 = load i8, ptr %21, align 1
  store i8 %22, ptr %8, align 1
  store i32 1, ptr %9, align 4
  br label %23

23:                                               ; preds = %43, %17
  %24 = load i32, ptr %7, align 4
  %25 = load i32, ptr %9, align 4
  %26 = add nsw i32 %24, %25
  %27 = load i32, ptr %6, align 4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %41

29:                                               ; preds = %23
  %30 = load ptr, ptr %3, align 8
  %31 = load i32, ptr %7, align 4
  %32 = load i32, ptr %9, align 4
  %33 = add nsw i32 %31, %32
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds i8, ptr %30, i64 %34
  %36 = load i8, ptr %35, align 1
  %37 = sext i8 %36 to i32
  %38 = load i8, ptr %8, align 1
  %39 = sext i8 %38 to i32
  %40 = icmp eq i32 %37, %39
  br label %41

41:                                               ; preds = %29, %23
  %42 = phi i1 [ false, %23 ], [ %40, %29 ]
  br i1 %42, label %43, label %46

43:                                               ; preds = %41
  %44 = load i32, ptr %9, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %9, align 4
  br label %23, !llvm.loop !11

46:                                               ; preds = %41
  %47 = load i32, ptr %9, align 4
  %48 = icmp sgt i32 %47, 1
  br i1 %48, label %49, label %60

49:                                               ; preds = %46
  %50 = load ptr, ptr %4, align 8
  %51 = load i32, ptr %5, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds i8, ptr %50, i64 %52
  %54 = load i32, ptr %9, align 4
  %55 = load i8, ptr %8, align 1
  %56 = sext i8 %55 to i32
  %57 = call i32 (ptr, ptr, ...) @sprintf(ptr noundef %53, ptr noundef @.str, i32 noundef %54, i32 noundef %56) #7
  %58 = load i32, ptr %5, align 4
  %59 = add nsw i32 %58, %57
  store i32 %59, ptr %5, align 4
  br label %67

60:                                               ; preds = %46
  %61 = load i8, ptr %8, align 1
  %62 = load ptr, ptr %4, align 8
  %63 = load i32, ptr %5, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, ptr %5, align 4
  %65 = sext i32 %63 to i64
  %66 = getelementptr inbounds i8, ptr %62, i64 %65
  store i8 %61, ptr %66, align 1
  br label %67

67:                                               ; preds = %60, %49
  %68 = load i32, ptr %9, align 4
  %69 = load i32, ptr %7, align 4
  %70 = add nsw i32 %69, %68
  store i32 %70, ptr %7, align 4
  br label %13, !llvm.loop !12

71:                                               ; preds = %13
  %72 = load ptr, ptr %4, align 8
  %73 = load i32, ptr %5, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i8, ptr %72, i64 %74
  store i8 0, ptr %75, align 1
  %76 = load i32, ptr %5, align 4
  ret i32 %76
}

; Function Attrs: nounwind
declare i32 @sprintf(ptr noundef, ptr noundef, ...) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @myAtoi(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  store i32 1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %14, %1
  %7 = load ptr, ptr %2, align 8
  %8 = load i32, ptr %5, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds i8, ptr %7, i64 %9
  %11 = load i8, ptr %10, align 1
  %12 = sext i8 %11 to i32
  %13 = icmp eq i32 %12, 32
  br i1 %13, label %14, label %17

14:                                               ; preds = %6
  %15 = load i32, ptr %5, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %5, align 4
  br label %6, !llvm.loop !13

17:                                               ; preds = %6
  %18 = load ptr, ptr %2, align 8
  %19 = load i32, ptr %5, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i8, ptr %18, i64 %20
  %22 = load i8, ptr %21, align 1
  %23 = sext i8 %22 to i32
  %24 = icmp eq i32 %23, 45
  br i1 %24, label %25, label %28

25:                                               ; preds = %17
  store i32 -1, ptr %4, align 4
  %26 = load i32, ptr %5, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %5, align 4
  br label %40

28:                                               ; preds = %17
  %29 = load ptr, ptr %2, align 8
  %30 = load i32, ptr %5, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds i8, ptr %29, i64 %31
  %33 = load i8, ptr %32, align 1
  %34 = sext i8 %33 to i32
  %35 = icmp eq i32 %34, 43
  br i1 %35, label %36, label %39

36:                                               ; preds = %28
  %37 = load i32, ptr %5, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %5, align 4
  br label %39

39:                                               ; preds = %36, %28
  br label %40

40:                                               ; preds = %39, %25
  br label %41

41:                                               ; preds = %59, %40
  %42 = load ptr, ptr %2, align 8
  %43 = load i32, ptr %5, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds i8, ptr %42, i64 %44
  %46 = load i8, ptr %45, align 1
  %47 = sext i8 %46 to i32
  %48 = icmp sge i32 %47, 48
  br i1 %48, label %49, label %57

49:                                               ; preds = %41
  %50 = load ptr, ptr %2, align 8
  %51 = load i32, ptr %5, align 4
  %52 = sext i32 %51 to i64
  %53 = getelementptr inbounds i8, ptr %50, i64 %52
  %54 = load i8, ptr %53, align 1
  %55 = sext i8 %54 to i32
  %56 = icmp sle i32 %55, 57
  br label %57

57:                                               ; preds = %49, %41
  %58 = phi i1 [ false, %41 ], [ %56, %49 ]
  br i1 %58, label %59, label %72

59:                                               ; preds = %57
  %60 = load i32, ptr %3, align 4
  %61 = mul nsw i32 %60, 10
  %62 = load ptr, ptr %2, align 8
  %63 = load i32, ptr %5, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds i8, ptr %62, i64 %64
  %66 = load i8, ptr %65, align 1
  %67 = sext i8 %66 to i32
  %68 = sub nsw i32 %67, 48
  %69 = add nsw i32 %61, %68
  store i32 %69, ptr %3, align 4
  %70 = load i32, ptr %5, align 4
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %5, align 4
  br label %41, !llvm.loop !14

72:                                               ; preds = %57
  %73 = load i32, ptr %4, align 4
  %74 = load i32, ptr %3, align 4
  %75 = mul nsw i32 %73, %74
  ret i32 %75
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @strCompareIgnoreCase(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  br label %6

6:                                                ; preds = %38, %2
  %7 = load ptr, ptr %4, align 8
  %8 = load i8, ptr %7, align 1
  %9 = sext i8 %8 to i32
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %16

11:                                               ; preds = %6
  %12 = load ptr, ptr %5, align 8
  %13 = load i8, ptr %12, align 1
  %14 = sext i8 %13 to i32
  %15 = icmp ne i32 %14, 0
  br label %16

16:                                               ; preds = %11, %6
  %17 = phi i1 [ false, %6 ], [ %15, %11 ]
  br i1 %17, label %18, label %43

18:                                               ; preds = %16
  %19 = load ptr, ptr %4, align 8
  %20 = load i8, ptr %19, align 1
  %21 = sext i8 %20 to i32
  %22 = call i32 @tolower(i32 noundef %21) #5
  %23 = load ptr, ptr %5, align 8
  %24 = load i8, ptr %23, align 1
  %25 = sext i8 %24 to i32
  %26 = call i32 @tolower(i32 noundef %25) #5
  %27 = icmp ne i32 %22, %26
  br i1 %27, label %28, label %38

28:                                               ; preds = %18
  %29 = load ptr, ptr %4, align 8
  %30 = load i8, ptr %29, align 1
  %31 = sext i8 %30 to i32
  %32 = call i32 @tolower(i32 noundef %31) #5
  %33 = load ptr, ptr %5, align 8
  %34 = load i8, ptr %33, align 1
  %35 = sext i8 %34 to i32
  %36 = call i32 @tolower(i32 noundef %35) #5
  %37 = sub nsw i32 %32, %36
  store i32 %37, ptr %3, align 4
  br label %51

38:                                               ; preds = %18
  %39 = load ptr, ptr %4, align 8
  %40 = getelementptr inbounds i8, ptr %39, i32 1
  store ptr %40, ptr %4, align 8
  %41 = load ptr, ptr %5, align 8
  %42 = getelementptr inbounds i8, ptr %41, i32 1
  store ptr %42, ptr %5, align 8
  br label %6, !llvm.loop !15

43:                                               ; preds = %16
  %44 = load ptr, ptr %4, align 8
  %45 = load i8, ptr %44, align 1
  %46 = sext i8 %45 to i32
  %47 = load ptr, ptr %5, align 8
  %48 = load i8, ptr %47, align 1
  %49 = sext i8 %48 to i32
  %50 = sub nsw i32 %46, %49
  store i32 %50, ptr %3, align 4
  br label %51

51:                                               ; preds = %43, %28
  %52 = load i32, ptr %3, align 4
  ret i32 %52
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [256 x i8], align 16
  %3 = alloca [256 x i8], align 16
  store i32 0, ptr %1, align 4
  %4 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  %5 = call ptr @strcpy(ptr noundef %4, ptr noundef @.str.1) #7
  %6 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  call void @reverseStr(ptr noundef %6)
  %7 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, ptr noundef %7)
  %9 = call i32 @isPalindrome(ptr noundef @.str.4)
  %10 = icmp ne i32 %9, 0
  %11 = zext i1 %10 to i64
  %12 = select i1 %10, ptr @.str.5, ptr @.str.6
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, ptr noundef %12)
  %14 = call i32 @isPalindrome(ptr noundef @.str.8)
  %15 = icmp ne i32 %14, 0
  %16 = zext i1 %15 to i64
  %17 = select i1 %15, ptr @.str.5, ptr @.str.6
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, ptr noundef %17)
  %19 = call i32 @wordCount(ptr noundef @.str.10)
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str.9, i32 noundef %19)
  %21 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  %22 = call ptr @strcpy(ptr noundef %21, ptr noundef @.str.11) #7
  %23 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  call void @caesarEncrypt(ptr noundef %23, i32 noundef 3)
  %24 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, ptr noundef %24)
  %26 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  call void @caesarDecrypt(ptr noundef %26, i32 noundef 3)
  %27 = getelementptr inbounds [256 x i8], ptr %2, i64 0, i64 0
  %28 = call i32 (ptr, ...) @printf(ptr noundef @.str.13, ptr noundef %27)
  %29 = getelementptr inbounds [256 x i8], ptr %3, i64 0, i64 0
  %30 = call i32 @rleEncode(ptr noundef @.str.14, ptr noundef %29)
  %31 = getelementptr inbounds [256 x i8], ptr %3, i64 0, i64 0
  %32 = call i32 (ptr, ...) @printf(ptr noundef @.str.15, ptr noundef %31)
  %33 = call i32 @myAtoi(ptr noundef @.str.17)
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str.16, i32 noundef %33)
  %35 = call i32 @myAtoi(ptr noundef @.str.19)
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str.18, i32 noundef %35)
  %37 = call i32 @strCompareIgnoreCase(ptr noundef @.str.21, ptr noundef @.str.8)
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str.20, i32 noundef %37)
  ret i32 0
}

; Function Attrs: nounwind
declare ptr @strcpy(ptr noundef, ptr noundef) #3

declare i32 @printf(ptr noundef, ...) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind willreturn memory(none) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind willreturn memory(read) }
attributes #6 = { nounwind willreturn memory(none) }
attributes #7 = { nounwind }

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
