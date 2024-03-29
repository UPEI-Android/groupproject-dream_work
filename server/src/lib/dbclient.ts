import { PrismaClient } from '@prisma/client'

// a singleton instance of the database client
export default class DatabaseClient {
    private static instance: DatabaseClient;
    private dbclient: PrismaClient;
    
    private constructor() {
        this.dbclient = new PrismaClient()
    }

    get client():PrismaClient { return this.dbclient;}

    public static getInstance(): DatabaseClient {
        if (!DatabaseClient.instance) {
            DatabaseClient.instance = new DatabaseClient();
        }
        return DatabaseClient.instance;
    }
}