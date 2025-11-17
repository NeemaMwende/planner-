node root {
    has list todos = [];
}

walker read_todos {
    can root;
    has list reports;

    root {
        reports = root.todos;
    }
}

walker add_todo {
    can root;
    root {
        root.todos.append({"text": text})
    }
} 


cl {

    def TodoList(todos: List) -> any {
        return <ul>
            {todos.map(
                lambda todo: any -> any {
                    return <li key={todo._jac_id}>
                        {todo.text}
                    </li>
                }
            )}
        </ul>
    }

    def app() -> any {
        let [todos, setTodos] = useState([]);

        useEffect(
            lambda -> None {
                async def loadTodos() -> None {
                    result = root.spawn read_todos();
                    setTodos(result.reports if result.reports else []);
                }
                loadTodos();
            }, []
        );

        return <div>
            <h1>My Todos</h1>
            <TodoList todos={todos}/>
        </div>; 
    }
}






