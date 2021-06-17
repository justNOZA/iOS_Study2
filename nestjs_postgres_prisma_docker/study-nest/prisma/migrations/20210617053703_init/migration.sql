-- CreateTable
CREATE TABLE "region" (
    "area_id" SERIAL NOT NULL,
    "area_name" TEXT NOT NULL,
    "create_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_date" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("area_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "region.area_name_unique" ON "region"("area_name");
