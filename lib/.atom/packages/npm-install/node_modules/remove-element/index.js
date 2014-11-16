module.exports = remove

function remove(element) {
  if (
    element &&
    element.parentNode
  ) element.parentNode.removeChild(element)

  return element
}
