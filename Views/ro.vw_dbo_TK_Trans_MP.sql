SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [ro].[vw_dbo_TK_Trans_MP] as
select
	isnull(TR.MP_Buyer,'(none)')as BuyerID,
	TR.MP_Buy_Net				as BuyNet,
	TR.MP_BOChg					as BuyOrdChrg,
	isnull(TR.Customer,'(none)')as CustomerID,
	isnull(TR.MP_DMeth_Type,
		'(none)')				as DispositionCode,
	TR.MP_Event					as EventCode,
	TR.MP_SBLS					as FirstSeatBlock,
	isnull(TR.MP_From_Season,
		'(none)')				as FromSeasonCode,
	TR.MP_From_Trans_No			as FromTransNo,
	TR.Last_DateTime			as LastUpdate,
	TR.Last_User				as LastUpdaterCode,
	1							as NbrOne,
	TR.MP_NetItem				as NetItemCode,
	isnull(TR.MP_Owner,'(none)')as OwnerID,
	isnull(TR.SH_Owner_Season,
		'(none)')				as OwnerSeasonCode,
	TR.SH_Owner_Trans_No		as OwnerTransNo,
	TR.MP_Buy_Amt-TR.MP_Diff	as PrimaryValue,
	case when (TR.MP_Qty = 0)
		then 0
	else
		(TR.MP_Buy_Amt-TR.MP_Diff)/TR.MP_Qty
	end							as "PrimaryValue/Ticket",
	TR.MP_Qty					as Qty,
	Convert(date,TR.Date)		as ResaleDate,
	TR.MP_Diff					as ResaleDifference,
	TR.MP_Buy_Amt				as ResaleValue,
	case when (MP_Qty = 0)
		then 0
	else
		TR.MP_Buy_Amt/TR.MP_Qty
	end							as "ResaleValue/Ticket",
	isnull(TR.SaleCode,
		'(none)')				as SaleCodeCode,
	TR.Season					as SeasonCode,
	case when (TR.MP_Event is null)
		then '(none)'
	else
		TR.Season+'::'+Tr.MP_Event
	end							as SeasonCodeEventCode,
	case when (TR.MP_NetItem is null)
		then '(none)'
	else
		TR.Season+'::'+TR.MP_NetItem
	end							as SeasonCodeNetItemCode,
	isnull(TR.MP_Seller,
		'(none)')				as SellerID,
	TR.MP_SellCr				as SellCredit,
	case TR.MP_ShPaid
		when 'Y'	then 'Yes'
	else 'No' end				as "SellerPaid?",
	TR.MP_SOChg					as SellOrdChrg,
	isnull(TR.SH_Seller_Season,
		'(none)')				as SellerSeasonCode,
	TR.MP_SellTixAmt			as SellTicketAmt,
	TR.SH_Seller_Trans_No		as SellTransNo,
	TR.MP_TixAmt				as TicketAmt,
	isnull(TR.MP_To_Season,
		'(none)')				as ToSeasonCode,
	TR.MP_To_Trans_No			as ToTransNo,
	TR.Trans_No					as TransNo,
	TR.ZID						as ZID

 , EXPORT_DATETIME From dbo.TK_Trans_MP(nolock)	as TR


GO
