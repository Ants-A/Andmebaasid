import { mysqlTable, int, varchar } from "drizzle-orm/mysql-core";

export const test = mysqlTable("test", {
  id: int("id").primaryKey().autoincrement(),
  description: varchar("description", { length: 255 }).notNull(),
});