; ModuleID = '/home/karthik/llvm-project/pass/test/test12.c'
source_filename = "/home/karthik/llvm-project/pass/test/test12.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, ptr }

@.str = private unnamed_addr constant [7 x i8] c"%d -> \00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"NULL\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"List 1 length: %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [19 x i8] c"List 2 length: %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [34 x i8] c"List 1 after deletes, length: %d\0A\00", align 1
@.str.5 = private unnamed_addr constant [21 x i8] c"Cycle in list 1? %s\0A\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"YES\00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"NO\00", align 1
@.str.8 = private unnamed_addr constant [19 x i8] c"Merged length: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @createNode(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  %4 = call noalias ptr @malloc(i64 noundef 16) #4
  store ptr %4, ptr %3, align 8
  %5 = load i32, ptr %2, align 4
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.Node, ptr %6, i32 0, i32 0
  store i32 %5, ptr %7, align 8
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.Node, ptr %8, i32 0, i32 1
  store ptr null, ptr %9, align 8
  %10 = load ptr, ptr %3, align 8
  ret ptr %10
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @insertFront(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call ptr @createNode(i32 noundef %6)
  store ptr %7, ptr %5, align 8
  %8 = load ptr, ptr %3, align 8
  %9 = load ptr, ptr %8, align 8
  %10 = load ptr, ptr %5, align 8
  %11 = getelementptr inbounds %struct.Node, ptr %10, i32 0, i32 1
  store ptr %9, ptr %11, align 8
  %12 = load ptr, ptr %5, align 8
  %13 = load ptr, ptr %3, align 8
  store ptr %12, ptr %13, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @insertEnd(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %4, align 4
  %8 = call ptr @createNode(i32 noundef %7)
  store ptr %8, ptr %5, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = load ptr, ptr %9, align 8
  %11 = icmp eq ptr %10, null
  br i1 %11, label %12, label %15

12:                                               ; preds = %2
  %13 = load ptr, ptr %5, align 8
  %14 = load ptr, ptr %3, align 8
  store ptr %13, ptr %14, align 8
  br label %31

15:                                               ; preds = %2
  %16 = load ptr, ptr %3, align 8
  %17 = load ptr, ptr %16, align 8
  store ptr %17, ptr %6, align 8
  br label %18

18:                                               ; preds = %23, %15
  %19 = load ptr, ptr %6, align 8
  %20 = getelementptr inbounds %struct.Node, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  %22 = icmp ne ptr %21, null
  br i1 %22, label %23, label %27

23:                                               ; preds = %18
  %24 = load ptr, ptr %6, align 8
  %25 = getelementptr inbounds %struct.Node, ptr %24, i32 0, i32 1
  %26 = load ptr, ptr %25, align 8
  store ptr %26, ptr %6, align 8
  br label %18, !llvm.loop !6

27:                                               ; preds = %18
  %28 = load ptr, ptr %5, align 8
  %29 = load ptr, ptr %6, align 8
  %30 = getelementptr inbounds %struct.Node, ptr %29, i32 0, i32 1
  store ptr %28, ptr %30, align 8
  br label %31

31:                                               ; preds = %27, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @deleteNode(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 8
  %8 = load ptr, ptr %7, align 8
  store ptr %8, ptr %5, align 8
  store ptr null, ptr %6, align 8
  br label %9

9:                                                ; preds = %20, %2
  %10 = load ptr, ptr %5, align 8
  %11 = icmp ne ptr %10, null
  br i1 %11, label %12, label %18

12:                                               ; preds = %9
  %13 = load ptr, ptr %5, align 8
  %14 = getelementptr inbounds %struct.Node, ptr %13, i32 0, i32 0
  %15 = load i32, ptr %14, align 8
  %16 = load i32, ptr %4, align 4
  %17 = icmp ne i32 %15, %16
  br label %18

18:                                               ; preds = %12, %9
  %19 = phi i1 [ false, %9 ], [ %17, %12 ]
  br i1 %19, label %20, label %25

20:                                               ; preds = %18
  %21 = load ptr, ptr %5, align 8
  store ptr %21, ptr %6, align 8
  %22 = load ptr, ptr %5, align 8
  %23 = getelementptr inbounds %struct.Node, ptr %22, i32 0, i32 1
  %24 = load ptr, ptr %23, align 8
  store ptr %24, ptr %5, align 8
  br label %9, !llvm.loop !8

25:                                               ; preds = %18
  %26 = load ptr, ptr %5, align 8
  %27 = icmp ne ptr %26, null
  br i1 %27, label %29, label %28

28:                                               ; preds = %25
  br label %45

29:                                               ; preds = %25
  %30 = load ptr, ptr %6, align 8
  %31 = icmp ne ptr %30, null
  br i1 %31, label %37, label %32

32:                                               ; preds = %29
  %33 = load ptr, ptr %5, align 8
  %34 = getelementptr inbounds %struct.Node, ptr %33, i32 0, i32 1
  %35 = load ptr, ptr %34, align 8
  %36 = load ptr, ptr %3, align 8
  store ptr %35, ptr %36, align 8
  br label %43

37:                                               ; preds = %29
  %38 = load ptr, ptr %5, align 8
  %39 = getelementptr inbounds %struct.Node, ptr %38, i32 0, i32 1
  %40 = load ptr, ptr %39, align 8
  %41 = load ptr, ptr %6, align 8
  %42 = getelementptr inbounds %struct.Node, ptr %41, i32 0, i32 1
  store ptr %40, ptr %42, align 8
  br label %43

43:                                               ; preds = %37, %32
  %44 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %44) #5
  br label %45

45:                                               ; preds = %43, %28
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @reverseList(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  store ptr null, ptr %3, align 8
  %6 = load ptr, ptr %2, align 8
  store ptr %6, ptr %4, align 8
  store ptr null, ptr %5, align 8
  br label %7

7:                                                ; preds = %10, %1
  %8 = load ptr, ptr %4, align 8
  %9 = icmp ne ptr %8, null
  br i1 %9, label %10, label %19

10:                                               ; preds = %7
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds %struct.Node, ptr %11, i32 0, i32 1
  %13 = load ptr, ptr %12, align 8
  store ptr %13, ptr %5, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds %struct.Node, ptr %15, i32 0, i32 1
  store ptr %14, ptr %16, align 8
  %17 = load ptr, ptr %4, align 8
  store ptr %17, ptr %3, align 8
  %18 = load ptr, ptr %5, align 8
  store ptr %18, ptr %4, align 8
  br label %7, !llvm.loop !9

19:                                               ; preds = %7
  %20 = load ptr, ptr %3, align 8
  ret ptr %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @hasCycle(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  store ptr %6, ptr %4, align 8
  %7 = load ptr, ptr %3, align 8
  store ptr %7, ptr %5, align 8
  br label %8

8:                                                ; preds = %31, %1
  %9 = load ptr, ptr %5, align 8
  %10 = icmp ne ptr %9, null
  br i1 %10, label %11, label %16

11:                                               ; preds = %8
  %12 = load ptr, ptr %5, align 8
  %13 = getelementptr inbounds %struct.Node, ptr %12, i32 0, i32 1
  %14 = load ptr, ptr %13, align 8
  %15 = icmp ne ptr %14, null
  br label %16

16:                                               ; preds = %11, %8
  %17 = phi i1 [ false, %8 ], [ %15, %11 ]
  br i1 %17, label %18, label %32

18:                                               ; preds = %16
  %19 = load ptr, ptr %4, align 8
  %20 = getelementptr inbounds %struct.Node, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  store ptr %21, ptr %4, align 8
  %22 = load ptr, ptr %5, align 8
  %23 = getelementptr inbounds %struct.Node, ptr %22, i32 0, i32 1
  %24 = load ptr, ptr %23, align 8
  %25 = getelementptr inbounds %struct.Node, ptr %24, i32 0, i32 1
  %26 = load ptr, ptr %25, align 8
  store ptr %26, ptr %5, align 8
  %27 = load ptr, ptr %4, align 8
  %28 = load ptr, ptr %5, align 8
  %29 = icmp eq ptr %27, %28
  br i1 %29, label %30, label %31

30:                                               ; preds = %18
  store i32 1, ptr %2, align 4
  br label %33

31:                                               ; preds = %18
  br label %8, !llvm.loop !10

32:                                               ; preds = %16
  store i32 0, ptr %2, align 4
  br label %33

33:                                               ; preds = %32, %30
  %34 = load i32, ptr %2, align 4
  ret i32 %34
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @mergeSorted(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca %struct.Node, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %7 = getelementptr inbounds %struct.Node, ptr %5, i32 0, i32 1
  store ptr null, ptr %7, align 8
  store ptr %5, ptr %6, align 8
  br label %8

8:                                                ; preds = %38, %2
  %9 = load ptr, ptr %3, align 8
  %10 = icmp ne ptr %9, null
  br i1 %10, label %11, label %14

11:                                               ; preds = %8
  %12 = load ptr, ptr %4, align 8
  %13 = icmp ne ptr %12, null
  br label %14

14:                                               ; preds = %11, %8
  %15 = phi i1 [ false, %8 ], [ %13, %11 ]
  br i1 %15, label %16, label %42

16:                                               ; preds = %14
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.Node, ptr %17, i32 0, i32 0
  %19 = load i32, ptr %18, align 8
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds %struct.Node, ptr %20, i32 0, i32 0
  %22 = load i32, ptr %21, align 8
  %23 = icmp sle i32 %19, %22
  br i1 %23, label %24, label %31

24:                                               ; preds = %16
  %25 = load ptr, ptr %3, align 8
  %26 = load ptr, ptr %6, align 8
  %27 = getelementptr inbounds %struct.Node, ptr %26, i32 0, i32 1
  store ptr %25, ptr %27, align 8
  %28 = load ptr, ptr %3, align 8
  %29 = getelementptr inbounds %struct.Node, ptr %28, i32 0, i32 1
  %30 = load ptr, ptr %29, align 8
  store ptr %30, ptr %3, align 8
  br label %38

31:                                               ; preds = %16
  %32 = load ptr, ptr %4, align 8
  %33 = load ptr, ptr %6, align 8
  %34 = getelementptr inbounds %struct.Node, ptr %33, i32 0, i32 1
  store ptr %32, ptr %34, align 8
  %35 = load ptr, ptr %4, align 8
  %36 = getelementptr inbounds %struct.Node, ptr %35, i32 0, i32 1
  %37 = load ptr, ptr %36, align 8
  store ptr %37, ptr %4, align 8
  br label %38

38:                                               ; preds = %31, %24
  %39 = load ptr, ptr %6, align 8
  %40 = getelementptr inbounds %struct.Node, ptr %39, i32 0, i32 1
  %41 = load ptr, ptr %40, align 8
  store ptr %41, ptr %6, align 8
  br label %8, !llvm.loop !11

42:                                               ; preds = %14
  %43 = load ptr, ptr %3, align 8
  %44 = icmp ne ptr %43, null
  br i1 %44, label %45, label %47

45:                                               ; preds = %42
  %46 = load ptr, ptr %3, align 8
  br label %49

47:                                               ; preds = %42
  %48 = load ptr, ptr %4, align 8
  br label %49

49:                                               ; preds = %47, %45
  %50 = phi ptr [ %46, %45 ], [ %48, %47 ]
  %51 = load ptr, ptr %6, align 8
  %52 = getelementptr inbounds %struct.Node, ptr %51, i32 0, i32 1
  store ptr %50, ptr %52, align 8
  %53 = getelementptr inbounds %struct.Node, ptr %5, i32 0, i32 1
  %54 = load ptr, ptr %53, align 8
  ret ptr %54
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @listLength(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %4

4:                                                ; preds = %7, %1
  %5 = load ptr, ptr %2, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %7, label %13

7:                                                ; preds = %4
  %8 = load i32, ptr %3, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %3, align 4
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.Node, ptr %10, i32 0, i32 1
  %12 = load ptr, ptr %11, align 8
  store ptr %12, ptr %2, align 8
  br label %4, !llvm.loop !12

13:                                               ; preds = %4
  %14 = load i32, ptr %3, align 4
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @printList(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  br label %3

3:                                                ; preds = %6, %1
  %4 = load ptr, ptr %2, align 8
  %5 = icmp ne ptr %4, null
  br i1 %5, label %6, label %14

6:                                                ; preds = %3
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.Node, ptr %7, i32 0, i32 0
  %9 = load i32, ptr %8, align 8
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %9)
  %11 = load ptr, ptr %2, align 8
  %12 = getelementptr inbounds %struct.Node, ptr %11, i32 0, i32 1
  %13 = load ptr, ptr %12, align 8
  store ptr %13, ptr %2, align 8
  br label %3, !llvm.loop !13

14:                                               ; preds = %3
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  ret void
}

declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @freeList(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  br label %4

4:                                                ; preds = %7, %1
  %5 = load ptr, ptr %2, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %7, label %13

7:                                                ; preds = %4
  %8 = load ptr, ptr %2, align 8
  store ptr %8, ptr %3, align 8
  %9 = load ptr, ptr %2, align 8
  %10 = getelementptr inbounds %struct.Node, ptr %9, i32 0, i32 1
  %11 = load ptr, ptr %10, align 8
  store ptr %11, ptr %2, align 8
  %12 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %12) #5
  br label %4, !llvm.loop !14

13:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  store ptr null, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %7

7:                                                ; preds = %13, %0
  %8 = load i32, ptr %3, align 4
  %9 = icmp slt i32 %8, 20
  br i1 %9, label %10, label %16

10:                                               ; preds = %7
  %11 = load i32, ptr %3, align 4
  %12 = mul nsw i32 %11, 2
  call void @insertEnd(ptr noundef %2, i32 noundef %12)
  br label %13

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %3, align 4
  br label %7, !llvm.loop !15

16:                                               ; preds = %7
  store ptr null, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %17

17:                                               ; preds = %24, %16
  %18 = load i32, ptr %5, align 4
  %19 = icmp slt i32 %18, 15
  br i1 %19, label %20, label %27

20:                                               ; preds = %17
  %21 = load i32, ptr %5, align 4
  %22 = mul nsw i32 %21, 3
  %23 = add nsw i32 %22, 1
  call void @insertEnd(ptr noundef %4, i32 noundef %23)
  br label %24

24:                                               ; preds = %20
  %25 = load i32, ptr %5, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %5, align 4
  br label %17, !llvm.loop !16

27:                                               ; preds = %17
  %28 = load ptr, ptr %2, align 8
  %29 = call i32 @listLength(ptr noundef %28)
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %29)
  %31 = load ptr, ptr %4, align 8
  %32 = call i32 @listLength(ptr noundef %31)
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %32)
  %34 = load ptr, ptr %2, align 8
  %35 = call ptr @reverseList(ptr noundef %34)
  store ptr %35, ptr %2, align 8
  %36 = load ptr, ptr %2, align 8
  %37 = call ptr @reverseList(ptr noundef %36)
  store ptr %37, ptr %2, align 8
  call void @deleteNode(ptr noundef %2, i32 noundef 0)
  call void @deleteNode(ptr noundef %2, i32 noundef 10)
  call void @deleteNode(ptr noundef %2, i32 noundef 38)
  %38 = load ptr, ptr %2, align 8
  %39 = call i32 @listLength(ptr noundef %38)
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %39)
  %41 = load ptr, ptr %2, align 8
  %42 = call i32 @hasCycle(ptr noundef %41)
  %43 = icmp ne i32 %42, 0
  %44 = zext i1 %43 to i64
  %45 = select i1 %43, ptr @.str.6, ptr @.str.7
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %45)
  %47 = load ptr, ptr %2, align 8
  %48 = load ptr, ptr %4, align 8
  %49 = call ptr @mergeSorted(ptr noundef %47, ptr noundef %48)
  store ptr %49, ptr %6, align 8
  %50 = load ptr, ptr %6, align 8
  %51 = call i32 @listLength(ptr noundef %50)
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, i32 noundef %51)
  %53 = load ptr, ptr %6, align 8
  call void @freeList(ptr noundef %53)
  ret i32 0
}

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
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
