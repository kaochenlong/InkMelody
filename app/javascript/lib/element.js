const createHiddenField = (name, value) => {
  const elm = document.createElement("input");
  elm.setAttribute("type", "hidden");
  elm.setAttribute("name", name);
  elm.setAttribute("value", value);

  return elm;
};

export { createHiddenField };
