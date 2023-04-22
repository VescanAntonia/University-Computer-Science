import { CityBreak } from "./CityBreak";
export interface TravelAgency{
    id:number;
    name:string; 
    website:string; 
    address:string;
    nrOfEmployees:number;
    nrOfOffers:number;
    cityBreaks:CityBreak[];
}