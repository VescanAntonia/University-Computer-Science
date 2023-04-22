import {Box, Button, Card, CardActions, CardContent, Container, IconButton, Tooltip, Typography} from "@mui/material";
import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { TravelAgency } from "../../models/TravelAgency";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import { CityBreak } from "../../models/CityBreak";
import EditIcon from "@mui/icons-material/Edit";
import DeleteForeverIcon from "@mui/icons-material/DeleteForever";
import {BACKEND_API_URL} from "../../constants";
import DeleteIcon from "@mui/icons-material/Delete";
import UpgradeIcon from "@mui/icons-material/Upgrade";


export const TravelAgencyDetails = () => {

    const { travelAgencyId } = useParams();
    const [travelAgency, setTravelAgency] = useState<TravelAgency>();

    useEffect(() => {
        const fetchTravelAgency = async () => {
            const response = await fetch(`${BACKEND_API_URL}/travel/${travelAgencyId}/`);
            const travelAgency = await response.json();
            setTravelAgency(travelAgency);
            console.log(travelAgency);
        };
        fetchTravelAgency();
    }, [travelAgencyId]);

    return (
        <Container>
            <Card style={{backgroundColor:"whitesmoke"}}>
                <CardContent>
                    <Box sx={{display: 'flex', alignItems: 'center', justifyContent: 'center', paddingRight:3}}>
                        <IconButton component={Link} sx={{ mr: 3 }} to={`/travel`}>
                            <ArrowBackIcon />
                        </IconButton>{" "}
                        <h2 style={{textAlign:"left", fontWeight:'bold'}}>{travelAgency?.name}</h2>
                    </Box>
                    {/*<p  style={{textAlign:"left", fontWeight:'bold'}}>Name: {shelter?.name}</p>*/}
                    <p  style={{textAlign:"left", fontWeight:'bold'}}>Website: {travelAgency?.website}</p>
                    <p  style={{textAlign:"left", fontWeight:'bold'}}>Address: {travelAgency?.address}</p>
                    <p  style={{textAlign:"left", fontWeight:'bold'}}>nrOfEmployees: {travelAgency?.nrOfEmployees}</p>
                    <p  style={{textAlign:"left", fontWeight:'bold'}}>nrOfOffers: {travelAgency?.nrOfOffers}</p>
                    <p  style={{textAlign:"left", fontWeight:'bold'}}>CityBreaks</p>
                    <ul style={{textAlign:"left", fontWeight:'bold'}}>
                        {travelAgency?.cityBreaks?.map((cityBreak) => (
                            <li key={cityBreak.id}>{cityBreak.country} {cityBreak.city}</li>
                        ))}
                    </ul>
                </CardContent>

                <CardActions>
                    <IconButton component={Link} sx={{ mr: 3 }} to={`/travel/${travelAgencyId}/edit`}>
                        <EditIcon sx={{ color: "navy" }}/>
                    </IconButton>

                    <IconButton component={Link} sx={{ mr: 3 }} to={`/travel/${travelAgencyId}/delete`}>
                        <DeleteIcon sx={{ color: "darkred" }} />
                    </IconButton>
                </CardActions>

            </Card>
        </Container>
    );
};