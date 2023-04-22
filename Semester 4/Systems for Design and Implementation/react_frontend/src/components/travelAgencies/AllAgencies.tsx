import {
    TableContainer,
    Paper,
    Table,
    TableHead,
    TableRow,
    TableCell,
    TableBody,
    CircularProgress,
    Container,
    IconButton,
    Tooltip,
    Button,
} from "@mui/material";

import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from '@mui/icons-material/Delete';
import { useEffect, useState } from "react";
import { TravelAgency } from "../../models/TravelAgency";
import { Link } from "react-router-dom";
import AddIcon from "@mui/icons-material/Add";
import SortIcon from '@mui/icons-material/Sort';
import VisibilityIcon from '@mui/icons-material/Visibility';
import { BACKEND_API_URL } from "../../constants";


export const TravelAgenciesShowAll = () => {

    const[loading, setLoading] = useState(true)
    const[travelAgencies, setTravelAgencies] = useState<TravelAgency[]>([]);

    useEffect(() => {
		setLoading(true);
		fetch(`${BACKEND_API_URL}/travel`)
			.then((response) => response.json())
			.then((data) => {
				setTravelAgencies(data);
				setLoading(false);
			});
	}, []);

    console.log(travelAgencies);

    const sortTravelAgencies = () => {
        const sortedTravelAgencies = [...travelAgencies].sort((a: TravelAgency, b: TravelAgency) => {
            if (a.nrOfOffers < b.nrOfOffers) {
                return -1;
            }
            if (a.nrOfOffers > b.nrOfOffers) {
                return 1;
            }
            return 0;
        })
        console.log(sortedTravelAgencies);
        setTravelAgencies(sortedTravelAgencies);
    }

    return (

        <Container>
            <h1 style={{marginTop:"65px"}}>All Travel Agencies</h1>

            {loading && <CircularProgress />}

            {!loading && travelAgencies.length == 0 && <div>No travel agencies found</div>}

            {!loading && travelAgencies.length > 0 && (

                <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 800 }} aria-label="simple table" style={{backgroundColor:"whitesmoke"}}>
                        <TableHead>
                            <TableRow>
                                <TableCell align="center" style={{color:"#2471A3", fontWeight:'bold'}}>Crt.</TableCell>
                                <TableCell align="center" style={{color:"#2471A3", fontWeight:'bold'}}>Name</TableCell>
                                <TableCell align="center" style={{color:"#2471A3", fontWeight: 'bold'}}>Website</TableCell>
                                <TableCell align="center" style={{color:"#2471A3", fontWeight: 'bold'}}>Address</TableCell>
                                <TableCell align="center" style={{color:"#2471A3", fontWeight: 'bold'}}>No employees </TableCell>
                                <TableCell align="center" style={{color:"#2471A3", fontWeight: 'bold'}}>
                                    No Offers
                                    <IconButton sx={{color:"black", paddingLeft:2, fontSize:"20px", width:"20px", '&:focus': {
                                            outline: "none"
                                        } }} onClick={sortTravelAgencies}>
                                        <Tooltip title="Sort" arrow>
                                            <SortIcon style={{color:"black", fontSize:"20px"}} />
                                        </Tooltip>
                                    </IconButton>

                                </TableCell>
                                <TableCell align="center" style={{color:"#2471A3", fontWeight: 'bold'}}>Operations
                                    <IconButton component={Link} sx={{ mr: 3 }} to={`/travel/add`}>
                                        <Tooltip title="Add a new travel agency" arrow>
                                            <AddIcon style={{color:"black", fontSize:"20px"}} />
                                        </Tooltip>
                                    </IconButton></TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {travelAgencies.map((travelAgency:TravelAgency, index) => (
                                <TableRow key={travelAgency.id}>
                                    <TableCell component="th" scope="row">
                                        {index + 1}
                                    </TableCell>
                                    <TableCell align="center">
                                        {travelAgency.name}
                                        </TableCell>
                                    <TableCell align="center">{travelAgency.website}</TableCell>
                                    <TableCell align="center">{travelAgency.address}</TableCell>
                                    <TableCell align="center">{travelAgency.nrOfEmployees}</TableCell>
                                    <TableCell align="center">{travelAgency.nrOfOffers}</TableCell>
                                    <TableCell align="center">
                                        <IconButton component={Link} sx={{ mr: 3 }} to={`/travel/${travelAgency.id}/`}>
                                            <VisibilityIcon  style={{color:"black", fontSize:"20px"}}/>
                                        </IconButton>

                                        <IconButton component={Link} sx={{ mr: 3 }} to={`/travel/${travelAgency.id}/edit`}>
                                            <EditIcon sx={{ color: "navy" }}/>
                                        </IconButton>

                                        <IconButton component={Link} sx={{ mr: 3 }} to={`/travel/${travelAgency.id}/delete`}>
                                            <DeleteIcon sx={{ color: "darkred" }} />
                                        </IconButton>
                                    </TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
            )
            }
        </Container>

    );
};


// import {
// 	TableContainer,
// 	Paper,
// 	Table,
// 	TableHead,
// 	TableRow,
// 	TableCell,
// 	TableBody,
// 	CircularProgress,
// 	Container,
// 	IconButton,
// 	Tooltip,
// } from "@mui/material";
// import { useEffect, useState } from "react";
// import { Link } from "react-router-dom";
// import { BACKEND_API_URL } from "../../constants";
// import { TravelAgency } from "../../models/TravelAgency";
// import ReadMoreIcon from "@mui/icons-material/ReadMore";
// import EditIcon from "@mui/icons-material/Edit";
// import DeleteForeverIcon from "@mui/icons-material/DeleteForever";
// import AddIcon from "@mui/icons-material/Add";

// export const AllClients = () => {
// 	const [loading, setLoading] = useState(false);
// 	const [travelAgency, setTravelAgency] = useState<TravelAgency[]>([]);

// 	useEffect(() => {
// 		setLoading(true);
// 		fetch(`${BACKEND_API_URL}/travel/`)
// 			.then((response) => response.json())
// 			.then((data) => {
// 				setTravelAgency(data);
// 				setLoading(false);
// 			});
// 	}, []);

// 	return (
// 		<Container>
// 			<h1>All Travel Agencies</h1>

// 			{loading && <CircularProgress />}
// 			{!loading && clients.length === 0 && <p>No travel agencies found</p>}
// 			{!loading && (
// 				<IconButton component={Link} sx={{ mr: 3 }} to={`/travel/add`}>
// 					<Tooltip title="Add a new travel agency" arrow>
// 						<AddIcon color="primary" />
// 					</Tooltip>
// 				</IconButton>
// 			)}
// 			{!loading && clients.length > 0 && (
// 				<TableContainer component={Paper}>
// 					<Table sx={{ minWidth: 650 }} aria-label="simple table">
// 						<TableHead>
// 							<TableRow>
// 								<TableCell>#</TableCell>
// 								<TableCell align="right">Name</TableCell>
// 								<TableCell align="right">Website</TableCell>
// 								<TableCell align="right">Address</TableCell>
// 								<TableCell align="center">No Employees</TableCell>
// 								<TableCell align="center">NO Offers</TableCell>
// 							</TableRow>
// 						</TableHead>
// 						<TableBody>
// 							{clients.map((client, index) => (
// 								<TableRow key={client.id}>
// 									<TableCell component="th" scope="row">
// 										{index + 1}
// 									</TableCell>
// 									<TableCell component="th" scope="row">
// 										<Link to={`/client/${client.id}/`} title="View travel agency details">
// 											{client.name}
// 										</Link>
// 									</TableCell>
// 									<TableCell align="right">{client.website}</TableCell>
// 									<TableCell align="right">{client.address}</TableCell>
// 									<TableCell align="right">{client.nrOfEmployees}</TableCell>
// 									<TableCell align="right">{client.nrOfOffers}</TableCell>
// 									<TableCell align="right">
// 										<IconButton
// 											component={Link}
// 											sx={{ mr: 3 }}
// 											to={`/travel/${client.id}/`}>
// 											<Tooltip title="View client details" arrow>
// 												<ReadMoreIcon color="primary" />
// 											</Tooltip>
// 										</IconButton>

// 										<IconButton component={Link} sx={{ mr: 3 }} to={`/client/${client.id}/edit`}>
// 											<EditIcon />
// 										</IconButton>

// 										<IconButton component={Link} sx={{ mr: 3 }} to={`/client/${client.id}/delete`}>
// 											<DeleteForeverIcon sx={{ color: "red" }} />
// 										</IconButton>
// 									</TableCell>
// 								</TableRow>
// 							))}
// 						</TableBody>
// 					</Table>
// 				</TableContainer>
// 			)}
// 		</Container>
// 	);
// };