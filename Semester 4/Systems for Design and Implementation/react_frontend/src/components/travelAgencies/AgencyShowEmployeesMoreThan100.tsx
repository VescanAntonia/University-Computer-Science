import { useEffect, useState } from "react";
import { BACKEND_API_URL } from "../../constants";
import { CircularProgress, Container, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TableRow } from "@mui/material";
import { TravelAgencyStatistic } from "../../models/TravelAgencyStatistic";

export const TravelAgenciesShowEmployeesMoreThan100 = () => {
    const [loading, setLoading] = useState(true);
    const [travelAgencies, setTravelAgencies] = useState([]);

    useEffect(() => {
        fetch(`${BACKEND_API_URL}/travel/filter/`)
            .then(response => response.json())
            .then(data => {
                setTravelAgencies(data);
                setLoading(false);
            }
            );
    }, []);

    console.log(travelAgencies);

    return (
        <Container>
            <h1>All Travel agencies which have more than 100 employees</h1>
            {loading && <CircularProgress />}
            
            {!loading && travelAgencies.length == 0 && <div>No travel agencies were found!</div>}

            {!loading && travelAgencies.length > 0 && (
                <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 900}} aria-label="simple table">
                        <TableHead>
                            <TableRow>
                                <TableCell>#</TableCell>
                                <TableCell align="center">Name</TableCell>
                                <TableCell align="center">Website</TableCell>
                                <TableCell align="center">Address</TableCell>
                                <TableCell align="center">nrOfEmployees</TableCell>
                                <TableCell align="center">nrOfOffers</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {travelAgencies.map((travelAgency:TravelAgencyStatistic, index) => (
                                <TableRow key={travelAgency.id}>
                                    <TableCell component="th" scope="row">
                                        {index + 1}
                                    </TableCell>
                                    <TableCell align="center">{travelAgency.name}</TableCell>
                                    <TableCell align="center">{travelAgency.website}</TableCell>
                                    <TableCell align="center">{travelAgency.address}</TableCell>
                                    <TableCell align="center">{travelAgency.nrOfEmployees}</TableCell>
                                    <TableCell align="center">{travelAgency.nrOfOffers}</TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
            )}
        </Container>
    )
}