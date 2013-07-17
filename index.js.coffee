window.PathHelper = class PathHelper

  # Get base path of element, element's siblings,
  # element's parents, and element's parent's siblings
  # e.g. body > div#id.class:nth-child(n) + div#id.class:nth-child(n) > el#id.class:nth-child(n)

  get_path: (el, path) ->
   path = path or []
   if not el or ( @get_node_name(el) == "html")
     return path.join(" > ")

   path.unshift( @get_child_selector(el) )
   @get_path(el.parentNode, path)


  # Get element and element's siblings base paths
  # e.g. div#id.class:nth-child(n) + el#id.class:nth-child(n)

  get_child_selector: (el) ->
    parent = el.parentNode
    return "" unless parent
    selector = []

    if @get_node_name(el) != "body"
      siblings = @get_siblings_without_text_nodes(el)

      i = 1
      for sibling in siblings
        break if sibling == el
        break if sibling.nodeType == 9

        selector.push( @get_el_selector(sibling) )

        i += 1
        if i == siblings.length
          selector.push("+")
        else
          selector.push("~")


    selector.push( @get_el_selector(el) )
    selector.join(" ")

  # Get base path of element
  # e.g. el#id.class:nth-child(n)

  get_el_selector: (el) ->
    selector = []

    selector.push( @get_node_name(el) )
    selector.push( @get_id_selector(el) )
    selector.push( @get_class_selector(el) )
    selector.push( @get_nth_child_selector(el) )

    selector = selector.filter (chunk) -> !!chunk
    selector = selector.join("")
    selector.trim()

  # Get node name of element
  # e.g. "DIV"

  get_node_name: (el) ->
    el.nodeName.toLowerCase()

  # Get class selector for element
  # e.g. ".class1.class2.class3"

  get_class_selector: (el) ->
    if el.className
      class_names = el.className.split(" ")
      class_names = class_names.map (class_name) -> "." + class_name
      class_names.join("")

  # Get id selector for element
  # e.g. "#id"

  get_id_selector: (el) ->
    if el.id
      "#" + el.id

  # Get nth-child selector for element
  # e.g. ":nth-child(n)"

  get_nth_child_selector: (el) ->
    index = @get_index(el)
    if !!~index
      return ":nth-child(" + index + ")"


  # Get index for element in relation to siblings

  get_index: (el) ->
    current = el.previousSibling
    index = 1

    while current && current.nodeType != 9
      if current.nodeType == 1
        index += 1
      current = current.previousSibling

    index

  # Get element siblings without text nodes

  get_siblings_without_text_nodes: (el) ->
    parent   = el.parentNode
    siblings = parent.childNodes
    filtered = []

    for sibling in siblings
      filtered.push(sibling) if sibling.nodeType != 3

    filtered
