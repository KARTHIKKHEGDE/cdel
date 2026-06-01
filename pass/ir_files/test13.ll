; ModuleID = '/home/karthik/llvm-project/pass/test/test13.c'
source_filename = "/home/karthik/llvm-project/pass/test/test13.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.HashTable = type { [128 x %struct.Entry], i32, i32 }
%struct.Entry = type { i32, i32, i32, i32 }

@.str = private unnamed_addr constant [60 x i8] c"Count: %d, Occupied slots: %d, Deleted: %d, Collisions: %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"After 80 inserts:\0A\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"Found %d / 80 keys\0A\00", align 1
@.str.3 = private unnamed_addr constant [25 x i8] c"After deleting 40 keys:\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @htInit(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.HashTable, ptr %3, i32 0, i32 0
  %5 = getelementptr inbounds [128 x %struct.Entry], ptr %4, i64 0, i64 0
  call void @llvm.memset.p0.i64(ptr align 4 %5, i8 0, i64 2048, i1 false)
  %6 = load ptr, ptr %2, align 8
  %7 = getelementptr inbounds %struct.HashTable, ptr %6, i32 0, i32 1
  store i32 0, ptr %7, align 4
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %struct.HashTable, ptr %8, i32 0, i32 2
  store i32 0, ptr %9, align 4
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @hashFunc(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  store i32 %4, ptr %3, align 4
  %5 = load i32, ptr %3, align 4
  %6 = lshr i32 %5, 16
  %7 = load i32, ptr %3, align 4
  %8 = xor i32 %6, %7
  %9 = mul i32 %8, 73244475
  store i32 %9, ptr %3, align 4
  %10 = load i32, ptr %3, align 4
  %11 = lshr i32 %10, 16
  %12 = load i32, ptr %3, align 4
  %13 = xor i32 %11, %12
  %14 = mul i32 %13, 73244475
  store i32 %14, ptr %3, align 4
  %15 = load i32, ptr %3, align 4
  %16 = lshr i32 %15, 16
  %17 = load i32, ptr %3, align 4
  %18 = xor i32 %16, %17
  store i32 %18, ptr %3, align 4
  %19 = load i32, ptr %3, align 4
  %20 = urem i32 %19, 128
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @htInsert(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  %10 = load ptr, ptr %5, align 8
  %11 = getelementptr inbounds %struct.HashTable, ptr %10, i32 0, i32 1
  %12 = load i32, ptr %11, align 4
  %13 = icmp sge i32 %12, 96
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  store i32 0, ptr %4, align 4
  br label %102

15:                                               ; preds = %3
  %16 = load i32, ptr %6, align 4
  %17 = call i32 @hashFunc(i32 noundef %16)
  store i32 %17, ptr %8, align 4
  %18 = load i32, ptr %8, align 4
  store i32 %18, ptr %9, align 4
  br label %19

19:                                               ; preds = %70, %15
  %20 = load ptr, ptr %5, align 8
  %21 = getelementptr inbounds %struct.HashTable, ptr %20, i32 0, i32 0
  %22 = load i32, ptr %8, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [128 x %struct.Entry], ptr %21, i64 0, i64 %23
  %25 = getelementptr inbounds %struct.Entry, ptr %24, i32 0, i32 2
  %26 = load i32, ptr %25, align 4
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %38

28:                                               ; preds = %19
  %29 = load ptr, ptr %5, align 8
  %30 = getelementptr inbounds %struct.HashTable, ptr %29, i32 0, i32 0
  %31 = load i32, ptr %8, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [128 x %struct.Entry], ptr %30, i64 0, i64 %32
  %34 = getelementptr inbounds %struct.Entry, ptr %33, i32 0, i32 3
  %35 = load i32, ptr %34, align 4
  %36 = icmp ne i32 %35, 0
  %37 = xor i1 %36, true
  br label %38

38:                                               ; preds = %28, %19
  %39 = phi i1 [ false, %19 ], [ %37, %28 ]
  br i1 %39, label %40, label %71

40:                                               ; preds = %38
  %41 = load ptr, ptr %5, align 8
  %42 = getelementptr inbounds %struct.HashTable, ptr %41, i32 0, i32 0
  %43 = load i32, ptr %8, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [128 x %struct.Entry], ptr %42, i64 0, i64 %44
  %46 = getelementptr inbounds %struct.Entry, ptr %45, i32 0, i32 0
  %47 = load i32, ptr %46, align 4
  %48 = load i32, ptr %6, align 4
  %49 = icmp eq i32 %47, %48
  br i1 %49, label %50, label %58

50:                                               ; preds = %40
  %51 = load i32, ptr %7, align 4
  %52 = load ptr, ptr %5, align 8
  %53 = getelementptr inbounds %struct.HashTable, ptr %52, i32 0, i32 0
  %54 = load i32, ptr %8, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [128 x %struct.Entry], ptr %53, i64 0, i64 %55
  %57 = getelementptr inbounds %struct.Entry, ptr %56, i32 0, i32 1
  store i32 %51, ptr %57, align 4
  store i32 1, ptr %4, align 4
  br label %102

58:                                               ; preds = %40
  %59 = load ptr, ptr %5, align 8
  %60 = getelementptr inbounds %struct.HashTable, ptr %59, i32 0, i32 2
  %61 = load i32, ptr %60, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, ptr %60, align 4
  %63 = load i32, ptr %8, align 4
  %64 = add nsw i32 %63, 1
  %65 = srem i32 %64, 128
  store i32 %65, ptr %8, align 4
  %66 = load i32, ptr %8, align 4
  %67 = load i32, ptr %9, align 4
  %68 = icmp eq i32 %66, %67
  br i1 %68, label %69, label %70

69:                                               ; preds = %58
  store i32 0, ptr %4, align 4
  br label %102

70:                                               ; preds = %58
  br label %19, !llvm.loop !6

71:                                               ; preds = %38
  %72 = load i32, ptr %6, align 4
  %73 = load ptr, ptr %5, align 8
  %74 = getelementptr inbounds %struct.HashTable, ptr %73, i32 0, i32 0
  %75 = load i32, ptr %8, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [128 x %struct.Entry], ptr %74, i64 0, i64 %76
  %78 = getelementptr inbounds %struct.Entry, ptr %77, i32 0, i32 0
  store i32 %72, ptr %78, align 4
  %79 = load i32, ptr %7, align 4
  %80 = load ptr, ptr %5, align 8
  %81 = getelementptr inbounds %struct.HashTable, ptr %80, i32 0, i32 0
  %82 = load i32, ptr %8, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [128 x %struct.Entry], ptr %81, i64 0, i64 %83
  %85 = getelementptr inbounds %struct.Entry, ptr %84, i32 0, i32 1
  store i32 %79, ptr %85, align 4
  %86 = load ptr, ptr %5, align 8
  %87 = getelementptr inbounds %struct.HashTable, ptr %86, i32 0, i32 0
  %88 = load i32, ptr %8, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [128 x %struct.Entry], ptr %87, i64 0, i64 %89
  %91 = getelementptr inbounds %struct.Entry, ptr %90, i32 0, i32 2
  store i32 1, ptr %91, align 4
  %92 = load ptr, ptr %5, align 8
  %93 = getelementptr inbounds %struct.HashTable, ptr %92, i32 0, i32 0
  %94 = load i32, ptr %8, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds [128 x %struct.Entry], ptr %93, i64 0, i64 %95
  %97 = getelementptr inbounds %struct.Entry, ptr %96, i32 0, i32 3
  store i32 0, ptr %97, align 4
  %98 = load ptr, ptr %5, align 8
  %99 = getelementptr inbounds %struct.HashTable, ptr %98, i32 0, i32 1
  %100 = load i32, ptr %99, align 4
  %101 = add nsw i32 %100, 1
  store i32 %101, ptr %99, align 4
  store i32 1, ptr %4, align 4
  br label %102

102:                                              ; preds = %71, %69, %50, %14
  %103 = load i32, ptr %4, align 4
  ret i32 %103
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @htSearch(ptr noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  %10 = load i32, ptr %6, align 4
  %11 = call i32 @hashFunc(i32 noundef %10)
  store i32 %11, ptr %8, align 4
  %12 = load i32, ptr %8, align 4
  store i32 %12, ptr %9, align 4
  br label %13

13:                                               ; preds = %58, %3
  %14 = load ptr, ptr %5, align 8
  %15 = getelementptr inbounds %struct.HashTable, ptr %14, i32 0, i32 0
  %16 = load i32, ptr %8, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [128 x %struct.Entry], ptr %15, i64 0, i64 %17
  %19 = getelementptr inbounds %struct.Entry, ptr %18, i32 0, i32 2
  %20 = load i32, ptr %19, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %59

22:                                               ; preds = %13
  %23 = load ptr, ptr %5, align 8
  %24 = getelementptr inbounds %struct.HashTable, ptr %23, i32 0, i32 0
  %25 = load i32, ptr %8, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [128 x %struct.Entry], ptr %24, i64 0, i64 %26
  %28 = getelementptr inbounds %struct.Entry, ptr %27, i32 0, i32 3
  %29 = load i32, ptr %28, align 4
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %50, label %31

31:                                               ; preds = %22
  %32 = load ptr, ptr %5, align 8
  %33 = getelementptr inbounds %struct.HashTable, ptr %32, i32 0, i32 0
  %34 = load i32, ptr %8, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [128 x %struct.Entry], ptr %33, i64 0, i64 %35
  %37 = getelementptr inbounds %struct.Entry, ptr %36, i32 0, i32 0
  %38 = load i32, ptr %37, align 4
  %39 = load i32, ptr %6, align 4
  %40 = icmp eq i32 %38, %39
  br i1 %40, label %41, label %50

41:                                               ; preds = %31
  %42 = load ptr, ptr %5, align 8
  %43 = getelementptr inbounds %struct.HashTable, ptr %42, i32 0, i32 0
  %44 = load i32, ptr %8, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [128 x %struct.Entry], ptr %43, i64 0, i64 %45
  %47 = getelementptr inbounds %struct.Entry, ptr %46, i32 0, i32 1
  %48 = load i32, ptr %47, align 4
  %49 = load ptr, ptr %7, align 8
  store i32 %48, ptr %49, align 4
  store i32 1, ptr %4, align 4
  br label %60

50:                                               ; preds = %31, %22
  %51 = load i32, ptr %8, align 4
  %52 = add nsw i32 %51, 1
  %53 = srem i32 %52, 128
  store i32 %53, ptr %8, align 4
  %54 = load i32, ptr %8, align 4
  %55 = load i32, ptr %9, align 4
  %56 = icmp eq i32 %54, %55
  br i1 %56, label %57, label %58

57:                                               ; preds = %50
  br label %59

58:                                               ; preds = %50
  br label %13, !llvm.loop !8

59:                                               ; preds = %57, %13
  store i32 0, ptr %4, align 4
  br label %60

60:                                               ; preds = %59, %41
  %61 = load i32, ptr %4, align 4
  ret i32 %61
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @htDelete(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  %8 = load i32, ptr %5, align 4
  %9 = call i32 @hashFunc(i32 noundef %8)
  store i32 %9, ptr %6, align 4
  %10 = load i32, ptr %6, align 4
  store i32 %10, ptr %7, align 4
  br label %11

11:                                               ; preds = %58, %2
  %12 = load ptr, ptr %4, align 8
  %13 = getelementptr inbounds %struct.HashTable, ptr %12, i32 0, i32 0
  %14 = load i32, ptr %6, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [128 x %struct.Entry], ptr %13, i64 0, i64 %15
  %17 = getelementptr inbounds %struct.Entry, ptr %16, i32 0, i32 2
  %18 = load i32, ptr %17, align 4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %59

20:                                               ; preds = %11
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds %struct.HashTable, ptr %21, i32 0, i32 0
  %23 = load i32, ptr %6, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [128 x %struct.Entry], ptr %22, i64 0, i64 %24
  %26 = getelementptr inbounds %struct.Entry, ptr %25, i32 0, i32 3
  %27 = load i32, ptr %26, align 4
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %50, label %29

29:                                               ; preds = %20
  %30 = load ptr, ptr %4, align 8
  %31 = getelementptr inbounds %struct.HashTable, ptr %30, i32 0, i32 0
  %32 = load i32, ptr %6, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [128 x %struct.Entry], ptr %31, i64 0, i64 %33
  %35 = getelementptr inbounds %struct.Entry, ptr %34, i32 0, i32 0
  %36 = load i32, ptr %35, align 4
  %37 = load i32, ptr %5, align 4
  %38 = icmp eq i32 %36, %37
  br i1 %38, label %39, label %50

39:                                               ; preds = %29
  %40 = load ptr, ptr %4, align 8
  %41 = getelementptr inbounds %struct.HashTable, ptr %40, i32 0, i32 0
  %42 = load i32, ptr %6, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [128 x %struct.Entry], ptr %41, i64 0, i64 %43
  %45 = getelementptr inbounds %struct.Entry, ptr %44, i32 0, i32 3
  store i32 1, ptr %45, align 4
  %46 = load ptr, ptr %4, align 8
  %47 = getelementptr inbounds %struct.HashTable, ptr %46, i32 0, i32 1
  %48 = load i32, ptr %47, align 4
  %49 = add nsw i32 %48, -1
  store i32 %49, ptr %47, align 4
  store i32 1, ptr %3, align 4
  br label %60

50:                                               ; preds = %29, %20
  %51 = load i32, ptr %6, align 4
  %52 = add nsw i32 %51, 1
  %53 = srem i32 %52, 128
  store i32 %53, ptr %6, align 4
  %54 = load i32, ptr %6, align 4
  %55 = load i32, ptr %7, align 4
  %56 = icmp eq i32 %54, %55
  br i1 %56, label %57, label %58

57:                                               ; preds = %50
  br label %59

58:                                               ; preds = %50
  br label %11, !llvm.loop !9

59:                                               ; preds = %57, %11
  store i32 0, ptr %3, align 4
  br label %60

60:                                               ; preds = %59, %39
  %61 = load i32, ptr %3, align 4
  ret i32 %61
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @htStats(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %34, %1
  %7 = load i32, ptr %5, align 4
  %8 = icmp slt i32 %7, 128
  br i1 %8, label %9, label %37

9:                                                ; preds = %6
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.HashTable, ptr %10, i32 0, i32 0
  %12 = load i32, ptr %5, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [128 x %struct.Entry], ptr %11, i64 0, i64 %13
  %15 = getelementptr inbounds %struct.Entry, ptr %14, i32 0, i32 2
  %16 = load i32, ptr %15, align 4
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %21

18:                                               ; preds = %9
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %3, align 4
  br label %21

21:                                               ; preds = %18, %9
  %22 = load ptr, ptr %2, align 8
  %23 = getelementptr inbounds %struct.HashTable, ptr %22, i32 0, i32 0
  %24 = load i32, ptr %5, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [128 x %struct.Entry], ptr %23, i64 0, i64 %25
  %27 = getelementptr inbounds %struct.Entry, ptr %26, i32 0, i32 3
  %28 = load i32, ptr %27, align 4
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %33

30:                                               ; preds = %21
  %31 = load i32, ptr %4, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %4, align 4
  br label %33

33:                                               ; preds = %30, %21
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %5, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %5, align 4
  br label %6, !llvm.loop !10

37:                                               ; preds = %6
  %38 = load ptr, ptr %2, align 8
  %39 = getelementptr inbounds %struct.HashTable, ptr %38, i32 0, i32 1
  %40 = load i32, ptr %39, align 4
  %41 = load i32, ptr %3, align 4
  %42 = load i32, ptr %4, align 4
  %43 = load ptr, ptr %2, align 8
  %44 = getelementptr inbounds %struct.HashTable, ptr %43, i32 0, i32 2
  %45 = load i32, ptr %44, align 4
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %40, i32 noundef %41, i32 noundef %42, i32 noundef %45)
  ret void
}

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.HashTable, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @htInit(ptr noundef %2)
  store i32 0, ptr %3, align 4
  br label %8

8:                                                ; preds = %18, %0
  %9 = load i32, ptr %3, align 4
  %10 = icmp slt i32 %9, 80
  br i1 %10, label %11, label %21

11:                                               ; preds = %8
  %12 = load i32, ptr %3, align 4
  %13 = mul nsw i32 %12, 7
  %14 = add nsw i32 %13, 3
  %15 = load i32, ptr %3, align 4
  %16 = mul nsw i32 %15, 100
  %17 = call i32 @htInsert(ptr noundef %2, i32 noundef %14, i32 noundef %16)
  br label %18

18:                                               ; preds = %11
  %19 = load i32, ptr %3, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %3, align 4
  br label %8, !llvm.loop !11

21:                                               ; preds = %8
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  call void @htStats(ptr noundef %2)
  store i32 0, ptr %4, align 4
  store i32 0, ptr %6, align 4
  br label %23

23:                                               ; preds = %36, %21
  %24 = load i32, ptr %6, align 4
  %25 = icmp slt i32 %24, 80
  br i1 %25, label %26, label %39

26:                                               ; preds = %23
  %27 = load i32, ptr %6, align 4
  %28 = mul nsw i32 %27, 7
  %29 = add nsw i32 %28, 3
  %30 = call i32 @htSearch(ptr noundef %2, i32 noundef %29, ptr noundef %5)
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %32, label %35

32:                                               ; preds = %26
  %33 = load i32, ptr %4, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %4, align 4
  br label %35

35:                                               ; preds = %32, %26
  br label %36

36:                                               ; preds = %35
  %37 = load i32, ptr %6, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %6, align 4
  br label %23, !llvm.loop !12

39:                                               ; preds = %23
  %40 = load i32, ptr %4, align 4
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %40)
  store i32 0, ptr %7, align 4
  br label %42

42:                                               ; preds = %50, %39
  %43 = load i32, ptr %7, align 4
  %44 = icmp slt i32 %43, 80
  br i1 %44, label %45, label %53

45:                                               ; preds = %42
  %46 = load i32, ptr %7, align 4
  %47 = mul nsw i32 %46, 7
  %48 = add nsw i32 %47, 3
  %49 = call i32 @htDelete(ptr noundef %2, i32 noundef %48)
  br label %50

50:                                               ; preds = %45
  %51 = load i32, ptr %7, align 4
  %52 = add nsw i32 %51, 2
  store i32 %52, ptr %7, align 4
  br label %42, !llvm.loop !13

53:                                               ; preds = %42
  %54 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  call void @htStats(ptr noundef %2)
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
