# Multiple file selector by Stickman -- http://www.the-stickman.com 
# with thanks to: [for Safari fixes] Luis Torrefranca -- http://www.law.pitt.edu and Shawn Parker & John Pennypacker -- http://www.fuzzycoconut.com [for duplicate name bug] 'neal'
MultiSelector = (list_target, max) ->
  @list_target = list_target
  @count = 0
  @id = 0
  if max
    @max = max
  else
    @max = -1
  @addElement = (element) ->
    if element.tagName is "INPUT" and element.type is "file"
      element.name = "file_" + @id++
      element.multi_selector = this
      element.onchange = ->
        new_element = document.createElement("input")
        new_element.type = "file"
        @parentNode.insertBefore new_element, this
        @multi_selector.addElement new_element
        @multi_selector.addListRow this
        @style.position = "absolute"
        @style.left = "-1000px"

      element.disabled = true  if @max isnt -1 and @count >= @max
      @count++
      @current_element = element
    else
      alert "Error: not a file input element"

  @addListRow = (element) ->
    new_row = document.createElement("div")
    new_row_button = document.createElement("input")
    new_row_button.type = "button"
    new_row_button.value = "Delete"
    new_row.element = element
    new_row_button.onclick = ->
      @parentNode.element.parentNode.removeChild @parentNode.element
      @parentNode.parentNode.removeChild @parentNode
      @parentNode.element.multi_selector.count--
      @parentNode.element.multi_selector.current_element.disabled = false
      false

    new_row.innerHTML = element.value
    new_row.appendChild new_row_button
    @list_target.appendChild new_row
