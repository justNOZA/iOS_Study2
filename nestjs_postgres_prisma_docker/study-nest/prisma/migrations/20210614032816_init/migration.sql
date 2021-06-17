-- CreateTable
CREATE TABLE "nagoya" (
    "day" TIMESTAMP(3) NOT NULL,
    "day_of_week" TEXT NOT NULL,
    "weather" TEXT NOT NULL,
    "temperature" DECIMAL(65,30) NOT NULL,
    "rainy_percent" INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY ("day")
);
