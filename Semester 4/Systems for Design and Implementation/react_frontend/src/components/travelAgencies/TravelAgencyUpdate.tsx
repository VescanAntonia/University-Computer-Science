import {
    Box,
    Button,
    Card,
    CardActions,
    CardContent,
    CircularProgress,
    Container,
    IconButton,
    Snackbar,
    TextField, Tooltip, Typography
} from "@mui/material";
import React, {useEffect, useState} from "react";
import {Link, useNavigate, useParams} from "react-router-dom";
import {TravelAgency} from "../../models/TravelAgency";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import axios from "axios";
import {BACKEND_API_URL} from "../../constants";
import MuiAlert, {AlertProps} from "@mui/material/Alert";
import UpgradeIcon from '@mui/icons-material/Upgrade';
import AddIcon from "@mui/icons-material/Add";


const Alert = React.forwardRef<HTMLDivElement, AlertProps>(function Alert(
    props,
    ref,
) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
});


export const TravelAgencyUpdate = () => {
    const [errorMessage, setErrorMessage] = useState("");
    const [showNotification, setShowNotification] = useState(false);

    const navigate = useNavigate();
    const {travelAgencyId} = useParams();

    const [loading, setLoading] = useState(true)
    const [travelAgency, setTravelAgency] = useState({
        id:travelAgencyId,
        name:"", 
        website:"",
        address:"",
        nrOfEmployees:1,
        nrOfOffers:1
    });

    useEffect(() => {
        const fetchTravelAgency = async () => {
            const response = await fetch(`${BACKEND_API_URL}/travel/${travelAgencyId}/`);
            const travelAgency = await response.json();
            setTravelAgency({
                id: travelAgencyId,
                name: travelAgency.name,
                website: travelAgency.website,
                address: travelAgency.address,
                nrOfEmployees: travelAgency.nrOfEmployees,
                nrOfOffers: travelAgency.nrOfOffers
            })
            setLoading(false);
            console.log(travelAgency);
        };
        fetchTravelAgency();
    }, [travelAgencyId]);

    const updateTravelAgency = async (event: { preventDefault: () => void }) => {
        event.preventDefault();
        try {
            await axios.put(`${BACKEND_API_URL}/travel/${travelAgencyId}/`, travelAgency);
            navigate(`/travel/${travelAgencyId}`);
        } catch (error) {
            console.log(error);
            setErrorMessage("Travel agency could not be updated.  Make sure the information is correct. ");
            setShowNotification(true);
        }
    };



    return (
        <Container>

            {showNotification && (
                <Snackbar open={!!errorMessage} autoHideDuration={6000} onClose={() => setShowNotification(false)}>
                    <Alert severity="error" sx={{width: '100%'}}>
                        {errorMessage}
                    </Alert>
                </Snackbar>

            )}

            {loading && <CircularProgress/>}

            {!loading && !travelAgency && <div>Travel agency not found</div>}

            {!loading && (
                <Card>
                    <CardContent>
                        <form onSubmit={updateTravelAgency}>
                        <Box sx={{display: 'flex', alignItems: 'center', justifyContent: 'center', paddingBlockEnd:3}}>
                            <IconButton component={Link} to={`/travel`} sx={{mr: 2}}>
                                <ArrowBackIcon/>
                            </IconButton>
                            <Typography variant="h6" sx={{flexGrow: 1, textAlign: 'center', color:'black'}}>
                                <b>Update {travelAgency.name} Travel agency</b>
                            </Typography>

                            <Button type="submit" color="inherit" sx={{ color: 'black'}}>
                                <Tooltip title="Update" arrow>
                                    <UpgradeIcon/>
                                </Tooltip>
                            </Button>
                        </Box>
                            <TextField value={travelAgency.name} style={{color: "#2471A3", fontWeight: 'bold'}}
                                       id="name"
                                       label="Name"
                                       variant="outlined"
                                       fullWidth
                                       sx={{mb: 2}}
                                       onChange={(event) => setTravelAgency({...travelAgency, name: event.target.value})}
                            />
                            <TextField value={travelAgency.website} style={{color: "#2471A3", fontWeight: 'bold'}}
                                       id="website"
                                       label="Website"
                                       variant="outlined"
                                       fullWidth
                                       sx={{mb: 2}}
                                       onChange={(event) => setTravelAgency({...travelAgency, website: event.target.value})}
                            />

                            <TextField value={travelAgency.address} style={{color: "#2471A3", fontWeight: 'bold'}}
                                       id="address"
                                       label="Address"
                                       variant="outlined"
                                       fullWidth
                                       sx={{mb: 2}}
                                       onChange={(event) => setTravelAgency({...travelAgency, address: event.target.value})}
                            />

                            <TextField value={travelAgency.nrOfEmployees} style={{color: "#2471A3", fontWeight: 'bold'}}
                                       id="nrOfEmployees"
                                       label="No Employees"
                                       variant="outlined"
                                       fullWidth
                                       sx={{mb: 2}}
                                       onChange={(event) => setTravelAgency({...travelAgency, nrOfEmployees: Number(event.target.value)})}
                            />

                            <TextField value={travelAgency.nrOfOffers} style={{color: "#2471A3", fontWeight: 'bold'}}
                                       id="nrOfOffers"
                                       label="No Offers"
                                       variant="outlined"
                                       fullWidth
                                       sx={{mb: 2}}
                                       onChange={(event) => setTravelAgency({...travelAgency,nrOfOffers: Number(event.target.value)
                                       })}
                            />

                        </form>
                    </CardContent>
                    <CardActions></CardActions>
                </Card>
            )
            }
        </Container>
    );
};