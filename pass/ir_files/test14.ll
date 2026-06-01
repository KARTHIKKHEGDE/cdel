; ModuleID = '/home/karthik/llvm-project/pass/test/test14.c'
source_filename = "/home/karthik/llvm-project/pass/test/test14.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.BSTNode = type { i32, ptr, ptr, i32 }

@.str = private unnamed_addr constant [19 x i8] c"Inorder count: %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"Node count:    %d\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"Height:        %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [19 x i8] c"Balanced:      %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"YES\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"NO\00", align 1
@.str.6 = private unnamed_addr constant [30 x i8] c"Found %d / 200 searched keys\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @createBSTNode(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  %4 = call noalias ptr @malloc(i64 noundef 32) #4
  store ptr %4, ptr %3, align 8
  %5 = load i32, ptr %2, align 4
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.BSTNode, ptr %6, i32 0, i32 0
  store i32 %5, ptr %7, align 8
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.BSTNode, ptr %8, i32 0, i32 2
  store ptr null, ptr %9, align 8
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.BSTNode, ptr %10, i32 0, i32 1
  store ptr null, ptr %11, align 8
  %12 = load ptr, ptr %3, align 8
  %13 = getelementptr inbounds %struct.BSTNode, ptr %12, i32 0, i32 3
  store i32 1, ptr %13, align 8
  %14 = load ptr, ptr %3, align 8
  ret ptr %14
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @height(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = icmp ne ptr %3, null
  br i1 %4, label %5, label %9

5:                                                ; preds = %1
  %6 = load ptr, ptr %2, align 8
  %7 = getelementptr inbounds %struct.BSTNode, ptr %6, i32 0, i32 3
  %8 = load i32, ptr %7, align 8
  br label %10

9:                                                ; preds = %1
  br label %10

10:                                               ; preds = %9, %5
  %11 = phi i32 [ %8, %5 ], [ 0, %9 ]
  ret i32 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @maxVal(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp sgt i32 %5, %6
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = load i32, ptr %3, align 4
  br label %12

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4
  br label %12

12:                                               ; preds = %10, %8
  %13 = phi i32 [ %9, %8 ], [ %11, %10 ]
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @getBalance(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = icmp ne ptr %3, null
  br i1 %4, label %5, label %15

5:                                                ; preds = %1
  %6 = load ptr, ptr %2, align 8
  %7 = getelementptr inbounds %struct.BSTNode, ptr %6, i32 0, i32 1
  %8 = load ptr, ptr %7, align 8
  %9 = call i32 @height(ptr noundef %8)
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.BSTNode, ptr %10, i32 0, i32 2
  %12 = load ptr, ptr %11, align 8
  %13 = call i32 @height(ptr noundef %12)
  %14 = sub nsw i32 %9, %13
  br label %16

15:                                               ; preds = %1
  br label %16

16:                                               ; preds = %15, %5
  %17 = phi i32 [ %14, %5 ], [ 0, %15 ]
  ret i32 %17
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @rightRotate(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.BSTNode, ptr %5, i32 0, i32 1
  %7 = load ptr, ptr %6, align 8
  store ptr %7, ptr %3, align 8
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.BSTNode, ptr %8, i32 0, i32 2
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %4, align 8
  %11 = load ptr, ptr %2, align 8
  %12 = load ptr, ptr %3, align 8
  %13 = getelementptr inbounds %struct.BSTNode, ptr %12, i32 0, i32 2
  store ptr %11, ptr %13, align 8
  %14 = load ptr, ptr %4, align 8
  %15 = load ptr, ptr %2, align 8
  %16 = getelementptr inbounds %struct.BSTNode, ptr %15, i32 0, i32 1
  store ptr %14, ptr %16, align 8
  %17 = load ptr, ptr %2, align 8
  %18 = getelementptr inbounds %struct.BSTNode, ptr %17, i32 0, i32 1
  %19 = load ptr, ptr %18, align 8
  %20 = call i32 @height(ptr noundef %19)
  %21 = load ptr, ptr %2, align 8
  %22 = getelementptr inbounds %struct.BSTNode, ptr %21, i32 0, i32 2
  %23 = load ptr, ptr %22, align 8
  %24 = call i32 @height(ptr noundef %23)
  %25 = call i32 @maxVal(i32 noundef %20, i32 noundef %24)
  %26 = add nsw i32 %25, 1
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds %struct.BSTNode, ptr %27, i32 0, i32 3
  store i32 %26, ptr %28, align 8
  %29 = load ptr, ptr %3, align 8
  %30 = getelementptr inbounds %struct.BSTNode, ptr %29, i32 0, i32 1
  %31 = load ptr, ptr %30, align 8
  %32 = call i32 @height(ptr noundef %31)
  %33 = load ptr, ptr %3, align 8
  %34 = getelementptr inbounds %struct.BSTNode, ptr %33, i32 0, i32 2
  %35 = load ptr, ptr %34, align 8
  %36 = call i32 @height(ptr noundef %35)
  %37 = call i32 @maxVal(i32 noundef %32, i32 noundef %36)
  %38 = add nsw i32 %37, 1
  %39 = load ptr, ptr %3, align 8
  %40 = getelementptr inbounds %struct.BSTNode, ptr %39, i32 0, i32 3
  store i32 %38, ptr %40, align 8
  %41 = load ptr, ptr %3, align 8
  ret ptr %41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @leftRotate(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.BSTNode, ptr %5, i32 0, i32 2
  %7 = load ptr, ptr %6, align 8
  store ptr %7, ptr %3, align 8
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.BSTNode, ptr %8, i32 0, i32 1
  %10 = load ptr, ptr %9, align 8
  store ptr %10, ptr %4, align 8
  %11 = load ptr, ptr %2, align 8
  %12 = load ptr, ptr %3, align 8
  %13 = getelementptr inbounds %struct.BSTNode, ptr %12, i32 0, i32 1
  store ptr %11, ptr %13, align 8
  %14 = load ptr, ptr %4, align 8
  %15 = load ptr, ptr %2, align 8
  %16 = getelementptr inbounds %struct.BSTNode, ptr %15, i32 0, i32 2
  store ptr %14, ptr %16, align 8
  %17 = load ptr, ptr %2, align 8
  %18 = getelementptr inbounds %struct.BSTNode, ptr %17, i32 0, i32 1
  %19 = load ptr, ptr %18, align 8
  %20 = call i32 @height(ptr noundef %19)
  %21 = load ptr, ptr %2, align 8
  %22 = getelementptr inbounds %struct.BSTNode, ptr %21, i32 0, i32 2
  %23 = load ptr, ptr %22, align 8
  %24 = call i32 @height(ptr noundef %23)
  %25 = call i32 @maxVal(i32 noundef %20, i32 noundef %24)
  %26 = add nsw i32 %25, 1
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds %struct.BSTNode, ptr %27, i32 0, i32 3
  store i32 %26, ptr %28, align 8
  %29 = load ptr, ptr %3, align 8
  %30 = getelementptr inbounds %struct.BSTNode, ptr %29, i32 0, i32 1
  %31 = load ptr, ptr %30, align 8
  %32 = call i32 @height(ptr noundef %31)
  %33 = load ptr, ptr %3, align 8
  %34 = getelementptr inbounds %struct.BSTNode, ptr %33, i32 0, i32 2
  %35 = load ptr, ptr %34, align 8
  %36 = call i32 @height(ptr noundef %35)
  %37 = call i32 @maxVal(i32 noundef %32, i32 noundef %36)
  %38 = add nsw i32 %37, 1
  %39 = load ptr, ptr %3, align 8
  %40 = getelementptr inbounds %struct.BSTNode, ptr %39, i32 0, i32 3
  store i32 %38, ptr %40, align 8
  %41 = load ptr, ptr %3, align 8
  ret ptr %41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @avlInsert(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  %7 = load ptr, ptr %4, align 8
  %8 = icmp ne ptr %7, null
  br i1 %8, label %12, label %9

9:                                                ; preds = %2
  %10 = load i32, ptr %5, align 4
  %11 = call ptr @createBSTNode(i32 noundef %10)
  store ptr %11, ptr %3, align 8
  br label %127

12:                                               ; preds = %2
  %13 = load i32, ptr %5, align 4
  %14 = load ptr, ptr %4, align 8
  %15 = getelementptr inbounds %struct.BSTNode, ptr %14, i32 0, i32 0
  %16 = load i32, ptr %15, align 8
  %17 = icmp slt i32 %13, %16
  br i1 %17, label %18, label %26

18:                                               ; preds = %12
  %19 = load ptr, ptr %4, align 8
  %20 = getelementptr inbounds %struct.BSTNode, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  %22 = load i32, ptr %5, align 4
  %23 = call ptr @avlInsert(ptr noundef %21, i32 noundef %22)
  %24 = load ptr, ptr %4, align 8
  %25 = getelementptr inbounds %struct.BSTNode, ptr %24, i32 0, i32 1
  store ptr %23, ptr %25, align 8
  br label %43

26:                                               ; preds = %12
  %27 = load i32, ptr %5, align 4
  %28 = load ptr, ptr %4, align 8
  %29 = getelementptr inbounds %struct.BSTNode, ptr %28, i32 0, i32 0
  %30 = load i32, ptr %29, align 8
  %31 = icmp sgt i32 %27, %30
  br i1 %31, label %32, label %40

32:                                               ; preds = %26
  %33 = load ptr, ptr %4, align 8
  %34 = getelementptr inbounds %struct.BSTNode, ptr %33, i32 0, i32 2
  %35 = load ptr, ptr %34, align 8
  %36 = load i32, ptr %5, align 4
  %37 = call ptr @avlInsert(ptr noundef %35, i32 noundef %36)
  %38 = load ptr, ptr %4, align 8
  %39 = getelementptr inbounds %struct.BSTNode, ptr %38, i32 0, i32 2
  store ptr %37, ptr %39, align 8
  br label %42

40:                                               ; preds = %26
  %41 = load ptr, ptr %4, align 8
  store ptr %41, ptr %3, align 8
  br label %127

42:                                               ; preds = %32
  br label %43

43:                                               ; preds = %42, %18
  %44 = load ptr, ptr %4, align 8
  %45 = getelementptr inbounds %struct.BSTNode, ptr %44, i32 0, i32 1
  %46 = load ptr, ptr %45, align 8
  %47 = call i32 @height(ptr noundef %46)
  %48 = load ptr, ptr %4, align 8
  %49 = getelementptr inbounds %struct.BSTNode, ptr %48, i32 0, i32 2
  %50 = load ptr, ptr %49, align 8
  %51 = call i32 @height(ptr noundef %50)
  %52 = call i32 @maxVal(i32 noundef %47, i32 noundef %51)
  %53 = add nsw i32 1, %52
  %54 = load ptr, ptr %4, align 8
  %55 = getelementptr inbounds %struct.BSTNode, ptr %54, i32 0, i32 3
  store i32 %53, ptr %55, align 8
  %56 = load ptr, ptr %4, align 8
  %57 = call i32 @getBalance(ptr noundef %56)
  store i32 %57, ptr %6, align 4
  %58 = load i32, ptr %6, align 4
  %59 = icmp sgt i32 %58, 1
  br i1 %59, label %60, label %71

60:                                               ; preds = %43
  %61 = load i32, ptr %5, align 4
  %62 = load ptr, ptr %4, align 8
  %63 = getelementptr inbounds %struct.BSTNode, ptr %62, i32 0, i32 1
  %64 = load ptr, ptr %63, align 8
  %65 = getelementptr inbounds %struct.BSTNode, ptr %64, i32 0, i32 0
  %66 = load i32, ptr %65, align 8
  %67 = icmp slt i32 %61, %66
  br i1 %67, label %68, label %71

68:                                               ; preds = %60
  %69 = load ptr, ptr %4, align 8
  %70 = call ptr @rightRotate(ptr noundef %69)
  store ptr %70, ptr %3, align 8
  br label %127

71:                                               ; preds = %60, %43
  %72 = load i32, ptr %6, align 4
  %73 = icmp slt i32 %72, -1
  br i1 %73, label %74, label %85

74:                                               ; preds = %71
  %75 = load i32, ptr %5, align 4
  %76 = load ptr, ptr %4, align 8
  %77 = getelementptr inbounds %struct.BSTNode, ptr %76, i32 0, i32 2
  %78 = load ptr, ptr %77, align 8
  %79 = getelementptr inbounds %struct.BSTNode, ptr %78, i32 0, i32 0
  %80 = load i32, ptr %79, align 8
  %81 = icmp sgt i32 %75, %80
  br i1 %81, label %82, label %85

82:                                               ; preds = %74
  %83 = load ptr, ptr %4, align 8
  %84 = call ptr @leftRotate(ptr noundef %83)
  store ptr %84, ptr %3, align 8
  br label %127

85:                                               ; preds = %74, %71
  %86 = load i32, ptr %6, align 4
  %87 = icmp sgt i32 %86, 1
  br i1 %87, label %88, label %105

88:                                               ; preds = %85
  %89 = load i32, ptr %5, align 4
  %90 = load ptr, ptr %4, align 8
  %91 = getelementptr inbounds %struct.BSTNode, ptr %90, i32 0, i32 1
  %92 = load ptr, ptr %91, align 8
  %93 = getelementptr inbounds %struct.BSTNode, ptr %92, i32 0, i32 0
  %94 = load i32, ptr %93, align 8
  %95 = icmp sgt i32 %89, %94
  br i1 %95, label %96, label %105

96:                                               ; preds = %88
  %97 = load ptr, ptr %4, align 8
  %98 = getelementptr inbounds %struct.BSTNode, ptr %97, i32 0, i32 1
  %99 = load ptr, ptr %98, align 8
  %100 = call ptr @leftRotate(ptr noundef %99)
  %101 = load ptr, ptr %4, align 8
  %102 = getelementptr inbounds %struct.BSTNode, ptr %101, i32 0, i32 1
  store ptr %100, ptr %102, align 8
  %103 = load ptr, ptr %4, align 8
  %104 = call ptr @rightRotate(ptr noundef %103)
  store ptr %104, ptr %3, align 8
  br label %127

105:                                              ; preds = %88, %85
  %106 = load i32, ptr %6, align 4
  %107 = icmp slt i32 %106, -1
  br i1 %107, label %108, label %125

108:                                              ; preds = %105
  %109 = load i32, ptr %5, align 4
  %110 = load ptr, ptr %4, align 8
  %111 = getelementptr inbounds %struct.BSTNode, ptr %110, i32 0, i32 2
  %112 = load ptr, ptr %111, align 8
  %113 = getelementptr inbounds %struct.BSTNode, ptr %112, i32 0, i32 0
  %114 = load i32, ptr %113, align 8
  %115 = icmp slt i32 %109, %114
  br i1 %115, label %116, label %125

116:                                              ; preds = %108
  %117 = load ptr, ptr %4, align 8
  %118 = getelementptr inbounds %struct.BSTNode, ptr %117, i32 0, i32 2
  %119 = load ptr, ptr %118, align 8
  %120 = call ptr @rightRotate(ptr noundef %119)
  %121 = load ptr, ptr %4, align 8
  %122 = getelementptr inbounds %struct.BSTNode, ptr %121, i32 0, i32 2
  store ptr %120, ptr %122, align 8
  %123 = load ptr, ptr %4, align 8
  %124 = call ptr @leftRotate(ptr noundef %123)
  store ptr %124, ptr %3, align 8
  br label %127

125:                                              ; preds = %108, %105
  %126 = load ptr, ptr %4, align 8
  store ptr %126, ptr %3, align 8
  br label %127

127:                                              ; preds = %125, %116, %96, %82, %68, %40, %9
  %128 = load ptr, ptr %3, align 8
  ret ptr %128
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @bstSearch(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  %6 = load ptr, ptr %4, align 8
  %7 = icmp ne ptr %6, null
  br i1 %7, label %8, label %14

8:                                                ; preds = %2
  %9 = load ptr, ptr %4, align 8
  %10 = getelementptr inbounds %struct.BSTNode, ptr %9, i32 0, i32 0
  %11 = load i32, ptr %10, align 8
  %12 = load i32, ptr %5, align 4
  %13 = icmp eq i32 %11, %12
  br i1 %13, label %14, label %16

14:                                               ; preds = %8, %2
  %15 = load ptr, ptr %4, align 8
  store ptr %15, ptr %3, align 8
  br label %34

16:                                               ; preds = %8
  %17 = load i32, ptr %5, align 4
  %18 = load ptr, ptr %4, align 8
  %19 = getelementptr inbounds %struct.BSTNode, ptr %18, i32 0, i32 0
  %20 = load i32, ptr %19, align 8
  %21 = icmp slt i32 %17, %20
  br i1 %21, label %22, label %28

22:                                               ; preds = %16
  %23 = load ptr, ptr %4, align 8
  %24 = getelementptr inbounds %struct.BSTNode, ptr %23, i32 0, i32 1
  %25 = load ptr, ptr %24, align 8
  %26 = load i32, ptr %5, align 4
  %27 = call ptr @bstSearch(ptr noundef %25, i32 noundef %26)
  store ptr %27, ptr %3, align 8
  br label %34

28:                                               ; preds = %16
  %29 = load ptr, ptr %4, align 8
  %30 = getelementptr inbounds %struct.BSTNode, ptr %29, i32 0, i32 2
  %31 = load ptr, ptr %30, align 8
  %32 = load i32, ptr %5, align 4
  %33 = call ptr @bstSearch(ptr noundef %31, i32 noundef %32)
  store ptr %33, ptr %3, align 8
  br label %34

34:                                               ; preds = %28, %22, %14
  %35 = load ptr, ptr %3, align 8
  ret ptr %35
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @inorder(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  br label %20

8:                                                ; preds = %2
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.BSTNode, ptr %9, i32 0, i32 1
  %11 = load ptr, ptr %10, align 8
  %12 = load ptr, ptr %4, align 8
  call void @inorder(ptr noundef %11, ptr noundef %12)
  %13 = load ptr, ptr %4, align 8
  %14 = load i32, ptr %13, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %13, align 4
  %16 = load ptr, ptr %3, align 8
  %17 = getelementptr inbounds %struct.BSTNode, ptr %16, i32 0, i32 2
  %18 = load ptr, ptr %17, align 8
  %19 = load ptr, ptr %4, align 8
  call void @inorder(ptr noundef %18, ptr noundef %19)
  br label %20

20:                                               ; preds = %8, %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @countNodes(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = icmp ne ptr %4, null
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  store i32 0, ptr %2, align 4
  br label %18

7:                                                ; preds = %1
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.BSTNode, ptr %8, i32 0, i32 1
  %10 = load ptr, ptr %9, align 8
  %11 = call i32 @countNodes(ptr noundef %10)
  %12 = add nsw i32 1, %11
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.BSTNode, ptr %13, i32 0, i32 2
  %15 = load ptr, ptr %14, align 8
  %16 = call i32 @countNodes(ptr noundef %15)
  %17 = add nsw i32 %12, %16
  store i32 %17, ptr %2, align 4
  br label %18

18:                                               ; preds = %7, %6
  %19 = load i32, ptr %2, align 4
  ret i32 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @isBalanced(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %8, label %7

7:                                                ; preds = %1
  store i32 1, ptr %2, align 4
  br label %32

8:                                                ; preds = %1
  %9 = load ptr, ptr %3, align 8
  %10 = call i32 @getBalance(ptr noundef %9)
  store i32 %10, ptr %4, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %11, -1
  br i1 %12, label %16, label %13

13:                                               ; preds = %8
  %14 = load i32, ptr %4, align 4
  %15 = icmp sgt i32 %14, 1
  br i1 %15, label %16, label %17

16:                                               ; preds = %13, %8
  store i32 0, ptr %2, align 4
  br label %32

17:                                               ; preds = %13
  %18 = load ptr, ptr %3, align 8
  %19 = getelementptr inbounds %struct.BSTNode, ptr %18, i32 0, i32 1
  %20 = load ptr, ptr %19, align 8
  %21 = call i32 @isBalanced(ptr noundef %20)
  %22 = icmp ne i32 %21, 0
  br i1 %22, label %23, label %29

23:                                               ; preds = %17
  %24 = load ptr, ptr %3, align 8
  %25 = getelementptr inbounds %struct.BSTNode, ptr %24, i32 0, i32 2
  %26 = load ptr, ptr %25, align 8
  %27 = call i32 @isBalanced(ptr noundef %26)
  %28 = icmp ne i32 %27, 0
  br label %29

29:                                               ; preds = %23, %17
  %30 = phi i1 [ false, %17 ], [ %28, %23 ]
  %31 = zext i1 %30 to i32
  store i32 %31, ptr %2, align 4
  br label %32

32:                                               ; preds = %29, %16, %7
  %33 = load i32, ptr %2, align 4
  ret i32 %33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @freeTree(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = icmp ne ptr %3, null
  br i1 %4, label %6, label %5

5:                                                ; preds = %1
  br label %14

6:                                                ; preds = %1
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.BSTNode, ptr %7, i32 0, i32 1
  %9 = load ptr, ptr %8, align 8
  call void @freeTree(ptr noundef %9)
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.BSTNode, ptr %10, i32 0, i32 2
  %12 = load ptr, ptr %11, align 8
  call void @freeTree(ptr noundef %12)
  %13 = load ptr, ptr %2, align 8
  call void @free(ptr noundef %13) #5
  br label %14

14:                                               ; preds = %6, %5
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store ptr null, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %7

7:                                                ; preds = %15, %0
  %8 = load i32, ptr %3, align 4
  %9 = icmp slt i32 %8, 100
  br i1 %9, label %10, label %18

10:                                               ; preds = %7
  %11 = load ptr, ptr %2, align 8
  %12 = call i32 @rand() #5
  %13 = srem i32 %12, 500
  %14 = call ptr @avlInsert(ptr noundef %11, i32 noundef %13)
  store ptr %14, ptr %2, align 8
  br label %15

15:                                               ; preds = %10
  %16 = load i32, ptr %3, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %3, align 4
  br label %7, !llvm.loop !6

18:                                               ; preds = %7
  store i32 0, ptr %4, align 4
  %19 = load ptr, ptr %2, align 8
  call void @inorder(ptr noundef %19, ptr noundef %4)
  %20 = load i32, ptr %4, align 4
  %21 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %20)
  %22 = load ptr, ptr %2, align 8
  %23 = call i32 @countNodes(ptr noundef %22)
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %23)
  %25 = load ptr, ptr %2, align 8
  %26 = call i32 @height(ptr noundef %25)
  %27 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %26)
  %28 = load ptr, ptr %2, align 8
  %29 = call i32 @isBalanced(ptr noundef %28)
  %30 = icmp ne i32 %29, 0
  %31 = zext i1 %30 to i64
  %32 = select i1 %30, ptr @.str.4, ptr @.str.5
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, ptr noundef %32)
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %34

34:                                               ; preds = %46, %18
  %35 = load i32, ptr %6, align 4
  %36 = icmp slt i32 %35, 200
  br i1 %36, label %37, label %49

37:                                               ; preds = %34
  %38 = load ptr, ptr %2, align 8
  %39 = load i32, ptr %6, align 4
  %40 = call ptr @bstSearch(ptr noundef %38, i32 noundef %39)
  %41 = icmp ne ptr %40, null
  br i1 %41, label %42, label %45

42:                                               ; preds = %37
  %43 = load i32, ptr %5, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %5, align 4
  br label %45

45:                                               ; preds = %42, %37
  br label %46

46:                                               ; preds = %45
  %47 = load i32, ptr %6, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %6, align 4
  br label %34, !llvm.loop !8

49:                                               ; preds = %34
  %50 = load i32, ptr %5, align 4
  %51 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %50)
  %52 = load ptr, ptr %2, align 8
  call void @freeTree(ptr noundef %52)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @rand() #2

declare i32 @printf(ptr noundef, ...) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind allocsize(0) }
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
