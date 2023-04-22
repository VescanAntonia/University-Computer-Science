import { TravelAgency } from "./TravelAgency";

export interface CityBreak{
    id?:number;
    country:string;
    city:string;
    hotel:string; 
    price:number;
    transport:string;
    agency:TravelAgency[];
}
