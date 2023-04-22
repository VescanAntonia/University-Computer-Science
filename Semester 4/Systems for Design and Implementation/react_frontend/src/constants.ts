const PROD_BACKEND_API_URL = "/snippets";
const DEV_BACKEND_API_URL = "http://127.0.0.1:8000/snippets";

export const BACKEND_API_URL = 
    process.env.NODE_ENV === "development" ? DEV_BACKEND_API_URL : PROD_BACKEND_API_URL;

// export const BACKEND_API_URL = "http://localhost:80/snippets";