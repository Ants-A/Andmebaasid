import { defineConfig } from "drizzle-kit";

export default defineConfig({
   schema: "./src/schema.ts",
   dialect: "mysql",
   out: "./drizzle",
   dbCredentials: {
      host: process.env.DB_HOST || "localhost",
      port: 3306,
      user: process.env.DB_USER || "mysql",
      password: process.env.DB_PASSWORD || "5123",
      database: process.env.DB_NAME || 'test-db',
   }
});


