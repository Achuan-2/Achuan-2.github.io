---
title: pandoc将markdown导出为docx，如何修改图片标题为title文本而不是alt文本
date: '2025-06-04 23:50:58'
updated: '2025-06-05 00:30:37'
categories:
  - 编程笔记
permalink: >-
  /post/pandoc-exports-markdown-as-docx-how-to-modify-image-title-to-title-text-instead-of-alt-text-19kkpr.html
comments: true
toc: true
---





markdown的图片语法为

```matlab
![alt](src "title")
```

pandoc 3.x，将markdown导出为docx时，会把图片的caption默认设置为alt文本

见issue

- [[ext req] Syntax for image (figure) caption vs alt · Issue #8752 · jgm/pandoc](https://github.com/jgm/pandoc/issues/8752)
- [Feature request: Allow using title attribute for figcaptions in implicit figures · Issue #6859 · jgm/pandoc](https://github.com/jgm/pandoc/issues/6859)

但是目前的笔记软件，比如思源笔记、语雀是用markdown图片语法中的title作为图片的标题的

![PixPin_2025-06-05_00-27-53](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-05_00-27-53-20250605002754-4xnvz7k.png)

所以我需要尝试修改pandoc的默认行为，使得docx图片标题与笔记软件里的预览效果一样

![image](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/image-20250605002833-hlzmhza.png "导出word的效果")​

参考这个issue提供的代码进行改进，[Lua filter on image captions does not work. · Issue #8974 · jgm/pandoc](https://github.com/jgm/pandoc/issues/8974)

```
-- image-width.lua
-- A Pandoc Lua filter to adjust image widths based on caption format
-- Format: ![Caption text|width](image.png)
-- Function to create a new caption from text
function create_caption(text)
    -- For simple captions, we can just use a Str element
    if text:find("^%s*$") then
        -- Empty caption
        return {}
    else
        -- Non-empty caption
        return pandoc.Inlines(pandoc.Str(text))
    end
end

-- Function to process the image and extract width from caption
function process_image(img)

    -- Convert the caption to a single string
    local caption_text = pandoc.utils.stringify(img.caption)

    -- Check if the caption contains a pipe followed by a number
    -- Using a more flexible pattern that looks for a pipe character followed by digits
    local pipe_pos = caption_text:find("|")

    if pipe_pos then

        -- Extract the parts before and after the pipe
        local new_caption = caption_text:sub(1, pipe_pos - 1)
        local width_part = caption_text:sub(pipe_pos + 1)

        -- Extract the width number from the width part
        local width = width_part:match("(%d+)")

        if width then

            -- Update the image caption without the width part
            img.caption = create_caption(new_caption)

            -- Set the width attribute for the image (in pixels)
            img.attributes.width = width .. "px"

            -- Log the attributes
            for k, v in pairs(img.attributes) do end

            -- Return the modified image
            return img
        else
        end
    else
    end

    -- If no width specification was found, return the image unchanged
    return img
end

-- Handler for standalone images
function Image(img) return process_image(img) end

-- Handler for Figure blocks (which may contain images)
function Figure(fig)

    -- Check if the figure has an image
    for i, block in ipairs(fig.content) do
        if block.t == "Plain" then
            for j, inline in ipairs(block.content) do
                if inline.t == "Image" then
                    -- Process the image
                    local processed_image = process_image(inline)
                    -- Update the image in the figure
                    block.content[j] = processed_image

                    -- Also update the figure caption if needed
                    if processed_image.caption then
                        -- Extract the caption text
                        local caption_text =
                            pandoc.utils.stringify(processed_image.caption)
                        -- Update the figure caption
                        fig.caption = create_caption(caption_text)
                    end
                end
            end
        end
    end

    return fig
end

-- Log when the filter is loaded

-- Return the filter
return {{Image = Image}, {Figure = Figure}}
```

改进的代码

```lua
-- image-title-to-caption.lua
-- A Pandoc Lua filter to set image title as caption
-- Format: ![alt](src "title")

-- Function to create a new caption from text
function create_caption(text)
    -- For simple captions, we can just use a Str element
    if text:find("^%s*$") then
        -- Empty caption
        return {}
    else
        -- Non-empty caption
        return {pandoc.Str(text)}
    end
end

-- Function to process the image and set title as caption
function process_image(img)

    -- Check if title exists and is not empty
    if img.title and img.title ~= "" then
        
        -- Set the title as the image caption
        img.caption = create_caption(img.title)
        
        -- Clear the title to avoid duplication
        img.title = ""
        
        -- Return the modified image
        return img
    end
    
    -- If no title, return the image unchanged
    return img
end

-- Handler for standalone images
function Image(img)
    return process_image(img)
end

-- Handler for Figure blocks (which may contain images)
function Figure(fig)
    -- Check if the figure has an image
    for i, block in ipairs(fig.content) do
        if block.t == "Plain" then
            for j, inline in ipairs(block.content) do
                if inline.t == "Image" then
                    -- Process the image
                    local processed_image = process_image(inline)
                    -- Update the image in the figure
                    block.content[j] = processed_image
                    
                    -- Also update the figure caption
                    if processed_image.caption and #processed_image.caption > 0 then
                        -- Extract the caption text
                        local caption_text = pandoc.utils.stringify(processed_image.caption)
                        -- Update the figure caption
                        fig.caption = create_caption(caption_text)
                    end
                end
            end
        end
    end
    
    return fig
end

-- Return the filter
return {{Image = Image}, {Figure = Figure}}
```

## 笔记

- pandoc 3新增了Figure对象，所以不能仅仅用`img.caption`​来修改图片标题

  ```lua
  function Image(img)
    -- 打印调试信息（可选，用于调试）
    -- print("Image found:", img.src, "Title:", img.title, "Caption:", pandoc.utils.stringify(img.caption))
    
    -- 检查是否存在 title 属性且不为空
    if img.title and img.title ~= "" then
      -- 创建新的 caption，使用 pandoc.Inlines 包装
      local new_caption = pandoc.Inlines({pandoc.Str(img.title)})
      
      -- 替换原有的 caption
      img.caption = new_caption
      
      -- 清空 title 以避免重复显示
      img.title = ""
    end
    
    return img
  end
  ```
- 发现pandoc有时候没有生成图片标题，是因为图片前后没有空一行，像img1就没有caption

  ```matlab
  测试
  ![alt1](preview.png "title1")

  测试

  ![alt2](preview.png "title2")
  ```
  ![PixPin_2025-06-05_00-05-46](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2025-06-05_00-05-46-20250605000555-6awe3ni.png)​
