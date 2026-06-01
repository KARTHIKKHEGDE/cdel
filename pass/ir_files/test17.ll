; ModuleID = '/home/karthik/llvm-project/pass/test/test17.c'
source_filename = "/home/karthik/llvm-project/pass/test/test17.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [30 x i8] c"LCS(\22AGGTAB\22, \22GXTXAYB\22): %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"AGGTAB\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"GXTXAYB\00", align 1
@.str.3 = private unnamed_addr constant [41 x i8] c"Edit distance(\22sunday\22, \22saturday\22): %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [7 x i8] c"sunday\00", align 1
@.str.5 = private unnamed_addr constant [9 x i8] c"saturday\00", align 1
@__const.main.wt = private unnamed_addr constant [5 x i32] [i32 10, i32 20, i32 30, i32 40, i32 50], align 16
@__const.main.val = private unnamed_addr constant [5 x i32] [i32 60, i32 100, i32 120, i32 160, i32 200], align 16
@.str.6 = private unnamed_addr constant [27 x i8] c"Knapsack(capacity=80): %d\0A\00", align 1
@__const.main.coins = private unnamed_addr constant [4 x i32] [i32 1, i32 5, i32 10, i32 25], align 16
@.str.7 = private unnamed_addr constant [27 x i8] c"Coin change(63): %d coins\0A\00", align 1
@__const.main.arr = private unnamed_addr constant [15 x i32] [i32 10, i32 22, i32 9, i32 33, i32 21, i32 50, i32 41, i32 60, i32 80, i32 3, i32 15, i32 25, i32 35, i32 45, i32 55], align 16
@.str.8 = private unnamed_addr constant [16 x i8] c"LIS length: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @lcs(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %12 = load ptr, ptr %3, align 8
  %13 = call i64 @strlen(ptr noundef %12) #5
  %14 = trunc i64 %13 to i32
  store i32 %14, ptr %5, align 4
  %15 = load ptr, ptr %4, align 8
  %16 = call i64 @strlen(ptr noundef %15) #5
  %17 = trunc i64 %16 to i32
  store i32 %17, ptr %6, align 4
  %18 = load i32, ptr %5, align 4
  %19 = add nsw i32 %18, 1
  %20 = zext i32 %19 to i64
  %21 = load i32, ptr %6, align 4
  %22 = add nsw i32 %21, 1
  %23 = zext i32 %22 to i64
  %24 = call ptr @llvm.stacksave()
  store ptr %24, ptr %7, align 8
  %25 = mul nuw i64 %20, %23
  %26 = alloca i32, i64 %25, align 16
  store i64 %20, ptr %8, align 8
  store i64 %23, ptr %9, align 8
  store i32 0, ptr %10, align 4
  br label %27

27:                                               ; preds = %140, %2
  %28 = load i32, ptr %10, align 4
  %29 = load i32, ptr %5, align 4
  %30 = icmp sle i32 %28, %29
  br i1 %30, label %31, label %143

31:                                               ; preds = %27
  store i32 0, ptr %11, align 4
  br label %32

32:                                               ; preds = %136, %31
  %33 = load i32, ptr %11, align 4
  %34 = load i32, ptr %6, align 4
  %35 = icmp sle i32 %33, %34
  br i1 %35, label %36, label %139

36:                                               ; preds = %32
  %37 = load i32, ptr %10, align 4
  %38 = icmp eq i32 %37, 0
  br i1 %38, label %42, label %39

39:                                               ; preds = %36
  %40 = load i32, ptr %11, align 4
  %41 = icmp eq i32 %40, 0
  br i1 %41, label %42, label %50

42:                                               ; preds = %39, %36
  %43 = load i32, ptr %10, align 4
  %44 = sext i32 %43 to i64
  %45 = mul nsw i64 %44, %23
  %46 = getelementptr inbounds i32, ptr %26, i64 %45
  %47 = load i32, ptr %11, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds i32, ptr %46, i64 %48
  store i32 0, ptr %49, align 4
  br label %135

50:                                               ; preds = %39
  %51 = load ptr, ptr %3, align 8
  %52 = load i32, ptr %10, align 4
  %53 = sub nsw i32 %52, 1
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds i8, ptr %51, i64 %54
  %56 = load i8, ptr %55, align 1
  %57 = sext i8 %56 to i32
  %58 = load ptr, ptr %4, align 8
  %59 = load i32, ptr %11, align 4
  %60 = sub nsw i32 %59, 1
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds i8, ptr %58, i64 %61
  %63 = load i8, ptr %62, align 1
  %64 = sext i8 %63 to i32
  %65 = icmp eq i32 %57, %64
  br i1 %65, label %66, label %85

66:                                               ; preds = %50
  %67 = load i32, ptr %10, align 4
  %68 = sub nsw i32 %67, 1
  %69 = sext i32 %68 to i64
  %70 = mul nsw i64 %69, %23
  %71 = getelementptr inbounds i32, ptr %26, i64 %70
  %72 = load i32, ptr %11, align 4
  %73 = sub nsw i32 %72, 1
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i32, ptr %71, i64 %74
  %76 = load i32, ptr %75, align 4
  %77 = add nsw i32 %76, 1
  %78 = load i32, ptr %10, align 4
  %79 = sext i32 %78 to i64
  %80 = mul nsw i64 %79, %23
  %81 = getelementptr inbounds i32, ptr %26, i64 %80
  %82 = load i32, ptr %11, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i32, ptr %81, i64 %83
  store i32 %77, ptr %84, align 4
  br label %134

85:                                               ; preds = %50
  %86 = load i32, ptr %10, align 4
  %87 = sub nsw i32 %86, 1
  %88 = sext i32 %87 to i64
  %89 = mul nsw i64 %88, %23
  %90 = getelementptr inbounds i32, ptr %26, i64 %89
  %91 = load i32, ptr %11, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds i32, ptr %90, i64 %92
  %94 = load i32, ptr %93, align 4
  %95 = load i32, ptr %10, align 4
  %96 = sext i32 %95 to i64
  %97 = mul nsw i64 %96, %23
  %98 = getelementptr inbounds i32, ptr %26, i64 %97
  %99 = load i32, ptr %11, align 4
  %100 = sub nsw i32 %99, 1
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds i32, ptr %98, i64 %101
  %103 = load i32, ptr %102, align 4
  %104 = icmp sgt i32 %94, %103
  br i1 %104, label %105, label %115

105:                                              ; preds = %85
  %106 = load i32, ptr %10, align 4
  %107 = sub nsw i32 %106, 1
  %108 = sext i32 %107 to i64
  %109 = mul nsw i64 %108, %23
  %110 = getelementptr inbounds i32, ptr %26, i64 %109
  %111 = load i32, ptr %11, align 4
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds i32, ptr %110, i64 %112
  %114 = load i32, ptr %113, align 4
  br label %125

115:                                              ; preds = %85
  %116 = load i32, ptr %10, align 4
  %117 = sext i32 %116 to i64
  %118 = mul nsw i64 %117, %23
  %119 = getelementptr inbounds i32, ptr %26, i64 %118
  %120 = load i32, ptr %11, align 4
  %121 = sub nsw i32 %120, 1
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds i32, ptr %119, i64 %122
  %124 = load i32, ptr %123, align 4
  br label %125

125:                                              ; preds = %115, %105
  %126 = phi i32 [ %114, %105 ], [ %124, %115 ]
  %127 = load i32, ptr %10, align 4
  %128 = sext i32 %127 to i64
  %129 = mul nsw i64 %128, %23
  %130 = getelementptr inbounds i32, ptr %26, i64 %129
  %131 = load i32, ptr %11, align 4
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds i32, ptr %130, i64 %132
  store i32 %126, ptr %133, align 4
  br label %134

134:                                              ; preds = %125, %66
  br label %135

135:                                              ; preds = %134, %42
  br label %136

136:                                              ; preds = %135
  %137 = load i32, ptr %11, align 4
  %138 = add nsw i32 %137, 1
  store i32 %138, ptr %11, align 4
  br label %32, !llvm.loop !6

139:                                              ; preds = %32
  br label %140

140:                                              ; preds = %139
  %141 = load i32, ptr %10, align 4
  %142 = add nsw i32 %141, 1
  store i32 %142, ptr %10, align 4
  br label %27, !llvm.loop !8

143:                                              ; preds = %27
  %144 = load i32, ptr %5, align 4
  %145 = sext i32 %144 to i64
  %146 = mul nsw i64 %145, %23
  %147 = getelementptr inbounds i32, ptr %26, i64 %146
  %148 = load i32, ptr %6, align 4
  %149 = sext i32 %148 to i64
  %150 = getelementptr inbounds i32, ptr %147, i64 %149
  %151 = load i32, ptr %150, align 4
  %152 = load ptr, ptr %7, align 8
  call void @llvm.stackrestore(ptr %152)
  ret i32 %151
}

; Function Attrs: nounwind willreturn memory(read)
declare i64 @strlen(ptr noundef) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @editDistance(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %17 = load ptr, ptr %3, align 8
  %18 = call i64 @strlen(ptr noundef %17) #5
  %19 = trunc i64 %18 to i32
  store i32 %19, ptr %5, align 4
  %20 = load ptr, ptr %4, align 8
  %21 = call i64 @strlen(ptr noundef %20) #5
  %22 = trunc i64 %21 to i32
  store i32 %22, ptr %6, align 4
  %23 = load i32, ptr %5, align 4
  %24 = add nsw i32 %23, 1
  %25 = zext i32 %24 to i64
  %26 = load i32, ptr %6, align 4
  %27 = add nsw i32 %26, 1
  %28 = zext i32 %27 to i64
  %29 = call ptr @llvm.stacksave()
  store ptr %29, ptr %7, align 8
  %30 = mul nuw i64 %25, %28
  %31 = alloca i32, i64 %30, align 16
  store i64 %25, ptr %8, align 8
  store i64 %28, ptr %9, align 8
  store i32 0, ptr %10, align 4
  br label %32

32:                                               ; preds = %43, %2
  %33 = load i32, ptr %10, align 4
  %34 = load i32, ptr %5, align 4
  %35 = icmp sle i32 %33, %34
  br i1 %35, label %36, label %46

36:                                               ; preds = %32
  %37 = load i32, ptr %10, align 4
  %38 = load i32, ptr %10, align 4
  %39 = sext i32 %38 to i64
  %40 = mul nsw i64 %39, %28
  %41 = getelementptr inbounds i32, ptr %31, i64 %40
  %42 = getelementptr inbounds i32, ptr %41, i64 0
  store i32 %37, ptr %42, align 4
  br label %43

43:                                               ; preds = %36
  %44 = load i32, ptr %10, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, ptr %10, align 4
  br label %32, !llvm.loop !9

46:                                               ; preds = %32
  store i32 0, ptr %11, align 4
  br label %47

47:                                               ; preds = %58, %46
  %48 = load i32, ptr %11, align 4
  %49 = load i32, ptr %6, align 4
  %50 = icmp sle i32 %48, %49
  br i1 %50, label %51, label %61

51:                                               ; preds = %47
  %52 = load i32, ptr %11, align 4
  %53 = mul nsw i64 0, %28
  %54 = getelementptr inbounds i32, ptr %31, i64 %53
  %55 = load i32, ptr %11, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds i32, ptr %54, i64 %56
  store i32 %52, ptr %57, align 4
  br label %58

58:                                               ; preds = %51
  %59 = load i32, ptr %11, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, ptr %11, align 4
  br label %47, !llvm.loop !10

61:                                               ; preds = %47
  store i32 1, ptr %12, align 4
  br label %62

62:                                               ; preds = %174, %61
  %63 = load i32, ptr %12, align 4
  %64 = load i32, ptr %5, align 4
  %65 = icmp sle i32 %63, %64
  br i1 %65, label %66, label %177

66:                                               ; preds = %62
  store i32 1, ptr %13, align 4
  br label %67

67:                                               ; preds = %170, %66
  %68 = load i32, ptr %13, align 4
  %69 = load i32, ptr %6, align 4
  %70 = icmp sle i32 %68, %69
  br i1 %70, label %71, label %173

71:                                               ; preds = %67
  %72 = load ptr, ptr %3, align 8
  %73 = load i32, ptr %12, align 4
  %74 = sub nsw i32 %73, 1
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds i8, ptr %72, i64 %75
  %77 = load i8, ptr %76, align 1
  %78 = sext i8 %77 to i32
  %79 = load ptr, ptr %4, align 8
  %80 = load i32, ptr %13, align 4
  %81 = sub nsw i32 %80, 1
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds i8, ptr %79, i64 %82
  %84 = load i8, ptr %83, align 1
  %85 = sext i8 %84 to i32
  %86 = icmp eq i32 %78, %85
  br i1 %86, label %87, label %105

87:                                               ; preds = %71
  %88 = load i32, ptr %12, align 4
  %89 = sub nsw i32 %88, 1
  %90 = sext i32 %89 to i64
  %91 = mul nsw i64 %90, %28
  %92 = getelementptr inbounds i32, ptr %31, i64 %91
  %93 = load i32, ptr %13, align 4
  %94 = sub nsw i32 %93, 1
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds i32, ptr %92, i64 %95
  %97 = load i32, ptr %96, align 4
  %98 = load i32, ptr %12, align 4
  %99 = sext i32 %98 to i64
  %100 = mul nsw i64 %99, %28
  %101 = getelementptr inbounds i32, ptr %31, i64 %100
  %102 = load i32, ptr %13, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds i32, ptr %101, i64 %103
  store i32 %97, ptr %104, align 4
  br label %169

105:                                              ; preds = %71
  %106 = load i32, ptr %12, align 4
  %107 = sext i32 %106 to i64
  %108 = mul nsw i64 %107, %28
  %109 = getelementptr inbounds i32, ptr %31, i64 %108
  %110 = load i32, ptr %13, align 4
  %111 = sub nsw i32 %110, 1
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds i32, ptr %109, i64 %112
  %114 = load i32, ptr %113, align 4
  %115 = add nsw i32 %114, 1
  store i32 %115, ptr %14, align 4
  %116 = load i32, ptr %12, align 4
  %117 = sub nsw i32 %116, 1
  %118 = sext i32 %117 to i64
  %119 = mul nsw i64 %118, %28
  %120 = getelementptr inbounds i32, ptr %31, i64 %119
  %121 = load i32, ptr %13, align 4
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds i32, ptr %120, i64 %122
  %124 = load i32, ptr %123, align 4
  %125 = add nsw i32 %124, 1
  store i32 %125, ptr %15, align 4
  %126 = load i32, ptr %12, align 4
  %127 = sub nsw i32 %126, 1
  %128 = sext i32 %127 to i64
  %129 = mul nsw i64 %128, %28
  %130 = getelementptr inbounds i32, ptr %31, i64 %129
  %131 = load i32, ptr %13, align 4
  %132 = sub nsw i32 %131, 1
  %133 = sext i32 %132 to i64
  %134 = getelementptr inbounds i32, ptr %130, i64 %133
  %135 = load i32, ptr %134, align 4
  %136 = add nsw i32 %135, 1
  store i32 %136, ptr %16, align 4
  %137 = load i32, ptr %14, align 4
  %138 = load i32, ptr %15, align 4
  %139 = icmp slt i32 %137, %138
  br i1 %139, label %140, label %150

140:                                              ; preds = %105
  %141 = load i32, ptr %14, align 4
  %142 = load i32, ptr %16, align 4
  %143 = icmp slt i32 %141, %142
  br i1 %143, label %144, label %146

144:                                              ; preds = %140
  %145 = load i32, ptr %14, align 4
  br label %148

146:                                              ; preds = %140
  %147 = load i32, ptr %16, align 4
  br label %148

148:                                              ; preds = %146, %144
  %149 = phi i32 [ %145, %144 ], [ %147, %146 ]
  br label %160

150:                                              ; preds = %105
  %151 = load i32, ptr %15, align 4
  %152 = load i32, ptr %16, align 4
  %153 = icmp slt i32 %151, %152
  br i1 %153, label %154, label %156

154:                                              ; preds = %150
  %155 = load i32, ptr %15, align 4
  br label %158

156:                                              ; preds = %150
  %157 = load i32, ptr %16, align 4
  br label %158

158:                                              ; preds = %156, %154
  %159 = phi i32 [ %155, %154 ], [ %157, %156 ]
  br label %160

160:                                              ; preds = %158, %148
  %161 = phi i32 [ %149, %148 ], [ %159, %158 ]
  %162 = load i32, ptr %12, align 4
  %163 = sext i32 %162 to i64
  %164 = mul nsw i64 %163, %28
  %165 = getelementptr inbounds i32, ptr %31, i64 %164
  %166 = load i32, ptr %13, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds i32, ptr %165, i64 %167
  store i32 %161, ptr %168, align 4
  br label %169

169:                                              ; preds = %160, %87
  br label %170

170:                                              ; preds = %169
  %171 = load i32, ptr %13, align 4
  %172 = add nsw i32 %171, 1
  store i32 %172, ptr %13, align 4
  br label %67, !llvm.loop !11

173:                                              ; preds = %67
  br label %174

174:                                              ; preds = %173
  %175 = load i32, ptr %12, align 4
  %176 = add nsw i32 %175, 1
  store i32 %176, ptr %12, align 4
  br label %62, !llvm.loop !12

177:                                              ; preds = %62
  %178 = load i32, ptr %5, align 4
  %179 = sext i32 %178 to i64
  %180 = mul nsw i64 %179, %28
  %181 = getelementptr inbounds i32, ptr %31, i64 %180
  %182 = load i32, ptr %6, align 4
  %183 = sext i32 %182 to i64
  %184 = getelementptr inbounds i32, ptr %181, i64 %183
  %185 = load i32, ptr %184, align 4
  %186 = load ptr, ptr %7, align 8
  call void @llvm.stackrestore(ptr %186)
  ret i32 %185
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @knapsack(i32 noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  store i32 %3, ptr %8, align 4
  %14 = load i32, ptr %8, align 4
  %15 = add nsw i32 %14, 1
  %16 = zext i32 %15 to i64
  %17 = load i32, ptr %5, align 4
  %18 = add nsw i32 %17, 1
  %19 = zext i32 %18 to i64
  %20 = call ptr @llvm.stacksave()
  store ptr %20, ptr %9, align 8
  %21 = mul nuw i64 %16, %19
  %22 = alloca i32, i64 %21, align 16
  store i64 %16, ptr %10, align 8
  store i64 %19, ptr %11, align 8
  store i32 0, ptr %12, align 4
  br label %23

23:                                               ; preds = %155, %4
  %24 = load i32, ptr %12, align 4
  %25 = load i32, ptr %8, align 4
  %26 = icmp sle i32 %24, %25
  br i1 %26, label %27, label %158

27:                                               ; preds = %23
  store i32 0, ptr %13, align 4
  br label %28

28:                                               ; preds = %151, %27
  %29 = load i32, ptr %13, align 4
  %30 = load i32, ptr %5, align 4
  %31 = icmp sle i32 %29, %30
  br i1 %31, label %32, label %154

32:                                               ; preds = %28
  %33 = load i32, ptr %12, align 4
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %38, label %35

35:                                               ; preds = %32
  %36 = load i32, ptr %13, align 4
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %38, label %46

38:                                               ; preds = %35, %32
  %39 = load i32, ptr %12, align 4
  %40 = sext i32 %39 to i64
  %41 = mul nsw i64 %40, %19
  %42 = getelementptr inbounds i32, ptr %22, i64 %41
  %43 = load i32, ptr %13, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds i32, ptr %42, i64 %44
  store i32 0, ptr %45, align 4
  br label %150

46:                                               ; preds = %35
  %47 = load ptr, ptr %6, align 8
  %48 = load i32, ptr %12, align 4
  %49 = sub nsw i32 %48, 1
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds i32, ptr %47, i64 %50
  %52 = load i32, ptr %51, align 4
  %53 = load i32, ptr %13, align 4
  %54 = icmp sle i32 %52, %53
  br i1 %54, label %55, label %132

55:                                               ; preds = %46
  %56 = load i32, ptr %12, align 4
  %57 = sub nsw i32 %56, 1
  %58 = sext i32 %57 to i64
  %59 = mul nsw i64 %58, %19
  %60 = getelementptr inbounds i32, ptr %22, i64 %59
  %61 = load i32, ptr %13, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds i32, ptr %60, i64 %62
  %64 = load i32, ptr %63, align 4
  %65 = load ptr, ptr %7, align 8
  %66 = load i32, ptr %12, align 4
  %67 = sub nsw i32 %66, 1
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds i32, ptr %65, i64 %68
  %70 = load i32, ptr %69, align 4
  %71 = load i32, ptr %12, align 4
  %72 = sub nsw i32 %71, 1
  %73 = sext i32 %72 to i64
  %74 = mul nsw i64 %73, %19
  %75 = getelementptr inbounds i32, ptr %22, i64 %74
  %76 = load i32, ptr %13, align 4
  %77 = load ptr, ptr %6, align 8
  %78 = load i32, ptr %12, align 4
  %79 = sub nsw i32 %78, 1
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds i32, ptr %77, i64 %80
  %82 = load i32, ptr %81, align 4
  %83 = sub nsw i32 %76, %82
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds i32, ptr %75, i64 %84
  %86 = load i32, ptr %85, align 4
  %87 = add nsw i32 %70, %86
  %88 = icmp sgt i32 %64, %87
  br i1 %88, label %89, label %99

89:                                               ; preds = %55
  %90 = load i32, ptr %12, align 4
  %91 = sub nsw i32 %90, 1
  %92 = sext i32 %91 to i64
  %93 = mul nsw i64 %92, %19
  %94 = getelementptr inbounds i32, ptr %22, i64 %93
  %95 = load i32, ptr %13, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds i32, ptr %94, i64 %96
  %98 = load i32, ptr %97, align 4
  br label %123

99:                                               ; preds = %55
  %100 = load ptr, ptr %7, align 8
  %101 = load i32, ptr %12, align 4
  %102 = sub nsw i32 %101, 1
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds i32, ptr %100, i64 %103
  %105 = load i32, ptr %104, align 4
  %106 = load i32, ptr %12, align 4
  %107 = sub nsw i32 %106, 1
  %108 = sext i32 %107 to i64
  %109 = mul nsw i64 %108, %19
  %110 = getelementptr inbounds i32, ptr %22, i64 %109
  %111 = load i32, ptr %13, align 4
  %112 = load ptr, ptr %6, align 8
  %113 = load i32, ptr %12, align 4
  %114 = sub nsw i32 %113, 1
  %115 = sext i32 %114 to i64
  %116 = getelementptr inbounds i32, ptr %112, i64 %115
  %117 = load i32, ptr %116, align 4
  %118 = sub nsw i32 %111, %117
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds i32, ptr %110, i64 %119
  %121 = load i32, ptr %120, align 4
  %122 = add nsw i32 %105, %121
  br label %123

123:                                              ; preds = %99, %89
  %124 = phi i32 [ %98, %89 ], [ %122, %99 ]
  %125 = load i32, ptr %12, align 4
  %126 = sext i32 %125 to i64
  %127 = mul nsw i64 %126, %19
  %128 = getelementptr inbounds i32, ptr %22, i64 %127
  %129 = load i32, ptr %13, align 4
  %130 = sext i32 %129 to i64
  %131 = getelementptr inbounds i32, ptr %128, i64 %130
  store i32 %124, ptr %131, align 4
  br label %149

132:                                              ; preds = %46
  %133 = load i32, ptr %12, align 4
  %134 = sub nsw i32 %133, 1
  %135 = sext i32 %134 to i64
  %136 = mul nsw i64 %135, %19
  %137 = getelementptr inbounds i32, ptr %22, i64 %136
  %138 = load i32, ptr %13, align 4
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds i32, ptr %137, i64 %139
  %141 = load i32, ptr %140, align 4
  %142 = load i32, ptr %12, align 4
  %143 = sext i32 %142 to i64
  %144 = mul nsw i64 %143, %19
  %145 = getelementptr inbounds i32, ptr %22, i64 %144
  %146 = load i32, ptr %13, align 4
  %147 = sext i32 %146 to i64
  %148 = getelementptr inbounds i32, ptr %145, i64 %147
  store i32 %141, ptr %148, align 4
  br label %149

149:                                              ; preds = %132, %123
  br label %150

150:                                              ; preds = %149, %38
  br label %151

151:                                              ; preds = %150
  %152 = load i32, ptr %13, align 4
  %153 = add nsw i32 %152, 1
  store i32 %153, ptr %13, align 4
  br label %28, !llvm.loop !13

154:                                              ; preds = %28
  br label %155

155:                                              ; preds = %154
  %156 = load i32, ptr %12, align 4
  %157 = add nsw i32 %156, 1
  store i32 %157, ptr %12, align 4
  br label %23, !llvm.loop !14

158:                                              ; preds = %23
  %159 = load i32, ptr %8, align 4
  %160 = sext i32 %159 to i64
  %161 = mul nsw i64 %160, %19
  %162 = getelementptr inbounds i32, ptr %22, i64 %161
  %163 = load i32, ptr %5, align 4
  %164 = sext i32 %163 to i64
  %165 = getelementptr inbounds i32, ptr %162, i64 %164
  %166 = load i32, ptr %165, align 4
  %167 = load ptr, ptr %9, align 8
  call void @llvm.stackrestore(ptr %167)
  ret i32 %166
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @coinChange(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %12 = load i32, ptr %6, align 4
  %13 = add nsw i32 %12, 1
  %14 = zext i32 %13 to i64
  %15 = call ptr @llvm.stacksave()
  store ptr %15, ptr %7, align 8
  %16 = alloca i32, i64 %14, align 16
  store i64 %14, ptr %8, align 8
  %17 = getelementptr inbounds i32, ptr %16, i64 0
  store i32 0, ptr %17, align 16
  store i32 1, ptr %9, align 4
  br label %18

18:                                               ; preds = %28, %3
  %19 = load i32, ptr %9, align 4
  %20 = load i32, ptr %6, align 4
  %21 = icmp sle i32 %19, %20
  br i1 %21, label %22, label %31

22:                                               ; preds = %18
  %23 = load i32, ptr %6, align 4
  %24 = add nsw i32 %23, 1
  %25 = load i32, ptr %9, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, ptr %16, i64 %26
  store i32 %24, ptr %27, align 4
  br label %28

28:                                               ; preds = %22
  %29 = load i32, ptr %9, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %9, align 4
  br label %18, !llvm.loop !15

31:                                               ; preds = %18
  store i32 1, ptr %10, align 4
  br label %32

32:                                               ; preds = %86, %31
  %33 = load i32, ptr %10, align 4
  %34 = load i32, ptr %6, align 4
  %35 = icmp sle i32 %33, %34
  br i1 %35, label %36, label %89

36:                                               ; preds = %32
  store i32 0, ptr %11, align 4
  br label %37

37:                                               ; preds = %82, %36
  %38 = load i32, ptr %11, align 4
  %39 = load i32, ptr %5, align 4
  %40 = icmp slt i32 %38, %39
  br i1 %40, label %41, label %85

41:                                               ; preds = %37
  %42 = load ptr, ptr %4, align 8
  %43 = load i32, ptr %11, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds i32, ptr %42, i64 %44
  %46 = load i32, ptr %45, align 4
  %47 = load i32, ptr %10, align 4
  %48 = icmp sle i32 %46, %47
  br i1 %48, label %49, label %81

49:                                               ; preds = %41
  %50 = load i32, ptr %10, align 4
  %51 = load ptr, ptr %4, align 8
  %52 = load i32, ptr %11, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds i32, ptr %51, i64 %53
  %55 = load i32, ptr %54, align 4
  %56 = sub nsw i32 %50, %55
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds i32, ptr %16, i64 %57
  %59 = load i32, ptr %58, align 4
  %60 = add nsw i32 %59, 1
  %61 = load i32, ptr %10, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds i32, ptr %16, i64 %62
  %64 = load i32, ptr %63, align 4
  %65 = icmp slt i32 %60, %64
  br i1 %65, label %66, label %81

66:                                               ; preds = %49
  %67 = load i32, ptr %10, align 4
  %68 = load ptr, ptr %4, align 8
  %69 = load i32, ptr %11, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds i32, ptr %68, i64 %70
  %72 = load i32, ptr %71, align 4
  %73 = sub nsw i32 %67, %72
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i32, ptr %16, i64 %74
  %76 = load i32, ptr %75, align 4
  %77 = add nsw i32 %76, 1
  %78 = load i32, ptr %10, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds i32, ptr %16, i64 %79
  store i32 %77, ptr %80, align 4
  br label %81

81:                                               ; preds = %66, %49, %41
  br label %82

82:                                               ; preds = %81
  %83 = load i32, ptr %11, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, ptr %11, align 4
  br label %37, !llvm.loop !16

85:                                               ; preds = %37
  br label %86

86:                                               ; preds = %85
  %87 = load i32, ptr %10, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %10, align 4
  br label %32, !llvm.loop !17

89:                                               ; preds = %32
  %90 = load i32, ptr %6, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i32, ptr %16, i64 %91
  %93 = load i32, ptr %92, align 4
  %94 = load i32, ptr %6, align 4
  %95 = icmp sgt i32 %93, %94
  br i1 %95, label %96, label %97

96:                                               ; preds = %89
  br label %102

97:                                               ; preds = %89
  %98 = load i32, ptr %6, align 4
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds i32, ptr %16, i64 %99
  %101 = load i32, ptr %100, align 4
  br label %102

102:                                              ; preds = %97, %96
  %103 = phi i32 [ -1, %96 ], [ %101, %97 ]
  %104 = load ptr, ptr %7, align 8
  call void @llvm.stackrestore(ptr %104)
  ret i32 %103
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @lis(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %12 = load i32, ptr %4, align 4
  %13 = zext i32 %12 to i64
  %14 = call ptr @llvm.stacksave()
  store ptr %14, ptr %5, align 8
  %15 = alloca i32, i64 %13, align 16
  store i64 %13, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %16

16:                                               ; preds = %24, %2
  %17 = load i32, ptr %7, align 4
  %18 = load i32, ptr %4, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %27

20:                                               ; preds = %16
  %21 = load i32, ptr %7, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds i32, ptr %15, i64 %22
  store i32 1, ptr %23, align 4
  br label %24

24:                                               ; preds = %20
  %25 = load i32, ptr %7, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %7, align 4
  br label %16, !llvm.loop !18

27:                                               ; preds = %16
  store i32 1, ptr %8, align 4
  br label %28

28:                                               ; preds = %74, %27
  %29 = load i32, ptr %8, align 4
  %30 = load i32, ptr %4, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %77

32:                                               ; preds = %28
  store i32 0, ptr %9, align 4
  br label %33

33:                                               ; preds = %70, %32
  %34 = load i32, ptr %9, align 4
  %35 = load i32, ptr %8, align 4
  %36 = icmp slt i32 %34, %35
  br i1 %36, label %37, label %73

37:                                               ; preds = %33
  %38 = load ptr, ptr %3, align 8
  %39 = load i32, ptr %9, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds i32, ptr %38, i64 %40
  %42 = load i32, ptr %41, align 4
  %43 = load ptr, ptr %3, align 8
  %44 = load i32, ptr %8, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds i32, ptr %43, i64 %45
  %47 = load i32, ptr %46, align 4
  %48 = icmp slt i32 %42, %47
  br i1 %48, label %49, label %69

49:                                               ; preds = %37
  %50 = load i32, ptr %9, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i32, ptr %15, i64 %51
  %53 = load i32, ptr %52, align 4
  %54 = add nsw i32 %53, 1
  %55 = load i32, ptr %8, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds i32, ptr %15, i64 %56
  %58 = load i32, ptr %57, align 4
  %59 = icmp sgt i32 %54, %58
  br i1 %59, label %60, label %69

60:                                               ; preds = %49
  %61 = load i32, ptr %9, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds i32, ptr %15, i64 %62
  %64 = load i32, ptr %63, align 4
  %65 = add nsw i32 %64, 1
  %66 = load i32, ptr %8, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds i32, ptr %15, i64 %67
  store i32 %65, ptr %68, align 4
  br label %69

69:                                               ; preds = %60, %49, %37
  br label %70

70:                                               ; preds = %69
  %71 = load i32, ptr %9, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, ptr %9, align 4
  br label %33, !llvm.loop !19

73:                                               ; preds = %33
  br label %74

74:                                               ; preds = %73
  %75 = load i32, ptr %8, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, ptr %8, align 4
  br label %28, !llvm.loop !20

77:                                               ; preds = %28
  store i32 0, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %78

78:                                               ; preds = %95, %77
  %79 = load i32, ptr %11, align 4
  %80 = load i32, ptr %4, align 4
  %81 = icmp slt i32 %79, %80
  br i1 %81, label %82, label %98

82:                                               ; preds = %78
  %83 = load i32, ptr %11, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds i32, ptr %15, i64 %84
  %86 = load i32, ptr %85, align 4
  %87 = load i32, ptr %10, align 4
  %88 = icmp sgt i32 %86, %87
  br i1 %88, label %89, label %94

89:                                               ; preds = %82
  %90 = load i32, ptr %11, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i32, ptr %15, i64 %91
  %93 = load i32, ptr %92, align 4
  store i32 %93, ptr %10, align 4
  br label %94

94:                                               ; preds = %89, %82
  br label %95

95:                                               ; preds = %94
  %96 = load i32, ptr %11, align 4
  %97 = add nsw i32 %96, 1
  store i32 %97, ptr %11, align 4
  br label %78, !llvm.loop !21

98:                                               ; preds = %78
  %99 = load i32, ptr %10, align 4
  %100 = load ptr, ptr %5, align 8
  call void @llvm.stackrestore(ptr %100)
  ret i32 %99
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [5 x i32], align 16
  %3 = alloca [5 x i32], align 16
  %4 = alloca [4 x i32], align 16
  %5 = alloca [15 x i32], align 16
  store i32 0, ptr %1, align 4
  %6 = call i32 @lcs(ptr noundef @.str.1, ptr noundef @.str.2)
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %6)
  %8 = call i32 @editDistance(ptr noundef @.str.4, ptr noundef @.str.5)
  %9 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %8)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %2, ptr align 16 @__const.main.wt, i64 20, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %3, ptr align 16 @__const.main.val, i64 20, i1 false)
  %10 = getelementptr inbounds [5 x i32], ptr %2, i64 0, i64 0
  %11 = getelementptr inbounds [5 x i32], ptr %3, i64 0, i64 0
  %12 = call i32 @knapsack(i32 noundef 80, ptr noundef %10, ptr noundef %11, i32 noundef 5)
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %12)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %4, ptr align 16 @__const.main.coins, i64 16, i1 false)
  %14 = getelementptr inbounds [4 x i32], ptr %4, i64 0, i64 0
  %15 = call i32 @coinChange(ptr noundef %14, i32 noundef 4, i32 noundef 63)
  %16 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i32 noundef %15)
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %5, ptr align 16 @__const.main.arr, i64 60, i1 false)
  %17 = getelementptr inbounds [15 x i32], ptr %5, i64 0, i64 0
  %18 = call i32 @lis(ptr noundef %17, i32 noundef 15)
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, i32 noundef %18)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { nounwind willreturn memory(read) }

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
!21 = distinct !{!21, !7}
