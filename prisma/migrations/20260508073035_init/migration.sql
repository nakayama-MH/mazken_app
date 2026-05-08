-- CreateTable
CREATE TABLE "branch_offices" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "color" TEXT NOT NULL,
    "address" TEXT,
    "phone" TEXT,
    "fax" TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "branch_offices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "qualifications" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "qualifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "staff" (
    "id" SERIAL NOT NULL,
    "employeeCode" TEXT NOT NULL,
    "branchOfficeId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "nameKana" TEXT NOT NULL,
    "displayName" TEXT,
    "phone" TEXT,
    "insuranceType" TEXT NOT NULL DEFAULT 'company',
    "hasShaho" BOOLEAN NOT NULL DEFAULT false,
    "hasKokuho" BOOLEAN NOT NULL DEFAULT false,
    "hasIchiriOyakata" BOOLEAN NOT NULL DEFAULT false,
    "residenceType" TEXT NOT NULL DEFAULT 'commuter',
    "role" TEXT NOT NULL DEFAULT 'worker',
    "dailyRate" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "licenseExpiry" TEXT,
    "openingBalance" INTEGER NOT NULL DEFAULT 0,
    "openingBalanceDate" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "staff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "staff_qualifications" (
    "id" SERIAL NOT NULL,
    "staffId" INTEGER NOT NULL,
    "qualificationId" INTEGER NOT NULL,
    "expiryDate" TEXT,

    CONSTRAINT "staff_qualifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_sites" (
    "id" SERIAL NOT NULL,
    "siteCode" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "clientName" TEXT,
    "branchOfficeId" INTEGER NOT NULL,
    "address" TEXT,
    "contactName1" TEXT,
    "contactTel1" TEXT,
    "contactName2" TEXT,
    "contactTel2" TEXT,
    "contactName3" TEXT,
    "contactTel3" TEXT,
    "transportation" TEXT,
    "startDate" TEXT,
    "endDate" TEXT,
    "status" TEXT NOT NULL DEFAULT 'active',
    "requiredInsurance" TEXT,
    "workCategory" TEXT NOT NULL DEFAULT 'spot',
    "requiredHeadcount" INTEGER,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "job_sites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_site_qualification_bonuses" (
    "id" SERIAL NOT NULL,
    "jobSiteId" INTEGER NOT NULL,
    "qualificationId" INTEGER NOT NULL,
    "bonusAmount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "job_site_qualification_bonuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicles" (
    "id" SERIAL NOT NULL,
    "plateNumber" TEXT NOT NULL,
    "name" TEXT,
    "vehicleType" TEXT,
    "inspectionDate" TEXT,
    "notes" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vehicles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "assignments" (
    "id" SERIAL NOT NULL,
    "staffId" INTEGER,
    "jobSiteId" INTEGER NOT NULL,
    "vehicleId" INTEGER,
    "startDate" TEXT NOT NULL,
    "endDate" TEXT NOT NULL,
    "assignmentType" TEXT NOT NULL DEFAULT 'commute',
    "shiftType" TEXT NOT NULL DEFAULT 'day',
    "startTime" TEXT NOT NULL DEFAULT '08:00',
    "endTime" TEXT NOT NULL DEFAULT '18:00',
    "dailyRateOverride" INTEGER,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "assignments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "assignment_days" (
    "id" SERIAL NOT NULL,
    "assignmentId" INTEGER NOT NULL,
    "date" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'scheduled',
    "startTime" TEXT,
    "endTime" TEXT,
    "overtimeHours" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "dailyRateOverride" INTEGER,
    "notes" TEXT,
    "acknowledgedAt" TIMESTAMP(3),
    "acknowledgedBy" INTEGER,

    CONSTRAINT "assignment_days_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "work_completion_forms" (
    "id" SERIAL NOT NULL,
    "assignmentDayId" INTEGER,
    "jobSiteId" INTEGER NOT NULL,
    "date" TEXT NOT NULL,
    "workContent" TEXT,
    "quantity" TEXT,
    "unit" TEXT,
    "staffNames" TEXT,
    "startTime" TEXT,
    "endTime" TEXT,
    "overtimeHours" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "clientSignature" TEXT,
    "clientName" TEXT,
    "isSubmitted" BOOLEAN NOT NULL DEFAULT false,
    "submittedAt" TIMESTAMP(3),
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "work_completion_forms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'office',
    "branchOfficeId" INTEGER,
    "staffId" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "loginToken" TEXT,
    "loginTokenAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER,
    "username" TEXT,
    "action" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "recordId" TEXT NOT NULL,
    "diff" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "daily_payments" (
    "id" SERIAL NOT NULL,
    "date" TEXT NOT NULL,
    "staffId" INTEGER NOT NULL,
    "site1Id" INTEGER,
    "site1BaseFee" INTEGER NOT NULL DEFAULT 0,
    "site1Driving" INTEGER NOT NULL DEFAULT 0,
    "site1Holiday" INTEGER NOT NULL DEFAULT 0,
    "site1Lift" INTEGER NOT NULL DEFAULT 0,
    "site1Skill" INTEGER NOT NULL DEFAULT 0,
    "site1Other" INTEGER NOT NULL DEFAULT 0,
    "site1Additional" INTEGER NOT NULL DEFAULT 0,
    "site2Id" INTEGER,
    "site2BaseFee" INTEGER NOT NULL DEFAULT 0,
    "site2Driving" INTEGER NOT NULL DEFAULT 0,
    "site2Holiday" INTEGER NOT NULL DEFAULT 0,
    "site2Lift" INTEGER NOT NULL DEFAULT 0,
    "site2Skill" INTEGER NOT NULL DEFAULT 0,
    "site2Other" INTEGER NOT NULL DEFAULT 0,
    "site2Additional" INTEGER NOT NULL DEFAULT 0,
    "safetyOffset" INTEGER NOT NULL DEFAULT 500,
    "lodgingOffset" INTEGER NOT NULL DEFAULT 0,
    "otherOffset" INTEGER NOT NULL DEFAULT 0,
    "advanceOffset" INTEGER NOT NULL DEFAULT 0,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "daily_payments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "branch_offices_code_key" ON "branch_offices"("code");

-- CreateIndex
CREATE UNIQUE INDEX "qualifications_name_key" ON "qualifications"("name");

-- CreateIndex
CREATE UNIQUE INDEX "staff_employeeCode_key" ON "staff"("employeeCode");

-- CreateIndex
CREATE INDEX "staff_branchOfficeId_idx" ON "staff"("branchOfficeId");

-- CreateIndex
CREATE UNIQUE INDEX "staff_qualifications_staffId_qualificationId_key" ON "staff_qualifications"("staffId", "qualificationId");

-- CreateIndex
CREATE UNIQUE INDEX "job_sites_siteCode_key" ON "job_sites"("siteCode");

-- CreateIndex
CREATE INDEX "job_sites_branchOfficeId_idx" ON "job_sites"("branchOfficeId");

-- CreateIndex
CREATE INDEX "job_site_qualification_bonuses_jobSiteId_idx" ON "job_site_qualification_bonuses"("jobSiteId");

-- CreateIndex
CREATE UNIQUE INDEX "job_site_qualification_bonuses_jobSiteId_qualificationId_key" ON "job_site_qualification_bonuses"("jobSiteId", "qualificationId");

-- CreateIndex
CREATE UNIQUE INDEX "vehicles_plateNumber_key" ON "vehicles"("plateNumber");

-- CreateIndex
CREATE INDEX "assignments_staffId_idx" ON "assignments"("staffId");

-- CreateIndex
CREATE INDEX "assignments_jobSiteId_idx" ON "assignments"("jobSiteId");

-- CreateIndex
CREATE INDEX "assignments_vehicleId_idx" ON "assignments"("vehicleId");

-- CreateIndex
CREATE INDEX "assignments_startDate_endDate_idx" ON "assignments"("startDate", "endDate");

-- CreateIndex
CREATE INDEX "assignment_days_date_idx" ON "assignment_days"("date");

-- CreateIndex
CREATE INDEX "assignment_days_status_idx" ON "assignment_days"("status");

-- CreateIndex
CREATE UNIQUE INDEX "assignment_days_assignmentId_date_key" ON "assignment_days"("assignmentId", "date");

-- CreateIndex
CREATE INDEX "work_completion_forms_date_idx" ON "work_completion_forms"("date");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_staffId_key" ON "users"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "users_loginToken_key" ON "users"("loginToken");

-- CreateIndex
CREATE INDEX "audit_logs_model_recordId_idx" ON "audit_logs"("model", "recordId");

-- CreateIndex
CREATE INDEX "audit_logs_userId_idx" ON "audit_logs"("userId");

-- CreateIndex
CREATE INDEX "audit_logs_createdAt_idx" ON "audit_logs"("createdAt");

-- CreateIndex
CREATE INDEX "daily_payments_date_idx" ON "daily_payments"("date");

-- CreateIndex
CREATE INDEX "daily_payments_staffId_idx" ON "daily_payments"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "daily_payments_staffId_date_key" ON "daily_payments"("staffId", "date");

-- AddForeignKey
ALTER TABLE "staff" ADD CONSTRAINT "staff_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "branch_offices"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff_qualifications" ADD CONSTRAINT "staff_qualifications_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff_qualifications" ADD CONSTRAINT "staff_qualifications_qualificationId_fkey" FOREIGN KEY ("qualificationId") REFERENCES "qualifications"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_sites" ADD CONSTRAINT "job_sites_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "branch_offices"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_site_qualification_bonuses" ADD CONSTRAINT "job_site_qualification_bonuses_jobSiteId_fkey" FOREIGN KEY ("jobSiteId") REFERENCES "job_sites"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_site_qualification_bonuses" ADD CONSTRAINT "job_site_qualification_bonuses_qualificationId_fkey" FOREIGN KEY ("qualificationId") REFERENCES "qualifications"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignments" ADD CONSTRAINT "assignments_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "staff"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignments" ADD CONSTRAINT "assignments_jobSiteId_fkey" FOREIGN KEY ("jobSiteId") REFERENCES "job_sites"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignments" ADD CONSTRAINT "assignments_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "vehicles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignment_days" ADD CONSTRAINT "assignment_days_assignmentId_fkey" FOREIGN KEY ("assignmentId") REFERENCES "assignments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignment_days" ADD CONSTRAINT "assignment_days_acknowledgedBy_fkey" FOREIGN KEY ("acknowledgedBy") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_completion_forms" ADD CONSTRAINT "work_completion_forms_assignmentDayId_fkey" FOREIGN KEY ("assignmentDayId") REFERENCES "assignment_days"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_completion_forms" ADD CONSTRAINT "work_completion_forms_jobSiteId_fkey" FOREIGN KEY ("jobSiteId") REFERENCES "job_sites"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "branch_offices"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "staff"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_payments" ADD CONSTRAINT "daily_payments_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_payments" ADD CONSTRAINT "daily_payments_site1Id_fkey" FOREIGN KEY ("site1Id") REFERENCES "job_sites"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "daily_payments" ADD CONSTRAINT "daily_payments_site2Id_fkey" FOREIGN KEY ("site2Id") REFERENCES "job_sites"("id") ON DELETE SET NULL ON UPDATE CASCADE;
