; ModuleID = '/home/karthik/llvm-project/pass/test/test11.c'
source_filename = "/home/karthik/llvm-project/pass/test/test11.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [16 x i8] c"Bubble    : %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"PASS\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"FAIL\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"Selection : %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"Insertion : %s\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"Merge     : %s\0A\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"Quick     : %s\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @swap(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = load i32, ptr %6, align 4
  store i32 %7, ptr %5, align 4
  %8 = load ptr, ptr %4, align 8
  %9 = load i32, ptr %8, align 4
  %10 = load ptr, ptr %3, align 8
  store i32 %9, ptr %10, align 4
  %11 = load i32, ptr %5, align 4
  %12 = load ptr, ptr %4, align 8
  store i32 %11, ptr %12, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @bubbleSort(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %8

8:                                                ; preds = %53, %2
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %4, align 4
  %11 = sub nsw i32 %10, 1
  %12 = icmp slt i32 %9, %11
  br i1 %12, label %13, label %56

13:                                               ; preds = %8
  store i32 0, ptr %6, align 4
  store i32 0, ptr %7, align 4
  br label %14

14:                                               ; preds = %45, %13
  %15 = load i32, ptr %7, align 4
  %16 = load i32, ptr %4, align 4
  %17 = load i32, ptr %5, align 4
  %18 = sub nsw i32 %16, %17
  %19 = sub nsw i32 %18, 1
  %20 = icmp slt i32 %15, %19
  br i1 %20, label %21, label %48

21:                                               ; preds = %14
  %22 = load ptr, ptr %3, align 8
  %23 = load i32, ptr %7, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32, ptr %22, i64 %24
  %26 = load i32, ptr %25, align 4
  %27 = load ptr, ptr %3, align 8
  %28 = load i32, ptr %7, align 4
  %29 = add nsw i32 %28, 1
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds i32, ptr %27, i64 %30
  %32 = load i32, ptr %31, align 4
  %33 = icmp sgt i32 %26, %32
  br i1 %33, label %34, label %44

34:                                               ; preds = %21
  %35 = load ptr, ptr %3, align 8
  %36 = load i32, ptr %7, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i32, ptr %35, i64 %37
  %39 = load ptr, ptr %3, align 8
  %40 = load i32, ptr %7, align 4
  %41 = add nsw i32 %40, 1
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i32, ptr %39, i64 %42
  call void @swap(ptr noundef %38, ptr noundef %43)
  store i32 1, ptr %6, align 4
  br label %44

44:                                               ; preds = %34, %21
  br label %45

45:                                               ; preds = %44
  %46 = load i32, ptr %7, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr %7, align 4
  br label %14, !llvm.loop !6

48:                                               ; preds = %14
  %49 = load i32, ptr %6, align 4
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %52, label %51

51:                                               ; preds = %48
  br label %56

52:                                               ; preds = %48
  br label %53

53:                                               ; preds = %52
  %54 = load i32, ptr %5, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %5, align 4
  br label %8, !llvm.loop !8

56:                                               ; preds = %51, %8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @selectionSort(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %8

8:                                                ; preds = %48, %2
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %4, align 4
  %11 = sub nsw i32 %10, 1
  %12 = icmp slt i32 %9, %11
  br i1 %12, label %13, label %51

13:                                               ; preds = %8
  %14 = load i32, ptr %5, align 4
  store i32 %14, ptr %6, align 4
  %15 = load i32, ptr %5, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %7, align 4
  br label %17

17:                                               ; preds = %36, %13
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %4, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %39

21:                                               ; preds = %17
  %22 = load ptr, ptr %3, align 8
  %23 = load i32, ptr %7, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32, ptr %22, i64 %24
  %26 = load i32, ptr %25, align 4
  %27 = load ptr, ptr %3, align 8
  %28 = load i32, ptr %6, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i32, ptr %27, i64 %29
  %31 = load i32, ptr %30, align 4
  %32 = icmp slt i32 %26, %31
  br i1 %32, label %33, label %35

33:                                               ; preds = %21
  %34 = load i32, ptr %7, align 4
  store i32 %34, ptr %6, align 4
  br label %35

35:                                               ; preds = %33, %21
  br label %36

36:                                               ; preds = %35
  %37 = load i32, ptr %7, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %7, align 4
  br label %17, !llvm.loop !9

39:                                               ; preds = %17
  %40 = load ptr, ptr %3, align 8
  %41 = load i32, ptr %6, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i32, ptr %40, i64 %42
  %44 = load ptr, ptr %3, align 8
  %45 = load i32, ptr %5, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds i32, ptr %44, i64 %46
  call void @swap(ptr noundef %43, ptr noundef %47)
  br label %48

48:                                               ; preds = %39
  %49 = load i32, ptr %5, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %5, align 4
  br label %8, !llvm.loop !10

51:                                               ; preds = %8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @insertionSort(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 1, ptr %5, align 4
  br label %8

8:                                                ; preds = %53, %2
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %4, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %56

12:                                               ; preds = %8
  %13 = load ptr, ptr %3, align 8
  %14 = load i32, ptr %5, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %13, i64 %15
  %17 = load i32, ptr %16, align 4
  store i32 %17, ptr %6, align 4
  %18 = load i32, ptr %5, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %7, align 4
  br label %20

20:                                               ; preds = %33, %12
  %21 = load i32, ptr %7, align 4
  %22 = icmp sge i32 %21, 0
  br i1 %22, label %23, label %31

23:                                               ; preds = %20
  %24 = load ptr, ptr %3, align 8
  %25 = load i32, ptr %7, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, ptr %24, i64 %26
  %28 = load i32, ptr %27, align 4
  %29 = load i32, ptr %6, align 4
  %30 = icmp sgt i32 %28, %29
  br label %31

31:                                               ; preds = %23, %20
  %32 = phi i1 [ false, %20 ], [ %30, %23 ]
  br i1 %32, label %33, label %46

33:                                               ; preds = %31
  %34 = load ptr, ptr %3, align 8
  %35 = load i32, ptr %7, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i32, ptr %34, i64 %36
  %38 = load i32, ptr %37, align 4
  %39 = load ptr, ptr %3, align 8
  %40 = load i32, ptr %7, align 4
  %41 = add nsw i32 %40, 1
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i32, ptr %39, i64 %42
  store i32 %38, ptr %43, align 4
  %44 = load i32, ptr %7, align 4
  %45 = add nsw i32 %44, -1
  store i32 %45, ptr %7, align 4
  br label %20, !llvm.loop !11

46:                                               ; preds = %31
  %47 = load i32, ptr %6, align 4
  %48 = load ptr, ptr %3, align 8
  %49 = load i32, ptr %7, align 4
  %50 = add nsw i32 %49, 1
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i32, ptr %48, i64 %51
  store i32 %47, ptr %52, align 4
  br label %53

53:                                               ; preds = %46
  %54 = load i32, ptr %5, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %5, align 4
  br label %8, !llvm.loop !12

56:                                               ; preds = %8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @merge(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %19 = load i32, ptr %7, align 4
  %20 = load i32, ptr %6, align 4
  %21 = sub nsw i32 %19, %20
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %9, align 4
  %23 = load i32, ptr %8, align 4
  %24 = load i32, ptr %7, align 4
  %25 = sub nsw i32 %23, %24
  store i32 %25, ptr %10, align 4
  %26 = load i32, ptr %9, align 4
  %27 = zext i32 %26 to i64
  %28 = call ptr @llvm.stacksave()
  store ptr %28, ptr %11, align 8
  %29 = alloca i32, i64 %27, align 16
  store i64 %27, ptr %12, align 8
  %30 = load i32, ptr %10, align 4
  %31 = zext i32 %30 to i64
  %32 = alloca i32, i64 %31, align 16
  store i64 %31, ptr %13, align 8
  store i32 0, ptr %14, align 4
  br label %33

33:                                               ; preds = %48, %4
  %34 = load i32, ptr %14, align 4
  %35 = load i32, ptr %9, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %51

37:                                               ; preds = %33
  %38 = load ptr, ptr %5, align 8
  %39 = load i32, ptr %6, align 4
  %40 = load i32, ptr %14, align 4
  %41 = add nsw i32 %39, %40
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i32, ptr %38, i64 %42
  %44 = load i32, ptr %43, align 4
  %45 = load i32, ptr %14, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds i32, ptr %29, i64 %46
  store i32 %44, ptr %47, align 4
  br label %48

48:                                               ; preds = %37
  %49 = load i32, ptr %14, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %14, align 4
  br label %33, !llvm.loop !13

51:                                               ; preds = %33
  store i32 0, ptr %15, align 4
  br label %52

52:                                               ; preds = %68, %51
  %53 = load i32, ptr %15, align 4
  %54 = load i32, ptr %10, align 4
  %55 = icmp slt i32 %53, %54
  br i1 %55, label %56, label %71

56:                                               ; preds = %52
  %57 = load ptr, ptr %5, align 8
  %58 = load i32, ptr %7, align 4
  %59 = add nsw i32 %58, 1
  %60 = load i32, ptr %15, align 4
  %61 = add nsw i32 %59, %60
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds i32, ptr %57, i64 %62
  %64 = load i32, ptr %63, align 4
  %65 = load i32, ptr %15, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds i32, ptr %32, i64 %66
  store i32 %64, ptr %67, align 4
  br label %68

68:                                               ; preds = %56
  %69 = load i32, ptr %15, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr %15, align 4
  br label %52, !llvm.loop !14

71:                                               ; preds = %52
  store i32 0, ptr %16, align 4
  store i32 0, ptr %17, align 4
  %72 = load i32, ptr %6, align 4
  store i32 %72, ptr %18, align 4
  br label %73

73:                                               ; preds = %115, %71
  %74 = load i32, ptr %16, align 4
  %75 = load i32, ptr %9, align 4
  %76 = icmp slt i32 %74, %75
  br i1 %76, label %77, label %81

77:                                               ; preds = %73
  %78 = load i32, ptr %17, align 4
  %79 = load i32, ptr %10, align 4
  %80 = icmp slt i32 %78, %79
  br label %81

81:                                               ; preds = %77, %73
  %82 = phi i1 [ false, %73 ], [ %80, %77 ]
  br i1 %82, label %83, label %116

83:                                               ; preds = %81
  %84 = load i32, ptr %16, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds i32, ptr %29, i64 %85
  %87 = load i32, ptr %86, align 4
  %88 = load i32, ptr %17, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds i32, ptr %32, i64 %89
  %91 = load i32, ptr %90, align 4
  %92 = icmp sle i32 %87, %91
  br i1 %92, label %93, label %104

93:                                               ; preds = %83
  %94 = load i32, ptr %16, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, ptr %16, align 4
  %96 = sext i32 %94 to i64
  %97 = getelementptr inbounds i32, ptr %29, i64 %96
  %98 = load i32, ptr %97, align 4
  %99 = load ptr, ptr %5, align 8
  %100 = load i32, ptr %18, align 4
  %101 = add nsw i32 %100, 1
  store i32 %101, ptr %18, align 4
  %102 = sext i32 %100 to i64
  %103 = getelementptr inbounds i32, ptr %99, i64 %102
  store i32 %98, ptr %103, align 4
  br label %115

104:                                              ; preds = %83
  %105 = load i32, ptr %17, align 4
  %106 = add nsw i32 %105, 1
  store i32 %106, ptr %17, align 4
  %107 = sext i32 %105 to i64
  %108 = getelementptr inbounds i32, ptr %32, i64 %107
  %109 = load i32, ptr %108, align 4
  %110 = load ptr, ptr %5, align 8
  %111 = load i32, ptr %18, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, ptr %18, align 4
  %113 = sext i32 %111 to i64
  %114 = getelementptr inbounds i32, ptr %110, i64 %113
  store i32 %109, ptr %114, align 4
  br label %115

115:                                              ; preds = %104, %93
  br label %73, !llvm.loop !15

116:                                              ; preds = %81
  br label %117

117:                                              ; preds = %121, %116
  %118 = load i32, ptr %16, align 4
  %119 = load i32, ptr %9, align 4
  %120 = icmp slt i32 %118, %119
  br i1 %120, label %121, label %132

121:                                              ; preds = %117
  %122 = load i32, ptr %16, align 4
  %123 = add nsw i32 %122, 1
  store i32 %123, ptr %16, align 4
  %124 = sext i32 %122 to i64
  %125 = getelementptr inbounds i32, ptr %29, i64 %124
  %126 = load i32, ptr %125, align 4
  %127 = load ptr, ptr %5, align 8
  %128 = load i32, ptr %18, align 4
  %129 = add nsw i32 %128, 1
  store i32 %129, ptr %18, align 4
  %130 = sext i32 %128 to i64
  %131 = getelementptr inbounds i32, ptr %127, i64 %130
  store i32 %126, ptr %131, align 4
  br label %117, !llvm.loop !16

132:                                              ; preds = %117
  br label %133

133:                                              ; preds = %137, %132
  %134 = load i32, ptr %17, align 4
  %135 = load i32, ptr %10, align 4
  %136 = icmp slt i32 %134, %135
  br i1 %136, label %137, label %148

137:                                              ; preds = %133
  %138 = load i32, ptr %17, align 4
  %139 = add nsw i32 %138, 1
  store i32 %139, ptr %17, align 4
  %140 = sext i32 %138 to i64
  %141 = getelementptr inbounds i32, ptr %32, i64 %140
  %142 = load i32, ptr %141, align 4
  %143 = load ptr, ptr %5, align 8
  %144 = load i32, ptr %18, align 4
  %145 = add nsw i32 %144, 1
  store i32 %145, ptr %18, align 4
  %146 = sext i32 %144 to i64
  %147 = getelementptr inbounds i32, ptr %143, i64 %146
  store i32 %142, ptr %147, align 4
  br label %133, !llvm.loop !17

148:                                              ; preds = %133
  %149 = load ptr, ptr %11, align 8
  call void @llvm.stackrestore(ptr %149)
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @mergeSort(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load i32, ptr %5, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %29

11:                                               ; preds = %3
  %12 = load i32, ptr %5, align 4
  %13 = load i32, ptr %6, align 4
  %14 = load i32, ptr %5, align 4
  %15 = sub nsw i32 %13, %14
  %16 = sdiv i32 %15, 2
  %17 = add nsw i32 %12, %16
  store i32 %17, ptr %7, align 4
  %18 = load ptr, ptr %4, align 8
  %19 = load i32, ptr %5, align 4
  %20 = load i32, ptr %7, align 4
  call void @mergeSort(ptr noundef %18, i32 noundef %19, i32 noundef %20)
  %21 = load ptr, ptr %4, align 8
  %22 = load i32, ptr %7, align 4
  %23 = add nsw i32 %22, 1
  %24 = load i32, ptr %6, align 4
  call void @mergeSort(ptr noundef %21, i32 noundef %23, i32 noundef %24)
  %25 = load ptr, ptr %4, align 8
  %26 = load i32, ptr %5, align 4
  %27 = load i32, ptr %7, align 4
  %28 = load i32, ptr %6, align 4
  call void @merge(ptr noundef %25, i32 noundef %26, i32 noundef %27, i32 noundef %28)
  br label %29

29:                                               ; preds = %11, %3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @partition(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %10 = load ptr, ptr %4, align 8
  %11 = load i32, ptr %6, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32, ptr %10, i64 %12
  %14 = load i32, ptr %13, align 4
  store i32 %14, ptr %7, align 4
  %15 = load i32, ptr %5, align 4
  %16 = sub nsw i32 %15, 1
  store i32 %16, ptr %8, align 4
  %17 = load i32, ptr %5, align 4
  store i32 %17, ptr %9, align 4
  br label %18

18:                                               ; preds = %43, %3
  %19 = load i32, ptr %9, align 4
  %20 = load i32, ptr %6, align 4
  %21 = sub nsw i32 %20, 1
  %22 = icmp sle i32 %19, %21
  br i1 %22, label %23, label %46

23:                                               ; preds = %18
  %24 = load ptr, ptr %4, align 8
  %25 = load i32, ptr %9, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, ptr %24, i64 %26
  %28 = load i32, ptr %27, align 4
  %29 = load i32, ptr %7, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %42

31:                                               ; preds = %23
  %32 = load i32, ptr %8, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, ptr %8, align 4
  %34 = load ptr, ptr %4, align 8
  %35 = load i32, ptr %8, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i32, ptr %34, i64 %36
  %38 = load ptr, ptr %4, align 8
  %39 = load i32, ptr %9, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i32, ptr %38, i64 %40
  call void @swap(ptr noundef %37, ptr noundef %41)
  br label %42

42:                                               ; preds = %31, %23
  br label %43

43:                                               ; preds = %42
  %44 = load i32, ptr %9, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %9, align 4
  br label %18, !llvm.loop !18

46:                                               ; preds = %18
  %47 = load ptr, ptr %4, align 8
  %48 = load i32, ptr %8, align 4
  %49 = add nsw i32 %48, 1
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds i32, ptr %47, i64 %50
  %52 = load ptr, ptr %4, align 8
  %53 = load i32, ptr %6, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds i32, ptr %52, i64 %54
  call void @swap(ptr noundef %51, ptr noundef %55)
  %56 = load i32, ptr %8, align 4
  %57 = add nsw i32 %56, 1
  ret i32 %57
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @quickSort(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load i32, ptr %5, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %24

11:                                               ; preds = %3
  %12 = load ptr, ptr %4, align 8
  %13 = load i32, ptr %5, align 4
  %14 = load i32, ptr %6, align 4
  %15 = call i32 @partition(ptr noundef %12, i32 noundef %13, i32 noundef %14)
  store i32 %15, ptr %7, align 4
  %16 = load ptr, ptr %4, align 8
  %17 = load i32, ptr %5, align 4
  %18 = load i32, ptr %7, align 4
  %19 = sub nsw i32 %18, 1
  call void @quickSort(ptr noundef %16, i32 noundef %17, i32 noundef %19)
  %20 = load ptr, ptr %4, align 8
  %21 = load i32, ptr %7, align 4
  %22 = add nsw i32 %21, 1
  %23 = load i32, ptr %6, align 4
  call void @quickSort(ptr noundef %20, i32 noundef %22, i32 noundef %23)
  br label %24

24:                                               ; preds = %11, %3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @isSorted(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 1, ptr %6, align 4
  br label %7

7:                                                ; preds = %26, %2
  %8 = load i32, ptr %6, align 4
  %9 = load i32, ptr %5, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %29

11:                                               ; preds = %7
  %12 = load ptr, ptr %4, align 8
  %13 = load i32, ptr %6, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i32, ptr %12, i64 %14
  %16 = load i32, ptr %15, align 4
  %17 = load ptr, ptr %4, align 8
  %18 = load i32, ptr %6, align 4
  %19 = sub nsw i32 %18, 1
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %17, i64 %20
  %22 = load i32, ptr %21, align 4
  %23 = icmp slt i32 %16, %22
  br i1 %23, label %24, label %25

24:                                               ; preds = %11
  store i32 0, ptr %3, align 4
  br label %30

25:                                               ; preds = %11
  br label %26

26:                                               ; preds = %25
  %27 = load i32, ptr %6, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %6, align 4
  br label %7, !llvm.loop !19

29:                                               ; preds = %7
  store i32 1, ptr %3, align 4
  br label %30

30:                                               ; preds = %29, %24
  %31 = load i32, ptr %3, align 4
  ret i32 %31
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @fillRandom(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %17, %2
  %7 = load i32, ptr %5, align 4
  %8 = load i32, ptr %4, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %20

10:                                               ; preds = %6
  %11 = call i32 @rand() #5
  %12 = srem i32 %11, 10000
  %13 = load ptr, ptr %3, align 8
  %14 = load i32, ptr %5, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %13, i64 %15
  store i32 %12, ptr %16, align 4
  br label %17

17:                                               ; preds = %10
  %18 = load i32, ptr %5, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %5, align 4
  br label %6, !llvm.loop !20

20:                                               ; preds = %6
  ret void
}

; Function Attrs: nounwind
declare i32 @rand() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @copyArray(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %7 = load ptr, ptr %5, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load i32, ptr %6, align 4
  %10 = sext i32 %9 to i64
  %11 = mul i64 %10, 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %7, ptr align 4 %8, i64 %11, i1 false)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [200 x i32], align 16
  %3 = alloca [200 x i32], align 16
  store i32 0, ptr %1, align 4
  %4 = getelementptr inbounds [200 x i32], ptr %2, i64 0, i64 0
  call void @fillRandom(ptr noundef %4, i32 noundef 200)
  %5 = getelementptr inbounds [200 x i32], ptr %2, i64 0, i64 0
  %6 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @copyArray(ptr noundef %5, ptr noundef %6, i32 noundef 200)
  %7 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @bubbleSort(ptr noundef %7, i32 noundef 200)
  %8 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  %9 = call i32 @isSorted(ptr noundef %8, i32 noundef 200)
  %10 = icmp ne i32 %9, 0
  %11 = zext i1 %10 to i64
  %12 = select i1 %10, ptr @.str.1, ptr @.str.2
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str, ptr noundef %12)
  %14 = getelementptr inbounds [200 x i32], ptr %2, i64 0, i64 0
  %15 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @copyArray(ptr noundef %14, ptr noundef %15, i32 noundef 200)
  %16 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @selectionSort(ptr noundef %16, i32 noundef 200)
  %17 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  %18 = call i32 @isSorted(ptr noundef %17, i32 noundef 200)
  %19 = icmp ne i32 %18, 0
  %20 = zext i1 %19 to i64
  %21 = select i1 %19, ptr @.str.1, ptr @.str.2
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, ptr noundef %21)
  %23 = getelementptr inbounds [200 x i32], ptr %2, i64 0, i64 0
  %24 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @copyArray(ptr noundef %23, ptr noundef %24, i32 noundef 200)
  %25 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @insertionSort(ptr noundef %25, i32 noundef 200)
  %26 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  %27 = call i32 @isSorted(ptr noundef %26, i32 noundef 200)
  %28 = icmp ne i32 %27, 0
  %29 = zext i1 %28 to i64
  %30 = select i1 %28, ptr @.str.1, ptr @.str.2
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, ptr noundef %30)
  %32 = getelementptr inbounds [200 x i32], ptr %2, i64 0, i64 0
  %33 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @copyArray(ptr noundef %32, ptr noundef %33, i32 noundef 200)
  %34 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @mergeSort(ptr noundef %34, i32 noundef 0, i32 noundef 199)
  %35 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  %36 = call i32 @isSorted(ptr noundef %35, i32 noundef 200)
  %37 = icmp ne i32 %36, 0
  %38 = zext i1 %37 to i64
  %39 = select i1 %37, ptr @.str.1, ptr @.str.2
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %39)
  %41 = getelementptr inbounds [200 x i32], ptr %2, i64 0, i64 0
  %42 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @copyArray(ptr noundef %41, ptr noundef %42, i32 noundef 200)
  %43 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  call void @quickSort(ptr noundef %43, i32 noundef 0, i32 noundef 199)
  %44 = getelementptr inbounds [200 x i32], ptr %3, i64 0, i64 0
  %45 = call i32 @isSorted(ptr noundef %44, i32 noundef 200)
  %46 = icmp ne i32 %45, 0
  %47 = zext i1 %46 to i64
  %48 = select i1 %46, ptr @.str.1, ptr @.str.2
  %49 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, ptr noundef %48)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

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
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
