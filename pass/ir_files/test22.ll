; ModuleID = '/home/karthik/llvm-project/pass/test/test22.c'
source_filename = "/home/karthik/llvm-project/pass/test/test22.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.MinHeap = type { [256 x i32], i32 }

@.str = private unnamed_addr constant [15 x i8] c"Heap size: %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"Min element: %d\0A\00", align 1
@.str.2 = private unnamed_addr constant [31 x i8] c"Extracted in sorted order: %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"YES\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"NO\00", align 1
@.str.5 = private unnamed_addr constant [22 x i8] c"Heap sort result: %s\0A\00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"PASS\00", align 1
@.str.7 = private unnamed_addr constant [5 x i8] c"FAIL\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @heapInit(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.MinHeap, ptr %3, i32 0, i32 1
  store i32 0, ptr %4, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @heapSwap(ptr noundef %0, ptr noundef %1) #0 {
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
define dso_local void @siftUp(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  br label %6

6:                                                ; preds = %39, %2
  %7 = load i32, ptr %4, align 4
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %9, label %40

9:                                                ; preds = %6
  %10 = load i32, ptr %4, align 4
  %11 = sub nsw i32 %10, 1
  %12 = sdiv i32 %11, 2
  store i32 %12, ptr %5, align 4
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.MinHeap, ptr %13, i32 0, i32 0
  %15 = load i32, ptr %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [256 x i32], ptr %14, i64 0, i64 %16
  %18 = load i32, ptr %17, align 4
  %19 = load ptr, ptr %3, align 8
  %20 = getelementptr inbounds %struct.MinHeap, ptr %19, i32 0, i32 0
  %21 = load i32, ptr %4, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [256 x i32], ptr %20, i64 0, i64 %22
  %24 = load i32, ptr %23, align 4
  %25 = icmp sgt i32 %18, %24
  br i1 %25, label %26, label %38

26:                                               ; preds = %9
  %27 = load ptr, ptr %3, align 8
  %28 = getelementptr inbounds %struct.MinHeap, ptr %27, i32 0, i32 0
  %29 = load i32, ptr %5, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [256 x i32], ptr %28, i64 0, i64 %30
  %32 = load ptr, ptr %3, align 8
  %33 = getelementptr inbounds %struct.MinHeap, ptr %32, i32 0, i32 0
  %34 = load i32, ptr %4, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [256 x i32], ptr %33, i64 0, i64 %35
  call void @heapSwap(ptr noundef %31, ptr noundef %36)
  %37 = load i32, ptr %5, align 4
  store i32 %37, ptr %4, align 4
  br label %39

38:                                               ; preds = %9
  br label %40

39:                                               ; preds = %26
  br label %6, !llvm.loop !6

40:                                               ; preds = %38, %6
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @siftDown(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  br label %8

8:                                                ; preds = %84, %2
  %9 = load i32, ptr %4, align 4
  %10 = mul nsw i32 2, %9
  %11 = add nsw i32 %10, 1
  %12 = load ptr, ptr %3, align 8
  %13 = getelementptr inbounds %struct.MinHeap, ptr %12, i32 0, i32 1
  %14 = load i32, ptr %13, align 4
  %15 = icmp slt i32 %11, %14
  br i1 %15, label %16, label %85

16:                                               ; preds = %8
  %17 = load i32, ptr %4, align 4
  store i32 %17, ptr %5, align 4
  %18 = load i32, ptr %4, align 4
  %19 = mul nsw i32 2, %18
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %6, align 4
  %21 = load i32, ptr %4, align 4
  %22 = mul nsw i32 2, %21
  %23 = add nsw i32 %22, 2
  store i32 %23, ptr %7, align 4
  %24 = load i32, ptr %6, align 4
  %25 = load ptr, ptr %3, align 8
  %26 = getelementptr inbounds %struct.MinHeap, ptr %25, i32 0, i32 1
  %27 = load i32, ptr %26, align 4
  %28 = icmp slt i32 %24, %27
  br i1 %28, label %29, label %45

29:                                               ; preds = %16
  %30 = load ptr, ptr %3, align 8
  %31 = getelementptr inbounds %struct.MinHeap, ptr %30, i32 0, i32 0
  %32 = load i32, ptr %6, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [256 x i32], ptr %31, i64 0, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = load ptr, ptr %3, align 8
  %37 = getelementptr inbounds %struct.MinHeap, ptr %36, i32 0, i32 0
  %38 = load i32, ptr %5, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [256 x i32], ptr %37, i64 0, i64 %39
  %41 = load i32, ptr %40, align 4
  %42 = icmp slt i32 %35, %41
  br i1 %42, label %43, label %45

43:                                               ; preds = %29
  %44 = load i32, ptr %6, align 4
  store i32 %44, ptr %5, align 4
  br label %45

45:                                               ; preds = %43, %29, %16
  %46 = load i32, ptr %7, align 4
  %47 = load ptr, ptr %3, align 8
  %48 = getelementptr inbounds %struct.MinHeap, ptr %47, i32 0, i32 1
  %49 = load i32, ptr %48, align 4
  %50 = icmp slt i32 %46, %49
  br i1 %50, label %51, label %67

51:                                               ; preds = %45
  %52 = load ptr, ptr %3, align 8
  %53 = getelementptr inbounds %struct.MinHeap, ptr %52, i32 0, i32 0
  %54 = load i32, ptr %7, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [256 x i32], ptr %53, i64 0, i64 %55
  %57 = load i32, ptr %56, align 4
  %58 = load ptr, ptr %3, align 8
  %59 = getelementptr inbounds %struct.MinHeap, ptr %58, i32 0, i32 0
  %60 = load i32, ptr %5, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [256 x i32], ptr %59, i64 0, i64 %61
  %63 = load i32, ptr %62, align 4
  %64 = icmp slt i32 %57, %63
  br i1 %64, label %65, label %67

65:                                               ; preds = %51
  %66 = load i32, ptr %7, align 4
  store i32 %66, ptr %5, align 4
  br label %67

67:                                               ; preds = %65, %51, %45
  %68 = load i32, ptr %5, align 4
  %69 = load i32, ptr %4, align 4
  %70 = icmp ne i32 %68, %69
  br i1 %70, label %71, label %83

71:                                               ; preds = %67
  %72 = load ptr, ptr %3, align 8
  %73 = getelementptr inbounds %struct.MinHeap, ptr %72, i32 0, i32 0
  %74 = load i32, ptr %4, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds [256 x i32], ptr %73, i64 0, i64 %75
  %77 = load ptr, ptr %3, align 8
  %78 = getelementptr inbounds %struct.MinHeap, ptr %77, i32 0, i32 0
  %79 = load i32, ptr %5, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds [256 x i32], ptr %78, i64 0, i64 %80
  call void @heapSwap(ptr noundef %76, ptr noundef %81)
  %82 = load i32, ptr %5, align 4
  store i32 %82, ptr %4, align 4
  br label %84

83:                                               ; preds = %67
  br label %85

84:                                               ; preds = %71
  br label %8, !llvm.loop !8

85:                                               ; preds = %83, %8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @heapInsert(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.MinHeap, ptr %6, i32 0, i32 0
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.MinHeap, ptr %8, i32 0, i32 1
  %10 = load i32, ptr %9, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [256 x i32], ptr %7, i64 0, i64 %11
  store i32 %5, ptr %12, align 4
  %13 = load ptr, ptr %3, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.MinHeap, ptr %14, i32 0, i32 1
  %16 = load i32, ptr %15, align 4
  call void @siftUp(ptr noundef %13, i32 noundef %16)
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.MinHeap, ptr %17, i32 0, i32 1
  %19 = load i32, ptr %18, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %18, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @heapExtractMin(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.MinHeap, ptr %4, i32 0, i32 0
  %6 = getelementptr inbounds [256 x i32], ptr %5, i64 0, i64 0
  %7 = load i32, ptr %6, align 4
  store i32 %7, ptr %3, align 4
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %struct.MinHeap, ptr %8, i32 0, i32 1
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, -1
  store i32 %11, ptr %9, align 4
  %12 = load ptr, ptr %2, align 8
  %13 = getelementptr inbounds %struct.MinHeap, ptr %12, i32 0, i32 0
  %14 = load ptr, ptr %2, align 8
  %15 = getelementptr inbounds %struct.MinHeap, ptr %14, i32 0, i32 1
  %16 = load i32, ptr %15, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [256 x i32], ptr %13, i64 0, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = load ptr, ptr %2, align 8
  %21 = getelementptr inbounds %struct.MinHeap, ptr %20, i32 0, i32 0
  %22 = getelementptr inbounds [256 x i32], ptr %21, i64 0, i64 0
  store i32 %19, ptr %22, align 4
  %23 = load ptr, ptr %2, align 8
  call void @siftDown(ptr noundef %23, i32 noundef 0)
  %24 = load i32, ptr %3, align 4
  ret i32 %24
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @heapPeek(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.MinHeap, ptr %3, i32 0, i32 0
  %5 = getelementptr inbounds [256 x i32], ptr %4, i64 0, i64 0
  %6 = load i32, ptr %5, align 4
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @heapSort(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
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
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %19 = load i32, ptr %4, align 4
  %20 = sdiv i32 %19, 2
  %21 = sub nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %22

22:                                               ; preds = %98, %2
  %23 = load i32, ptr %5, align 4
  %24 = icmp sge i32 %23, 0
  br i1 %24, label %25, label %101

25:                                               ; preds = %22
  %26 = load i32, ptr %5, align 4
  store i32 %26, ptr %6, align 4
  br label %27

27:                                               ; preds = %25, %96
  %28 = load i32, ptr %6, align 4
  store i32 %28, ptr %7, align 4
  %29 = load i32, ptr %6, align 4
  %30 = mul nsw i32 2, %29
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %8, align 4
  %32 = load i32, ptr %6, align 4
  %33 = mul nsw i32 2, %32
  %34 = add nsw i32 %33, 2
  store i32 %34, ptr %9, align 4
  %35 = load i32, ptr %8, align 4
  %36 = load i32, ptr %4, align 4
  %37 = icmp slt i32 %35, %36
  br i1 %37, label %38, label %52

38:                                               ; preds = %27
  %39 = load ptr, ptr %3, align 8
  %40 = load i32, ptr %8, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds i32, ptr %39, i64 %41
  %43 = load i32, ptr %42, align 4
  %44 = load ptr, ptr %3, align 8
  %45 = load i32, ptr %7, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds i32, ptr %44, i64 %46
  %48 = load i32, ptr %47, align 4
  %49 = icmp sgt i32 %43, %48
  br i1 %49, label %50, label %52

50:                                               ; preds = %38
  %51 = load i32, ptr %8, align 4
  store i32 %51, ptr %7, align 4
  br label %52

52:                                               ; preds = %50, %38, %27
  %53 = load i32, ptr %9, align 4
  %54 = load i32, ptr %4, align 4
  %55 = icmp slt i32 %53, %54
  br i1 %55, label %56, label %70

56:                                               ; preds = %52
  %57 = load ptr, ptr %3, align 8
  %58 = load i32, ptr %9, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds i32, ptr %57, i64 %59
  %61 = load i32, ptr %60, align 4
  %62 = load ptr, ptr %3, align 8
  %63 = load i32, ptr %7, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds i32, ptr %62, i64 %64
  %66 = load i32, ptr %65, align 4
  %67 = icmp sgt i32 %61, %66
  br i1 %67, label %68, label %70

68:                                               ; preds = %56
  %69 = load i32, ptr %9, align 4
  store i32 %69, ptr %7, align 4
  br label %70

70:                                               ; preds = %68, %56, %52
  %71 = load i32, ptr %7, align 4
  %72 = load i32, ptr %6, align 4
  %73 = icmp ne i32 %71, %72
  br i1 %73, label %74, label %95

74:                                               ; preds = %70
  %75 = load ptr, ptr %3, align 8
  %76 = load i32, ptr %6, align 4
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds i32, ptr %75, i64 %77
  %79 = load i32, ptr %78, align 4
  store i32 %79, ptr %10, align 4
  %80 = load ptr, ptr %3, align 8
  %81 = load i32, ptr %7, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds i32, ptr %80, i64 %82
  %84 = load i32, ptr %83, align 4
  %85 = load ptr, ptr %3, align 8
  %86 = load i32, ptr %6, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds i32, ptr %85, i64 %87
  store i32 %84, ptr %88, align 4
  %89 = load i32, ptr %10, align 4
  %90 = load ptr, ptr %3, align 8
  %91 = load i32, ptr %7, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds i32, ptr %90, i64 %92
  store i32 %89, ptr %93, align 4
  %94 = load i32, ptr %7, align 4
  store i32 %94, ptr %6, align 4
  br label %96

95:                                               ; preds = %70
  br label %97

96:                                               ; preds = %74
  br label %27

97:                                               ; preds = %95
  br label %98

98:                                               ; preds = %97
  %99 = load i32, ptr %5, align 4
  %100 = add nsw i32 %99, -1
  store i32 %100, ptr %5, align 4
  br label %22, !llvm.loop !9

101:                                              ; preds = %22
  %102 = load i32, ptr %4, align 4
  %103 = sub nsw i32 %102, 1
  store i32 %103, ptr %11, align 4
  br label %104

104:                                              ; preds = %195, %101
  %105 = load i32, ptr %11, align 4
  %106 = icmp sgt i32 %105, 0
  br i1 %106, label %107, label %198

107:                                              ; preds = %104
  %108 = load ptr, ptr %3, align 8
  %109 = getelementptr inbounds i32, ptr %108, i64 0
  %110 = load i32, ptr %109, align 4
  store i32 %110, ptr %12, align 4
  %111 = load ptr, ptr %3, align 8
  %112 = load i32, ptr %11, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds i32, ptr %111, i64 %113
  %115 = load i32, ptr %114, align 4
  %116 = load ptr, ptr %3, align 8
  %117 = getelementptr inbounds i32, ptr %116, i64 0
  store i32 %115, ptr %117, align 4
  %118 = load i32, ptr %12, align 4
  %119 = load ptr, ptr %3, align 8
  %120 = load i32, ptr %11, align 4
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds i32, ptr %119, i64 %121
  store i32 %118, ptr %122, align 4
  store i32 0, ptr %13, align 4
  %123 = load i32, ptr %11, align 4
  store i32 %123, ptr %14, align 4
  br label %124

124:                                              ; preds = %107, %193
  %125 = load i32, ptr %13, align 4
  store i32 %125, ptr %15, align 4
  %126 = load i32, ptr %13, align 4
  %127 = mul nsw i32 2, %126
  %128 = add nsw i32 %127, 1
  store i32 %128, ptr %16, align 4
  %129 = load i32, ptr %13, align 4
  %130 = mul nsw i32 2, %129
  %131 = add nsw i32 %130, 2
  store i32 %131, ptr %17, align 4
  %132 = load i32, ptr %16, align 4
  %133 = load i32, ptr %14, align 4
  %134 = icmp slt i32 %132, %133
  br i1 %134, label %135, label %149

135:                                              ; preds = %124
  %136 = load ptr, ptr %3, align 8
  %137 = load i32, ptr %16, align 4
  %138 = sext i32 %137 to i64
  %139 = getelementptr inbounds i32, ptr %136, i64 %138
  %140 = load i32, ptr %139, align 4
  %141 = load ptr, ptr %3, align 8
  %142 = load i32, ptr %15, align 4
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds i32, ptr %141, i64 %143
  %145 = load i32, ptr %144, align 4
  %146 = icmp sgt i32 %140, %145
  br i1 %146, label %147, label %149

147:                                              ; preds = %135
  %148 = load i32, ptr %16, align 4
  store i32 %148, ptr %15, align 4
  br label %149

149:                                              ; preds = %147, %135, %124
  %150 = load i32, ptr %17, align 4
  %151 = load i32, ptr %14, align 4
  %152 = icmp slt i32 %150, %151
  br i1 %152, label %153, label %167

153:                                              ; preds = %149
  %154 = load ptr, ptr %3, align 8
  %155 = load i32, ptr %17, align 4
  %156 = sext i32 %155 to i64
  %157 = getelementptr inbounds i32, ptr %154, i64 %156
  %158 = load i32, ptr %157, align 4
  %159 = load ptr, ptr %3, align 8
  %160 = load i32, ptr %15, align 4
  %161 = sext i32 %160 to i64
  %162 = getelementptr inbounds i32, ptr %159, i64 %161
  %163 = load i32, ptr %162, align 4
  %164 = icmp sgt i32 %158, %163
  br i1 %164, label %165, label %167

165:                                              ; preds = %153
  %166 = load i32, ptr %17, align 4
  store i32 %166, ptr %15, align 4
  br label %167

167:                                              ; preds = %165, %153, %149
  %168 = load i32, ptr %15, align 4
  %169 = load i32, ptr %13, align 4
  %170 = icmp ne i32 %168, %169
  br i1 %170, label %171, label %192

171:                                              ; preds = %167
  %172 = load ptr, ptr %3, align 8
  %173 = load i32, ptr %13, align 4
  %174 = sext i32 %173 to i64
  %175 = getelementptr inbounds i32, ptr %172, i64 %174
  %176 = load i32, ptr %175, align 4
  store i32 %176, ptr %18, align 4
  %177 = load ptr, ptr %3, align 8
  %178 = load i32, ptr %15, align 4
  %179 = sext i32 %178 to i64
  %180 = getelementptr inbounds i32, ptr %177, i64 %179
  %181 = load i32, ptr %180, align 4
  %182 = load ptr, ptr %3, align 8
  %183 = load i32, ptr %13, align 4
  %184 = sext i32 %183 to i64
  %185 = getelementptr inbounds i32, ptr %182, i64 %184
  store i32 %181, ptr %185, align 4
  %186 = load i32, ptr %18, align 4
  %187 = load ptr, ptr %3, align 8
  %188 = load i32, ptr %15, align 4
  %189 = sext i32 %188 to i64
  %190 = getelementptr inbounds i32, ptr %187, i64 %189
  store i32 %186, ptr %190, align 4
  %191 = load i32, ptr %15, align 4
  store i32 %191, ptr %13, align 4
  br label %193

192:                                              ; preds = %167
  br label %194

193:                                              ; preds = %171
  br label %124

194:                                              ; preds = %192
  br label %195

195:                                              ; preds = %194
  %196 = load i32, ptr %11, align 4
  %197 = add nsw i32 %196, -1
  store i32 %197, ptr %11, align 4
  br label %104, !llvm.loop !10

198:                                              ; preds = %104
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.MinHeap, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca [80 x i32], align 16
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @heapInit(ptr noundef %2)
  call void @srand(i32 noundef 99) #3
  store i32 0, ptr %3, align 4
  br label %11

11:                                               ; preds = %17, %0
  %12 = load i32, ptr %3, align 4
  %13 = icmp slt i32 %12, 100
  br i1 %13, label %14, label %20

14:                                               ; preds = %11
  %15 = call i32 @rand() #3
  %16 = srem i32 %15, 1000
  call void @heapInsert(ptr noundef %2, i32 noundef %16)
  br label %17

17:                                               ; preds = %14
  %18 = load i32, ptr %3, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %3, align 4
  br label %11, !llvm.loop !11

20:                                               ; preds = %11
  %21 = getelementptr inbounds %struct.MinHeap, ptr %2, i32 0, i32 1
  %22 = load i32, ptr %21, align 4
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %22)
  %24 = call i32 @heapPeek(ptr noundef %2)
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %24)
  store i32 -1, ptr %4, align 4
  store i32 1, ptr %5, align 4
  br label %26

26:                                               ; preds = %36, %20
  %27 = getelementptr inbounds %struct.MinHeap, ptr %2, i32 0, i32 1
  %28 = load i32, ptr %27, align 4
  %29 = icmp sgt i32 %28, 0
  br i1 %29, label %30, label %38

30:                                               ; preds = %26
  %31 = call i32 @heapExtractMin(ptr noundef %2)
  store i32 %31, ptr %6, align 4
  %32 = load i32, ptr %6, align 4
  %33 = load i32, ptr %4, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %36

35:                                               ; preds = %30
  store i32 0, ptr %5, align 4
  br label %36

36:                                               ; preds = %35, %30
  %37 = load i32, ptr %6, align 4
  store i32 %37, ptr %4, align 4
  br label %26, !llvm.loop !12

38:                                               ; preds = %26
  %39 = load i32, ptr %5, align 4
  %40 = icmp ne i32 %39, 0
  %41 = zext i1 %40 to i64
  %42 = select i1 %40, ptr @.str.3, ptr @.str.4
  %43 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, ptr noundef %42)
  store i32 0, ptr %8, align 4
  br label %44

44:                                               ; preds = %53, %38
  %45 = load i32, ptr %8, align 4
  %46 = icmp slt i32 %45, 80
  br i1 %46, label %47, label %56

47:                                               ; preds = %44
  %48 = call i32 @rand() #3
  %49 = srem i32 %48, 500
  %50 = load i32, ptr %8, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [80 x i32], ptr %7, i64 0, i64 %51
  store i32 %49, ptr %52, align 4
  br label %53

53:                                               ; preds = %47
  %54 = load i32, ptr %8, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %8, align 4
  br label %44, !llvm.loop !13

56:                                               ; preds = %44
  %57 = getelementptr inbounds [80 x i32], ptr %7, i64 0, i64 0
  call void @heapSort(ptr noundef %57, i32 noundef 80)
  store i32 1, ptr %9, align 4
  store i32 1, ptr %10, align 4
  br label %58

58:                                               ; preds = %74, %56
  %59 = load i32, ptr %10, align 4
  %60 = icmp slt i32 %59, 80
  br i1 %60, label %61, label %77

61:                                               ; preds = %58
  %62 = load i32, ptr %10, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [80 x i32], ptr %7, i64 0, i64 %63
  %65 = load i32, ptr %64, align 4
  %66 = load i32, ptr %10, align 4
  %67 = sub nsw i32 %66, 1
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [80 x i32], ptr %7, i64 0, i64 %68
  %70 = load i32, ptr %69, align 4
  %71 = icmp slt i32 %65, %70
  br i1 %71, label %72, label %73

72:                                               ; preds = %61
  store i32 0, ptr %9, align 4
  br label %77

73:                                               ; preds = %61
  br label %74

74:                                               ; preds = %73
  %75 = load i32, ptr %10, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, ptr %10, align 4
  br label %58, !llvm.loop !14

77:                                               ; preds = %72, %58
  %78 = load i32, ptr %9, align 4
  %79 = icmp ne i32 %78, 0
  %80 = zext i1 %79 to i64
  %81 = select i1 %79, ptr @.str.6, ptr @.str.7
  %82 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %81)
  ret i32 0
}

; Function Attrs: nounwind
declare void @srand(i32 noundef) #1

; Function Attrs: nounwind
declare i32 @rand() #1

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

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
