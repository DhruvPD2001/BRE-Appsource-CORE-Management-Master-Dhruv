codeunit 50106 GenerateConsolidatedInvoices
{
    trigger OnRun()
    var
        paymentScheudle2: Record "Payment Schedule2";
        SalesHeader: Record "Sales Header";
        newsalesheader: Record "Sales Header";
        paymentschedul1: Record "Payment Schedule";
        paymentScheudle3: Record "Payment Schedule2";
        newsalesheader1: Record "Sales Header";
        SalesHeader1: Record "Sales Header";
        paymentschedule2grid: Record "Payment Schedule2";
        customercard: Record Customer;
        salesheader1card: Record "Sales Header";
        slaesheader1card1: Record "Sales Header";
        paymentschedulecardpage: Record "Payment Schedule";
        todaydate: Date;
        currentdate: Date;
    begin
        todaydate := Today();
        currentdate := Today();
        paymentScheudle3.SetFilter("Due Date", '<%1', todaydate);
        paymentScheudle3.SetRange("Contract Status", 'Active');
        if paymentScheudle3.FindSet() then
            repeat
                if paymentScheudle3.Invoiced = false then begin
                    SalesHeader1.SetRange("Contract ID", paymentScheudle3."Contract ID");
                    SalesHeader1.SetRange("Overdue Invoice", 'Reactive');
                    SalesHeader1.SetRange("Due Date", currentdate);
                    SalesHeader1.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                    if SalesHeader1.FindSet() then
                        createSalesLines(SalesHeader1, paymentScheudle3)
                    else begin
                        newsalesheader1 := CreateSalesInvoice(paymentScheudle3."Tenant ID", currentdate, paymentScheudle3."Contract ID", paymentScheudle3."Tenant Name", paymentScheudle3."Property Classification");
                        customercard.SetRange("No.", newsalesheader1."Sell-to Customer No.");
                        if customercard.FindSet() then
                            if newsalesheader1."Property Classification" <> '' then begin
                                customercard.Validate("Gen. Bus. Posting Group", newsalesheader1."Property Classification");
                                customercard.Validate("Customer Posting Group", newsalesheader1."Property Classification");
                                customercard.Modify();
                            end;
                        if newsalesheader1."Property Classification" <> '' then begin
                            newsalesheader1.Validate("Gen. Bus. Posting Group", newsalesheader1."Property Classification");
                            newsalesheader1.Validate("Customer Posting Group", newsalesheader1."Property Classification");
                            newsalesheader1.Modify();
                        end;
                        createSalesLines(newsalesheader1, paymentScheudle3);
                    end;
                    newsalesheader1."Overdue Invoice" := 'Reactive';
                    newsalesheader1.Modify();
                    paymentScheudle3.Invoiced := true;
                    paymentScheudle3."Invoice ID" := newsalesheader1."No.";
                    paymentScheudle3."Overdue Invoice" := newsalesheader1."Overdue Invoice";
                    paymentScheudle3.Modify();
                end;
            until paymentScheudle3.Next() = 0;
        paymentScheudle2.SetRange("Contract start date", todaydate);
        paymentScheudle2.SetRange("Due Date", todaydate);
        if paymentScheudle2.FindSet() then
            repeat
                if paymentScheudle2."Contract Status" = 'Terminated' then
                    exit
                else begin
                    paymentschedul1.SetRange("Contract ID", paymentScheudle2."Contract ID");
                    paymentschedul1.SetFilter("Contract Status", 'Suspended');
                    if paymentschedul1.FindFirst() then begin
                        paymentScheudle2."Contract Status" := paymentschedul1."Contract Status";
                        paymentScheudle2.Modify();
                    end else
                        if paymentScheudle2.Invoiced = false then begin
                            SalesHeader.SetRange("Contract ID", paymentScheudle2."Contract ID");
                            SalesHeader.SetRange("Due Date", paymentScheudle2."Due Date");
                            SalesHeader.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                            if SalesHeader.FindSet() then
                                createSalesLines(SalesHeader, paymentScheudle2)
                            else begin
                                newsalesheader := CreateSalesInvoice(paymentScheudle2."Tenant ID", paymentScheudle2."Due Date", paymentScheudle2."Contract ID", paymentScheudle2."Tenant Name", paymentScheudle2."Property Classification");
                                customercard.SetRange("No.", newsalesheader."Sell-to Customer No.");
                                if customercard.FindSet() then
                                    if newsalesheader."Property Classification" <> '' then begin
                                        customercard.Validate("Gen. Bus. Posting Group", newsalesheader."Property Classification");
                                        customercard.Validate("Customer Posting Group", newsalesheader."Property Classification");
                                        customercard.Modify();
                                    end;
                                if newsalesheader."Property Classification" <> '' then begin
                                    newsalesheader.Validate("Gen. Bus. Posting Group", newsalesheader."Property Classification");
                                    newsalesheader.Validate("Customer Posting Group", newsalesheader."Property Classification");
                                    newsalesheader.Modify();
                                end;
                                createSalesLines(newsalesheader, paymentScheudle2);
                            end;
                            paymentScheudle2.Invoiced := true;
                            paymentScheudle2."Invoice ID" := newsalesheader."No.";
                            paymentScheudle2.Modify();
                        end;
                end;
            until paymentScheudle2.Next() = 0 else begin
            paymentschedule2grid.SetRange("Workflow frequency date", todaydate);
            if paymentschedule2grid.FindSet() then
                repeat
                    if paymentschedule2grid."Contract Status" = 'Terminated' then
                        exit
                    else begin
                        paymentschedulecardpage.SetRange("Contract ID", paymentschedule2grid."Contract ID");
                        paymentschedulecardpage.SetFilter("Contract Status", 'Suspended');
                        if paymentschedulecardpage.FindFirst() then begin
                            paymentschedule2grid."Contract Status" := paymentschedulecardpage."Contract Status";
                            paymentschedule2grid.Modify();
                        end else
                            if paymentschedule2grid.Invoiced = false then begin
                                salesheader1card.SetRange("Contract ID", paymentschedule2grid."Contract ID");
                                salesheader1card.SetRange("Due Date", paymentschedule2grid."Due Date");
                                salesheader1card.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
                                if salesheader1card.FindSet() then
                                    createSalesLines(salesheader1card, paymentschedule2grid)
                                else begin
                                    slaesheader1card1 := CreateSalesInvoice(paymentschedule2grid."Tenant ID", paymentschedule2grid."Due Date", paymentschedule2grid."Contract ID", paymentschedule2grid."Tenant Name", paymentschedule2grid."Property Classification");
                                    customercard.SetRange("No.", slaesheader1card1."Sell-to Customer No.");
                                    if customercard.FindSet() then
                                        if slaesheader1card1."Property Classification" <> '' then begin
                                            customercard.Validate("Gen. Bus. Posting Group", slaesheader1card1."Property Classification");
                                            customercard.Validate("Customer Posting Group", slaesheader1card1."Property Classification");
                                            customercard.Modify();
                                        end;
                                    if slaesheader1card1."Property Classification" <> '' then begin
                                        slaesheader1card1.Validate("Gen. Bus. Posting Group", slaesheader1card1."Property Classification");
                                        slaesheader1card1.Validate("Customer Posting Group", slaesheader1card1."Property Classification");
                                        slaesheader1card1.Modify();
                                    end;
                                    createSalesLines(slaesheader1card1, paymentschedule2grid);
                                end;
                                paymentschedule2grid.Invoiced := true;
                                paymentschedule2grid."Invoice ID" := slaesheader1card1."No.";
                                paymentschedule2grid.Modify();
                            end;
                    end;
                until paymentschedule2grid.Next() = 0;
        end;
    end;

    procedure CreateSalesInvoice(TenantID: Code[20]; DueDate: Date; ContractID: Integer; TenantName: Text[100]; PropertyClassification: Text[40]): Record "Sales Header"
    var
        salesHeader: Record "Sales Header";
        salesReciveable: Record "Sales & Receivables Setup";
        noseries: Codeunit "No. Series";
    begin
        salesHeader.Init();
        if salesReciveable.FindFirst() then
            salesHeader."No." := noseries.GetNextNo(salesReciveable."Invoice Nos.", Today, true);
        salesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
        salesHeader.Validate("Sell-to Customer No.", TenantID);
        salesHeader.Validate("Bill-to Customer No.", TenantID);
        salesHeader.Validate("Bill-to Name", TenantName);
        salesHeader.Validate("Sell-to Customer Name", TenantName);
        salesHeader.Validate("Due Date", DueDate);
        salesHeader.Validate("Contract ID", ContractID);
        salesHeader.Validate("Tenant Name", TenantName);
        salesHeader.Validate("Document Date", Today);
        salesHeader.Validate("Posting Date", Today);
        salesHeader.Validate("Shipment Date", Today);
        salesHeader.Validate("Posting No. Series", salesReciveable."Posted Invoice Nos.");
        salesHeader.Validate("Property Classification", PropertyClassification);
        salesHeader.Insert();
        exit(salesHeader);
    end;

    procedure createSalesLines(salesheader1: Record "Sales Header"; newpaymentschedule2: Record "Payment Schedule2")
    var
        saleline: Record "Sales Line";
        newSaleslines: Record "Sales Line";
        item: Record Item;
    begin
        saleline.Init();
        saleline."Document Type" := saleline."Document Type"::Invoice;
        newSaleslines.SetRange("Document No.", salesheader1."No.");
        newSaleslines.SetRange("Document Type", Enum::"Sales Document Type"::Invoice);
        newSaleslines.SetRange("Contract ID", salesheader1."Contract ID");
        newSaleslines.SetCurrentKey("Line No.");
        if newSaleslines.FindLast() then
            saleline."Line No." := newSaleslines."Line No." + 1000
        else
            saleline."Line No." := 1000;
        saleline.Validate("Document No.", salesheader1."No.");
        saleline.Validate("Contract ID", salesheader1."Contract ID");
        saleline.Validate("Type", saleline.Type::Item);
        saleline.Validate("Sell-to Customer No.", salesheader1."Sell-to Customer No.");
        item.SetRange(Description, newpaymentschedule2."Secondary Item Type");
        if item.FindFirst() then begin
            saleline.Validate("No.", item."No.");
            saleline.Validate(Description, item.Description);
            saleline.Validate("Gen. Prod. Posting Group", item."Gen. Prod. Posting Group");
            saleline.Validate("VAT Prod. Posting Group", item."VAT Prod. Posting Group");
            saleline.Validate("Unit of Measure Code", item."Base Unit of Measure");
        end;
        saleline.Validate("Quantity (Base)", 1);
        saleline.Validate(Quantity, 1);
        saleline.Validate("Unit Price", newpaymentschedule2."Amount");
        saleline.Validate("Line Amount", saleline.Quantity * saleline."Unit Price");
        saleline.Validate(Amount, saleline.Quantity * saleline."Unit Price");
        saleline.Validate("Qty. to Invoice", 1);
        saleline.Validate("Qty. to Ship", 1);
        saleline.Validate("Qty. to Invoice (Base)", 1);
        saleline.Validate("Outstanding Qty. (Base)", 1);
        saleline.Validate("Outstanding Quantity", 1);
        saleline.Validate("VAT Base Amount", newpaymentschedule2."VAT Amount");
        saleline.Validate("Amount Including VAT", saleline."Line Amount" + newpaymentschedule2."VAT Amount");
        saleline.Validate("Outstanding Amount", saleline.Quantity * saleline."Unit Price");
        saleline.Validate("Outstanding Amount (LCY)", saleline.Quantity * saleline."Unit Price");
        saleline.Insert();
        Clear(saleline);
    end;
}