---
title: PPT 宏丨图片 加图题
date: '2024-12-11 16:46:38'
updated: '2024-12-11 16:47:53'
categories:
  - 研究生的自我修养
permalink: /post/ppt-macro-gun-picture-plus-picture-questions-zmn1ej.html
comments: true
toc: true
---



## 在图片上方添加文字

```vb
Sub AddFigureCaptionTOP()
    Dim sld As Slide
    Dim shp As Shape
    Dim txtBox As Shape
  
    ' 检查是否有选中的对象
    If ActiveWindow.Selection.Type = ppSelectionShapes Then
        ' 获取当前幻灯片
        Set sld = ActiveWindow.View.Slide
  
        ' 获取选中的形状
        Set shp = ActiveWindow.Selection.ShapeRange(1)
  

    
            ' 创建文本框，稍微调整 Left 属性以修正偏右问题
            Set txtBox = sld.Shapes.AddTextbox( _
                Orientation:=msoTextOrientationHorizontal, _
                Left:=shp.Left - 7, _
                Top:=shp.Top - 25, _
                Width:=shp.Width, _
                Height:=20)
    
            ' 设置文本框格式
            With txtBox.TextFrame
                .TextRange.Text = "图题文本" ' 默认图题文本，可根据需要修改
                With .TextRange.Font
                    .Size = 14
                    .Name = "微软雅黑"
                End With
                .TextRange.ParagraphFormat.Alignment = ppAlignCenter
                .VerticalAnchor = msoAnchorMiddle
                .MarginBottom = 0
                .MarginLeft = 0
                .MarginRight = 0
                .MarginTop = 0
                .AutoSize = ppAutoSizeNone
                .WordWrap = True
            End With
    
            ' 确保文本框宽度与图片完全一致
            txtBox.Width = shp.Width
    
            ' 选中文本框以便用户直接编辑
            txtBox.Select

    Else
        MsgBox "请先选择一个图片。", vbInformation
    End If
End Sub

```

## 在图片下方添加文字

```vb
Sub AddFigureCaption()
    Dim sld As Slide
    Dim shp As Shape
    Dim txtBox As Shape
  
    ' 检查是否有选中的对象
    If ActiveWindow.Selection.Type = ppSelectionShapes Then
        ' 获取当前幻灯片
        Set sld = ActiveWindow.View.Slide
  
        ' 获取选中的形状
        Set shp = ActiveWindow.Selection.ShapeRange(1)
  
        ' 显示选中对象的类型（调试用）
        'MsgBox "选中对象的类型代码为：" & shp.Type, vbInformation
  
        ' 检查选中的是否为图片

     
            ' 创建文本框，稍微调整 Left 属性以修正偏右问题
            Set txtBox = sld.Shapes.AddTextbox( _
                Orientation:=msoTextOrientationHorizontal, _
                Left:=shp.Left - 7, _
                Top:=shp.Top + shp.Height + 5, _
                Width:=shp.Width, _
                Height:=20)
      
            ' 设置文本框格式
            With txtBox.TextFrame
                .TextRange.Text = "X" ' 默认图题文本
                With .TextRange.Font
                    .Size = 14
                    .Name = "微软雅黑"
                End With
                .TextRange.ParagraphFormat.Alignment = ppAlignCenter
                .VerticalAnchor = msoAnchorMiddle
                .MarginBottom = 0
                .MarginLeft = 0
                .MarginRight = 0
                .MarginTop = 0
                .AutoSize = ppAutoSizeNone
                .WordWrap = True
            End With
      
            ' 确保文本框宽度与图片完全一致
            txtBox.Width = shp.Width
      
            ' 选中文本框以便用户直接编辑
            txtBox.Select

    Else
        MsgBox "请先选择一个图片。", vbInformation
    End If
End Sub



```
