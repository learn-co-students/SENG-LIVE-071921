import Painting from './Painting';

// Material-UI Imports
import { Grid } from '@material-ui/core';
import { Box } from '@material-ui/core';
import { Container } from '@material-ui/core';

function PaintingsList({ paintings }) {
  return(
    <div>
      <Container align="center">
        <h1>My Paintings</h1>
        <hr />

        {/* Implement Material-UI */}
        <Box m={5}>
          <Grid
            container
            spacing={10}
            direction="row"
          >
            {
              paintings.map(painting => (
                <Grid key={painting.id} item xs={3}>
                  <Painting
                    key={painting.id}
                    painting={painting}
                  />
                </Grid>
              ))
            }
          </Grid>
        </Box>
      </Container>
    </div>
  );
}

export default PaintingsList;