import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock {
  double avgPrice;
  double best1Bid;
  double best1BidVol;
  double best1Offer;
  double best1OfferVol;
  double best2Bid;
  double best2BidVol;
  double best2Offer;
  double best2OfferVol;
  double best3Bid;
  double best3BidVol;
  double best3Offer;
  double best3OfferVol;
  double ceiling;
  List<String> corporateEvents;
  String coveredWarrantType;
  String exchange;
  double exercisePrice;
  String exerciseRatio;
  double floor;
  double highest;
  String issuerName;
  String lastTradingDate;
  double lastVol;
  double lowest;
  double matchedPrice;
  String maturityDate;
  double nmTotalTradedValue;
  double openPrice;
  double priorClosePrice;
  double refPrice;
  String securityName;
  String stockSymbol;
  String stockType;
  double totalShare;
  String tradingStatus;
  double tradingUnit;
  String underlyingSymbol;
  String companyNameEn;
  String companyNameVi;
  String oddSession;
  int buyForeignQtty;
  int remainForeignQtty;
  int sellForeignQtty;
  int matchedVolume;
  double priceChange;
  double lastMatchedPrice;
  double lastMatchedVolume;
  double lastPriceChange;
  double lastPriceChangePercent;
  int nmTotalTradedQty;

  Stock(
    this.avgPrice,
    this.best1Bid,
    this.best1BidVol,
    this.best1Offer,
    this.best1OfferVol,
    this.best2Bid,
    this.best2BidVol,
    this.best2Offer,
    this.best2OfferVol,
    this.best3Bid,
    this.best3BidVol,
    this.best3Offer,
    this.best3OfferVol,
    this.ceiling,
    this.corporateEvents,
    this.coveredWarrantType,
    this.exchange,
    this.exercisePrice,
    this.exerciseRatio,
    this.floor,
    this.highest,
    this.issuerName,
    this.lastTradingDate,
    this.lastVol,
    this.lowest,
    this.matchedPrice,
    this.maturityDate,
    this.nmTotalTradedValue,
    this.openPrice,
    this.priorClosePrice,
    this.refPrice,
    this.securityName,
    this.stockSymbol,
    this.stockType,
    this.totalShare,
    this.tradingStatus,
    this.tradingUnit,
    this.underlyingSymbol,
    this.companyNameEn,
    this.companyNameVi,
    this.oddSession,
    this.buyForeignQtty,
    this.remainForeignQtty,
    this.sellForeignQtty,
    this.matchedVolume,
    this.priceChange,
    this.lastMatchedPrice,
    this.lastMatchedVolume,
    this.lastPriceChange,
    this.lastPriceChangePercent,
    this.nmTotalTradedQty,
  );

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);

  @override
  String toString() {
    return 'Stock{avgPrice: $avgPrice, best1Bid: $best1Bid, best1BidVol: $best1BidVol, best1Offer: $best1Offer, best1OfferVol: $best1OfferVol, best2Bid: $best2Bid, best2BidVol: $best2BidVol, best2Offer: $best2Offer, best2OfferVol: $best2OfferVol, best3Bid: $best3Bid, best3BidVol: $best3BidVol, best3Offer: $best3Offer, best3OfferVol: $best3OfferVol, ceiling: $ceiling, corporateEvents: $corporateEvents, coveredWarrantType: $coveredWarrantType, exchange: $exchange, exercisePrice: $exercisePrice, exerciseRatio: $exerciseRatio, floor: $floor, highest: $highest, issuerName: $issuerName, lastTradingDate: $lastTradingDate, lastVol: $lastVol, lowest: $lowest, matchedPrice: $matchedPrice, maturityDate: $maturityDate, nmTotalTradedValue: $nmTotalTradedValue, openPrice: $openPrice, priorClosePrice: $priorClosePrice, securityName: $securityName, stockSymbol: $stockSymbol, stockType: $stockType, totalShare: $totalShare, tradingStatus: $tradingStatus, tradingUnit: $tradingUnit, underlyingSymbol: $underlyingSymbol, companyNameEn: $companyNameEn, companyNameVi: $companyNameVi, oddSession: $oddSession, buyForeignQtty: $buyForeignQtty, remainForeignQtty: $remainForeignQtty, sellForeignQtty: $sellForeignQtty, matchedVolume: $matchedVolume, priceChange: $priceChange, lastMatchedPrice: $lastMatchedPrice, lastMatchedVolume: $lastMatchedVolume, lastPriceChange: $lastPriceChange, lastPriceChangePercent: $lastPriceChangePercent, nmTotalTradedQty: $nmTotalTradedQty}';
  }
}
