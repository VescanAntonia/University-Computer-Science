import { CityBreak } from "./CityBreak";

export interface Person{
    id:number;
    first_name:string;
    last_name:string;
    age:number;
    gender:string;
    email:string;
    cityBreak_id:number;
    cityBreak:CityBreak;
}