; ModuleID = '/home/karthik/llvm-project/pass/test/test16.c'
source_filename = "/home/karthik/llvm-project/pass/test/test16.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@V = dso_local global i32 0, align 4
@adj = dso_local global [50 x [50 x i32]] zeroinitializer, align 16
@visited = dso_local global [50 x i32] zeroinitializer, align 16
@dist = dso_local global [50 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [32 x i8] c"BFS from 0: %d nodes reachable\0A\00", align 1
@.str.1 = private unnamed_addr constant [32 x i8] c"DFS from 0: %d nodes reachable\0A\00", align 1
@.str.2 = private unnamed_addr constant [33 x i8] c"Shortest distances from node 0:\0A\00", align 1
@.str.3 = private unnamed_addr constant [13 x i8] c"  to %d: %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [26 x i8] c"Connected components: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @initGraph(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %5 = load i32, ptr %2, align 4
  store i32 %5, ptr @V, align 4
  store i32 0, ptr %3, align 4
  br label %6

6:                                                ; preds = %26, %1
  %7 = load i32, ptr %3, align 4
  %8 = load i32, ptr @V, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %29

10:                                               ; preds = %6
  store i32 0, ptr %4, align 4
  br label %11

11:                                               ; preds = %22, %10
  %12 = load i32, ptr %4, align 4
  %13 = load i32, ptr @V, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %25

15:                                               ; preds = %11
  %16 = load i32, ptr %3, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %17
  %19 = load i32, ptr %4, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [50 x i32], ptr %18, i64 0, i64 %20
  store i32 0, ptr %21, align 4
  br label %22

22:                                               ; preds = %15
  %23 = load i32, ptr %4, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %4, align 4
  br label %11, !llvm.loop !6

25:                                               ; preds = %11
  br label %26

26:                                               ; preds = %25
  %27 = load i32, ptr %3, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %3, align 4
  br label %6, !llvm.loop !8

29:                                               ; preds = %6
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @addEdge(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %6, align 4
  %8 = load i32, ptr %4, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %9
  %11 = load i32, ptr %5, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [50 x i32], ptr %10, i64 0, i64 %12
  store i32 %7, ptr %13, align 4
  %14 = load i32, ptr %6, align 4
  %15 = load i32, ptr %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %16
  %18 = load i32, ptr %4, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [50 x i32], ptr %17, i64 0, i64 %19
  store i32 %14, ptr %20, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @bfs(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca [50 x i32], align 16
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %4, align 4
  store i32 0, ptr %5, align 4
  call void @llvm.memset.p0.i64(ptr align 16 @visited, i8 0, i64 200, i1 false)
  %9 = load i32, ptr %2, align 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [50 x i32], ptr @visited, i64 0, i64 %10
  store i32 1, ptr %11, align 4
  %12 = load i32, ptr %2, align 4
  %13 = load i32, ptr %5, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, ptr %5, align 4
  %15 = sext i32 %13 to i64
  %16 = getelementptr inbounds [50 x i32], ptr %3, i64 0, i64 %15
  store i32 %12, ptr %16, align 4
  store i32 0, ptr %6, align 4
  br label %17

17:                                               ; preds = %61, %1
  %18 = load i32, ptr %4, align 4
  %19 = load i32, ptr %5, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %62

21:                                               ; preds = %17
  %22 = load i32, ptr %4, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, ptr %4, align 4
  %24 = sext i32 %22 to i64
  %25 = getelementptr inbounds [50 x i32], ptr %3, i64 0, i64 %24
  %26 = load i32, ptr %25, align 4
  store i32 %26, ptr %7, align 4
  %27 = load i32, ptr %6, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %6, align 4
  store i32 0, ptr %8, align 4
  br label %29

29:                                               ; preds = %58, %21
  %30 = load i32, ptr %8, align 4
  %31 = load i32, ptr @V, align 4
  %32 = icmp slt i32 %30, %31
  br i1 %32, label %33, label %61

33:                                               ; preds = %29
  %34 = load i32, ptr %7, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %35
  %37 = load i32, ptr %8, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [50 x i32], ptr %36, i64 0, i64 %38
  %40 = load i32, ptr %39, align 4
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %57

42:                                               ; preds = %33
  %43 = load i32, ptr %8, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [50 x i32], ptr @visited, i64 0, i64 %44
  %46 = load i32, ptr %45, align 4
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %57, label %48

48:                                               ; preds = %42
  %49 = load i32, ptr %8, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [50 x i32], ptr @visited, i64 0, i64 %50
  store i32 1, ptr %51, align 4
  %52 = load i32, ptr %8, align 4
  %53 = load i32, ptr %5, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %5, align 4
  %55 = sext i32 %53 to i64
  %56 = getelementptr inbounds [50 x i32], ptr %3, i64 0, i64 %55
  store i32 %52, ptr %56, align 4
  br label %57

57:                                               ; preds = %48, %42, %33
  br label %58

58:                                               ; preds = %57
  %59 = load i32, ptr %8, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %8, align 4
  br label %29, !llvm.loop !9

61:                                               ; preds = %29
  br label %17, !llvm.loop !10

62:                                               ; preds = %17
  %63 = load i32, ptr %6, align 4
  ret i32 %63
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @dfsUtil(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %6 = load i32, ptr %3, align 4
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [50 x i32], ptr @visited, i64 0, i64 %7
  store i32 1, ptr %8, align 4
  %9 = load ptr, ptr %4, align 8
  %10 = load i32, ptr %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %9, align 4
  store i32 0, ptr %5, align 4
  br label %12

12:                                               ; preds = %35, %2
  %13 = load i32, ptr %5, align 4
  %14 = load i32, ptr @V, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %38

16:                                               ; preds = %12
  %17 = load i32, ptr %3, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %18
  %20 = load i32, ptr %5, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [50 x i32], ptr %19, i64 0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %34

25:                                               ; preds = %16
  %26 = load i32, ptr %5, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [50 x i32], ptr @visited, i64 0, i64 %27
  %29 = load i32, ptr %28, align 4
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %34, label %31

31:                                               ; preds = %25
  %32 = load i32, ptr %5, align 4
  %33 = load ptr, ptr %4, align 8
  call void @dfsUtil(i32 noundef %32, ptr noundef %33)
  br label %34

34:                                               ; preds = %31, %25, %16
  br label %35

35:                                               ; preds = %34
  %36 = load i32, ptr %5, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %5, align 4
  br label %12, !llvm.loop !11

38:                                               ; preds = %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @dfs(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  call void @llvm.memset.p0.i64(ptr align 16 @visited, i8 0, i64 200, i1 false)
  store i32 0, ptr %3, align 4
  %4 = load i32, ptr %2, align 4
  call void @dfsUtil(i32 noundef %4, ptr noundef %3)
  %5 = load i32, ptr %3, align 4
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @dijkstra(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca [50 x i32], align 16
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %10 = getelementptr inbounds [50 x i32], ptr %3, i64 0, i64 0
  call void @llvm.memset.p0.i64(ptr align 16 %10, i8 0, i64 200, i1 false)
  store i32 0, ptr %4, align 4
  br label %11

11:                                               ; preds = %19, %1
  %12 = load i32, ptr %4, align 4
  %13 = load i32, ptr @V, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %22

15:                                               ; preds = %11
  %16 = load i32, ptr %4, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %17
  store i32 999999, ptr %18, align 4
  br label %19

19:                                               ; preds = %15
  %20 = load i32, ptr %4, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %4, align 4
  br label %11, !llvm.loop !12

22:                                               ; preds = %11
  %23 = load i32, ptr %2, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %24
  store i32 0, ptr %25, align 4
  store i32 0, ptr %5, align 4
  br label %26

26:                                               ; preds = %124, %22
  %27 = load i32, ptr %5, align 4
  %28 = load i32, ptr @V, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %127

30:                                               ; preds = %26
  store i32 -1, ptr %6, align 4
  store i32 999999, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %31

31:                                               ; preds = %55, %30
  %32 = load i32, ptr %8, align 4
  %33 = load i32, ptr @V, align 4
  %34 = icmp slt i32 %32, %33
  br i1 %34, label %35, label %58

35:                                               ; preds = %31
  %36 = load i32, ptr %8, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [50 x i32], ptr %3, i64 0, i64 %37
  %39 = load i32, ptr %38, align 4
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %54, label %41

41:                                               ; preds = %35
  %42 = load i32, ptr %8, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %43
  %45 = load i32, ptr %44, align 4
  %46 = load i32, ptr %7, align 4
  %47 = icmp slt i32 %45, %46
  br i1 %47, label %48, label %54

48:                                               ; preds = %41
  %49 = load i32, ptr %8, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %50
  %52 = load i32, ptr %51, align 4
  store i32 %52, ptr %7, align 4
  %53 = load i32, ptr %8, align 4
  store i32 %53, ptr %6, align 4
  br label %54

54:                                               ; preds = %48, %41, %35
  br label %55

55:                                               ; preds = %54
  %56 = load i32, ptr %8, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, ptr %8, align 4
  br label %31, !llvm.loop !13

58:                                               ; preds = %31
  %59 = load i32, ptr %6, align 4
  %60 = icmp eq i32 %59, -1
  br i1 %60, label %61, label %62

61:                                               ; preds = %58
  br label %127

62:                                               ; preds = %58
  %63 = load i32, ptr %6, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [50 x i32], ptr %3, i64 0, i64 %64
  store i32 1, ptr %65, align 4
  store i32 0, ptr %9, align 4
  br label %66

66:                                               ; preds = %120, %62
  %67 = load i32, ptr %9, align 4
  %68 = load i32, ptr @V, align 4
  %69 = icmp slt i32 %67, %68
  br i1 %69, label %70, label %123

70:                                               ; preds = %66
  %71 = load i32, ptr %6, align 4
  %72 = sext i32 %71 to i64
  %73 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %72
  %74 = load i32, ptr %9, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds [50 x i32], ptr %73, i64 0, i64 %75
  %77 = load i32, ptr %76, align 4
  %78 = icmp ne i32 %77, 0
  br i1 %78, label %79, label %119

79:                                               ; preds = %70
  %80 = load i32, ptr %9, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds [50 x i32], ptr %3, i64 0, i64 %81
  %83 = load i32, ptr %82, align 4
  %84 = icmp ne i32 %83, 0
  br i1 %84, label %119, label %85

85:                                               ; preds = %79
  %86 = load i32, ptr %6, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %87
  %89 = load i32, ptr %88, align 4
  %90 = load i32, ptr %6, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %91
  %93 = load i32, ptr %9, align 4
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds [50 x i32], ptr %92, i64 0, i64 %94
  %96 = load i32, ptr %95, align 4
  %97 = add nsw i32 %89, %96
  %98 = load i32, ptr %9, align 4
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %99
  %101 = load i32, ptr %100, align 4
  %102 = icmp slt i32 %97, %101
  br i1 %102, label %103, label %119

103:                                              ; preds = %85
  %104 = load i32, ptr %6, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %105
  %107 = load i32, ptr %106, align 4
  %108 = load i32, ptr %6, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds [50 x [50 x i32]], ptr @adj, i64 0, i64 %109
  %111 = load i32, ptr %9, align 4
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds [50 x i32], ptr %110, i64 0, i64 %112
  %114 = load i32, ptr %113, align 4
  %115 = add nsw i32 %107, %114
  %116 = load i32, ptr %9, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %117
  store i32 %115, ptr %118, align 4
  br label %119

119:                                              ; preds = %103, %85, %79, %70
  br label %120

120:                                              ; preds = %119
  %121 = load i32, ptr %9, align 4
  %122 = add nsw i32 %121, 1
  store i32 %122, ptr %9, align 4
  br label %66, !llvm.loop !14

123:                                              ; preds = %66
  br label %124

124:                                              ; preds = %123
  %125 = load i32, ptr %5, align 4
  %126 = add nsw i32 %125, 1
  store i32 %126, ptr %5, align 4
  br label %26, !llvm.loop !15

127:                                              ; preds = %61, %26
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @countComponents() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.memset.p0.i64(ptr align 16 @visited, i8 0, i64 200, i1 false)
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %4

4:                                                ; preds = %19, %0
  %5 = load i32, ptr %2, align 4
  %6 = load i32, ptr @V, align 4
  %7 = icmp slt i32 %5, %6
  br i1 %7, label %8, label %22

8:                                                ; preds = %4
  %9 = load i32, ptr %2, align 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [50 x i32], ptr @visited, i64 0, i64 %10
  %12 = load i32, ptr %11, align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %18, label %14

14:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  %15 = load i32, ptr %2, align 4
  call void @dfsUtil(i32 noundef %15, ptr noundef %3)
  %16 = load i32, ptr %1, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %1, align 4
  br label %18

18:                                               ; preds = %14, %8
  br label %19

19:                                               ; preds = %18
  %20 = load i32, ptr %2, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %2, align 4
  br label %4, !llvm.loop !16

22:                                               ; preds = %4
  %23 = load i32, ptr %1, align 4
  ret i32 %23
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @initGraph(i32 noundef 40)
  call void @srand(i32 noundef 42) #4
  store i32 0, ptr %2, align 4
  br label %6

6:                                                ; preds = %24, %0
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %7, 120
  br i1 %8, label %9, label %27

9:                                                ; preds = %6
  %10 = call i32 @rand() #4
  %11 = srem i32 %10, 40
  store i32 %11, ptr %3, align 4
  %12 = call i32 @rand() #4
  %13 = srem i32 %12, 40
  store i32 %13, ptr %4, align 4
  %14 = load i32, ptr %3, align 4
  %15 = load i32, ptr %4, align 4
  %16 = icmp ne i32 %14, %15
  br i1 %16, label %17, label %23

17:                                               ; preds = %9
  %18 = load i32, ptr %3, align 4
  %19 = load i32, ptr %4, align 4
  %20 = call i32 @rand() #4
  %21 = srem i32 %20, 20
  %22 = add nsw i32 %21, 1
  call void @addEdge(i32 noundef %18, i32 noundef %19, i32 noundef %22)
  br label %23

23:                                               ; preds = %17, %9
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %2, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %2, align 4
  br label %6, !llvm.loop !17

27:                                               ; preds = %6
  %28 = call i32 @bfs(i32 noundef 0)
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %28)
  %30 = call i32 @dfs(i32 noundef 0)
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %30)
  call void @dijkstra(i32 noundef 0)
  %32 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  store i32 0, ptr %5, align 4
  br label %33

33:                                               ; preds = %52, %27
  %34 = load i32, ptr %5, align 4
  %35 = icmp slt i32 %34, 10
  br i1 %35, label %36, label %55

36:                                               ; preds = %33
  %37 = load i32, ptr %5, align 4
  %38 = load i32, ptr %5, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %39
  %41 = load i32, ptr %40, align 4
  %42 = icmp eq i32 %41, 999999
  br i1 %42, label %43, label %44

43:                                               ; preds = %36
  br label %49

44:                                               ; preds = %36
  %45 = load i32, ptr %5, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [50 x i32], ptr @dist, i64 0, i64 %46
  %48 = load i32, ptr %47, align 4
  br label %49

49:                                               ; preds = %44, %43
  %50 = phi i32 [ -1, %43 ], [ %48, %44 ]
  %51 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %37, i32 noundef %50)
  br label %52

52:                                               ; preds = %49
  %53 = load i32, ptr %5, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %5, align 4
  br label %33, !llvm.loop !18

55:                                               ; preds = %33
  %56 = call i32 @countComponents()
  %57 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %56)
  ret i32 0
}

; Function Attrs: nounwind
declare void @srand(i32 noundef) #2

; Function Attrs: nounwind
declare i32 @rand() #2

declare i32 @printf(ptr noundef, ...) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

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
