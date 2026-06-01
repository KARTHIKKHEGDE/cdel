; ModuleID = '/home/karthik/llvm-project/pass/test/test9.c'
source_filename = "/home/karthik/llvm-project/pass/test/test9.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Student = type { i32, [50 x i8], float }

@.str = private unnamed_addr constant [33 x i8] c"\0A===== STUDENT MANAGEMENT =====\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"1. Add Student\0A\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"2. Display Students\0A\00", align 1
@.str.3 = private unnamed_addr constant [19 x i8] c"3. Search Student\0A\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c"4. Exit\0A\00", align 1
@.str.5 = private unnamed_addr constant [15 x i8] c"Enter Choice: \00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.7 = private unnamed_addr constant [16 x i8] c"Enter Roll No: \00", align 1
@.str.8 = private unnamed_addr constant [13 x i8] c"Enter Name: \00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.10 = private unnamed_addr constant [14 x i8] c"Enter Marks: \00", align 1
@.str.11 = private unnamed_addr constant [3 x i8] c"%f\00", align 1
@.str.12 = private unnamed_addr constant [29 x i8] c"Student Added Successfully!\0A\00", align 1
@.str.13 = private unnamed_addr constant [18 x i8] c"\0AStudent Records\0A\00", align 1
@.str.14 = private unnamed_addr constant [10 x i8] c"\0ARoll: %d\00", align 1
@.str.15 = private unnamed_addr constant [10 x i8] c"\0AName: %s\00", align 1
@.str.16 = private unnamed_addr constant [14 x i8] c"\0AMarks: %.2f\0A\00", align 1
@.str.17 = private unnamed_addr constant [20 x i8] c"Enter Roll Number: \00", align 1
@.str.18 = private unnamed_addr constant [15 x i8] c"\0AStudent Found\00", align 1
@.str.19 = private unnamed_addr constant [19 x i8] c"Student Not Found\0A\00", align 1
@.str.20 = private unnamed_addr constant [16 x i8] c"Invalid Choice\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [100 x %struct.Student], align 16
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %8

8:                                                ; preds = %0, %113
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %12 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  %15 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.6, ptr noundef %4)
  %16 = load i32, ptr %4, align 4
  switch i32 %16, label %111 [
    i32 1, label %17
    i32 2, label %40
    i32 3, label %70
    i32 4, label %110
  ]

17:                                               ; preds = %8
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %20
  %22 = getelementptr inbounds %struct.Student, ptr %21, i32 0, i32 0
  %23 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.6, ptr noundef %22)
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  %25 = load i32, ptr %3, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %26
  %28 = getelementptr inbounds %struct.Student, ptr %27, i32 0, i32 1
  %29 = getelementptr inbounds [50 x i8], ptr %28, i64 0, i64 0
  %30 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.9, ptr noundef %29)
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.10)
  %32 = load i32, ptr %3, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %33
  %35 = getelementptr inbounds %struct.Student, ptr %34, i32 0, i32 2
  %36 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.11, ptr noundef %35)
  %37 = load i32, ptr %3, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %3, align 4
  %39 = call i32 (ptr, ...) @printf(ptr noundef @.str.12)
  br label %113

40:                                               ; preds = %8
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str.13)
  store i32 0, ptr %6, align 4
  br label %42

42:                                               ; preds = %66, %40
  %43 = load i32, ptr %6, align 4
  %44 = load i32, ptr %3, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %69

46:                                               ; preds = %42
  %47 = load i32, ptr %6, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %48
  %50 = getelementptr inbounds %struct.Student, ptr %49, i32 0, i32 0
  %51 = load i32, ptr %50, align 4
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.14, i32 noundef %51)
  %53 = load i32, ptr %6, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %54
  %56 = getelementptr inbounds %struct.Student, ptr %55, i32 0, i32 1
  %57 = getelementptr inbounds [50 x i8], ptr %56, i64 0, i64 0
  %58 = call i32 (ptr, ...) @printf(ptr noundef @.str.15, ptr noundef %57)
  %59 = load i32, ptr %6, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %60
  %62 = getelementptr inbounds %struct.Student, ptr %61, i32 0, i32 2
  %63 = load float, ptr %62, align 4
  %64 = fpext float %63 to double
  %65 = call i32 (ptr, ...) @printf(ptr noundef @.str.16, double noundef %64)
  br label %66

66:                                               ; preds = %46
  %67 = load i32, ptr %6, align 4
  %68 = add nsw i32 %67, 1
  store i32 %68, ptr %6, align 4
  br label %42, !llvm.loop !6

69:                                               ; preds = %42
  br label %113

70:                                               ; preds = %8
  %71 = call i32 (ptr, ...) @printf(ptr noundef @.str.17)
  %72 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str.6, ptr noundef %5)
  store i32 0, ptr %7, align 4
  store i32 0, ptr %6, align 4
  br label %73

73:                                               ; preds = %101, %70
  %74 = load i32, ptr %6, align 4
  %75 = load i32, ptr %3, align 4
  %76 = icmp slt i32 %74, %75
  br i1 %76, label %77, label %104

77:                                               ; preds = %73
  %78 = load i32, ptr %6, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %79
  %81 = getelementptr inbounds %struct.Student, ptr %80, i32 0, i32 0
  %82 = load i32, ptr %81, align 4
  %83 = load i32, ptr %5, align 4
  %84 = icmp eq i32 %82, %83
  br i1 %84, label %85, label %100

85:                                               ; preds = %77
  %86 = call i32 (ptr, ...) @printf(ptr noundef @.str.18)
  %87 = load i32, ptr %6, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %88
  %90 = getelementptr inbounds %struct.Student, ptr %89, i32 0, i32 1
  %91 = getelementptr inbounds [50 x i8], ptr %90, i64 0, i64 0
  %92 = call i32 (ptr, ...) @printf(ptr noundef @.str.15, ptr noundef %91)
  %93 = load i32, ptr %6, align 4
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds [100 x %struct.Student], ptr %2, i64 0, i64 %94
  %96 = getelementptr inbounds %struct.Student, ptr %95, i32 0, i32 2
  %97 = load float, ptr %96, align 4
  %98 = fpext float %97 to double
  %99 = call i32 (ptr, ...) @printf(ptr noundef @.str.16, double noundef %98)
  store i32 1, ptr %7, align 4
  br label %104

100:                                              ; preds = %77
  br label %101

101:                                              ; preds = %100
  %102 = load i32, ptr %6, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, ptr %6, align 4
  br label %73, !llvm.loop !8

104:                                              ; preds = %85, %73
  %105 = load i32, ptr %7, align 4
  %106 = icmp ne i32 %105, 0
  br i1 %106, label %109, label %107

107:                                              ; preds = %104
  %108 = call i32 (ptr, ...) @printf(ptr noundef @.str.19)
  br label %109

109:                                              ; preds = %107, %104
  br label %113

110:                                              ; preds = %8
  ret i32 0

111:                                              ; preds = %8
  %112 = call i32 (ptr, ...) @printf(ptr noundef @.str.20)
  br label %113

113:                                              ; preds = %111, %109, %69, %17
  br label %8
}

declare i32 @printf(ptr noundef, ...) #1

declare i32 @__isoc99_scanf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
