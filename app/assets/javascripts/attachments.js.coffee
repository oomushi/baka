# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# variables
dropArea = document.getElementById("dropArea")
canvas = document.querySelector("canvas")
context = canvas.getContext("2d")
count = document.getElementById("count")
destinationUrl = document.getElementById("url")
result = document.getElementById("result")
list = []
totalSize = 0
totalProgress = 0

# main initialization
(->
  
  # init handlers
  initHandlers = ->
    dropArea.addEventListener "drop", handleDrop, false
    dropArea.addEventListener "dragover", handleDragOver, false
  
  # draw progress
  drawProgress = (progress) ->
    context.clearRect 0, 0, canvas.width, canvas.height # clear context
    context.beginPath()
    context.strokeStyle = "#4B9500"
    context.fillStyle = "#4B9500"
    context.fillRect 0, 0, progress * 500, 20
    context.closePath()
    
    # draw progress (as text)
    context.font = "16px Verdana"
    context.fillStyle = "#000"
    context.fillText "Progress: " + Math.floor(progress * 100) + "%", 50, 15
  
  # drag over
  handleDragOver = (event) ->
    event.stopPropagation()
    event.preventDefault()
    dropArea.className = "hover"
  
  # drag drop
  handleDrop = (event) ->
    event.stopPropagation()
    event.preventDefault()
    processFiles event.dataTransfer.files
  
  # process bunch of files
  processFiles = (filelist) ->
    return  if not filelist or not filelist.length or list.length
    totalSize = 0
    totalProgress = 0
    result.textContent = ""
    i = 0

    while i < filelist.length and i < 5
      list.push filelist[i]
      totalSize += filelist[i].size
      i++
    uploadNext()
  
  # on complete - start next file
  handleComplete = (size) ->
    totalProgress += size
    drawProgress totalProgress / totalSize
    uploadNext()
  
  # update progress
  handleProgress = (event) ->
    progress = totalProgress + event.loaded
    drawProgress progress / totalSize
  
  # upload file
  uploadFile = (file, status) ->
    
    # prepare XMLHttpRequest
    xhr = new XMLHttpRequest()
    xhr.open "POST", destinationUrl.value
    xhr.onload = ->
      result.innerHTML += @responseText
      handleComplete file.size

    xhr.onerror = ->
      result.textContent = @responseText
      handleComplete file.size

    xhr.upload.onprogress = (event) ->
      handleProgress event

    xhr.upload.onloadstart = (event) ->

    
    # prepare FormData
    formData = new FormData()
    formData.append "myfile", file
    xhr.send formData
  
  # upload next file
  uploadNext = ->
    if list.length
      count.textContent = list.length - 1
      dropArea.className = "uploading"
      nextFile = list.shift()
      if nextFile.size >= 262144 # 256kb
        result.innerHTML += "<div class=\"f\">Too big file (max filesize exceeded)</div>"
        handleComplete nextFile.size
      else
        uploadFile nextFile, status
    else
      dropArea.className = ""
  initHandlers()
)()