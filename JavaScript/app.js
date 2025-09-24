// Initial empty array to simulate JSON data
let tasks = [];

// Grab references to DOM elements
const newTaskInput = document.getElementById("newTask");
const addTaskButton = document.getElementById("addTask");
const taskList = document.getElementById("tasks");

// Function to render tasks
function renderTasks() {
  taskList.innerHTML = ""; // Clear list
  tasks.forEach((task, index) => {
    const li = document.createElement("li");
    li.textContent = task.text;

    // Apply completed style if needed
    if (task.completed) li.classList.add("completed");

    // Toggle complete on click
    li.addEventListener("click", () => {
      tasks[index].completed = !tasks[index].completed;
      renderTasks();
    });

    li.addEventListener("click", () => {

      const newText = prompt("Edit task:", task.text);
      if (newText !== null && newText.trim() !== "") {
        tasks[index].text = newText.trim();
        renderTasks();
      }
    });
    

    // Add delete button
    const deleteBtn = document.createElement("button");
    deleteBtn.textContent = "X";
    deleteBtn.addEventListener("click", (e) => {
      e.stopPropagation(); // Prevent toggle
      tasks.splice(index, 1);
      renderTasks();
    });

    li.appendChild(deleteBtn);
    taskList.appendChild(li);
  });
}

// Add new task on button click
addTaskButton.addEventListener("click", () => {
  const text = newTaskInput.value.trim();
  if (text) {
    tasks.push({ text: text, completed: false });
    newTaskInput.value = "";
    renderTasks();
  }
});

// NEW: Add new task on "Enter" key press --- ⌨️
newTaskInput.addEventListener("keydown", (event) => {
  // If the key is "Enter", simulate a click on the add button
  if (event.key === "Enter") {
    addTaskButton.click();
  }
});
